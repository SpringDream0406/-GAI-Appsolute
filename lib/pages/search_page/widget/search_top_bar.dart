import 'package:flutter/material.dart';

class SearchPageTopBar extends StatelessWidget {
  const SearchPageTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        width: MediaQuery.of(context).size.width - 20,
        left: 10,
        top: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
              color: Colors.white,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.45,
                  height: 45,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decorationThickness: 0),
                    // onChanged: onChanged,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white30,
                      hintText: "노래, 앨범, 장르, 분위기를 검색하세요.",
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  color: Colors.white,
                )
              ],
            ),
          ],
        ));
  }
}
