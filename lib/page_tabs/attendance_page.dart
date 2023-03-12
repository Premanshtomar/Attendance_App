import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Today's Date",
                          style: TextStyle(fontWeight: FontWeight.w700),
                          textScaleFactor: 2,
                        ),
                        Text(
                          '${DateTime
                              .now()
                              .day
                              .toString()}/${DateTime
                              .now()
                              .month
                              .toString()}/${DateTime
                              .now()
                              .year
                              .toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.4,
                        ),
                        Text(
                          DateFormat('EEEE').format(DateTime.now()).toString(),
                          textScaleFactor: 1.2,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.yellow,
                    child: const Text(
                      'OR',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.red),
                      textScaleFactor: 2,
                    ),
                  ),
                  Container(
                    color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.w700),
                          textScaleFactor: 2,
                        ),
                        IconButton(
                            onPressed: () {

                            },
                            icon: const Icon(Icons.calendar_month_outlined)),
                        Text(
                          '${DateTime
                              .now()
                              .day
                              .toString()}/${DateTime
                              .now()
                              .month
                              .toString()}/${DateTime
                              .now()
                              .year
                              .toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.4,
                        ),
                        Text(
                          DateFormat('EEEE').format(DateTime.now()).toString(),
                          textScaleFactor: 1.2,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: const Text('prem'),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
