import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers.dart/logincontroller.dart';
import 'controllers.dart/testcontroller.dart';
import 'mainhome.dart';

enum states {
  loading,
  home,
  login,
  signup,
}

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);
  TestController controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.state.value) {
        case states.loading:
          return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        case states.home:
          return MainHome();
        case states.login:
          return Login();
        default:
      }
      return Container();
    });
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            onChanged: (newtext) => controller.username.value = newtext,
            decoration: InputDecoration(labelText: "Enter email"),
          ),
          TextFormField(
            onChanged: (newtext) => controller.password.value = newtext,
            obscureText: true,
            decoration: InputDecoration(labelText: "Enter password"),
          ),
          ElevatedButton(
              onPressed: () async => await controller.googleSignIn(),
              child: Text("Login with google")),
          ElevatedButton(
              onPressed: () => controller.login(), child: Text("Login"))
        ],
      )),
    );
  }
}
