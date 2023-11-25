import 'package:feature_login/common/injector/injector.dart';
import 'package:feature_login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:stokme/data/navigation/interaction_navigation_impl.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Injector.resolve<LoginBloc>().add(CheckLoginStatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserloggedIn) {
          Injector.resolve<InteractionNavigationImpl>()
              .navigateToDashboard(context);
        } else {
          Injector.resolve<InteractionNavigationImpl>()
              .navigateToLogin(context);
        }
      },
      builder: (context, state) {
        // TODO(melly): implement proper splash
        return Container(color: Colors.white);
      },
    );
  }
}
