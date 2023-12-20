part of 'home_bloc.dart';

sealed class HomeEvent {}

class GetFeaturesEvent extends HomeEvent {
  final BuildContext context;

  GetFeaturesEvent(this.context);
}
