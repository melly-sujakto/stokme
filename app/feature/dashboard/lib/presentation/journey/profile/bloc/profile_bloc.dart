import 'package:data_abstraction/entity/role_entity.dart';
import 'package:data_abstraction/entity/store_entity.dart';
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
      emit(ProfileLoading());
      try {
        final user = await dashboardUsecase.getUserDetail();
        final storeDetail = await dashboardUsecase.getStoreDetail(user.storeId);
        final role =
            await dashboardUsecase.getRoleDetail(user.roleId.toString());
        emit(
          ProfileLoaded(
            user: user,
            store: storeDetail,
            role: role,
          ),
        );
      } catch (e) {
        emit(ProfileFailed());
      }
    });
  }
}
