import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_page/music_list_page.dart';
import 'package:flutter_test_project/pages/music_play_page/music_play_page.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page.dart';
import 'package:flutter_test_project/pages/home_page/home_page.dart';
import 'package:flutter_test_project/pages/my_info_Page/my_info_page.dart';
import 'package:flutter_test_project/pages/video_page/video_page.dart';
import 'package:flutter_test_project/widgets/global_keys.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool bottomsheet = false;
  bool isBottomBarVisible = true; // BottomNavigationBar의 표시 상태를 관리하는 변수
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    RankPage(),
    VideoPage(),
    MyPage(),
  ];

  // 바텀 네비게이션을 유지하고 브록 위에 네비게이터를 스탯쌓기 위한 글로벌 키
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void onTap(int index) {
    if (index == currentIndex) {
      navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  // 바텀 네비게이션의 커스텀
  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 35),
      label: label,
    );
  }

  void toggleBottomBarVisibility() {
    setState(() {
      isBottomBarVisible = !isBottomBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final currentNavigator = navigatorKeys[currentIndex].currentState;
        if (currentNavigator!.canPop()) {
          currentNavigator.pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            IndexedStack(
              index: currentIndex,
              children: pages
                  .map((page) => Navigator(
                        key: navigatorKeys[pages.indexOf(page)],
                        onGenerateRoute: (settings) =>
                            MaterialPageRoute(builder: (_) => page),
                      ))
                  .toList(),
            ),
            if (bottomsheet)
              GestureDetector(
                onTap: toggleBottomBarVisibility, // 탭 이벤트 처리
                child: DraggableScrollableSheet(
                  initialChildSize: 0.09, // 10% of screen height initially
                  minChildSize: 0.09, // 10% of screen height at minimum
                  maxChildSize: 0.8, // 80% of screen height at maximum
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      width: 100,
                      color: Colors.purple[900],
                    );
                  },
                ),
              ),
          ],
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isBottomBarVisible ? 55.0 : 0.0, // 애니메이션 적용
          child: Wrap(
            children: <Widget>[
              BottomNavigationBar(
                unselectedFontSize: 0,
                selectedFontSize: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black.withOpacity(0.9),
                onTap: onTap,
                currentIndex: currentIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.withOpacity(0.5),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                elevation: 0,
                items: [
                  _buildNavItem(Icons.home_filled, "Home"),
                  _buildNavItem(Icons.bar_chart_sharp, "Rank"),
                  _buildNavItem(Icons.subscriptions, "Search"),
                  _buildNavItem(Icons.library_music, "My"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
