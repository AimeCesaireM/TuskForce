import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String _policyText = '';

  @override
  void initState() {
    super.initState();
    _loadPrivacyPolicy();
  }

  Future<void> _loadPrivacyPolicy() async {
    final String policyText =
        await rootBundle.loadString('assets/docs/privacy_policy.md');
    setState(() {
      _policyText = policyText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.brown.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _policyText == ''
            ? Center(child: CircularProgressIndicator())
            : Markdown(data: _policyText),
      ),
    );
  }
}
