part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailed extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserEntity user;
  final String greeting;
  final List<HomeFeature> homeFeatures;

  HomeLoaded({
    required this.user,
    required this.greeting,
    required this.homeFeatures,
  });
}

class HomeFeature {
  final Feature feature;
  final String iconPath;
  final String title;
  final void Function() action;

  HomeFeature({
    required this.feature,
    required this.iconPath,
    required this.title,
    required this.action,
  });
}
