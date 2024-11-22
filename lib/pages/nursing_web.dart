import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NursingWeb extends StatefulWidget {
  const NursingWeb({Key? key}) : super(key: key);

  @override
  State<NursingWeb> createState() => _NursingWebState();
}

class _NursingWebState extends State<NursingWeb> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://sc.edu/about/system_and_campuses/union/study/nursing.php"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.uscuBurgendy,
        title: const Text(
          "Nursing Program Info",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
