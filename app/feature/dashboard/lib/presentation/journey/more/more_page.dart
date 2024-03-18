import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_dashboard/presentation/dashboard_constants.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:feature_dashboard/presentation/journey/more/more_contants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/dialog/confirmation_dialog.dart';
import 'package:ui_kit/ui/dialog/plain_dialog.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/utils/screen_utils.dart';

// TODO(Melly): move to independent feature
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoreBloc, MoreState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Injector.resolve<DashboardInteractionNavigation>()
              .navigateToLogin(context);
        }
      },
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: CustomColors.neutral.c98,
                appBar: AppBar(
                  title: Text(
                    DashboardStrings.moreBottomNavBar.i18n(context),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_19.minSp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowPrinters(context),
                      rowLanguage(),
                      rowLogout(context),
                    ],
                  ),
                ),
              ),
              if (languageState is LanguageLoading)
                const CircularProgress.fullPage()
            ],
          );
        },
      ),
    );
  }

  Widget leftIcon(String iconPath) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        LayoutDimen.dimen_16.w,
        LayoutDimen.dimen_16.w,
        LayoutDimen.dimen_8.w,
        LayoutDimen.dimen_16.w,
      ),
      child: Image.asset(
        iconPath,
        height: LayoutDimen.dimen_28.h,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget rowItem({
    required String iconPath,
    required Widget? child,
  }) {
    return Row(
      children: [
        leftIcon(iconPath),
        Expanded(
          child: Container(
            height: LayoutDimen.dimen_59.h,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.2,
                  color: CustomColors.neutral.c60,
                ),
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }

  Widget rowLogout(BuildContext context) {
    return rowItem(
      iconPath: MoreAssets.logoutIcon,
      child: InkWell(
        onTap: () {
          ConfirmationDialog(
            assetPath: MoreAssets.logoutDialogIcon,
            descriptionText: MoreStrings.logoutDialogDesc.i18n(context),
            cancelText: TranslationConstants.no.i18n(context),
            confirmText: TranslationConstants.yes.i18n(context),
            onConfirmed: () {
              Injector.resolve<MoreBloc>().add(LogoutEvent());
            },
          ).show(context);
        },
        child: Row(
          children: [
            Text(
              MoreStrings.logout.i18n(context),
              style: TextStyle(
                fontSize: LayoutDimen.dimen_16.minSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowLanguage() {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return rowItem(
          iconPath: MoreAssets.languageIcon,
          child: DropdownButton(
            isExpanded: true,
            value: LanguageState.enumValueFromLocale(state.locale),
            items: [
              Languages.id.value,
              Languages.en.value,
            ]
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_16.minSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
            icon: Container(),
            underline: Container(),
            padding: EdgeInsets.zero,
            onChanged: (value) {
              Injector.resolve<LanguageBloc>().add(
                ChangeLocale(
                  LanguageState.localeFromEnumValue(
                    value ?? Languages.id.value,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget rowPrinters(BuildContext context) {
    final items = [
      'Selalu Tanya',
      'Printer A',
      'Printer B',
    ];

    return rowItem(
      iconPath: MoreAssets.printerIcon,
      child: InkWell(
        onTap: () {
          PlainDialog(
            height:
                LayoutDimen.dimen_100.h + LayoutDimen.dimen_55 * items.length,
            content: Padding(
              padding: EdgeInsets.fromLTRB(
                LayoutDimen.dimen_16.w,
                LayoutDimen.dimen_16.h,
                LayoutDimen.dimen_16.w,
                0,
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.asset(
                      MoreAssets.printerIcon,
                      height: LayoutDimen.dimen_40.h,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: LayoutDimen.dimen_8.h,
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: LayoutDimen.dimen_16.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.2,
                                color: CustomColors.neutral.c60,
                              ),
                            ),
                          ),
                          child: Text(
                            items[index],
                            style: TextStyle(
                              fontSize: LayoutDimen.dimen_16.minSp,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).show(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Printer',
                style: TextStyle(
                  fontSize: LayoutDimen.dimen_16.minSp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: LayoutDimen.dimen_40.w),
                child: Text(
                  'Printer A',
                  style: TextStyle(
                    fontSize: LayoutDimen.dimen_14.minSp,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
