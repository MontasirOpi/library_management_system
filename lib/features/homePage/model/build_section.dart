import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/homePage/data/book.dart';
import 'package:library_management_system/features/homePage/model/supabase_book_service.dart';
import 'package:library_management_system/features/homePage/ui/screens/category_books_screen.dart';
import 'package:library_management_system/features/homePage/widgets/book_details_widget.dart';

class BuildSection extends StatefulWidget {
  const BuildSection({Key? key, required this.context, required this.category})
    : super(key: key);

  final BuildContext context;
  final String category;

  @override
  State<BuildSection> createState() => _BuildSectionState();
}

class _BuildSectionState extends State<BuildSection> {
  final BookService _bookService = BookService();
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _bookService.getBooksByCategory(widget.category);
      if (!mounted) return;
      setState(() {
        _books = books;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load books: $e')));
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            CategoryBooksScreen(category: widget.category),
                  ),
                );
              },
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child:
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _books.isEmpty
                  ? Center(child: Text('No ${widget.category} books available'))
                  : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _books.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final book = _books[index];
                      return SizedBox(
                        width: 150,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    book.image,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 100,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:
                                        () => _showBookDetails(context, book),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.themeColor,
                                      shape: const StadiumBorder(),
                                      minimumSize: const Size(80, 32),
                                    ),
                                    child: const Text(
                                      "View",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
