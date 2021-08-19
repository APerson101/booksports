import 'package:booksports/controllers.dart/searchcontroller.dart';
import 'package:booksports/models/sportsEvent.dart';
import 'package:booksports/models/venueModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  final SearchPageController controller = Get.put(SearchPageController());
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [
        TextFormField(
          onChanged: (newText) => controller.searchText.value = newText,
          decoration: InputDecoration(labelText: "Search"),
        ),
        Row(
          children: [
            Text("event"),
            Obx(() => Switch.adaptive(
                value: controller.searchtype.value,
                onChanged: (newValue) =>
                    controller.searchtype.value = newValue)),
            Text("venue")
          ],
        ),
        ElevatedButton(
            onPressed: () => controller.search(), child: Text("search")),
        Obx(() {
          if (controller.searchStarted.value == "true") {
            return searchContent();
          }
          if (controller.searchStarted.value == "searching") {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return Container();
        })
      ],
    )));
  }

  searchContent() {
    if (!controller.searchtype.value) {
      List<SportsEvent> result = controller.eventresult.value;
      if (result.isEmpty) return Center(child: Text("No result found"));
      return SingleChildScrollView(
        child: Column(
            children: result
                .map((e) => GestureDetector(
                      child: Row(children: [Text(e.name), Text(e.description)]),
                      onTap: () => viewDetails(e),
                    ))
                .toList()),
      );
    } else {
      List<VenueModel> venues = controller.venueresult.value;
      if (venues.isEmpty) return Center(child: Text("No result found"));
      return SingleChildScrollView(
          child: Column(
              children: venues
                  .map((e) => GestureDetector(
                        child:
                            Row(children: [Text(e.name), Text(e.desription)]),
                        onTap: () => viewVenueDetails(e),
                      ))
                  .toList()));
    }
  }

  viewVenueDetails(VenueModel venue) {
    Get.defaultDialog(
        content: Container(
      child: Column(
        children: [
          Text(venue.facilities.toString()),
          Text(venue.name),
          Text(venue.rating.toString()),
          Text(venue.location),
          Text(venue.facilities.toString()),
          Text(venue.desription),
          ElevatedButton(
              onPressed: () => controller.bookVenue(venue),
              child: Text("book Venue"))
        ],
      ),
    ));
  }

  viewDetails(SportsEvent event) {
    Get.defaultDialog(
        content: Container(
      child: Column(
        children: [
          Text(event.description),
          Text(event.name),
          Text(event.link),
          Text(event.location),
          Text(event.attendance.toString()),
          Text(event.participant),
          ElevatedButton(
              onPressed: () => controller.bookEvent(event),
              child: Text("book event"))
        ],
      ),
    ));
  }
}
