import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({super.key});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse('https://lms.hcmut.edu.vn/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LMS'),
        backgroundColor: const Color.fromRGBO(25, 94, 182, 1),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
