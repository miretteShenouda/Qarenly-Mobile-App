import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../controller/homePage_controller.dart';
import '../../../model/product_model.dart';
import '../../core/app_export.dart';

class ProductcardItemWidgetHome extends StatelessWidget {
  final Product product; // Change the parameter type to Product
  // final HomePageController homePageController;

  const ProductcardItemWidgetHome({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.viewproductPage, arguments: {
            'productId': product.id,
            'productType': product.type
          });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: const Color.fromRGBO(0, 48, 73, 0.0001),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
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
                  "Source: ${product.sources.join(", ")} \nBrand: ${product.brand}",
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
