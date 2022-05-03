import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final title = argument["title"];
    final urlLink = argument["urlLink"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Palette.backgroundBoxColor,
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Palette.primaryColor,
        title: Text(title!,
            style: const TextStyle(color: Palette.backgroundBoxColor)),
      ),
      body: WebView(
        initialUrl: urlLink,
      ),
    );
  }
}
