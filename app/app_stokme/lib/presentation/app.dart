import 'package:feature_dashboard/presentation/routes.dart'
    as feature_dashboard;
import 'package:flutter/material.dart';
import 'package:module_common/presentation/global_routes.dart';
import 'package:stokme/presentation/routes.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _StokmeApp();
  }
}

class _StokmeApp extends StatelessWidget {
  const _StokmeApp();

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
      // supportedLocales: [
      //   Locale(Languages.en.code),
      //   Locale(Languages.fil.code),
      // ],
      // localizationsDelegates: [
      //   SLocalizationsDelegate(
      //     translations: languageState.translations,
      //     locale: languageState.locale,
      //   ),
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // locale: languageState.locale,
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
