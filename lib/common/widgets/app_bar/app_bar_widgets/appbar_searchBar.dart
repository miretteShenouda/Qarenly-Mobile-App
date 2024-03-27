import 'package:flutter/material.dart';

class AppbarSearchBar extends StatelessWidget {
  AppbarSearchBar({
    Key? key,
    this.controller,
    this.margin,
  }) : super(key: key);

  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 0, 48, 73),
          width: 2.0,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search for something',
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 0, 48, 73),
            ),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              // Perform search and navigate to search results page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultsPage(query: value),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SearchResultsPage extends StatelessWidget {
  final String query;

  SearchResultsPage({required this.query});

  @override
  Widget build(BuildContext context) {
    // Implement your search logic here, e.g., fetching data from a database
    // You can use the query variable to perform the search

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: Text('Display search results for: $query'),
      ),
    );
  }
}
