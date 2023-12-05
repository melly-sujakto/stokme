import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_dashboard/presentation/journey/home/bloc/home_bloc.dart';
import 'package:feature_dashboard/presentation/journey/home/home_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/theme_data.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colorScheme = theme.appColorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, 0.5),
          colors: [
            colorScheme.secondary,
            colorScheme.onSecondary,
          ],
        ),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CircularProgress();
          }
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(LayoutDimen.dimen_14.w),
                child: Column(
                  children: [
                    if (state is HomeLoaded)
                      Padding(
                        padding: EdgeInsets.only(top: LayoutDimen.dimen_39.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              HomeAssets.logoSmall,
                              width: LayoutDimen.dimen_80.w,
                              fit: BoxFit.fitWidth,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  state.greeting.i18n(context),
                                  style: TextStyle(
                                    fontSize: LayoutDimen.dimen_18.minSp,
                                  ),
                                ),
                                Text(
                                  state.user.name,
                                  style: TextStyle(
                                    fontSize: LayoutDimen.dimen_24.minSp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: LayoutDimen.dimen_121.h,
                    ),
                    Wrap(
                      spacing: LayoutDimen.dimen_14.w,
                      runSpacing: LayoutDimen.dimen_13.h,
                      children: [
                        accessCard(
                          title: HomeStrings.saleButtonTitle.i18n(context),
                          iconPath: HomeAssets.saleIcon,
                          action: () {
                            Injector.resolve<DashboardInteractionNavigation>()
                                .navigateToSale(context);
                          },
                        ),
                        accessCard(
                          title: HomeStrings.stockInButtonTitle.i18n(context),
                          iconPath: HomeAssets.stockInIcon,
                          action: () {
                            Injector.resolve<DashboardInteractionNavigation>()
                                .navigateToStockIn(context);
                          },
                        ),
                        accessCard(
                          title: HomeStrings.productButtonTitle.i18n(context),
                          iconPath: HomeAssets.productIcon,
                          action: () {
                            Injector.resolve<DashboardInteractionNavigation>()
                                .navigateToProduct(context);
                          },
                        ),
                        accessCard(
                          title: HomeStrings.stockButtonTitle.i18n(context),
                          iconPath: HomeAssets.stockIcon,
                          action: () {
                            Injector.resolve<DashboardInteractionNavigation>()
                                .navigateToStock(context);
                          },
                        ),
                        accessCard(
                          title:
                              HomeStrings.transactionButtonTitle.i18n(context),
                          iconPath: HomeAssets.transactionIcon,
                          action: () {
                            Injector.resolve<DashboardInteractionNavigation>()
                                .navigateToTransaction(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget accessCard({
    required String title,
    required String iconPath,
    void Function()? action,
  }) {
    return InkWell(
      onTap: action,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
        child: Container(
          padding: EdgeInsets.all(LayoutDimen.dimen_12.w),
          width: LayoutDimen.dimen_166.w,
          height: LayoutDimen.dimen_100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                width: LayoutDimen.dimen_40.w,
                fit: BoxFit.fitWidth,
              ),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: LayoutDimen.dimen_18.minSp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
