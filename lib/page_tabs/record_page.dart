import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return SingleChildScrollView(
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
                            cubit.onDateSelected(context);
                          },
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            size: MediaQuery.of(context).size.width * 0.11,
                          )),
                      Text(
                        getDateFromDateTime(
                            state.selectedDate ?? DateTime.now()),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.9,
                      ),
                      Text(
                        getDayFromDateTime(
                            state.selectedDate ?? DateTime.now()),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(30.0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black45),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              shape: const StadiumBorder(side: BorderSide(width: 10)),
                                context: context,
                                builder: (
                                  BuildContext context,
                                ) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: Center(
                                      child: ListView.builder(
                                          itemCount:
                                              cubit.state.subjects.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              leading: Text('${index + 1}'),
                                              title: Text(
                                                  cubit.state.subjects[index]),
                                            );
                                          }),
                                    ),
                                  );
                                });
                          },
                          child: const Text(
                            'Select Subject',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
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
      },
    );
  }
}
