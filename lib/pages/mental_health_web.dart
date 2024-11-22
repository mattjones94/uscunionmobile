import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MentalHealthWebPage extends StatefulWidget {
  const MentalHealthWebPage({Key? key}) : super(key: key);

  @override
  State<MentalHealthWebPage> createState() => _MentalHealthWebPageState();
}

class _MentalHealthWebPageState extends State<MentalHealthWebPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.mygroup.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: const Text(
          "MyGroup",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
