import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class CommunityGuidelinesScreen extends StatefulWidget {
  @override
  _CommunityGuidelinesScreenState createState() => _CommunityGuidelinesScreenState();
}

class _CommunityGuidelinesScreenState extends State<CommunityGuidelinesScreen> {
  String _markdownContent = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdownFile();
  }

  Future<void> _loadMarkdownFile() async {
    final String content = await rootBundle.loadString('assets/docs/community_guidelines.md');
    setState(() {
      _markdownContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Guidelines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _markdownContent.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Markdown(data: _markdownContent),
      ),
    );
  }
}