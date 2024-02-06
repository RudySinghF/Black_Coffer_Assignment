import 'package:black_coffer/Player.dart';
import 'package:black_coffer/firebase/Controller/Vid_Details.dart';
import 'package:black_coffer/firebase/Models/Usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> video = ['My First Video'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> match = [];
    for (var v in video) {
      if (v.toLowerCase().contains(query.toLowerCase())) {
        match.add(v);
      }
    }
    return ListView.builder(
        itemCount: match.length,
        itemBuilder: (context, index) {
          var res = match[index];
          return ListTile(
            title: Text(res),
          );
        });
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> match = [];
    for (var v in video) {
      if (v.toLowerCase().contains(query.toLowerCase())) {
        match.add(v);
      }
    }
    return ListView.builder(
        itemCount: match.length,
        itemBuilder: (context, index) {
          var res = match[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => VideoPlayerScreen(
                  videoUrl:
                      "https://firebasestorage.googleapis.com/v0/b/blackcoffer-e1db1.appspot.com/o/videos%2F04Y2jY0TgBSI5wSw3eT2.mp4?alt=media&token=69394303-fd9a-4011-ab42-68236e659a47",
                  title: match[index],
                  name: "Rudransh Singh"));
            },
            child: ListTile(
              title: Text(res),
            ),
          );
        });
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
