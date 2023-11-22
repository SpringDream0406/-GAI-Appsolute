import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/edit_my_information_page/widgets/edit_information_page_top_bar.dart';
import 'package:flutter_test_project/pages/search_page/widget/search_top_bar.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

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
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(children: [
          BackgroundConceptColor(),
          SearchPageTopBar(),
          Positioned(
              top: 110,
              left: screenWidth / 2 -
                  (MediaQuery.of(context).size.width / 1.3 / 2),
              child: Column(
                children: [],
              )),
        ]),
      ),
    );
  }
}
