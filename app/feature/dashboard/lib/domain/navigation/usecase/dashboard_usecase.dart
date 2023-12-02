import 'package:data_abstraction/entity/role_entity.dart';
import 'package:data_abstraction/entity/store_entity.dart';
import 'package:data_abstraction/entity/user_entity.dart';
import 'package:data_abstraction/model/role_model.dart';
import 'package:data_abstraction/model/store_model.dart';
import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class DashboardUsecase {
  final SharedPreferencesWrapper sharedPreferencesWrapper;
  final FirebaseLibrary firebaseLibrary;

  DashboardUsecase({
    required this.sharedPreferencesWrapper,
    required this.firebaseLibrary,
  });

  Future<UserEntity> getUserDetail() async {
    final prefs = await sharedPreferencesWrapper.getPrefs();
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

  Future<StoreEntity> getStoreDetail(String storeId) async {
    const collectionName = 'store';

    final json = await firebaseLibrary.get(
      collectionName: collectionName,
      id: storeId,
    );

    json!['id'] = storeId;

    return StoreModel.fromJson(json);
  }

  Future<RoleEntity> getRoleDetail(String roleId) async {
    const collectionName = 'role';

    final json = await firebaseLibrary.get(
      collectionName: collectionName,
      id: roleId,
    );

    json!['id'] = roleId;

    return RoleModel.fromJson(json);
  }

  Future<List<Feature>> getAvailableFeatures() async {
    //TODO(Melly): generate features by role
    return <Feature>[];
  }
}
