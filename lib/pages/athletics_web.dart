import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AthleticsWeb extends StatefulWidget {
  const AthleticsWeb({Key? key}) : super(key: key);

  @override
  State<AthleticsWeb> createState() => _AthleticsWebState();
}

class _AthleticsWebState extends State<AthleticsWeb> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.uscunionathletics.com/landing/index"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: const Text(
          "Athletics Website",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
