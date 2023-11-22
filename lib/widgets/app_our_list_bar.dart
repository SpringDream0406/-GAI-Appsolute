import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/app_text.dart';

class OurAppListBar extends StatefulWidget {
  final Function(String)? onMenuSelected;
  final List<String> menu;
  final Color? backgroundColor;

  const OurAppListBar({
    super.key,
    required this.menu,
    this.backgroundColor = Colors.black,
    this.onMenuSelected,
  });

  @override
  State<OurAppListBar> createState() => _OurAppListBarState();
}

class _OurAppListBarState extends State<OurAppListBar> {
  int? selectedMenuIndex;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: widget.backgroundColor!,
      toolbarHeight: 68,
      elevation: 0,
      floating: false,
      pinned: true,
      primary: true,
      actions: [
        _buildMenuList(),
      ],
    );
  }

  Widget _buildMenuList() {
    return Container(
      width: MediaQuery.of(context).size.width - 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.menu.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(index);
        },
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    bool isSelected = index == selectedMenuIndex;
    return GestureDetector(
      onTap: () => {_onMenuItemTap(index)},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10, top: 13, bottom: 13),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white70 : Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.white70, width: 1.0),
        ),
        child: AppText(
          text: widget.menu[index],
          size: 16,
          color: isSelected ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }

  void _onMenuItemTap(int index) {
    setState(() {
      if (selectedMenuIndex == index) {
        // 이미 선택된 메뉴를 다시 클릭한 경우 선택 해제
        selectedMenuIndex = null;
      } else {
        // 새로운 메뉴를 선택한 경우
        selectedMenuIndex = index;
      }
    });
    widget.onMenuSelected?.call(widget.menu[index]);
  }
}
