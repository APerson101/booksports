import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers.dart/maincontroller.dart';
import 'views/homeView.dart';
import 'views/notificationsView.dart';
import 'views/profileView.dart';
import 'views/searchView.dart';

enum pages { home, profile, search, notifications }

class MainHome extends StatelessWidget {
  MainHome({Key? key}) : super(key: key);
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodycontent(),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    Icon icon = Icon(Icons.home);
    return Obx(() {
      return BottomNavigationBar(
          selectedItemColor: Colors.green,
          currentIndex: pages.values.indexOf(controller.currentPage.value),
          onTap: (newIndex) =>
              controller.currentPage.value = pages.values[newIndex],
          items: pages.values.map((e) {
            switch (e) {
              case pages.home:
                icon = Icon(Icons.home);
                break;
              case pages.profile:
                icon = Icon(Icons.person);
                break;
              case pages.search:
                icon = Icon(Icons.search);
                break;
              case pages.notifications:
                icon = Icon(Icons.notifications);
                break;
              default:
            }
            return BottomNavigationBarItem(
              label: describeEnum(e),
              icon: icon,
            );
          }).toList());
    });
  }

  Widget bodycontent() {
    return Obx(() {
      switch (controller.currentPage.value) {
        case pages.home:
          return HomeView();
        case pages.profile:
          return ProfileView();
        case pages.search:
          return SearchView();
        case pages.notifications:
          return NotificationsView();
        default:
          return Container(
            child: Center(child: Text("Error")),
          );
      }
    });
  }
}
