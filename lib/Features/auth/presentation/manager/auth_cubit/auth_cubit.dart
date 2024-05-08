import 'package:bloc/bloc.dart';
import 'package:library_app/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepoImpl) : super(AuthInitial());
    final AuthRepoImpl authRepoImpl;

  Future<void> fetchUsers() async {
    emit(AuthLoading());
    var result = await authRepoImpl.fetchUsers();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (users) => emit(AuthSuccess(users)),
    );
  }
}

