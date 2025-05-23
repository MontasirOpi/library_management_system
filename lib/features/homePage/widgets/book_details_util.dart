import 'package:flutter/material.dart';
import 'package:library_management_system/features/homePage/data/book.dart';
import 'package:library_management_system/features/homePage/widgets/book_details_widget.dart';

class BookDetailsUtil {
  static void showBookDetails(BuildContext context, Book book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => FractionallySizedBox(
            heightFactor: 0.95,
            child: BookDetails(book: book),
          ),
    );
  }
}
