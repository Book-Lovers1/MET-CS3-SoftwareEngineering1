import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../Features/home/data/models/book_model/book_model.dart';
import '../../../../core/utils/api_services.dart';
import '../../domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServise apiServise;

  HomeRemoteDataSourceImpl(this.apiServise);

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    final apiKey = dotenv.env['API_KEY']!;
    var data = await apiServise.get(
        endpoint:
            'volumes?Filtering=free-ebooks&Sorting=newest&q=programming&key=$apiKey');
    List<BookEntity> books = getBooksList(data);

    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];

    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
