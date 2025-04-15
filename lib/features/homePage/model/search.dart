import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/homePage/data/book_list.dart';
import 'package:library_management_system/features/homePage/model/search_result.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (query) {
        if (query.trim().isEmpty) {
          return;
        }
        final foundBooks =
            BookList.books
                .where(
                  (book) =>
                      book.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
        if (foundBooks.isNotEmpty) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text("Search Results"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          foundBooks
                                  .map((book) => SearchResult(book: book))
                                  .toList()
                              as List<Widget>,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
          );
        } else {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("No Results"),
                  content: const Text("No books found."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
          );
        }
      },
      decoration: const InputDecoration(
        icon: Icon(Icons.search, color: AppColors.themeColor),
        border: InputBorder.none,
        hintText: "Search",
      ),
    );
  }
}