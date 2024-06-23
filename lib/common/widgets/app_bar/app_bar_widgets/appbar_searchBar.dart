import 'package:flutter/material.dart';
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/routes/app_routes.dart';
import '../../../../view/search_results_page/search_results_page.dart';
import 'package:get/get.dart';

class AppbarSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;
  AppbarSearchBar({
    Key? key,
    this.controller,
    this.margin,
  }) : super(key: key);

  @override
  State<AppbarSearchBar> createState() => _AppbarSearchBarState();
}

class _AppbarSearchBarState extends State<AppbarSearchBar> {
  FilterController filterController = Get.put(FilterController());

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
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Search for something',
            border: InputBorder.none,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width - 100, 60, 0, 0),
                      elevation: 8,
                      items: [
                        PopupMenuItem<String>(
                          value: 'All',
                          child: Row(
                            children: [
                              Text('All'),
                              Obx(
                                () => filterController.categoryFilter.value ==
                                        'All'
                                    ? Icon(Icons.check)
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'TVs',
                          child: Row(
                            children: [
                              Text('TVs'),
                              Obx(
                                () => filterController.categoryFilter.value ==
                                        'TVs'
                                    ? Icon(Icons.check)
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Laptops',
                          child: Row(
                            children: [
                              Text('Laptops'),
                              Obx(
                                () => filterController.categoryFilter.value ==
                                        'Laptops'
                                    ? Icon(Icons.check)
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'CPUs',
                          child: Row(
                            children: [
                              Text('CPUs'),
                              Obx(
                                () => filterController.categoryFilter.value ==
                                        'CPUs'
                                    ? Icon(Icons.check)
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'GPUs',
                          child: Row(
                            children: [
                              Text('GPUs'),
                              Obx(
                                () => filterController.categoryFilter.value ==
                                        'GPUs'
                                    ? Icon(Icons.check)
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).then<void>((String? value) {
                      if (value != null) {
                        filterController.setCategoryFilter(value);
                        print(value);
                      }
                    });
                  },
                ),
                IconButton(
                  icon:
                      Icon(Icons.monetization_on_outlined, color: Colors.black),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width - 100, 60, 0, 0),
                        items: [
                          PopupMenuItem<String>(
                            child: Text('Price Range'),
                          ),
                          // PopupMenuItem<RangeValues>(
                          //   child: RangeSlider(
                          //     min: filterController.priceFilterLowerBound.value,
                          //     max: filterController.priceFilterUpperBound.value,
                          //     // labels: RangeLabels(
                          //     //     filterController.priceFilter.value.start
                          //     //         .toString(),
                          //     //     filterController.priceFilter.value.end
                          //     //         .toString()),
                          //     // values: filterController.priceFilter.value,
                          //     onChanged: (value) {
                          //       // filterController.setPriceFilter(value);
                          //       // print(filterController.priceFilter.value);
                          //       // setState(() {});
                          //     },
                          //   ),
                          // )
                        ]);
                  },
                ),
              ],
            ),
            prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResultsPage(
                            query: widget.controller!.text)))),
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
