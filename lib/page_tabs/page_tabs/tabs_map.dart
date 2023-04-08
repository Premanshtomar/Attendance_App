import 'package:attendance_app/page_tabs/screens/attendance_page.dart';
import 'package:attendance_app/page_tabs/screens/profile_page.dart';
import 'package:attendance_app/page_tabs/screens/record_page.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> pageTabs = [
  {
    'pageName': const RecordPage(),
    'title': 'Record',
    'navigationBarColour': Colors.green.shade200,
    'bottomBarColor': Colors.green.shade600
  },
  {
    'pageName': const AttendancePage(),
    'title': 'Attendance',
    'navigationBarColour': Colors.blue.shade200,
    'bottomBarColor': Colors.blue.shade600
  },
  {
    'pageName': Profile(),
    'title': 'Profile',
    'navigationBarColour': Colors.red.shade200,
    'bottomBarColor': Colors.red.shade600
  },
];
