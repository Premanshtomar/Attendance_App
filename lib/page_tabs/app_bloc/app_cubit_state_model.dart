import 'package:attendance_app/utils/helper_enums.dart';
import 'package:equatable/equatable.dart';

class AppCubitStateModel extends Equatable {
  final int yearPercent;
  final int recordMonthPercent;
  final int recordPresent;
  final int recordLectures;
  final int recordAbsent;
  final String? selectedSubjectInRecord;
  final String course;
  final String studentName;
  final int? subjectListIndex;
  final int isChecked;
  final int? isCheckedYear;
  final List<String> subjects;
  final int pageIndex;
  final DateTime? selectedDate;
  final bool isVisible;
  final bool isExpandableTileExpanded;
  final int selectedYear;
  final String? selectedSubject;

  const AppCubitStateModel({
    this.yearPercent = 0,
    this.recordMonthPercent = 0,
    this.recordAbsent = 0,
    this.recordLectures = 0,
    this.recordPresent = 0,
    this.selectedSubjectInRecord,
    this.selectedSubject,
    this.isCheckedYear,
    this.course = '',
    this.selectedYear = 0,
    this.studentName = '',
    this.subjectListIndex,
    this.isVisible = false,
    this.selectedDate,
    this.pageIndex = 1,
    this.subjects = const [],
    this.isChecked = -1,
    this.isExpandableTileExpanded = false,
  });

  AppCubitStateModel copyWith(
      {int? isCheckedYear,
      int? yearPercent,
      int? recordMonthPercent,
      int? recordAbsent,
      int? recordLectures,
      int? recordPresent,
      String? selectedSubjectInRecord,
      int? isChecked,
      String? selectedSubject,
      int? selectedYear,
      String? course,
      String? studentName,
      List<String>? subjects,
      int? pageIndex,
      DateTime? selectedDate,
      bool? isVisible,
      bool? isExpandableTileExpanded,
      int? subjectListIndex}) {
    return AppCubitStateModel(
      isChecked: isChecked ?? this.isChecked,
      subjects: subjects ?? this.subjects,
      pageIndex: pageIndex ?? this.pageIndex,
      selectedDate: selectedDate ?? this.selectedDate,
      isVisible: isVisible ?? this.isVisible,
      isExpandableTileExpanded:
          isExpandableTileExpanded ?? this.isExpandableTileExpanded,
      subjectListIndex: subjectListIndex ?? this.subjectListIndex,
      studentName: studentName ?? this.studentName,
      course: course ?? this.course,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      isCheckedYear: isCheckedYear ?? this.isCheckedYear,
      selectedSubjectInRecord:
          selectedSubjectInRecord ?? this.selectedSubjectInRecord,
      recordAbsent: recordAbsent ?? this.recordAbsent,
      recordLectures: recordLectures ?? this.recordLectures,
      recordPresent: recordPresent ?? this.recordPresent,
      recordMonthPercent: recordMonthPercent ?? this.recordMonthPercent,
      yearPercent: yearPercent ?? this.yearPercent,
    );
  }

  @override
  List<Object?> get props => [
        yearPercent,
        recordMonthPercent,
        recordPresent,
        recordLectures,
        recordAbsent,
        selectedSubjectInRecord,
        isCheckedYear,
        selectedSubject,
        selectedYear,
        course,
        studentName,
        subjectListIndex,
        isVisible,
        isChecked,
        subjects,
        pageIndex,
        selectedDate,
        isExpandableTileExpanded,
      ];
}
