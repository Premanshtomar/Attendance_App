import 'package:equatable/equatable.dart';

class AuthCubitStateModel extends Equatable {
  final bool onChanged;

  final int year;

  AuthCubitStateModel copyWith({

    bool? onChanged,
    int? year,
  }) {
    return AuthCubitStateModel(
      onChanged: onChanged ?? this.onChanged,
      year: year ?? this.year,

    );
  }

  const AuthCubitStateModel({
    this.onChanged = false,
    this.year = 1,
  });

  @override
  List<Object?> get props => [

        onChanged,
        year,
      ];
}
