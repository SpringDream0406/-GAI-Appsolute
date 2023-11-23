import 'package:equatable/equatable.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object> get props => [];
}

// first 페이지(로그인, 회원가입, 어플소개)
class WelcomeState extends CubitStates {
  @override
  List<Object> get props => [];
}

// 로딩중
class LoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

// 로딩완료
class LoadedState extends CubitStates {
  LoadedState(this.places, this.lastResponse);

  final List<TestModel> places;
  final DataModel lastResponse;
  // final String lastResponse;

  @override
  List<Object> get props => [places, lastResponse];
}

class MainState extends CubitStates {
  @override
  List<Object> get props => [];
}

class RankPageState extends CubitStates {
  @override
  List<Object> get props => [];
}

class SearchPageState extends CubitStates {
  @override
  List<Object> get props => [];
}

class MyPageState extends CubitStates {
  @override
  List<Object> get props => [];
}

// //뮤직 플레이 페이지
// class MusicPlayState extends CubitStates {
//   MusicPlayState(this.place);
//   final TestModel place;
//   @override
//   List<Object> get props => [place];
// }
