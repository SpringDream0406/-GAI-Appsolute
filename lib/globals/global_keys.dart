import 'package:flutter/material.dart';

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

final List<GlobalKey<NavigatorState>> navigatorKeys =
    List.generate(4, (_) => GlobalKey<NavigatorState>());
