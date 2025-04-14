import 'package:flutter/material.dart';
import 'package:library_management_system/features/homePage/data/book_list.dart';
import 'package:library_management_system/features/homePage/widgets/book_details.dart';
import 'package:library_management_system/features/homePage/data/book.dart';

class BuildSection extends StatelessWidget {
  const BuildSection({
    super.key,
    required this.context,
    required this.category,
  });

  final BuildContext context;
  final String category;
  void _showBookDetails(BuildContext context, Map<String, String> bookMap) {
    final book = Book(
      title: bookMap['title'] ?? '',
      subtitle: bookMap['subtitle'] ?? '',
      category: bookMap['category'] ?? '',
      image: bookMap['image'] ?? '',
      publisher: bookMap['publisher'] ?? '',
      genre: bookMap['genre'] ?? '',
      pages: int.tryParse(bookMap['pages'] ?? '0') ?? 0,
      stock: int.tryParse(bookMap['stock'] ?? '0') ?? 0,
      description: bookMap['description'] ?? '',
      language: bookMap['language'] ?? '',
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => FractionallySizedBox(
            heightFactor: 1.0,
            child: BookDetails(book: book),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        BookList.books.where((book) => book.category == category).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {}, child: const Text("View All")),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final book = filtered[index];
              return SizedBox(
                width: 150,
                child: Card(
                  color: Colors.white, // Set background color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            book.image,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                () => _showBookDetails(context, {
                                  'title': book.title,
                                  'subtitle': book.subtitle,
                                  'category': book.category,
                                  'image': book.image,
                                  'publisher': book.publisher,
                                  'genre': book.genre,
                                  'pages': book.pages.toString(),
                                  'stock': book.stock.toString(),
                                  'description': book.description,
                                  'language': book.language,
                                }),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: StadiumBorder(),
                              minimumSize: Size(80, 32),
                            ),
                            child: Text(
                              "View",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
