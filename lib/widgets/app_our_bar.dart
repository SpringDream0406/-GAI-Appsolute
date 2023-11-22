import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/edit_my_information_page/edit_my_information_page.dart';
import 'package:flutter_test_project/pages/search_page/search_page.dart';

class OurAppBar extends StatelessWidget {
  final Color? backgroundColor;
  const OurAppBar({super.key, this.backgroundColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: backgroundColor!,
        expandedHeight: 56.0,
        elevation: 0,
        floating: true,
        pinned: false,
        primary: true,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8, left: 15),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/logo.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.5)),
                      ),
                      Text(
                        "Seb's Music",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton.outlined(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        SearchPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, -1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      EditMyInformationPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "HO",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                          margin: const EdgeInsets.only(right: 15),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purpleAccent.withOpacity(0.8)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]);
  }
}
