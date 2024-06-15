import 'package:flutter/material.dart';

import '../../../model/product_model.dart';
import '../../core/app_export.dart';

class ProductcardItemWidgetBenchmarking extends StatelessWidget {
  final Product product; // Change the parameter type to Product

  const ProductcardItemWidgetBenchmarking({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Product Name: ${product.name}");
    print("Product ID: ${product.id}");
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.viewproductPage, arguments: {
            'productId': product.id,
            'productType': product.type
          });
          print("Product ID: ${product.id}");
          print("Product Type: ${product.type}");
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: const Color.fromRGBO(0, 48, 73, 0.0001),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: CustomImageView(
              fit: BoxFit.fill,
              margin: EdgeInsets.zero,
              imagePath: product.imageUrl,
              //height: 128.0,
              //width: 104.0,
              radius: BorderRadius.circular(30.0),
            ),
            title: Text(
              "Name: ${product.name}",
              style: theme.textTheme.headline6,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Source: ${product.sources.join(", ")} \nPerformance: ${('')}",
                  maxLines: 2,
                  style: theme.textTheme.bodyLarge,
                  // overflow: TextOverflow.ellipsis,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: "Lowest price: ${product.lowestPrices}",
                        style: theme.textTheme.titleSmall,
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
