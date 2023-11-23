import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubit_states.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/services/data_services.dart';
import 'package:flutter_test_project/services/sign_up_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data, required this.userData})
      : super(InitialState()) {
    emit(WelcomeState());
  }

  int currentIndex = 0;

  final DataServices data;
  final UserLoginService userData;

  late var places;
  late var lastResponse;

  void getData() async {
    try {
      emit(LoadingState());

      places = await data.getInfo();

      lastResponse = await userData.getDataModel();

      print("큐빗의 위치 : $lastResponse");

      // lastResponse = await UserLoginService.lastResponseBody;

      // lastResponse = "hi";

      // lastResponse = UserLoginService.lastResponseBody;

      // infoData = await userData.getData();

      emit(LoadedState(places, lastResponse));
    } catch (e) {}
  }
}
