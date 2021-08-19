import 'package:booksports/controllers.dart/eventCreatorController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'addNotifications.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

class EventCreator extends StatelessWidget {
  EventCreator({Key? key}) : super(key: key);
  EventCreatorController controller = Get.put(EventCreatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          eventcreatorMenu(),
          SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: eventBody(context),
              );
            }),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                  onPressed: () => Get.back(), child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.createEvent();
                  },
                  child: Text("Confirm"))
            ],
          )
        ]),
      ),
    );
  }

  eventcreatorMenu() {
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

  eventBody(BuildContext context) {
    switch (controller.eventdropdownvalue.value) {
      case possibleEvents.custom:
        return [
          TextFormField(
              onChanged: (newVal) => controller.customValue.value = newVal,
              decoration: InputDecoration(labelText: "enter custom event")),
          Row(children: [
            Text("General"),
            Obx(() => Switch(
                value: controller.participantsType.value,
                onChanged: (newv) => controller.participantsType.value = newv)),
            Text("women Only")
          ]),
          ElevatedButton(
            child: Text("Start Date"),
            onPressed: () => DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(), onConfirm: (date) {
              controller.userSelectedDate.value = date;
            }, currentTime: DateTime.now()),
          ),
          ElevatedButton(
            child: Text("End Date"),
            onPressed: () => DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(), onConfirm: (date) {
              controller.endDate.value = date;
            }, currentTime: DateTime.now()),
          ),
          TextFormField(
              onChanged: (newLocation) =>
                  controller.location.value = newLocation,
              decoration: InputDecoration(labelText: "Enter location")),
          TextFormField(
              onChanged: (name) => controller.eventName.value = name,
              decoration: InputDecoration(labelText: "Enter name")),
          TextFormField(
              onChanged: (name) => controller.description.value = name,
              decoration: InputDecoration(labelText: "Enter description")),
        ];
      default:
        return [
          TextFormField(
              decoration: InputDecoration(labelText: "Enter no of teams")),
          TextFormField(
              decoration:
                  InputDecoration(labelText: "Enter no of players per team")),
          TextFormField(
              decoration: InputDecoration(labelText: "Enter location")),
          Row(children: [
            Text("General"),
            Obx(() => Switch(
                value: controller.participantsType.value,
                onChanged: (newv) => controller.participantsType.value = newv)),
            Text("women Only")
          ]),
          ElevatedButton(
            child: Text("Start Date"),
            onPressed: () => DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(), onConfirm: (date) {
              controller.userSelectedDate.value = date;
            }, currentTime: DateTime.now()),
          ),
          ElevatedButton(
            child: Text("End Date"),
            onPressed: () => DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(), onConfirm: (date) {
              controller.endDate.value = date;
            }, currentTime: DateTime.now()),
          ),
          TextFormField(
              onChanged: (newLocation) =>
                  controller.location.value = newLocation,
              decoration: InputDecoration(labelText: "Enter location")),
        ];
    }
  }
}
