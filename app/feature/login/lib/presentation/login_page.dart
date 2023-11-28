import 'package:feature_login/common/injector/injector.dart';
import 'package:feature_login/domain/navigation/interaction_navigation.dart';
import 'package:feature_login/presentation/bloc/login_bloc.dart';
import 'package:feature_login/presentation/login_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/theme_data.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/card/logo_image.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passworController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colorScheme = theme.appColorScheme;
    final loginBloc = Injector.resolve<LoginBloc>();
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
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Injector.resolve<LoginInteractionNavigation>()
                .navigateToDashboard(context);
          }
          if (state is LoginFailed) {
            SnackbarDialog().show(
              context: context,
              message: LoginStrings.errorMessage.i18n(context),
              type: SnackbarDialogType.failed,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                          emailTextField(context),
                          SizedBox(
                            height: LayoutDimen.dimen_40.h,
                          ),
                          passwordTextField(context),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: LayoutDimen.dimen_126.h,
                          bottom: LayoutDimen.dimen_32.h,
                        ),
                        child: FlatButton(
                          title: LoginStrings.loginButton.i18n(context),
                          onPressed: () {
                            loginBloc.add(
                              SubmitEmailAndPasswordEvent(
                                email: emailController.text,
                                password: passworController.text,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget emailTextField(BuildContext context) {
    return InputBasic(
      labelText: LoginStrings.email.i18n(context),
      controller: emailController,
    );
  }

  Widget passwordTextField(BuildContext context) {
    return InputBasic(
      labelText: LoginStrings.password.i18n(context),
      controller: passworController,
    );
  }
}
