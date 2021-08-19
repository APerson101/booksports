import 'package:booksports/controllers.dart/homecontroller.dart';
import 'package:booksports/models/sportsEvent.dart';
import 'package:booksports/models/userprofile.dart';
import 'package:booksports/views/profileView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

//display the most recent events and venues
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.status.value == "loading"
          ? Container(
              child: Center(child: CircularProgressIndicator.adaptive()),
            )
          :
          // return
          Scaffold(
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: getList(),
                  ),
                ),
              ),
            );
    });
  }

  getList() {
    List<SportsEvent> allEvents = controller.allEvents.value;
    print(allEvents.length);
    return allEvents.map((event) {
      return GestureDetector(
        onTap: () {
          // show details of all images and comments and likes?
          Get.defaultDialog(content: Container(child: Obx(() {
            return controller.commentLoadingStatus.value == "loading"
                ? Container(child: CircularProgressIndicator.adaptive())
                : allComments();
          })));
        },
        onDoubleTap: () {
          //like event
          controller.toggleLikeState(event);
        },
        child: Column(children: [
          Text(event.creatorName!),
          Text(event.description),
          Text(event.link),
          Text(event.commentCount.toString()),
          Text(event.likesCount.toString()),
          Text(event.location),
          Text(event.name),
          Text(event.attendance.toString()),
          Text(event.participant),
          Row(
            children: event.type.map((e) => Text(e)).toList(),
          ),
          // controller.checkifValid(event)
          //     ?
          ElevatedButton(
              onPressed: () => controller.makebooking(event),
              child: Text("book"))
          // : Container()
        ]),
      );
    }).toList();
  }

  allComments() {
    List<UserComments> allComments = controller.allComments.value;
    return Container(
      child: Column(children: [
        TextFormField(
            onChanged: (newComment) =>
                controller.commentText.value = newComment,
            decoration: InputDecoration(labelText: "Enter comment")),
        ElevatedButton(
            onPressed: () => controller.addComment(), child: Text("send")),
        Column(
            children: allComments
                .map((e) => Container(
                      child: Column(
                        children: [
                          Text(e.DateTime),
                          Text(e.comment),
                          Text(e.userName)
                        ],
                      ),
                    ))
                .toList()),
      ]),
    );
  }
}
