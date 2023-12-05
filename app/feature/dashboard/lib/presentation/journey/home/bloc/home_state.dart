part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailed extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserEntity user;
  final String greeting;
  final List<Feature> features;

  HomeLoaded({
    required this.user,
    required this.greeting,
    required this.features,
  });
}
