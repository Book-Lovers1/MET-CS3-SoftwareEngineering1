import 'package:library_app/Features/auth/data/data_sources/auth_data_sources.dart';
import 'package:library_app/Features/auth/domain/entities/user_entity.dart';
import 'package:library_app/Features/auth/domain/repos/auth_repo.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl({required this.authDataSource});
  @override
  Future<Either<Failure, List<UserEntity>>> fetchUsers() async {
    try {
      List<UserEntity> users;

      users = await authDataSource.fetchUsers();
      return right(users);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
