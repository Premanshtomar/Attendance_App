import 'package:attendance_app/page_tabs/attendance_page.dart';
import 'package:attendance_app/page_tabs/profile_page.dart';
import 'package:attendance_app/page_tabs/record_page.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> pageTabs = [
  {
    'pageName': const Profile(),
    'title': 'Profile',
    'navigationBarColour': Colors.red.shade200,
    'bottomBarColor': Colors.red.shade600
  },
  {
    'pageName':  const AttendancePage(),
    'title': 'Attendance',
    'navigationBarColour': Colors.blue.shade200,
    'bottomBarColor': Colors.blue.shade600
  },
  {
    'pageName': const RecordPage(),
    'title': 'Record',
    'navigationBarColour': Colors.green.shade200,
    'bottomBarColor': Colors.green.shade600
  },
];
