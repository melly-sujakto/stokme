import 'dart:async';

import 'package:data_abstraction/entity/role_entity.dart';
import 'package:data_abstraction/entity/store_entity.dart';
import 'package:data_abstraction/entity/user_entity.dart';
import 'package:data_abstraction/model/role_model.dart';
import 'package:data_abstraction/model/store_model.dart';
import 'package:data_abstraction/repository/printer_repository.dart';
import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/package/bluetooth_print.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class DashboardUsecase {
  final SharedPreferencesWrapper sharedPreferencesWrapper;
  final FirebaseLibrary firebaseLibrary;
  final PrinterRepository printerRepository;

  DashboardUsecase({
    required this.sharedPreferencesWrapper,
    required this.firebaseLibrary,
    required this.printerRepository,
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

    final json = await firebaseLibrary.getById(
      collectionName: collectionName,
      id: storeId,
    );

    json!['id'] = storeId;

    return StoreModel.fromJson(json);
  }

  Future<RoleEntity> getRoleDetail(String roleId) async {
    const collectionName = 'role';

    final json = await firebaseLibrary.getById(
      collectionName: collectionName,
      id: roleId,
    );

    return RoleModel.fromJson(json!);
  }

  Future<List<Feature>> getAvailableFeatures() async {
    final prefs = await sharedPreferencesWrapper.getPrefs();
    final roleId = prefs.getInt(GenericConstants.roleId);
    switch (roleId) {
      case 1:
        return Feature.values;
      case 2:
        return [Feature.sale];
      case 3:
        return [Feature.stockIn];
      default:
        return <Feature>[];
    }
  }

  Future<void> logout() async {
    // clear shared prefs
    unawaited(sharedPreferencesWrapper.clear());
    // logout firebase
    await firebaseLibrary.auth.signOut();
  }

  Future<List<BluetoothDevice>> scanAvailablePrinters() {
    return printerRepository.scan();
  }

  Future<void> startPrint({
    required BluetoothDevice device,
    required List<LineText> lineTexts,
  }) {
    return printerRepository.startPrint(device: device, lineTexts: lineTexts);
  }

  Future<void> setDefaultPrinter(BluetoothDevice device) async {
    final prefs = await sharedPreferencesWrapper.getPrefs();
    await prefs.setString(GenericConstants.printerAddress, device.address!);
    await prefs.setString(GenericConstants.printerName, device.name!);
  }

  Future<BluetoothDevice?> getDefaultPrinter() async {
    BluetoothDevice? device;
    final prefs = await sharedPreferencesWrapper.getPrefs();
    final address = prefs.getString(GenericConstants.printerAddress);
    final name = prefs.getString(GenericConstants.printerName);
    if (address != null || name != null) {
      device = BluetoothDevice()
        ..name = name
        ..address = address;
    }
    return device;
  }

  Future<void> resetDefaultPrinter() async {
    final prefs = await sharedPreferencesWrapper.getPrefs();
    await prefs.remove(GenericConstants.printerAddress);
    await prefs.remove(GenericConstants.printerName);
  }
}
