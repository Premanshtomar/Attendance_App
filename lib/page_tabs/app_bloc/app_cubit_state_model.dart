import 'package:equatable/equatable.dart';

class AppCubitStateModel extends Equatable {
  final String course;
  final String studentName;
  final int? subjectListIndex;
  final int isChecked;
  final List<String> subjects;
  final int pageIndex;
  final DateTime? selectedDate;
  final bool isVisible;
  final bool isExpandableTileExpanded;
  final int selectedYear;

  const AppCubitStateModel({
    this.course = '',
    this.selectedYear = 0,
    this.studentName = '',
    this.subjectListIndex,
    this.isVisible = false,
    this.selectedDate,
    this.pageIndex = 1,
    this.subjects = const [],
    this.isChecked = 0,
    this.isExpandableTileExpanded = false,
  });

  AppCubitStateModel copyWith(
      {int? isChecked,
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
    );
  }

  @override
  List<Object?> get props => [
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
