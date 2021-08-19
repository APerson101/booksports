import 'package:booksports/APIstuffs/apistuffs.dart';
import 'package:booksports/models/userprofile.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  APIStuffs _apiStuffs = Get.find();
  RxList<EventBookings> eventbookingsHistory = <EventBookings>[].obs;
  RxList<VenueBookings> venueBookingsHistory = <VenueBookings>[].obs;
  RxList<UserComments> userComments = <UserComments>[].obs;
  RxList<Likes> likesHistory = <Likes>[].obs;

  Rx<UserModel> user = UserModel(
          name: "loading", gender: "loading", email: "loading", imageBucket: "")
      .obs;

  RxString commentstatus = 'loading'.obs;

  RxString likestatus = 'loading'.obs;
  @override
  void onInit() {
    loadProfile();
    super.onInit();
  }

  RxString profileLoading = "loading".obs;
  RxString bookingstatus = "loading".obs;

  logOut() {
    Future.delayed(Duration(seconds: 1), () {
      // Get.off
    });
  }

  deleteAccount() {
    //
  }

  loadProfile() async {
    profileLoading.value = "loading";
    this.user.value = await _apiStuffs.loadProfile();
    profileLoading.value = "done";
  }

  loadEventBookings() async {
    this.eventbookingsHistory.value = await _apiStuffs.loadEventBookings();
    bookingstatus.value = "done";
  }

  loadVenueBookings() async {
    this.venueBookingsHistory.value = await _apiStuffs.loadVenueBookings();
    bookingstatus.value = "done";
  }

  loadComments() async {
    this.userComments.value = await _apiStuffs.loadComments();
    commentstatus.value = "done";
  }

  loadLikes() async {
    this.likesHistory.value = await _apiStuffs.loadlikes();
    likestatus.value = "done";
  }

  cancelVenueBooking(VenueBookings currentBooking) async {
    _apiStuffs.changeVenueBookingStatus(currentBooking.bookingID);
  }

  deleteComment(UserComments currentComment) async {
    _apiStuffs.deleteComment();
  }

  unlike(Likes currentLike) async {
    _apiStuffs.unlike(currentLike);
  }

  cancelEventBooking(EventBookings currentBooking) async {
    bool status =
        await _apiStuffs.changeEventBookingStatus(currentBooking.bookedID);
    if (status) Get.snackbar("booking", "succesfully cancelled");
  }
}
