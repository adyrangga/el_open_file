import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Download & Open File',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Download & Open File'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _pdfUrl =
      'https://adyrangga.github.io/test_files/lorem-ipsum.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Download & open file on native/3rd party device file viewer',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _onPressHandler(
                    url: _pdfUrl,
                    fileName: _pdfUrl.split('/').last,
                  ),
                  child: const Text('Download & Open PDF'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _onPressHandler(
      {required String url, required String fileName}) async {
    final file = await _downloadFile(url, fileName);
    if (file == null) return;

    debugPrint('Path: ${file.path}');
    OpenFilex.open(file.path);
  }

  Future<File?> _downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();

    final file = File('${appStorage.path}/$fileName');

    final isExist = await File(file.path).exists();
    if (isExist) return file;

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
