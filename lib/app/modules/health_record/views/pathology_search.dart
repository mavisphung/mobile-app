import 'package:flutter/material.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';

class PathologySearchDelegate extends SearchDelegate {
  List<String> searchTearms = pathologys.map((e) => Tx.getPathologyString(e.code, e.name)).toList();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var p in searchTearms) {
      if (p.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(p);
      }
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () => close(context, result),
          title: Text(result),
        );
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var p in searchTearms) {
      if (p.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(p);
      }
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
