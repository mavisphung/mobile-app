import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Center(child: Text('SEARCH RESULT PAGE')),
    );
  }
}
