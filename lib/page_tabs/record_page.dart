import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Choose Date",
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textScaleFactor: 2.5,
                  ),
                  IconButton(
                      color: Colors.red.shade500,
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.utc(2000, 09, 20),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.utc(2030, 09, 20),
                        ).then((value) {
                          setState(() {
                            _selectedDate = value;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        size: MediaQuery.of(context).size.width * 0.11,
                      )),
                  Text(
                    "${_selectedDate?.day ?? DateTime.now().day}/"
                    "${_selectedDate?.month ?? DateTime.now().month}/"
                    "${_selectedDate?.year ?? DateTime.now().year}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.9,
                  ),
                  Text(
                    DateFormat('EEEE')
                        .format(_selectedDate ?? DateTime.now())
                        .toString(),
                    textScaleFactor: 1.5,
                  )
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            // color: Colors.green,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(30.0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black45),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Select Subject',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        textScaleFactor: 2,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
