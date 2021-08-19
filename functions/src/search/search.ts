import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import algoliasearch from "algoliasearch";

const ALGOLIA_ID = "LD90DSAJA6";
const ALGOLIA_ADMIN_KEY = "2b76f0436247e8e0618f8ea978a88b1a";
const ALGOLIA_SEARCH_KEY = "639980d5818c6a632e5408a947c3a53d";

const ALGOLIA_INDEX_NAME = "indexName";
const ALGOLIA_INDEX_NAME_2 = "indexName2";
const client = algoliasearch(ALGOLIA_ID, ALGOLIA_ADMIN_KEY);

// possible improvements,
// replace the delete and save thing with just add or save
export const onEventCreated=functions.firestore.document("Events/{eventID}")
    .onWrite((snapshot, context)=>{
      const beforeData=snapshot.before.exists;
      const afterData=snapshot.after.exists;
      if (beforeData && afterData) {
        // updating
        const index=client.initIndex(ALGOLIA_INDEX_NAME);
        index.deleteObject(context.params.eventID).then(()=>{
          const newEvent=snapshot.after.data()!;
          newEvent.objectID=context.params.eventID;
          const index=client.initIndex(ALGOLIA_INDEX_NAME);
          return index.saveObject(newEvent);
        });
        return;
      } else if (!snapshot.after.exists) {
        // deleted
        const index=client.initIndex(ALGOLIA_INDEX_NAME);
        return index.deleteObject(context.params.eventID);
      } else {
        // new Entry
        const newEvent=snapshot.after.data()!;
        newEvent.objectID=context.params.eventID;
        const index=client.initIndex(ALGOLIA_INDEX_NAME);
        return index.saveObject(newEvent);
      }
    });


export const onVenueCreated=functions.firestore.document("Venues/{venueID}")
    .onWrite((snapshot, context)=>{
      const beforeData=snapshot.before.exists;
      const afterData=snapshot.after.exists;
      if (beforeData && afterData) {
        // updating
        const index=client.initIndex(ALGOLIA_INDEX_NAME_2);
        index.deleteObject(context.params.venueID).then(()=>{
          const newEvent=snapshot.after.data()!;
          newEvent.objectID=context.params.venueID;
          const index=client.initIndex(ALGOLIA_INDEX_NAME_2);
          return index.saveObject(newEvent);
        });
        return;
      } else if (!snapshot.after.exists) {
        // deleted
        const index=client.initIndex(ALGOLIA_INDEX_NAME_2);
        return index.deleteObject(context.params.venueID);
      } else {
        // new Entry
        const newEvent=snapshot.after.data()!;
        newEvent.objectID=context.params.venueID;
        const index=client.initIndex(ALGOLIA_INDEX_NAME_2);
        return index.saveObject(newEvent);
      }
    });
