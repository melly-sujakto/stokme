import 'package:feature_login/presentation/routes.dart' as feature_login;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:module_common/i18n/app_localizations.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:module_common/presentation/global_routes.dart';
import 'package:stokme/presentation/routes.dart';
import 'package:ui_kit/theme/bloc/app_theme_bloc.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.languageBloc,
    required this.appThemeBloc,
  }) : super(key: key);
  final LanguageBloc languageBloc;
  final AppThemeBloc appThemeBloc;

  List<BlocProvider> _getProviders() => [
        BlocProvider<LanguageBloc>.value(
          value: languageBloc
            ..add(
              LanguageInitialLoad(),
            ),
        ),
        BlocProvider<AppThemeBloc>.value(
          value: appThemeBloc,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        buildWhen: (context, state) => state is LanguageLoadedState,
        builder: (context, state) {
          return _StokmeApp(
            languageState: state,
            appThemeBloc: appThemeBloc,
          );
        },
      ),
    );
  }
}

class _StokmeApp extends StatelessWidget {
  const _StokmeApp({
    required this.languageState,
    required this.appThemeBloc,
  });

  final LanguageState languageState;
  final AppThemeBloc appThemeBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalRoutes.globalKey,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Builder(
            builder: (context) {
              ScreenUtil.init(context);
              appThemeBloc.add(
                AppThemeChange(
                  mode: AppThemeMode.light,
                ),
              );
              return BlocBuilder<AppThemeBloc, AppThemeState>(
                buildWhen: (previous, current) => current is AppThemeLoaded,
                builder: (context, state) {
                  if (state is AppThemeLoaded) {
                    return Theme(
                      data: state.data,
                      child: widget!,
                    );
                  }
                  return Container();
                },
              );
            },
          ),
        );
      },
      supportedLocales: [
        Locale(Languages.en.code),
        Locale(Languages.id.code),
      ],
      localizationsDelegates: [
        SLocalizationsDelegate(
          translations: languageState.translations,
          locale: languageState.locale,
        ),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: languageState.locale,
      initialRoute: feature_login.Routes.login,
      routes: Routes.all,
      // onGenerateRoute: Routes.getRoutesWithSettings,
      // navigatorObservers: [
      //   analytics.getNavigationObserver(),
      //   routeObserver,
      // ],
    );
  }
}
