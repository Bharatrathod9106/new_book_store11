import 'package:bookstore/Controller/PdfController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookPage extends StatelessWidget {
  final String bookUrl;

  const BookPage({Key? key, required this.bookUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.onBackground,

        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Book Title",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pdfController.pdfViewerKey.currentState?.openBookmarkView();
        },
        child: Icon(
          Icons.bookmark,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      body: SfPdfViewer.network(
        bookUrl,
        key: pdfController.pdfViewerKey,
        // key: _pdfViewerKey,
      ),
    );
  }
}
