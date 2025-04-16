// lib/features/homePage/data/book_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_management_system/features/homePage/data/book.dart';

class BookService {
  final supabase = Supabase.instance.client;
  
  Future<List<Book>> getAllBooks() async {
    try {
      final data = await supabase
          .from('books')
          .select();
          
      return (data as List).map((bookData) {
        return Book(
          title: bookData['title'] ?? '',
          subtitle: bookData['subtitle'] ?? '',
          category: bookData['category'] ?? '',
          image: bookData['image'] ?? '',
          publisher: bookData['publisher'] ?? '',
          genre: bookData['genre'] ?? '',
          pages: bookData['pages'] ?? 0,
          stock: bookData['stock'] ?? 0,
          description: bookData['description'] ?? '',
          language: bookData['language'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }
  
  Future<List<Book>> getBooksByCategory(String category) async {
    try {
      final data = await supabase
          .from('books')
          .select()
          .eq('category', category);
      
      return (data as List).map((bookData) {
        return Book(
          title: bookData['title'] ?? '',
          subtitle: bookData['subtitle'] ?? '',
          category: bookData['category'] ?? '',
          image: bookData['image'] ?? '',
          publisher: bookData['publisher'] ?? '',
          genre: bookData['genre'] ?? '',
          pages: bookData['pages'] ?? 0,
          stock: bookData['stock'] ?? 0,
          description: bookData['description'] ?? '',
          language: bookData['language'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching books by category: $e');
      return [];
    }
  }
  
  Future<void> addBook(Book book) async {
    try {
      await supabase
          .from('books')
          .insert({
            'title': book.title,
            'subtitle': book.subtitle,
            'category': book.category,
            'image': book.image,
            'publisher': book.publisher,
            'genre': book.genre,
            'pages': book.pages,
            'stock': book.stock,
            'description': book.description,
            'language': book.language,
          });
    } catch (e) {
      print('Error adding book: $e');
      rethrow;
    }
  }
  
  Future<void> updateBook(String bookId, Map<String, dynamic> data) async {
    try {
      await supabase
          .from('books')
          .update(data)
          .eq('id', bookId);
    } catch (e) {
      print('Error updating book: $e');
      rethrow;
    }
  }
  
  Future<void> deleteBook(String bookId) async {
    try {
      await supabase
          .from('books')
          .delete()
          .eq('id', bookId);
    } catch (e) {
      print('Error deleting book: $e');
      rethrow;
    }
  }
  
  // Search function
  Future<List<Book>> searchBooks(String query) async {
    try {
      final data = await supabase
          .from('books')
          .select()
          .or('title.ilike.%$query%,subtitle.ilike.%$query%,category.ilike.%$query%');
          
      return (data as List).map((bookData) {
        return Book(
          title: bookData['title'] ?? '',
          subtitle: bookData['subtitle'] ?? '',
          category: bookData['category'] ?? '',
          image: bookData['image'] ?? '',
          publisher: bookData['publisher'] ?? '',
          genre: bookData['genre'] ?? '',
          pages: bookData['pages'] ?? 0,
          stock: bookData['stock'] ?? 0,
          description: bookData['description'] ?? '',
          language: bookData['language'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error searching books: $e');
      return [];
    }
  }
}