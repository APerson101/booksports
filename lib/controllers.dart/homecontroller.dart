import 'package:booksports/APIstuffs/apistuffs.dart';
import 'package:booksports/models/sportsEvent.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  APIStuffs _apiStuffs = Get.find();
  RxString status = "loading".obs;
  RxList<SportsEvent> allEvents = <SportsEvent>[].obs;

  RxString commentLoadingStatus = 'loading'.obs;

  var allComments;

  var commentText;
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  // _apiStuffs

  loadData() {
    status.value = "loading";

    _apiStuffs.loadEvents().then((value) {
      allEvents.value = value;
      status.value = "done";
    });
  }

  checkifValid(SportsEvent current) {
    if (_apiStuffs.user!.gender == "M") {
      if (current.participant == "women_only")
        return false;
      else
        return true;
    }
    return true;
  }

  makebooking(SportsEvent event) async {
    bool status = await _apiStuffs.bookEvent(event);
    if (status)
      Get.snackbar("venue booking", "confirmed");
    else
      Get.snackbar("burst", "didnt work");
  }

  addComment() {}

  void toggleLikeState(SportsEvent event) {}
}
