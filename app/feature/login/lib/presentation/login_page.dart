import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/theme_data.dart';
import 'package:ui_kit/utils/screen_utils.dart';
import 'package:ui_kit/widgets/logo_image.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, -0.3),
          colors: [
            colorScheme.secondary,
            colorScheme.onSecondary,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: LayoutDimen.dimen_105.h,
                  ),
                  child: const LogoImage(),
                ),
                Column(
                  children: [
                    textFormField(labelText: 'Email'),
                    textFormField(labelText: 'Password'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: LayoutDimen.dimen_126.h,
                    bottom: LayoutDimen.dimen_32.h,
                  ),
                  child: button(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: LayoutDimen.dimen_16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                CustomColors.secondary.c60,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: SizedBox(
              height: LayoutDimen.dimen_50.w,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: LayoutDimen.dimen_19.minSp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textFormField({String labelText = ''}) {
    final textEditingController = TextEditingController();
    final focusNode = FocusNode();
    // TODO(Melly): improve with proper height
    return Padding(
      padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: CustomColors.neutral.c95,
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: CustomColors.secondary.c60,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: CustomColors.neutral.c95),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: CustomColors.neutral.c60,
            fontSize: LayoutDimen.dimen_18.minSp,
          ),
        ),
      ),
    );
  }
}
