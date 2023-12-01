import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:feature_dashboard/domain/navigation/usecase/home_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;

  HomeBloc(
    this.homeUsecase,
  ) : super(HomeInitial()) {
    on<GetFeaturesEvent>((event, emit) async {
      final userName = await homeUsecase.getUserName();
      emit(
        HomeLoaded(
          userName: userName ?? '',
          features: [],
        ),
      );
    });
  }
}
