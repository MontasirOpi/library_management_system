// import 'package:flutter/material.dart';
// import 'package:library_management_system/features/common/widgets/custom_button.dart';
// import 'package:library_management_system/features/homePage/data/book.dart';

// class BookDetails extends StatelessWidget {
//   final Book book;

//   const BookDetails({super.key, required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(book.image, height: 200, fit: BoxFit.cover),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 book.title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   book.subtitle,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Book Details',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Language : ${book.language}\n'
//                   'Publisher : ${book.publisher}\n'
//                   'Genre : ${book.genre}\n'
//                   'Pages: ${book.pages}',
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Only ${book.stock} left in Stock',
//                   style: const TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: CustomButton(
//                   text: 'ISSUE',
//                   onPressed: () {
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Book Issued: ${book.title}'),
//                         duration: const Duration(seconds: 2),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Description',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(book.description, style: const TextStyle(fontSize: 14)),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }