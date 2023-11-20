import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/edit_my_information_page/widgets/edit_information_page_top_bar.dart';
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
          EditInformationPageTopBar(),
          Positioned(
              top: 110,
              left: screenWidth / 2 -
                  (MediaQuery.of(context).size.width / 1.3 / 2),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 50,
                    child: TextField(
                      // onChanged: onChanged,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white30,
                        labelText: "노래, 앨범, 장르, 분위기를 검색하세요.",
                        hintText: "검색할 단어를 입력하세요.",
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizeBoxH05(),
                  AppLargeText(
                    text: "검색 페이지",
                    color: Colors.white,
                  ),
                  SizeBoxH05()
                ],
              )),
        ]),
      ),
    );
  }
}
