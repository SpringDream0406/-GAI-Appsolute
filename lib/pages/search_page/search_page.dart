import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/search_page/widget/search_top_bar.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          BackgroundConceptColor(),
          SearchPageTopBar(),
        ]),
      ),
    );
  }
}
