// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchResultController {
//   Stream<QuerySnapshot> searchLaptops(String query) {
//     return FirebaseFirestore.instance
//         .collection('Laptops')
//         .where('name', arrayContains: query.toLowerCase())
//         .snapshots();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchResultController {
  Stream<QuerySnapshot> searchLaptops(String query) {
    return FirebaseFirestore.instance
        .collection('Laptops')
        .orderBy('name') // Order the documents by name
        .startAt(
            [query.toLowerCase()]) // Start at documents where name >= query
        .endAt([
      query.toLowerCase() + '\uf8ff'
    ]) // End at documents where name < query + '\uf8ff'
        .snapshots();
  }
}
