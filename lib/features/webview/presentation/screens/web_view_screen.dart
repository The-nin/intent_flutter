import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  String? _errorMessage;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() => _progress = progress);
            }
          },
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _errorMessage = null);
            }
          },
          onWebResourceError: (_) {
            if (mounted) {
              setState(() {
                _errorMessage = LocaleKeys.webView.error.tr();
                _progress = 100;
              });
            }
          },
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);

            return uri != null && _isAllowedUri(uri)
                ? NavigationDecision.navigate
                : NavigationDecision.prevent;
          },
        ),
      );

    final uri = Uri.tryParse(widget.url);

    if (uri == null || !_isAllowedUri(uri)) {
      _errorMessage = LocaleKeys.webView.errorLoadUrl.tr();
      return;
    }

    _controller.loadRequest(uri);
  }

  bool _isAllowedUri(Uri uri) {
    const allowedHosts = {'dummyjson.com', 'www.dummyjson.com'};

    return uri.scheme == 'https' && allowedHosts.contains(uri.host);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.webView.title.tr())),
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : Column(
              children: [
                if (_progress < 100)
                  LinearProgressIndicator(value: _progress / 100),
                Expanded(child: WebViewWidget(controller: _controller)),
              ],
            ),
    );
  }
}
