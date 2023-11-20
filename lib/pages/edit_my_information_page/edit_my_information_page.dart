import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/edit_my_information_page/widgets/edit_information_page_top_bar.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class EditMyInformationPage extends StatefulWidget {
  const EditMyInformationPage({super.key});

  @override
  State<EditMyInformationPage> createState() => _EditMyInformationPageState();
}

class _EditMyInformationPageState extends State<EditMyInformationPage> {
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
              left: screenWidth / 2 - 100,
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: AppLargeText(
                        text: "사용자 사진",
                      ),
                    ),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizeBoxH05(),
                  AppLargeText(
                    text: "사용자 이름",
                    color: Colors.white,
                  ),
                  SizeBoxH05(),
                  AppText(
                    text: "사용자 아이디",
                    size: 23,
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
