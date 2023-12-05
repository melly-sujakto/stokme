part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileFailed extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final StoreEntity store;
  final RoleEntity role;

  ProfileLoaded({
    required this.user,
    required this.store,
    required this.role,
  });
}
