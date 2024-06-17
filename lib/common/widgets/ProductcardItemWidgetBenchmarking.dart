import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/product_model.dart';
import '../../core/app_export.dart';

class ProductcardItemWidgetBenchmarking extends StatelessWidget {
  final Product product; // Change the parameter type to Product
  final comparison;
  const ProductcardItemWidgetBenchmarking(
      {Key? key, required this.product, required this.comparison})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double? minPrice;
    // if (product.lowestPrices.isNotEmpty) {
    //   minPrice = product.lowestPrices.reduce(min);
    // } else {
    //   // Handle the case where the list is empty, for example:
    //   minPrice = 0.0; // Default value or handle it differently
    // } // Find the minimum value

    Map<dynamic, dynamic>? getMapwithTheLowestPrice() {
      if (product.sources.isEmpty) return null;

      Map<dynamic, dynamic>? lowestPriceMap;
      double? lowestPrice;
      for (var source in product.sources) {
        if (source['price'] != null &&
            (lowestPrice == null || (source['price'] < lowestPrice!))) {
          lowestPrice = source['price'];
          lowestPriceMap = source;
        }
      }
      return lowestPriceMap;
    }

    Map<dynamic, dynamic>? lowestPriceMap = getMapwithTheLowestPrice();
    void _launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launch(url as String);
      } else {
        throw 'could not launch $url';
      }
    }

    print("Product Name: ${product.name}");
    print("Product ID: ${product.id}");
    print("priceslowest:${product.lowestPrices}");
    print("benchmark  ratio: ${product.benchmark_ratio}");
    return GestureDetector(
        onTap: () {
          if (lowestPriceMap != null && lowestPriceMap['URL'] != null) {
            String url = lowestPriceMap['URL'];
            _launchURL(url);
          } else {
            print("No valid URL found for the lowest price source.");
          }
          Navigator.pushNamed(context, AppRoutes.viewproductPage, arguments: {
            'productId': product.id,
            'productType': product.type,
          });
          print("Product ID: ${product.id}");
          print("Product Type: ${product.type}");
        },
        child: Container(
          width: 200.0,
          margin: const EdgeInsets.all(16.0),
          child: Card(
            // color: const Color.fromRGBO(0, 48, 73, 0.0001),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      height: 50.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(Icons.shopping_bag,
                              size: 16.0, color: Colors.blue),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: Text(
                              lowestPriceMap != null
                                  ? "${lowestPriceMap['website']}"
                                  : "Not available",
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Performance: $comparison",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(width: 5),
                          if (product.arrow != null)
                            Icon(
                              product.arrow,
                              color: product.arrow ==
                                      Icons.arrow_circle_up_outlined
                                  ? Colors.green
                                  : Colors.red,
                              size: 20,
                            ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          lowestPriceMap != null
                              ? "EGY ${NumberFormat('#,###').format(lowestPriceMap['price'])}"
                              : "Price not available",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
