import 'package:feature_dashboard/presentation/dashboard_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

// TODO(Melly): move to independent feature
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DashboardStrings.moreBottomNavBar.i18n(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return rowItem(
                  iconPath: 'assets/icons/language_icon.png',
                  title: LanguageState.enumValueFromLocale(state.locale),
                  onTap: () {},
                );
              },
            ),
            rowItem(
              iconPath: 'assets/icons/logout_icon.png',
              title: 'Keluar',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              onTap: () {},
            ),
          ],
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
