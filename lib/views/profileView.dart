import 'package:booksports/controllers.dart/profileController.dart';
import 'package:booksports/views/profilewidets/eventCreator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'profilewidets/venueCreator.dart';

//show user profile or some rubbish
//add back button to take you back to the main profile
class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.profileLoading.value == "loading")
        return Center(child: CircularProgressIndicator.adaptive());
      else
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FlutterLogo(size: 30),
                Obx(() => Text(controller.user.value.name)),
                Obx(() => Text(controller.user.value.gender)),
                Obx(() => Text(controller.user.value.email)),
                ElevatedButton(
                    onPressed: () {}, child: Text("add notification")),
                ElevatedButton(
                    onPressed: () => Get.to(() => EventCreator()),
                    child: Text("create event")),
                ElevatedButton(
                    onPressed: () => Get.to(() => VenueCreator()),
                    child: Text("create venue")),
                ElevatedButton(
                    onPressed: () {}, child: Text("comment history")),
                ElevatedButton(onPressed: () {}, child: Text("likes history")),
                ElevatedButton(
                    onPressed: () async {
                      controller.loadEventBookings();
                      controller.loadVenueBookings();
                      Get.defaultDialog(content: BookingsHistory());
                    },
                    child: Text("bookings history or some trash")),
                ElevatedButton(
                    onPressed: () => controller.logOut(),
                    child: Text("logout")),
                ElevatedButton(
                    onPressed: () {
                      controller.deleteAccount();
                    },
                    child: Text("delete account")),
              ],
            ),
          ),
        );
    });
  }
}

class BookingsHistory extends StatelessWidget {
  BookingsHistory({Key? key}) : super(key: key);
  ProfileController _pController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _pController.bookingstatus.value == "loading"
          ? CircularProgressIndicator.adaptive()
          : content();
    });
  }

  content() {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _bookingsChildren(_pController))),
    );
  }
}

_bookingsChildren(ProfileController _pController) {
  List<Widget> allbookings = [];
  allbookings.addAll(_pController.eventbookingsHistory.map((currentBooking) {
    return Row(children: [
      Text(currentBooking.bookingType),
      Text(currentBooking.dateTime),
      Text(currentBooking.status),
      currentBooking.status == "confirmed"
          ? ElevatedButton(
              onPressed: () => _pController.cancelEventBooking(currentBooking),
              child: Text("cance"))
          : Container()
    ]);
  }).toList());

  allbookings.addAll(_pController.venueBookingsHistory.map((currentBooking) {
    return Row(children: [
      Text(currentBooking.venueName),
      Text(DateTime.fromMicrosecondsSinceEpoch(
              int.parse(currentBooking.dateTime))
          .toString()),
      Text(currentBooking.status),
      currentBooking.status == "confirmed"
          ? ElevatedButton(
              onPressed: () => _pController.cancelVenueBooking(currentBooking),
              child: Text("cance"))
          : Container()
    ]);
  }).toList());

  return allbookings;
}

class CommentHistory extends StatelessWidget {
  CommentHistory({Key? key}) : super(key: key);
  ProfileController _pController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _pController.commentstatus.value == "loading"
          ? CircularProgressIndicator.adaptive()
          : content();
    });
  }

  content() {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _pController.userComments.map((currentComment) {
                return Row(children: [
                  Text(currentComment.DateTime),
                  Text(currentComment.comment),
                  Text(currentComment.commentType),
                  ElevatedButton(
                      onPressed: _pController.deleteComment(currentComment),
                      child: Text("delete comment"))
                ]);
              }).toList())),
    );
  }
}

class LikesHistory extends StatelessWidget {
  LikesHistory({Key? key}) : super(key: key);
  ProfileController _pController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _pController.likestatus.value == "loading"
          ? CircularProgressIndicator.adaptive()
          : content();
    });
  }

  content() {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _pController.likesHistory.map((currentLike) {
                return Row(children: [
                  Text(currentLike.dateTime),
                  Text(currentLike.eventName),
                  ElevatedButton(
                      onPressed: () => _pController.unlike(currentLike),
                      child: Text("unlike"))
                ]);
              }).toList())),
    );
  }
}
