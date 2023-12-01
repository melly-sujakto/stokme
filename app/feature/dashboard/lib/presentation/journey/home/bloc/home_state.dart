part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoaded extends HomeState {
  final String userName;
  final List<Feature> features;

  HomeLoaded({required this.userName, required this.features});
}
