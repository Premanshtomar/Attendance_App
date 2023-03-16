import 'package:equatable/equatable.dart';

class AppCubitStateModel extends Equatable {
  final int isChecked;
  final List<String>subjects;

  AppCubitStateModel copyWith({int? isChecked,
  List<String>? subjects}) {
    return AppCubitStateModel(
      isChecked: isChecked ?? this.isChecked,
      subjects: subjects?? this.subjects,
    );
  }

  const AppCubitStateModel({
    this.subjects=const[],
    this.isChecked = 0,
  });

  @override
  List<Object?> get props => [
    isChecked,
    subjects
  ];
}
