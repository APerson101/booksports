import 'package:booksports/controllers.dart/venueCreatorController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueCreator extends StatelessWidget {
  VenueCreator({Key? key}) : super(key: key);
  VenueCreatorController controller = Get.put(VenueCreatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onChanged: (newthing) => controller.name.value = newthing,
                decoration: InputDecoration(labelText: "Enter name"),
              ),
              TextFormField(
                onChanged: (newthing) =>
                    controller.description.value = newthing,
                decoration: InputDecoration(labelText: "Enter description"),
              ),
              TextFormField(
                onChanged: (newthing) => controller.location.value = newthing,
                decoration: InputDecoration(labelText: "Enter location"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.createVenue();
                  },
                  child: Text("create Venu")),
              ElevatedButton(
                  onPressed: () => Get.back(), child: Text("cancel")),
              // TextFormField(
              //   onChanged: (newthing) => controller.features.value = newthing,
              //   decoration: InputDecoration(labelText: "Enter features"),
              // ),
              // TextFormField(
              //   onChanged: (newthing) => controller.faclities.value = newthing,
              //   decoration: InputDecoration(labelText: "Enter faclities"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
