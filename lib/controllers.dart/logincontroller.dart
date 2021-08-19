import 'package:booksports/mainhome.dart';
import 'package:booksports/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../APIstuffs/apistuffs.dart';
import 'testcontroller.dart';

class LoginController extends GetxController {
  APIStuffs stuffs = Get.find();
  TestController controller = Get.find();

  RxString username = "".obs;

  RxString password = ''.obs;
  User? user;

  login() async {
    controller.state.value = states.loading;
    await Future.delayed(Duration(seconds: 2), () {
// stuffs.login(username: username.value, password: password.value);
      return controller.state.value = states.home;
    });
  }

  googleSignIn() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    FirebaseAuth.instance.signInWithPopup(googleProvider).then((value) async {
      this.user = value.user;
      if (user != null) {
        bool status = await stuffs.saveNewUser(this.user!);
        if (status) {
          controller.state.value = states.home;
        }
      }
    });
  }
}
