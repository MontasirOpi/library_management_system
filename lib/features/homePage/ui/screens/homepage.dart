import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/auth/ui/screens/logout.dart';

import 'package:library_management_system/features/homePage/model/build_section.dart';
import 'package:library_management_system/features/homePage/model/search.dart';
import 'package:library_management_system/features/homePage/model/supabase_book_service.dart';
import 'package:library_management_system/features/homePage/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookService _bookService = BookService();
  List<String> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _bookService.getAllBooks();
      // Extract unique categories
      final uniqueCategories = <String>{};
      for (var book in books) {
        uniqueCategories.add(book.category);
      }

      setState(() {
        _categories = uniqueCategories.toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load categories: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Library App',
          style: TextStyle(color: AppColors.themeColor, fontSize: 20),
        ),
        centerTitle: true,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu, color: AppColors.themeColor),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actionsIconTheme: const IconThemeData(color: AppColors.themeColor),
        actions: [
          Padding(padding: EdgeInsets.only(right: 16.0), child: Logout()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Search(),
            ),
            const SizedBox(height: 20),

            // Sections
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _categories.isEmpty
                      ? const Center(child: Text('No categories available'))
                      : RefreshIndicator(
                        onRefresh: _loadCategories,
                        child: ListView.builder(
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            return BuildSection(
                              context: context,
                              category: _categories[index],
                            );
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
