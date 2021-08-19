import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import algoliasearch from "algoliasearch";

const ALGOLIA_ID = "LD90DSAJA6";
const ALGOLIA_ADMIN_KEY = "2b76f0436247e8e0618f8ea978a88b1a";
const ALGOLIA_SEARCH_KEY = "513112c803c4a78083bd02c3078897a2";

const ALGOLIA_INDEX_NAME = "indexName";
const ALGOLIA_INDEX_NAME_2 = "indexName2";
const client = algoliasearch(ALGOLIA_ID, ALGOLIA_SEARCH_KEY);
const index = client.initIndex(ALGOLIA_INDEX_NAME);
const Venueindex = client.initIndex(ALGOLIA_INDEX_NAME_2);

export const searchforEvent=
functions.https.onCall(async (request)=> {
  const toSearch:string=request.texttoSearch;
  let lists:Array<any>=[];
  console.log("searching for ", toSearch);
  const listofMatches:Array<any>=[];
  await index.setSettings({
    searchableAttributes: [
      "name,description",
      "location, participants",
      "type",
    ],
  });
  lists=await index.search(toSearch).then((response)=>{
    console.log(response.hits);
    response.hits.forEach((result)=>{
      listofMatches.push(result);
    });
    return listofMatches;
  });
  return lists;
});

export const searchforVenue=
functions.https.onCall(async (request)=> {
  const toSearch:string=request.texttoSearch;
  let lists:Array<any>=[];
  const listofMatches:Array<any>=[];

  lists=await Venueindex.search(toSearch).then((response)=>{
    console.log(response.hits);
    response.hits.forEach((result)=>{
      listofMatches.push(result);
    });
    return listofMatches;
  });
  return lists;
});
