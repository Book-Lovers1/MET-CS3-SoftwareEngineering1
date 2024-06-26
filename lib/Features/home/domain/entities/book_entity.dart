
class BookEntity {
  final String bookId;
  final String? image;
  final String title;
  final String? authorName;
  final num? rating;

  BookEntity({
    required this.image,
    required this.title,
    required this.authorName,
    required this.rating,
    required this.bookId,
  });
}

