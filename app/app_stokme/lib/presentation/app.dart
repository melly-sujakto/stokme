import 'package:feature_dashboard/presentation/routes.dart'
    as feature_dashboard;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:module_common/i18n/app_localizations.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:module_common/presentation/global_routes.dart';
import 'package:stokme/presentation/routes.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.languageBloc,
  }) : super(key: key);
  final LanguageBloc languageBloc;

  List<BlocProvider> _getProviders() => [
        BlocProvider<LanguageBloc>.value(
          value: languageBloc
            ..add(
              LanguageInitialLoad(),
            ),
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
          );
        },
      ),
    );
  }
}

class _StokmeApp extends StatelessWidget {
  const _StokmeApp({
    required this.languageState,
  });

  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalRoutes.globalKey,
      debugShowCheckedModeBanner: false,
      // builder: (context, widget){
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //     child: Builder(
      //       builder: (context) {
      //         /// Add theme init event (SafiThemeChange) here
      //         /// due to it requires ScreenUtil to be initiated first.
      //         themeBloc.add(
      //           SafiThemeChange(
      //             mode: SafiThemeMode.light,
      //           )
      //         );
      //         return Splash(
      //           readyBuilder: (context, widget) => _buildReady(widget),
      //           transitionWidget: widget,
      //           splashCondition: () =>
      //               !S.isReady(context) ||
      //               languageState is! LanguageLoadedState,
      //         );
      //       },
      //     ),
      //   );
      // },
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: feature_dashboard.Routes.initial,
      routes: Routes.all,
      // onGenerateRoute: Routes.getRoutesWithSettings,
      // navigatorObservers: [
      //   analytics.getNavigationObserver(),
      //   routeObserver,
      // ],
    );
  }
}
