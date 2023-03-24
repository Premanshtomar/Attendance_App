import 'package:attendance_app/page_tabs/models/models.dart';
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

  Future<void> setData() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    DocumentReference studentDocRef =
        studentReference.doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot studentDoc = await studentDocRef.get();
    Student student =
        Student.fromJson(studentDoc.data() as Map<String, dynamic>);
    List<String> subjectsListFromFirestore = [...student.allSubjects];
    emit(
      state.copyWith(
          subjects: subjectsListFromFirestore,
          studentName: student.name,
          course: student.enrolledCourse,
          selectedYear: student.selectedYear),
    );
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
  User? user = FirebaseAuth.instance.currentUser;

  PageController pageController = PageController(initialPage: 1);
  TextEditingController subjectFieldController = TextEditingController();

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
      lastDate: DateTime.utc(2030, 09, 20),
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
    if (subjectFieldController.text.trim().isNotEmpty) {
      DocumentReference studentDoc = studentReference.doc(user!.uid);
      DocumentSnapshot studentData = await studentDoc.get();
      if (studentData.exists) {
        Student presentStudent = Student.fromJson(
          studentData.data()! as Map<String, dynamic>,
        );
        List<String> newSubjectList = [...state.subjects];
        newSubjectList.add(subjectFieldController.text);
        //     subjectName: subjectFieldController.text,
        //     monthId: '${DateTime.now().month}',
        //     monthPercent: monthPercent).toJson());
        await studentReference.doc(user!.uid).update(
          {'allSubjects': newSubjectList},
        );
        String selectedYearId = presentStudent.yearId[0];
        DocumentSnapshot yearsDoc =
            await yearReference.doc(selectedYearId).get();
        if (yearsDoc.exists) {
          Year year = Year.fromJson(
            yearsDoc.data()! as Map<String, dynamic>,
          );
          List<String> newSubjectIdList = [...year.subjectId];
          newSubjectIdList.add(
            selectedYearId + subjectFieldController.text,
          );
          await yearReference
              .doc(selectedYearId)
              .update({'subjectId': newSubjectIdList});

          await subjectReference
              .doc(selectedYearId + subjectFieldController.text)
              .set(Subject(
                      subjectName: subjectFieldController.text,
                      monthId: [],
                      monthPercent: 0)
                  .toJson());
          DocumentReference monthDocRef = monthReference.doc(user!.uid +
              state.selectedYear.toString() +
              subjectFieldController.text+
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
        }
      }
      subjectFieldController.clear();
    } else {
      emit(state.copyWith(isVisible: false));
    }
  }

  void onListTileClicked(index) {
    emit(state.copyWith(selectedSubject: state.subjects[index]));
  }

  Future<void> onMarkAttendanceClicked() async {
    DocumentReference dateDocRef = dateReference.doc(
      user!.uid +
          state.selectedYear.toString() +
          state.selectedSubject! +
          DateTime.now().month.toString() +
          DateTime.now().day.toString(),
    );
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
    await dateDocRef.set(
      Date(
        present: present,
        absent: absent,
        dayOff: dayOff,
      ).toJson(),
    );
    DocumentReference monthDocRef = monthReference.doc(user!.uid +
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
        user!.uid + state.selectedYear.toString() + state.selectedSubject!);
    await subjectDocRef.update({
      'monthPercent': presentMonth.monthPresent ~/
          (presentMonth.monthAbsent + presentMonth.monthPresent).ceil()
    });
    DocumentReference yearDocRef = yearReference.doc(
      user!.uid + state.selectedYear.toString(),
    );
    DocumentSnapshot selectedYear = await yearDocRef.get();
    Year year = Year.fromJson(selectedYear.data()as Map<String, dynamic>);
    await yearDocRef.update({
      'totalAbsent':year.totalAbsent+absent,
      'totalPrecent':year.totalAbsent+present,
      'totalDayOff':year.totalAbsent+dayOff,
    });
    absent = 0;
    present = 0;
    dayOff = 0;

    emit(state.copyWith(
      isChecked: null,
      selectedSubject: null,

    ));
  }
}
