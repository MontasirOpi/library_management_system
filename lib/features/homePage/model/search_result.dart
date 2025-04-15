import 'package:flutter/material.dart';
import 'package:library_management_system/features/homePage/widgets/book_details.dart';
import 'package:library_management_system/features/homePage/data/book.dart';

class SearchResult extends StatelessWidget {
  final Book book;

  const SearchResult({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            book.image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(book.title),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetails(book: book)),
            );
          },
        ),
      ),
    );
  }
}