import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/common/widgets/action_button.dart';
import 'package:library_management_system/features/homePage/data/book.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IssuedBooks extends StatefulWidget {
  const IssuedBooks({super.key});

  @override
  State<IssuedBooks> createState() => _IssuedBooksState();
}

class _IssuedBooksState extends State<IssuedBooks> {
  final supabase = Supabase.instance.client;
  String? userId;
  List<Book> issuedBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userId = supabase.auth.currentUser?.id;
    fetchIssuedBooks();
  }

  Future<void> fetchIssuedBooks() async {
    try {
      final response = await supabase
          .from('issued_books')
          .select(
            'book:book_id (id, title, subtitle, category, image, publisher, genre, pages, stock, description, language)',
          )
          .eq('user_id', userId!);

      final booksData = response as List;

      setState(() {
        issuedBooks =
            booksData.map((row) {
              final bookMap = row['book'] as Map<String, dynamic>;
              return Book.fromMap(bookMap);
            }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching issued books: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> returnBook(Book book) async {
    try {
      // Delete from issued_books
      await supabase
          .from('issued_books')
          .delete()
          .eq('book_id', book.id)
          .eq('user_id', supabase.auth.currentUser!.id);

      // Update book stock
      await supabase
          .from('books')
          .update({'stock': book.stock + 1})
          .eq('id', book.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book returned successfully')),
      );

      // Refresh issued books list
      fetchIssuedBooks();
    } catch (e) {
      print('Error returning book: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to return book')));
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : issuedBooks.isEmpty
              ? const Center(child: Text('No books issued yet.'))
              : ListView.builder(
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
                            child: Image.network(
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
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    ActionButton(
                                      text: 'Return',
                                      onPressed: () {
                                        returnBook(book);
                                      },
                                    ),
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
