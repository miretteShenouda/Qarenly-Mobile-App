// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:qarenly/common/widgets/app_bar/app_bar.dart';

// import '../../controller/search_controller.dart';

// class SearchResultsPage extends StatelessWidget {
//   final String query;
//   final TextEditingController searchController = TextEditingController();

//   SearchResultsPage({required this.query});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BuildAppBar(searchController: searchController),
//       body: StreamBuilder(
//         stream: SearchResultController().searchLaptops(
//             query), // Using the SearchController to perform the search
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           if (snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No results found for: $query'),
//             );
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               String name = doc['name'];
//               return ListTile(
//                 title: Text(name),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';

import '../../controller/search_controller.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;
  final TextEditingController searchController = TextEditingController();

  SearchResultsPage({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(searchController: searchController),
      body: StreamBuilder(
        stream: SearchResultController().searchLaptops(query),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          print(query + "is the query");

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No results found for: $query'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String name = doc['name'];
              return ListTile(
                title: Text(name),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
