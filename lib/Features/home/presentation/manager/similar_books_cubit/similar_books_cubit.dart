import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/home_repo_impl.dart';
import '../../../domain/entities/book_entity.dart';
part 'similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepoImpl) : super(SimilarBooksInitial());
  final HomeRepoImpl homeRepoImpl;

  Future<void> fetchSimilarBooks() async {
    emit(SimilarBooksLoading());

    var result = await homeRepoImpl.fetchNewestBooks();
    result.fold(
      (failure) {
        emit(SimilarBooksFailure(failure.message));
      },
      (books) => emit(SimilarBooksSuccess(books)),
    );
  }
}
