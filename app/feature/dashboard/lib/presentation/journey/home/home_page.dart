import 'package:feature_dashboard/presentation/journey/home/bloc/home_bloc.dart';
import 'package:feature_dashboard/presentation/journey/home/home_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/theme_data.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colorScheme = theme.appColorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, 0.5),
          colors: [
            colorScheme.secondary,
            colorScheme.onSecondary,
          ],
        ),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CircularProgress();
          }
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(LayoutDimen.dimen_14.w),
                child: Builder(
                  builder: (context) {
                    if (state is HomeLoaded) {
                      final homeFeatures = state.homeFeatures;
                      final homeFeaturesLength = homeFeatures.length;
                      return Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: LayoutDimen.dimen_39.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  HomeAssets.logoSmall,
                                  width: LayoutDimen.dimen_80.w,
                                  fit: BoxFit.fitWidth,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      state.greeting.i18n(context),
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_18.minSp,
                                      ),
                                    ),
                                    Text(
                                      state.user.name,
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_24.minSp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: LayoutDimen.dimen_121.h,
                          ),
                          if (homeFeaturesLength == 1)
                            singleAccessCard(homeFeatures.first)
                          else
                            Wrap(
                              spacing: LayoutDimen.dimen_14.w,
                              runSpacing: LayoutDimen.dimen_13.h,
                              children: List.generate(
                                homeFeaturesLength,
                                (index) => accessCard(
                                  title: homeFeatures[index].title,
                                  iconPath: homeFeatures[index].iconPath,
                                  action: homeFeatures[index].action,
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget singleAccessCard(HomeFeature homeFeature) {
    return Card(
      elevation: 5,
      shape: const CircleBorder(),
      color: CustomColors.white,
      child: GestureDetector(
        onTap: homeFeature.action,
        child: Container(
          margin: EdgeInsets.all(LayoutDimen.dimen_16.h),
          width: LayoutDimen.dimen_269.h,
          height: LayoutDimen.dimen_269.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.white,
            border: Border.all(
              width: LayoutDimen.dimen_3.minSp,
              color: CustomColors.neutral.c80,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    homeFeature.iconPath,
                    width: LayoutDimen.dimen_40.w,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    homeFeature.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_18.minSp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget accessCard({
    required String title,
    required String iconPath,
    void Function()? action,
  }) {
    return InkWell(
      onTap: action,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
        child: Container(
          padding: EdgeInsets.all(LayoutDimen.dimen_12.w),
          width: LayoutDimen.dimen_166.w,
          height: LayoutDimen.dimen_100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                width: LayoutDimen.dimen_40.w,
                fit: BoxFit.fitWidth,
              ),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: LayoutDimen.dimen_18.minSp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
