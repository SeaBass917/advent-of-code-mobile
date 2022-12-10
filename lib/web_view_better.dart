import 'package:advent_of_code/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewBetter extends StatefulWidget {
  const WebViewBetter(this.url, this.cookieManager, {super.key});
  final Uri url;
  final CookieManager cookieManager;

  @override
  State<WebViewBetter> createState() => _WebViewBetter();
}

class _WebViewBetter extends State<WebViewBetter> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: widget.url),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(),
          ),
          onTitleChanged: (controller, title) {
            /// TODO: This is hacky. PLease be smarter about deciding when we are done. e.g. is the cookie here?
            if (title == "Advent of Code 2022") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ));
            }
          },
          onLoadStop: (controller, url) async {},
        ),
      ),
    );
  }
}
