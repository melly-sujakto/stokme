import 'package:data_abstraction/entity/user_entity.dart';
import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:feature_dashboard/domain/navigation/usecase/home_usecase.dart';
import 'package:feature_dashboard/presentation/journey/home/home_constants.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;

  HomeBloc(
    this.homeUsecase,
  ) : super(HomeInitial()) {
    on<GetFeaturesEvent>((event, emit) async {
      final user = await homeUsecase.getUserDetail();
      final greeting = generateGreeting();
      emit(
        HomeLoaded(
          user: user,
          greeting: greeting,
          features: [],
        ),
      );
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
}
