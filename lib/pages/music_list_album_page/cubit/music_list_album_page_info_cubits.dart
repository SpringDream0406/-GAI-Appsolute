import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_test_project/pages/music_list_album_page/cubit/music_list_album_page_info_states.dart';

class MusicListAlbumPageInfoCubits
    extends Cubit<List<MusicListAlbumPageInfoState>> {
  MusicListAlbumPageInfoCubits() : super([]);

  addMusicListAlbumPageInfo(String? name, int? index, Color? color) {
    var list = state;
    print('나의 리스트 길이+ ${list.length}');
    // 객체를 가져온 다음 (추가하고 목록을 내보냅니다.)
    emit([
      MusicListAlbumPageInfoState(name: name, index: index, color: color),
      ...state
    ]);
    //테스트와 공부를 위해 남겨둔 것입니다. 앨범을 눌러보면 리스트의 길이로 추가 된 것, 정보가 넘어온 것을 확인 할 수 있습니다.
    print('나의 리스트 길이+ ${state.length} ${state[0].name}');

    // 누른 버튼의 넘버를 가져오는 것을 직접 확인해 보세욧
    print("누른 버튼을 기억하는지? ${state.first.index}");
  }

  updateMusicListAlbumPageInfo(String? name, int? index, Color? color) {
    var myList = state;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i].name == name) {
        var rem = state.removeAt(i);
        // 이름: 페이지가 넘어 올 떄 가져온 이름, 인덱스는 내가 선택한 클릭한 객체(아이콘의 )의 값. ( 이것은 어느 페이지(이름을 기준으로)의 어느 정보(클린된)를 가져오는 것입니다.)
        // var rem = state.remove(MusicListPageInfoState(name:myList[i].name, index: myList[i].index));
      }
    }

    emit([
      MusicListAlbumPageInfoState(name: name, index: index, color: color),
      ...state
    ]);
  }

  updateMusicListAlbumPageWish(String? name, int? index, Color? color) {
    var myList = state;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i].name == name) {
        state.removeAt(i);
      }
    }

    // 이를 통해 우리는 항상 업데이트된 색상을 얻습니다. 하트 버튼 색상을 변경합니다.
    emit([
      MusicListAlbumPageInfoState(name: name, index: index, color: color),
      ...state
    ]);
  }
}
