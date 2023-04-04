import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:attendance_app/utils/date_formatter.dart';
import 'package:attendance_app/utils/helper_enums.dart';
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.01,
              // ),
              state.selectedSubjectInRecord != null &&
                      state.selectedSubjectInRecord != Unknown.UNKNOWN.name
                  ? Text(
                      state.selectedSubjectInRecord!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      textScaleFactor: 2,
                    )
                  : TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: NaturalColors.black),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(30.0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black45),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: NaturalColors.transparent,
                            context: context,
                            builder: (
                              BuildContext context,
                            ) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: NaturalColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                    topRight: Radius.circular(
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: cubit.state.subjects.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            tileColor: index.isEven
                                                ? NaturalColors.lightBlack
                                                : NaturalColors.white,
                                            onTap: () async {
                                              cubit.onSubjectSelectInRecord(
                                                index,
                                              );
                                              Navigator.pop(context);

                                            },
                                            leading: Text(
                                              '${index + 1}.',
                                              textScaleFactor: 1.5,
                                            ),
                                            title: Text(
                                              cubit.state.subjects[index],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textScaleFactor: 1.5,
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              );
                            });
                      },
                      child: const Text(
                        'Select Subject',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textScaleFactor: 2,
                      ),
                    ),
              Visibility(
                visible: state.selectedSubjectInRecord != null &&
                    state.selectedSubjectInRecord != Unknown.UNKNOWN.name,
                child: state.doneRecord
                    ? Container(
                        color: NaturalColors.lightBlueGrey.withOpacity(0.2),

                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: NaturalColors.black),
                                  children: [
                                    const TextSpan(
                                        text: "On this day there are "),
                                    TextSpan(
                                      text: "${state.recordLectures} ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: TextColors.blueGrey,
                                      ),
                                    ),
                                    const TextSpan(text: "lectures of "),
                                    TextSpan(
                                      text: state.selectedSubjectInRecord ??
                                          'this',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: TextColors.blueGrey,
                                      ),
                                    ),
                                    const TextSpan(
                                        text:
                                            " subject and you are present in "),
                                    TextSpan(
                                      text: '${state.recordPresent}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: TextColors.successColor,
                                      ),
                                    ),
                                    const TextSpan(text: " and absent in "),
                                    TextSpan(
                                      text: "${state.recordAbsent}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: TextColors.errorColor),
                                    ),
                                    const TextSpan(text: " lectures."),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "This month's Percentage of this Subject: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                    textScaleFactor: 2,
                                  ),
                                  Text(
                                    state.recordMonthPercent.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: TextColors.successColor),
                                    textScaleFactor: 2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: NaturalColors.black),
                                    ),
                                  ),
                                  elevation: MaterialStateProperty.all(30.0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black45),
                                ),
                                onPressed: () {
                                  cubit.onDoneRecordClicked();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textScaleFactor: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                          style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: NaturalColors.black),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(30.0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black45),
                          ),
                          onPressed: () async {
                            await cubit.onSelectedSubjectInRecord(
                                state.selectedDate ??
                                    DateTime.now(),context);
                          },
                          child: const Text(
                            'Show Record',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textScaleFactor: 2,
                          ),
                        ),
                    ),
              )
            ],
          ),
        );
      },
    );
  }
}
