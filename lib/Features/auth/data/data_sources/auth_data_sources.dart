import '../../../../Features/auth/domain/entities/user_entity.dart';

import '../../../../core/utils/api_services.dart';

abstract class AuthDataSource {
  Future<List<UserEntity>> fetchUsers();
}

class AuthDataSourceImpl extends AuthDataSource {
  final AuthApiServise authApiServise;

  AuthDataSourceImpl(this.authApiServise);

  @override
  Future<List<UserEntity>> fetchUsers() async {
    var data = await authApiServise.get(
        url: 'volumes?Filtering=free-ebooks&Sorting=newest&q=programming');
    List<UserEntity> users = getUsersList(data);

    return users;
  }

  List<UserEntity> getUsersList(Map<String, dynamic> data) {
    List<UserEntity> users = [];

    // for (var userMap in data['users']) {
    //  users.add(UserModel.fromJson(bookMap));
    // }
    return users;
  }
}
