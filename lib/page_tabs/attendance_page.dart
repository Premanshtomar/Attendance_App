import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  // bool _isExpanded = false;
  int _isChecked = 0;
  List<String>subjects=[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Today's Date",
                        style: TextStyle(fontWeight: FontWeight.w700),
                        textScaleFactor: 2.5,
                      ),
                      Text(
                        '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.9,
                      ),
                      Text(
                        DateFormat('EEEE').format(DateTime.now()).toString(),
                        textScaleFactor: 1.5,
                      ),
                      const Text(
                        '',
                        textScaleFactor: 2,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExpansionTile(
                    // onExpansionChanged: (isExpanded) {
                    //   setState(() {
                    //     _isExpanded = isExpanded;
                    //   });
                    // },
                    title: const Text(
                      'Select Subject',
                      style: TextStyle(fontWeight: FontWeight.w800
                          //   color: _isExpanded ? Colors.blueAccent : Colors.black,
                          ),
                      textScaleFactor: 1.5,
                    ),
                    children: List.generate(
                      subjects.length+1,
                      (index) {
                        if (index == subjects.length) {
                          return addNewSubjectButton();
                        }
                        return subjectName(index);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  customCheckboxTile('Present', 1),
                  customCheckboxTile('Absent', 2),
                  customCheckboxTile('Day_off', 3),
                ],
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
              elevation: MaterialStateProperty.all(30.0),
              backgroundColor: MaterialStateProperty.all(Colors.black45),
            ),
            onPressed: () {},
            child: const Text(
              'Mark Attendance',
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.5,
            ),
          )
        ],
      ),
    );
  },
);
  }

  Widget addNewSubjectButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8.0),
      child: Center(
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: Colors.grey[200]!)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.add_circled,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Add New',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget subjectName(int index) {
    return ListTile(
      title: Text(
        subjects[index],
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: (){},
    );
  }

  Widget customCheckboxTile(String text, int val) {
    return CheckboxListTile(
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        textScaleFactor: 2,
      ),
      value: _isChecked == val,
      onChanged: (value) {
        setState(() {
          _isChecked = val;
        });
      },
    );
  }
}
