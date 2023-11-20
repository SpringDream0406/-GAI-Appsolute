import 'package:flutter/material.dart';

void showToast(BuildContext context, String message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.9,
      left: MediaQuery.of(context).size.width / 2,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context)?.insert(overlayEntry);

  // 시간 지연 후 오버레이 제거
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
