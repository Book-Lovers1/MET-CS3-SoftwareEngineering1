
import 'package:dartz/dartz.dart';
import '../../../auth/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, List<UserEntity>>> fetchUsers();
}