// ignore_for_file: use_build_context_synchronously

import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:attendance_app/utils/helper_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
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
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (index, isExpanded) {
                            cubit.toggleExpandedTile();
                          },
                          expandedHeaderPadding:
                              const EdgeInsets.fromLTRB(16, 8, 4, 0),
                          children: [
                            ExpansionPanel(
                              backgroundColor: Colors.transparent,
                              canTapOnHeader: true,
                              isExpanded: state.isExpandableTileExpanded,
                              headerBuilder: (context, isExpanded) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 4, 0),
                                  child: Text(
                                    (state.selectedSubject == null ||
                                            state.selectedSubject ==
                                                Unknown.UNKNOWN.name
                                        ? 'Select Subject'
                                        : state.selectedSubject!),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800
                                        //   color: _isExpanded ? Colors.blueAccent : Colors.black,
                                        ),
                                    textScaleFactor: 1.5,
                                  ),
                                );
                              },
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  state.subjects.length + 1,
                                  (index) {
                                    if (index == state.subjects.length) {
                                      return addNewSubjectButton(
                                        cubit,
                                        context,
                                      );
                                    }
                                    return subjectName(index, cubit);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        customCheckboxTile('Present', 1, cubit),
                        customCheckboxTile('Absent', 2, cubit),
                        customCheckboxTile('Day-Off', 3, cubit),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: NaturalColors.black),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(30.0),
                    backgroundColor: MaterialStateProperty.all(Colors.black45),
                  ),
                  onPressed: () async {
                    bool marked = await cubit.onMarkAttendanceClicked();
                    if (marked == true) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: NaturalColors.backgroundColor,
                          content: Text(
                            'Attendance Marked',
                            style: TextStyle(
                              color: TextColors.successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: NaturalColors.backgroundColor,
                          content: Text(
                            'Select Correct Fields!',
                            style: TextStyle(
                              color: TextColors.errorColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Mark Attendance',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.5,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addNewSubjectButton(
    AppCubit cubit,
    BuildContext context,
  ) {
    return cubit.state.isVisible == true
        ? addNewSubjectTextField(cubit, context)
        : Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8.0),
            child: Center(
              child: InkWell(
                onTap: cubit.onAddNewSubjectClicked,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  Widget subjectName(int index, AppCubit cubit) {
    return ListTile(
      leading: Text('${index + 1}'),
      title: Text(
        cubit.state.subjects[index],
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        // closing the expansion tile
        cubit.onListTileClicked(index);
        cubit.toggleExpandedTile();
      },
    );
  }

  Widget customCheckboxTile(String text, int val, AppCubit cubit) {
    return CheckboxListTile(
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        textScaleFactor: 2,
      ),
      value: cubit.state.isChecked == val,
      onChanged: (value) {
        cubit.onChecked(val);
      },
    );
  }

  Widget addNewSubjectTextField(AppCubit cubit, BuildContext context) {
    return Visibility(
      visible: cubit.state.isVisible,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: cubit.subjectFieldController,
                decoration: const InputDecoration(hintText: 'subject'),
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                cubit.onDoneSubjectClicked(context);
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
    );
  }
}
