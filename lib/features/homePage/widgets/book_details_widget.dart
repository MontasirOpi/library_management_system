import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/common/widgets/custom_button.dart';
import 'package:library_management_system/features/homePage/data/book.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookDetails extends StatelessWidget {
  final Book book;

  const BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Details',
          style: TextStyle(color: AppColors.themeColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.themeColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            Container(
              height: 250,
              width: double.infinity,
              color: AppColors.themeColor.withOpacity(0.1),
              child: Center(
                child: Hero(
                  tag: book.title,
                  child: Image.network(
                    book.image,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (book.subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        book.subtitle,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Stock
                  Row(
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: book.stockNotifier,
                        builder: (context, stock, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: stock > 0 ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              stock > 0 ? 'Available' : 'Out of Stock',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      ValueListenableBuilder<int>(
                        valueListenable: book.stockNotifier,
                        builder: (context, stock, child) {
                          return Text('$stock copies in stock');
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Book Info
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailRow('Category', book.category),
                          _detailRow('Genre', book.genre),
                          _detailRow('Publisher', book.publisher),
                          _detailRow('Language', book.language),
                          _detailRow('Pages', book.pages.toString()),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: CustomButton(
          text: 'Borrow Book',
          onPressed: () async {
            final supabase = Supabase.instance.client;
            final user = supabase.auth.currentUser;

            if (user == null || book.stock <= 0) return;

            try {
              final existing = await supabase
                  .from('issued_books')
                  .select()
                  .eq('book_id', book.id)
                  .eq('user_id', user.id);

              if (existing.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You already borrowed this book.'),
                  ),
                );
                return;
              }

              // ✅ Step 2: Borrow the book (insert + reduce stock)
              await supabase.from('issued_books').insert({
                'book_id': book.id,
                'user_id': user.id,
              });

              await supabase
                  .from('books')
                  .update({'stock': book.stock - 1})
                  .eq('id', book.id);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Book borrowed successfully')),
              );

              Navigator.pop(context);
            } catch (e) {
              print('Borrow error: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error borrowing book')),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
