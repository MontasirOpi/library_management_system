import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/homePage/data/book.dart';

import 'package:library_management_system/features/homePage/model/supabase_book_service.dart';
import 'package:library_management_system/features/homePage/widgets/book_details_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final BookService _bookService = BookService();
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final allBooks = await _bookService.getAllBooks();
      final results =
          allBooks
              .where(
                (book) =>
                    book.title.toLowerCase().contains(query.toLowerCase()) ||
                    book.subtitle.toLowerCase().contains(query.toLowerCase()) ||
                    book.category.toLowerCase().contains(query.toLowerCase()) ||
                    book.publisher.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    book.genre.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Search failed: $e')));
    }
  }

  void _showBookDetails(BuildContext context, Book book) {
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
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search books...',
            prefixIcon: Icon(Icons.search, color: AppColors.themeColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.themeColor),
            ),
          ),
          onChanged: (value) {
            if (value.length > 2) {
              _performSearch(value);
            } else if (value.isEmpty) {
              setState(() {
                _searchResults = [];
              });
            }
          },
        ),

        if (_isSearching)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          ),

        if (_searchResults.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            constraints: BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final book = _searchResults[index];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(book.image),
                        fit: BoxFit.cover,
                        onError:
                            (exception, stackTrace) => const AssetImage(
                              'assets/images/placeholder.png',
                            ),
                      ),
                    ),
                  ),
                  title: Text(book.title),
                  subtitle: Text(book.category),
                  onTap: () => _showBookDetails(context, book),
                );
              },
            ),
          ),
      ],
    );
  }
}
