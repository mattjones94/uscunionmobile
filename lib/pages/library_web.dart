import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LibraryWebPage extends StatefulWidget {
  const LibraryWebPage({Key? key}) : super(key: key);

  @override
  State<LibraryWebPage> createState() => _LibraryWebPageState();
}

class _LibraryWebPageState extends State<LibraryWebPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.unionlibrary.org/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: const Text(
          "Carnegie Library",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
