import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../constants/hive_constant.dart';
import '../models/profile_local_model.dart';
import '../models/profile_remote_model.dart';

abstract class ProfileLocalDatasource {
  Future<ProfileLocalModel> getProfileData();
  Future<void> saveProfileData(ProfileRemoteModel profileRemoteModel);
}

@LazySingleton(as: ProfileLocalDatasource)
class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  @override
  Future<ProfileLocalModel> getProfileData() async {
    final userProfileBox = await Hive.openBox(HiveBoxName.profileDataBox);

    return userProfileBox.get(HiveBoxName.profileDataBox) as ProfileLocalModel;
  }

  @override
  Future<void> saveProfileData(ProfileRemoteModel profileRemoteModel) async {
    final model = ProfileLocalModel.fromRemote(profileRemoteModel);

    final userProfileBox = await Hive.openBox(HiveBoxName.profileDataBox);

    await userProfileBox.put(HiveBoxName.profileDataBox, model);
  }
}
