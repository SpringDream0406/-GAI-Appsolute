import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/animaited_card.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class ProducerBox extends StatefulWidget {
  const ProducerBox({super.key});

  @override
  State<ProducerBox> createState() => _ProducerBoxState();
}

class _ProducerBoxState extends State<ProducerBox>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 60,
          height: MediaQuery.of(context).size.height - 200,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 20,
                child: AnimatedCard(
                  width: 150,
                  height: 225,
                  cardColor: Colors.redAccent,
                  zAngle: -15,
                  widget: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH10(),
                        AppLargeText(
                          size: 28,
                          text: "CAPTAIN",
                          color: Colors.white,
                        ),
                        SizeBoxH20(),
                        AppLargeText(
                          text: "Lee ChanYong",
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 30,
                child: AnimatedCard(
                  width: 150,
                  height: 225,
                  cardColor: Colors.blueAccent,
                  zAngle: 15,
                  widget: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH10(),
                        AppLargeText(
                          text: "BACKEND",
                          color: Colors.white,
                          size: 28,
                        ),
                        SizeBoxH20(),
                        AppLargeText(
                          text: "Yang ChunMo",
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                left: 20,
                child: AnimatedCard(
                  width: 150,
                  height: 225,
                  cardColor: Colors.pinkAccent,
                  zAngle: -15,
                  widget: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH10(),
                        AppLargeText(
                          size: 28,
                          text: "BACKEND",
                          color: Colors.white,
                        ),
                        SizeBoxH20(),
                        AppLargeText(
                          text: "Choi ByeongMin",
                          size: 25,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 40,
                child: AnimatedCard(
                  width: 150,
                  height: 225,
                  cardColor: Colors.green,
                  zAngle: 15,
                  widget: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH10(),
                        AppLargeText(
                          size: 28,
                          text: "BACKEND",
                          color: Colors.white,
                        ),
                        SizeBoxH20(),
                        AppLargeText(
                          text: "Lee DongHeon",
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
