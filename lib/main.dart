import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubit_logics.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/pages/music_list_album_page/cubit/music_list_album_page_info_cubits.dart';
import 'package:flutter_test_project/pages/music_list_artist_page/cubit/music_list_artist_page_info_cubits.dart';
import 'package:flutter_test_project/pages/music_list_page/cubit/music_list_page_info_cubits.dart';
import 'package:flutter_test_project/services/data_services.dart';
import 'package:flutter_test_project/widgets/global_keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: mainNavigatorKey,
        title: "Flutter Demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AppCubits>(
              create: (context) => AppCubits(
                data: DataServices(),
              ),
            ),
            BlocProvider<MusicListPageInfoCubits>(
              create: (context) => MusicListPageInfoCubits(),
            ),
            BlocProvider<MusicListArtistPageInfoCubits>(
              create: (context) => MusicListArtistPageInfoCubits(),
            ),
            BlocProvider<MusicListAlbumPageInfoCubits>(
              create: (context) => MusicListAlbumPageInfoCubits(),
            )
          ],
          child: const AppCubitLogics(),
        ));
  }
}
