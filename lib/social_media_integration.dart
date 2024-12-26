import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SocialMediaIntegrationPage extends StatelessWidget {
  const SocialMediaIntegrationPage({super.key});

  void _shareResults() {
    Share.share('I just played Truth or Dare and it was awesome!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Results'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _shareResults,
          child: const Text('Share Results'),
        ),
      ),
    );
  }
}