import 'package:data_abstraction/entity/user_entity.dart';
import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_dashboard/domain/navigation/usecase/dashboard_usecase.dart';
import 'package:feature_dashboard/presentation/journey/home/home_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final DashboardUsecase dashboardUsecase;

  HomeBloc(
    this.dashboardUsecase,
  ) : super(HomeInitial()) {
    on<GetFeaturesEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final user = await dashboardUsecase.getUserDetail();
        final greeting = generateGreeting();
        final features = await dashboardUsecase.getAvailableFeatures();
        // ignore: use_build_context_synchronously
        final homeFeatures = convertToHomeFeature(
          context: event.context,
          features: features,
        );
        emit(
          HomeLoaded(
            user: user,
            greeting: greeting,
            homeFeatures: homeFeatures,
          ),
        );
      } catch (e) {
        emit(HomeFailed());
      }
    });
  }

  String generateGreeting() {
    final hourNow = DateTime.now().hour;
    switch (hourNow) {
      case > 3 && < 10:
        return HomeStrings.homeGreeting1;
      case > 10 && < 15:
        return HomeStrings.homeGreeting2;
      case > 15 && < 19:
        return HomeStrings.homeGreeting3;
      default:
        return HomeStrings.homeGreeting4;
    }
  }

  List<HomeFeature> convertToHomeFeature({
    required BuildContext context,
    required List<Feature> features,
  }) {
    return features
        .map((feature) {
          switch (feature) {
            case Feature.sale:
              return HomeFeature(
                feature: feature,
                iconPath: HomeAssets.saleIcon,
                title: HomeStrings.saleButtonTitle.i18n(context),
                action: () {
                  Injector.resolve<DashboardInteractionNavigation>()
                      .navigateToSale(context);
                },
              );
            case Feature.stockIn:
              return HomeFeature(
                feature: feature,
                title: HomeStrings.stockInButtonTitle.i18n(context),
                iconPath: HomeAssets.stockInIcon,
                action: () {
                  Injector.resolve<DashboardInteractionNavigation>()
                      .navigateToStockIn(context);
                },
              );
            case Feature.product:
              return HomeFeature(
                feature: feature,
                title: HomeStrings.productButtonTitle.i18n(context),
                iconPath: HomeAssets.productIcon,
                action: () {
                  Injector.resolve<DashboardInteractionNavigation>()
                      .navigateToProduct(context);
                },
              );
            case Feature.stock:
              return HomeFeature(
                feature: feature,
                title: HomeStrings.stockButtonTitle.i18n(context),
                iconPath: HomeAssets.stockIcon,
                action: () {
                  Injector.resolve<DashboardInteractionNavigation>()
                      .navigateToStock(context);
                },
              );
            case Feature.transaction:
              return HomeFeature(
                feature: feature,
                title: HomeStrings.transactionButtonTitle.i18n(context),
                iconPath: HomeAssets.transactionIcon,
                action: () {
                  Injector.resolve<DashboardInteractionNavigation>()
                      .navigateToTransaction(context);
                },
              );
            default:
              return null;
          }
        })
        .whereType<HomeFeature>()
        .toSet()
        .toList();
  }
}
