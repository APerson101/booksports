import 'package:booksports/controllers.dart/addnotificationscontroller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotifications extends StatelessWidget {
  AddNotifications({Key? key}) : super(key: key);
  AddNotificationsController controller = Get.put(AddNotificationsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("notify me about"),
            eventDropDown(),
            ButtonBar(
              children: [
                ElevatedButton(
                    onPressed: () {
                      //show scaffold notification
                      controller.setNotification();
                    },
                    child: Text("set")),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("cancel"))
              ],
            )
          ],
        ),
      ),
    );
  }

  eventDropDown() {
    return Obx(() {
      return DropdownButton<possibleEvents>(
          onChanged: (value) {
            if (value == possibleEvents.custom) {
              Get.defaultDialog(
                  onCancel: () {
                    controller.customValue.value = "";
                    Get.back();
                  },
                  onConfirm: () {
                    Get.back();
                  },
                  content: TextFormField(
                    onChanged: (newVal) =>
                        controller.customValue.value = newVal,
                    decoration: InputDecoration(labelText: "enter custom"),
                  ));
            }
            controller.eventdropdownvalue.value = value!;
          },
          value: controller.eventdropdownvalue.value,
          items: possibleEvents.values.map((e) {
            return DropdownMenuItem<possibleEvents>(
                value: e, child: Text(describeEnum(e)));
          }).toList());
    });
  }
}

enum possibleEvents {
  football,
  basekball,
  tennis,
  women_only_activities,
  custom
}
