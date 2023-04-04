import 'dart:ui';

import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/page_tabs/page_tabs/tabs_map.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return SafeArea(
          top: false,
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor:
                  Brightness.light == true ? Colors.white : Colors.black45,
              title: Center(
                child: Text(
                  pageTabs[state.pageIndex]['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      // color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              height: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black45,
              backgroundColor: Colors.transparent,
              // pageTabs[_pageIndex]['navigationBarColour'],
              index: state.pageIndex,
              onTap: (index) {
                cubit.onPageIconClicked(index);
              },

              items: const [
                Icon(
                  Icons.notes,
                  color: Colors.white,
                ),
                Icon(
                  Icons.add_reaction_sharp,
                  color: Colors.white,
                ),
                Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                ),
              ],
            ),
            body: Stack(
              children: [
                if (state.isLoading == true)
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: NaturalColors.black.withOpacity(0.4),
                    child: Center(
                      child: SpinKitFoldingCube(
                        color: NaturalColors.white,
                      ),
                    ),
                  ),
                PageView(
                  controller: cubit.pageController,
                  onPageChanged: (index) {
                    cubit.onPageChanged(index);
                  },
                  children: [
                    pageTabs[0]['pageName'],
                    pageTabs[1]['pageName'],
                    pageTabs[2]['pageName'],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
