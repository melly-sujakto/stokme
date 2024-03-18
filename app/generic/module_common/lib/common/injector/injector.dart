import 'package:library_injection/package/kiwi.dart';
import 'package:module_common/common/utils/printer_util.dart';
import 'package:module_common/domain/usecase/language_usecase.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

part 'injector.g.dart';

abstract class Injector {
  static void init() {
    _$Injector()._configure();
  }

  static final T Function<T>([String name]) resolve = KiwiContainer().resolve;

  void _configure() {
    _configureBloc();
    _configureUseCase();
    _configureUtils();
    _configureLocalDatasource();
  }

  void _configureBloc();

  @Register.singleton(LanguageUsecase)
  void _configureUseCase();

  @Register.singleton(PrinterUtil)
  void _configureUtils();

  @Register.singleton(SharedPreferencesWrapper)
  void _configureLocalDatasource();
}
