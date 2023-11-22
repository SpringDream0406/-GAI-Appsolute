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
              left: screenWidth / 2 - 75,
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: AppLargeText(
                        text: "HO",
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(75),
                    ),
                  ),
                  SizeBoxH10(),
                  AppLargeText(
                    text: "HOHOMEN",
                    color: Colors.white,
                  ),
                  SizeBoxH10(),
                  AppText(
                    text: "hohomen8939",
                    size: 23,
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
