import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class SocialMedia extends StatefulWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  late final WebViewController _controller;

  // This is the HTML content for the Twitter embed.
  final html = ''' 
    <!DOCTYPE html>
    <html lang="en">
    <body>
      <meta name='viewport' content='initial-scale=1.0'/>
      <a class="twitter-timeline" href="https://twitter.com/uscunion?ref_src=twsrc%5Etfw">Tweets by uscunion</a> 
      <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    </body>
    </html>
  ''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "Social",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: AppTheme.colors.uscuBurgendy,
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
