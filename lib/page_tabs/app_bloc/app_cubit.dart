import 'package:attendance_app/page_tabs/models/models.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:attendance_app/utils/helper_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_cubit_state_model.dart';

class AppCubit extends Cubit<AppCubitStateModel> {
  AppCubit() : super(const AppCubitStateModel()) {
    setData();
    setCurrentDate();
  }

  CollectionReference studentReference =
      FirebaseFirestore.instance.collection('students');
  CollectionReference dateReference =
      FirebaseFirestore.instance.collection('days');
  CollectionReference monthReference =
      FirebaseFirestore.instance.collection('month');
  CollectionReference yearReference =
      FirebaseFirestore.instance.collection('year');
  CollectionReference subjectReference =
      FirebaseFirestore.instance.collection('subjects');

  // User? user = FirebaseAuth.instance.currentUser;

  PageController pageController = PageController(initialPage: 1);
  TextEditingController subjectFieldController = TextEditingController();

  Future<void> setData() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }
    var user = FirebaseAuth.instance.currentUser;
    DocumentReference studentDocRef =
        studentReference.doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot studentDoc = await studentDocRef.get();
    Student student =
        Student.fromJson(studentDoc.data() as Map<String, dynamic>);
    int presentYear = student.selectedYear;
    DocumentSnapshot yearSnapshot =
        await yearReference.doc(user!.uid + presentYear.toString()).get();
    Year year = Year.fromJson(yearSnapshot.data() as Map<String, dynamic>);
    List<String> subjectsListFromFirestore = [...year.subjects];
    var temp = (year.totalPresent + year.totalAbsent) == 0
        ? 1
        : (year.totalPresent + year.totalAbsent);
    double thisYearPercent = (((year.totalPresent) / temp) * 100);
    emit(
      state.copyWith(
        yearPercent: thisYearPercent,
        subjects: subjectsListFromFirestore,
        studentName: student.name,
        course: student.enrolledCourse,
        selectedYear: student.selectedYear,
      ),
    );
  }

  void toggleExpandedTile() {
    emit(
      state.copyWith(
        isExpandableTileExpanded: !(state.isExpandableTileExpanded),
      ),
    );
  }

  void onPageIconClicked(index) {
    pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(index) {
    FocusManager.instance.primaryFocus?.unfocus();
    onPageIconClicked(index);
    emit(state.copyWith(pageIndex: index));
  }

  void setCurrentDate() {
    emit(
      state.copyWith(
        selectedDate: DateTime.now(),
      ),
    );
  }

  void onDateSelected(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.utc(2000, 09, 20),
      initialDate: state.selectedDate ?? DateTime.now(),
      lastDate: DateTime.now(),
    ).then((value) {
      emit(
        state.copyWith(
          selectedDate: value,
          // day: DateFormat('EEEE').format(value!).toString(),
        ),
      );
    });
  }

  void onChecked(value) {
    emit(state.copyWith(isChecked: value));
  }

  void onAddNewSubjectClicked() {
    emit(state.copyWith(isVisible: true));
  }

  Future<void> onDoneSubjectClicked(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser!;
    if (subjectFieldController.text.trim().isNotEmpty) {
      List<String> newSubjectList = [...state.subjects];
      newSubjectList.add(subjectFieldController.text.toUpperCase());
      await yearReference.doc(user.uid + state.selectedYear.toString()).update(
        {'subjects': newSubjectList},
      );
      String selectedYearId = user.uid + state.selectedYear.toString();
      await subjectReference
          .doc(selectedYearId + subjectFieldController.text.toUpperCase())
          .set(Subject(
                  subjectName: subjectFieldController.text.toUpperCase(),
                  monthPercent: 0)
              .toJson());
      DocumentReference monthDocRef = monthReference.doc(user.uid +
          state.selectedYear.toString() +
          subjectFieldController.text.toUpperCase() +
          DateTime.now().month.toString());
      await monthDocRef.set(Month(
        monthPresent: 0,
        monthAbsent: 0,
        monthDayOff: 0,
      ).toJson());
      emit(
        state.copyWith(
          subjects: newSubjectList,
          isVisible: false,
        ),
      );

      subjectFieldController.clear();
    } else {
      emit(state.copyWith(isVisible: false));
    }
  }

  void onListTileClicked(index) {
    emit(state.copyWith(selectedSubject: state.subjects[index]));
  }

  Future<bool> onMarkAttendanceClicked() async {
    emit(
      state.copyWith(isLoading: true),
    );
    var user = FirebaseAuth.instance.currentUser;
    int present = 0;
    int absent = 0;
    int dayOff = 0;
    if (state.isChecked == 1) {
      present = 1;
    } else if (state.isChecked == 2) {
      absent = 1;
    } else {
      dayOff = 1;
    }
    if (state.selectedSubject != null && state.isChecked != -1) {
      DocumentReference dateDocRef = dateReference.doc(
        user!.uid +
            state.selectedYear.toString() +
            state.selectedSubject! +
            DateTime.now().month.toString() +
            DateTime.now().day.toString(),
      );
      DocumentSnapshot dateDocData = await dateDocRef.get();
      if (dateDocData.exists) {
        Date dateData =
            Date.fromJson(dateDocData.data() as Map<String, dynamic>);
        dateDocRef.update({
          'noOfLectures': dateData.noOfLectures + 1,
          'present': dateData.present + present,
          'absent': dateData.absent + absent,
          'dayOff': dateData.dayOff + dayOff,
        });
      } else {
        await dateDocRef.set(
          Date(
            noOfLectures: 1,
            present: present,
            absent: absent,
            dayOff: dayOff,
          ).toJson(),
        );
      }
      DocumentReference monthDocRef = monthReference.doc(user.uid +
          state.selectedYear.toString() +
          state.selectedSubject! +
          DateTime.now().month.toString());
      DocumentSnapshot month = await monthDocRef.get();
      Month presentMonth = Month.fromJson(month.data() as Map<String, dynamic>);
      await monthDocRef.set(Month(
        monthPresent: presentMonth.monthPresent + present,
        monthAbsent: presentMonth.monthAbsent + absent,
        monthDayOff: presentMonth.monthDayOff + dayOff,
      ).toJson());
      DocumentReference subjectDocRef = subjectReference.doc(
          user.uid + state.selectedYear.toString() + state.selectedSubject!);
      double monthPercent = 0;
      if (presentMonth.monthPresent + present == 0) {
        monthPercent = 0;
      } else {
        monthPercent = ((presentMonth.monthPresent + present) /
                (presentMonth.monthAbsent +
                    absent +
                    presentMonth.monthPresent +
                    present)) *
            100;
      }
      await subjectDocRef.update({'monthPercent': monthPercent});
      DocumentReference yearDocRef = yearReference.doc(
        user.uid + state.selectedYear.toString(),
      );
      DocumentSnapshot selectedYear = await yearDocRef.get();
      Year year = Year.fromJson(selectedYear.data() as Map<String, dynamic>);
      await yearDocRef.update({
        'totalAbsent': year.totalAbsent + absent,
        'totalPresent': year.totalPresent + present,
        'totalDayOff': year.totalDayOff + dayOff,
      });

      absent = 0;
      present = 0;
      dayOff = 0;

      emit(
        state.copyWith(
          isLoading: false,
          isChecked: -1,
          selectedSubject: Unknown.UNKNOWN.name,
        ),
      );
      setData();
      return true;
    } else {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      return false;
    }
  }

  void onYearChangedClicked(int year) {
    emit(
      state.copyWith(
        checkedYear: year,
      ),
    );
    // print(state.isCheckedYear);
  }

  Future<void> onYearSetClicked() async {
    var user = FirebaseAuth.instance.currentUser;
    if (state.checkedYear == state.selectedYear) {
      return;
    } else {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      await studentReference.doc(user!.uid).update({
        'selectedYear': state.checkedYear,
      });
      DocumentReference yearDocRef =
          yearReference.doc(user.uid + state.checkedYear.toString());
      DocumentSnapshot yearDocData = await yearDocRef.get();
      if (yearDocData.exists) {
        emit(
          state.copyWith(
            selectedYear: state.checkedYear,
            pageIndex: 1,
          ),
        );
        setData();
        emit(
          state.copyWith(isLoading: false),
        );
        return;
      } else {
        yearDocRef.set(Year(
          totalPresent: 0,
          totalAbsent: 0,
          totalDayOff: 0,
          subjects: [],
        ).toJson());
      }
      state.copyWith(
        selectedYear: state.checkedYear,
      );
      setData();
    }
    emit(
      state.copyWith(
        pageIndex: 1,
        isLoading: false,
      ),
    );
  }

  void onYearCancelClicked() {
    emit(
      state.copyWith(
        checkedYear: null,
      ),
    );
  }

  void onSubjectSelectInRecord(int index) {
    emit(
      state.copyWith(
        selectedSubjectInRecord: state.subjects[index],
      ),
    );
  }

  void onDoneRecordClicked() {
    emit(
      state.copyWith(
        selectedDate: DateTime.now(),
        doneRecord: false,
        selectedSubjectInRecord: Unknown.UNKNOWN.name,
        // doneRecord: false,
      ),
    );
  }

  Future<void> onSelectedSubjectInRecord(
      DateTime dateTime, BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    DocumentReference dateDocRef = dateReference.doc(user!.uid +
        state.selectedYear.toString() +
        state.selectedSubjectInRecord! +
        dateTime.month.toString() +
        dateTime.day.toString());
    DocumentSnapshot dateDocData = await dateDocRef.get();
    DocumentReference subjectDocRef = subjectReference.doc(user.uid +
        state.selectedYear.toString() +
        state.selectedSubjectInRecord!);
    DocumentSnapshot subjectDocData = await subjectDocRef.get();

    if (dateDocData.exists) {
      Date dateData = Date.fromJson(
        dateDocData.data() as Map<String, dynamic>,
      );
      print(dateData.noOfLectures);
      print(state.selectedSubjectInRecord);
      Subject subjectData =
          Subject.fromJson(subjectDocData.data() as Map<String, dynamic>);
      emit(
        state.copyWith(
          recordPresent: dateData.present,
          recordAbsent: dateData.absent,
          recordLectures: dateData.noOfLectures,
          recordMonthPercent: subjectData.monthPercent,
          doneRecord: true,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: NaturalColors.backgroundColor,
          content: Text(
            'No Record Found for this date!!',
            style: TextStyle(
                color: TextColors.errorColor,
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
      );
      emit(state.copyWith(
          selectedDate: DateTime.now(),
          selectedSubjectInRecord: Unknown.UNKNOWN.name));
    }
  }

  void onConfirmRecordClicked() {
    emit(
      state.copyWith(
        doneRecord: true,
      ),
    );
  }

  Future<void> onLogoutClicked(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed('/logging/');
    emit(
      state.copyWith(
        pageIndex: 1,
      ),
    );
  }
}
