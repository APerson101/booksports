import 'package:booksports/APIstuffs/apistuffs.dart';
import 'package:booksports/models/sportsEvent.dart';
import 'package:booksports/views/profilewidets/addNotifications.dart';
import 'package:get/get.dart';

class EventCreatorController extends GetxController {
  RxString customValue = "".obs;
  RxBool participantsType = false.obs;
  Rx<DateTime> userSelectedDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString location = "".obs;
  Rx<possibleEvents> eventdropdownvalue = possibleEvents.football.obs;
  APIStuffs _apiStuffs = Get.find();

  RxString description = ''.obs;

  RxString eventName = ''.obs;
  createEvent() async {
    bool status = await _apiStuffs.createEvent(SportsEvent(
        attendance: 0,
        description: description.value,
        link: "link",
        location: location.value,
        name: eventName.value,
        participant: participantsType.value ? "women only" : "all",
        type: ["football"],
        dateTimeCreated: DateTime.now().microsecondsSinceEpoch.toString()));
    status
        ? Get.snackbar("event", "created success")
        : Get.snackbar("event", "failed");
    Get.back();
  }
}
