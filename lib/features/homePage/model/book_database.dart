// import 'package:library_management_system/features/homePage/data/book.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class BookDatabase {
//   final _client = Supabase.instance.client;

//   // Stream of all books
//   final Stream<List<Book>> booksStream = Supabase.instance.client
//       .from('books')
//       .stream(primaryKey: ['id'])
//       .map((data) => data
//           .map((bookMap) => Book.fromMap(bookMap as Map<String, dynamic>))
//           .toList());

//   // Fetch a single book by ID
//   Future<Book?> getBookById(int id) async {
//     final response = await _client
//         .from('books')
//         .select()
//         .eq('id', id)
//         .maybeSingle();

//     if (response != null) {
//       return Book.fromMap(response);
//     }
//     return null;
//   }
// }
