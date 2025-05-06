import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_management_system/features/homePage/data/book.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final supabase = Supabase.instance.client;
  String? userId;
  List<Map<String, dynamic>> overdueBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userId = supabase.auth.currentUser?.id;
    fetchOverdueBooks();
  }

  Future<void> fetchOverdueBooks() async {
    try {
      final response = await supabase
          .from('issued_books')
          .select('issued_at, book:book_id (id, title, image)')
          .eq('user_id', userId!);

      final data = response as List;

      final now = DateTime.now();
      overdueBooks =
          data
              .where((row) {
                final issuedAt = DateTime.parse(row['issued_at']);
                final days = now.difference(issuedAt).inDays;
                return days > 7; // Assuming 7 days is the overdue period
              })
              .map((row) {
                return {
                  'book': Book.fromMap(row['book']),
                  'issuedAt': DateTime.parse(row['issued_at']),
                };
              })
              .toList();

      setState(() => isLoading = false);
    } catch (e) {
      print('Error fetching overdue books: $e');
      setState(() => isLoading = false);
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
          icon: const Icon(Icons.arrow_back, color: AppColors.themeColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
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
              : overdueBooks.isEmpty
              ? const Center(child: Text('No overdue books.'))
              : ListView.builder(
                itemCount: overdueBooks.length,
                itemBuilder: (context, index) {
                  final item = overdueBooks[index];
                  final book = item['book'] as Book;
                  final issuedAt = item['issuedAt'] as DateTime;
                  final daysOverdue =
                      DateTime.now().difference(issuedAt).inDays;

                  return ListTile(
                    leading: Image.network(
                      book.image,
                      height: 50,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.title),
                    subtitle: Text(
                      'Please return this book. Borrowed $daysOverdue days ago.',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
    );
  }
}
