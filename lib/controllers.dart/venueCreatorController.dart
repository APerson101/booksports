import 'package:booksports/APIstuffs/apistuffs.dart';
import 'package:booksports/models/venueModel.dart';
import 'package:get/get.dart';

class VenueCreatorController extends GetxController {
  RxString location = "".obs;

  RxString description = ''.obs;

  RxString name = ''.obs;

  APIStuffs _apiStuffs = Get.find();

  createVenue() async {
    bool status = await _apiStuffs.createVenue(VenueModel(
        desription: description.value,
        facilities: ["facilities"],
        features: ["features"],
        location: location.value,
        name: name.value));
    status
        ? Get.snackbar("venue", "created success")
        : Get.snackbar("venue", "failed");
  }
}
