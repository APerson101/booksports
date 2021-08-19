import 'package:booksports/APIstuffs/apistuffs.dart';
import 'package:booksports/models/sportsEvent.dart';
import 'package:booksports/models/venueModel.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  RxString searchText = "".obs;
  APIStuffs _apiStuffs = Get.find();
  RxList<SportsEvent> eventresult = <SportsEvent>[].obs;
  RxList<VenueModel> venueresult = <VenueModel>[].obs;

  RxString searchStarted = "false".obs;

  RxBool searchtype = false.obs;
  search() async {
    searchStarted.value = "searching";
    searchtype.value
        ? venueresult.value = await _apiStuffs.searchForVenue(searchText.value)
        : eventresult.value = await _apiStuffs.searchForEvent(searchText.value);
    searchStarted.value = "true";
  }

  bookVenue(VenueModel venue) async {
    bool status = await _apiStuffs.bookVenue(venue);
    Get.back();
    if (status)
      Get.snackbar("venue booking", "confirmed");
    else
      Get.snackbar("burst", "didnt work");
  }

  bookEvent(SportsEvent event) async {
    bool status = await _apiStuffs.bookEvent(event);
    Get.back();
    if (status)
      Get.snackbar("event booking", "confirmed");
    else
      Get.snackbar("burst", "didnt work");
  }
}
