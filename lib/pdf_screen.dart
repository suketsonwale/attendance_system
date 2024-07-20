import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool _isReady = false;
  PDFViewController? _pdfViewController;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/Syllabus.pdf');
      final Uint8List list = bytes.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/sample.pdf');
      await tempFile.writeAsBytes(list);

      setState(() {
        _filePath = tempFile.path;
      });
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              if (_currentPage > 0) {
                _currentPage--;
                _pdfViewController?.setPage(_currentPage);
              }
            },
          ),
          Center(child: Text('Page $_currentPage/$_totalPages')),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              if (_currentPage < _totalPages - 1) {
                _currentPage++;
                _pdfViewController?.setPage(_currentPage);
              }
            },
          ),
        ],
      ),
      body: _filePath == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: <Widget>[
          PDFView(
            filePath: _filePath!,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                _isReady = true;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _pdfViewController = pdfViewController;
            },
            onPageChanged: (page, total) {
              setState(() {
                _currentPage = page!;
              });
            },
          ),
          _isReady
              ? Offstage()
              : Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
