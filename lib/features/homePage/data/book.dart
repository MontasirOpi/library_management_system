class Book {
  final String title;
  final String subtitle;
  final String category;
  final String image;
  final String publisher;
  final String genre;
  final int pages;
  final int stock;
  final String description;
  final String language;

  Book({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.image,
    required this.publisher,
    required this.genre,
    required this.pages,
    required this.stock,
    required this.description,
    required this.language,
  });

  factory Book.fromMap(Map<String, String> map) {
    return Book(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      publisher: map['publisher'] ?? '',
      genre: map['genre'] ?? '',
      pages: int.tryParse(map['pages'] ?? '0') ?? 0,
      stock: int.tryParse(map['stock'] ?? '0') ?? 0,
      description: map['description'] ?? '',
      language: map['language'] ?? '',
    );
  }
}
