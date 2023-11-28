import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_dashboard/presentation/dashboard_constants.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:feature_dashboard/presentation/journey/more/more_contants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/utils/screen_utils.dart';

// TODO(Melly): move to independent feature
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final moreBloc = Injector.resolve<MoreBloc>();
    return BlocListener<MoreBloc, MoreState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Injector.resolve<DashboardInteractionNavigation>()
              .navigateToLogin(context);
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.primary.c95,
        appBar: AppBar(
          title: Text(DashboardStrings.moreBottomNavBar.i18n(context)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return rowItem(
                    iconPath: MoreAssets.languageIcon,
                    title: LanguageState.enumValueFromLocale(state.locale),
                    onTap: () {},
                  );
                },
              ),
              rowItem(
                iconPath: MoreAssets.logoutIcon,
                title: MoreStrings.logout.i18n(context),
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: CustomColors.black.withOpacity(0.2),
                    builder: (context) => Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(),
                        ),
                        Center(
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(
                              LayoutDimen.dimen_10.w,
                            ),
                            child: Container(
                              height: LayoutDimen.dimen_230.h,
                              width: LayoutDimen.dimen_320.w,
                              padding: EdgeInsets.all(LayoutDimen.dimen_28.w),
                              decoration: BoxDecoration(
                                color: CustomColors.white,
                                borderRadius: BorderRadius.circular(
                                  LayoutDimen.dimen_10.w,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    MoreAssets.logoutDialogIcon,
                                    height: LayoutDimen.dimen_60.w,
                                    width: LayoutDimen.dimen_60.w,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    height: LayoutDimen.dimen_8.h,
                                  ),
                                  Text(
                                    MoreStrings.logoutDialogDesc.i18n(context),
                                    style: TextStyle(
                                      fontSize: LayoutDimen.dimen_18.minSp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: LayoutDimen.dimen_8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        width: LayoutDimen.dimen_70.w,
                                        title: MoreStrings.no.i18n(context),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        stretch: false,
                                        color: CustomColors.secondary.c90,
                                        margin: EdgeInsets.zero,
                                      ),
                                      FlatButton(
                                        width: LayoutDimen.dimen_70.w,
                                        title: MoreStrings.yes.i18n(context),
                                        onPressed: () {
                                          moreBloc.add(LogoutEvent());
                                        },
                                        stretch: false,
                                        margin: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem({
    required String iconPath,
    required String title,
    TextStyle? titleStyle,
    void Function()? onTap,
    Widget? additionalWidget,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.2,
              color: CustomColors.neutral.c60,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(iconPath),
                SizedBox(
                  width: LayoutDimen.dimen_8.w,
                ),
                Text(
                  title,
                  style: titleStyle ??
                      const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            if (additionalWidget != null) additionalWidget,
          ],
        ),
      ),
    );
  }
}
