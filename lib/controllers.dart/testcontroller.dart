import '../test.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  Rx<states> state = states.loading.obs;

  //
  @override
  void onInit() {
    _authenticate();
    super.onInit();
  }

  _authenticate() async {
    //add authentication later, for now just do a wait for about a second
    await Future.delayed(
        Duration(seconds: 3), () => state.value = states.login);
  }
}
