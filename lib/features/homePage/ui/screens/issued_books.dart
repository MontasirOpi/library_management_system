import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/common/widgets/action_button.dart';
import 'package:library_management_system/features/homePage/data/book_list.dart';
import 'package:library_management_system/features/homePage/data/book.dart';

class IssuedBooks extends StatelessWidget {
  const IssuedBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Book> issuedBooks = [BookList.books[0], BookList.books[6]];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Issued Books',
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: issuedBooks.length,
        itemBuilder: (context, index) {
          final book = issuedBooks[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      book.image,
                      height: 100,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${book.title} by ${book.author}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ActionButton(text: 'Return', onPressed: () {}),
                            const SizedBox(width: 12),
                            ActionButton(text: 'Reissue', onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
