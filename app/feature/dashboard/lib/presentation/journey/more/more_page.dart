import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_dashboard/presentation/dashboard_constants.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:feature_dashboard/presentation/journey/more/more_contants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/package/bluetooth_print.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/dialog/confirmation_dialog.dart';
import 'package:ui_kit/ui/dialog/plain_dialog.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late final MoreBloc moreBloc;

  @override
  void initState() {
    moreBloc = Injector.resolve<MoreBloc>()..add(PrepareMoreDataEvent());
    super.initState();
  }

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
                      rowCameraAsScanner(context),
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
              moreBloc.add(LogoutEvent());
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
    return rowItem(
      iconPath: MoreAssets.printerIcon,
      child: BlocBuilder<MoreBloc, MoreState>(
        builder: (context, state) {
          return InkWell(
            onTap: state is MoreDataLoaded
                ? () {
                    PlainDialog(
                      content: Container(
                        height: LayoutDimen.dimen_156.h +
                            LayoutDimen.dimen_55 * state.devices.length,
                        padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
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
                              child: ListView(
                                children: [
                                  if (state.devices.length > 1)
                                    Flexible(
                                      child: _printerRowItem(
                                        device: BluetoothDevice()
                                          ..name = MoreStrings.alwaysAsk
                                              .i18n(context),
                                        onTap: () {
                                          moreBloc.add(
                                            ResetDefaultPrinter(),
                                          );
                                          Navigator.pop(context);
                                        },
                                        isDefault: state.defaultDevice == null,
                                      ),
                                    ),
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.devices.length,
                                      itemBuilder: (context, index) =>
                                          _printerRowItem(
                                        device: state.devices[index],
                                        onTap: () {
                                          moreBloc.add(
                                            SetDefaultPrinter(
                                              state.devices[index],
                                            ),
                                          );
                                          Navigator.pop(context);
                                        },
                                        isDefault: state.defaultDevice !=
                                                null &&
                                            state.defaultDevice!.address ==
                                                state.devices[index].address,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).show(context);
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    MoreStrings.printer.i18n(context),
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
                      state is MoreDataLoaded &&
                              state.defaultDevice != null &&
                              state.defaultDevice!.name != null
                          ? state.defaultDevice!.name!
                          : MoreStrings.alwaysAsk.i18n(context),
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_14.minSp,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _printerRowItem({
    required BluetoothDevice device,
    Function()? onTap,
    bool isDefault = false,
  }) {
    return InkWell(
      onTap: onTap,
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
          device.name ?? MoreStrings.unknownName.i18n(context),
          style: TextStyle(
            fontSize: LayoutDimen.dimen_16.minSp,
            fontWeight: isDefault ? FontWeight.bold : FontWeight.w100,
          ),
        ),
      ),
    );
  }

  Widget rowCameraAsScanner(BuildContext context) {
    return rowItem(
      iconPath: MoreAssets.barcodeIcon,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              MoreStrings.alwaysUseCameraAsScanner.i18n(context),
              style: TextStyle(
                fontSize: LayoutDimen.dimen_16.minSp,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutDimen.dimen_16.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<MoreBloc, MoreState>(
                  builder: (context, state) {
                    if (state is MoreDataLoaded) {
                      return Switch(
                        value: state.alwaysUseCameraAsScanner,
                        trackOutlineColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return CustomColors.neutral.c50;
                          }
                          return CustomColors.neutral.c40;
                        }),
                        trackColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return CustomColors.secondary.c50;
                          }
                          return CustomColors.neutral.c40;
                        }),
                        onChanged: (value) {
                          moreBloc.add(SetAlwaysUseCameraAsScanner(value));
                        },
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(right: LayoutDimen.dimen_8.w),
                      width: LayoutDimen.dimen_20.w,
                      height: LayoutDimen.dimen_20.w,
                      child: const CircularProgress(),
                    );
                  },
                ),
                SizedBox(width: LayoutDimen.dimen_6.w),
                InkWell(
                  onTap: () {
                    PlainDialog(
                      content: Center(
                        child: Padding(
                          padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                MoreAssets.warningIcon,
                                height: LayoutDimen.dimen_28.h,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: LayoutDimen.dimen_6.w),
                              Flexible(
                                child: Text(
                                  MoreStrings.useCameraHelpDescription
                                      .i18n(context),
                                  style: TextStyle(
                                    fontSize: LayoutDimen.dimen_16.minSp,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).show(context);
                  },
                  child: Image.asset(
                    MoreAssets.helpIcon,
                    height: LayoutDimen.dimen_28.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
