import 'package:data_abstraction/entity/user_entity.dart';
import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class DashboardUsecase {
  final SharedPreferencesWrapper _sharedPreferencesWrapper;

  DashboardUsecase(this._sharedPreferencesWrapper);

  Future<UserEntity> getUserDetail() async {
    final prefs = await _sharedPreferencesWrapper.getPrefs();
    final userName = prefs.getString(GenericConstants.userName);
    final email = prefs.getString(GenericConstants.email);
    final phone = prefs.getString(GenericConstants.phone);
    final roleId = prefs.getInt(GenericConstants.roleId);
    final storeId = prefs.getString(GenericConstants.storeId);

    final user = UserEntity(
      email: email!,
      name: userName!,
      phone: phone!,
      roleId: roleId!,
      storeId: storeId!,
    );

    return user;
  }

  Future<List<Feature>> getAvailableFeatures() async {
    //TODO(Melly): generate features by role
    return <Feature>[];
  }
}
