import 'package:data_abstraction/entity/user_entity.dart';
import 'package:feature_dashboard/domain/navigation/usecase/dashboard_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  final DashboardUsecase dashboardUsecase;

  ProfileBloc(
    this.dashboardUsecase,
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      final user = await dashboardUsecase.getUserDetail();
      emit(ProfileLoaded(user: user));
    });
  }
}
