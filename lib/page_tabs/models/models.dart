class Student {
  Student({
    required this.selectedYear,
    required this.name,
    required this.enrolledCourse,
    required this.profilePhoto,
  });

  final String name;
  final int selectedYear;
  final String enrolledCourse;
  final String profilePhoto;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] as String,
      enrolledCourse: json['enrolledCourse'] as String,
      profilePhoto: json['profilePhoto'] as String,
      selectedYear: json['selectedYear'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'enrolledCourse': enrolledCourse,
      'profilePhoto': profilePhoto,
      'selectedYear': selectedYear,
    };
  }
}

class Subject {
  Subject({
    required this.subjectName,
    required this.monthPercent,
  });

  final String subjectName;
  final double monthPercent;

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectName: json['name'] as String,
      monthPercent: json['monthPercent'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': subjectName,
      'monthPercent': monthPercent,
    };
  }
}

class Year {
  final int totalPresent;
  final int totalAbsent;
  final int totalDayOff;
  final List subjects;

  Year({
    required this.totalPresent,
    required this.totalAbsent,
    required this.totalDayOff,
    required this.subjects,
  });

  factory Year.fromJson(Map<String, dynamic> json) {
    return Year(
      totalPresent: json['totalPresent'] as int,
      totalAbsent: json['totalAbsent'] as int,
      totalDayOff: json['totalDayOff'] as int,
      subjects: json['subjects'] as List,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPresent': totalPresent,
      'totalAbsent': totalAbsent,
      'totalDayOff': totalDayOff,
      'subjects': subjects,
    };
  }
}

class Month {
  final int monthPresent;
  final int monthAbsent;
  final int monthDayOff;

  Month({
    required this.monthPresent,
    required this.monthAbsent,
    required this.monthDayOff,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      monthPresent: json['monthPresent'] as int,
      monthAbsent: json['monthAbsent'] as int,
      monthDayOff: json['monthDayOff'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monthPresent': monthPresent,
      'monthAbsent': monthAbsent,
      'monthDayOff': monthDayOff,
    };
  }
}

class Date {
  final int noOfLectures;
  final int present;
  final int absent;
  final int dayOff;

  Date({
    required this.noOfLectures,
    required this.present,
    required this.absent,
    required this.dayOff,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      noOfLectures: json['noOfLectures'] as int,
      present: json['present'] as int,
      absent: json['absent'] as int,
      dayOff: json['dayOff'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noOfLectures': noOfLectures,
      'present': present,
      'absent': absent,
      'dayOff': dayOff,
    };
  }
}
