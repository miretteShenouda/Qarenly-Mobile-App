import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qarenly/core/app_export.dart';

import '../../controller/savedItems_controller.dart';
import '../../model/product_model.dart';

class ProductcardItemWidget extends StatelessWidget {
  final Product product;
  final SavedItemsController savedItemsController;

  const ProductcardItemWidget({
    Key? key,
    required this.product,
    required this.savedItemsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.viewproductPage,
            arguments: {'productId': product.id, 'productType': product.type});
        // print("Product ID: ${product.id}");
        // print("Product Type: ${product.type}");
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // color: Color.fromRGBO(0, 48, 73, 0.0001),
        child: ListTile(
          // contentPadding: EdgeInsets.all(16.0),
          leading: CustomImageView(
            imagePath: product.imageUrl,
            // height: 128.0,
            // width: 104.0,
            radius: BorderRadius.circular(10.0),
          ),
          title: Text(
            "${product.name}",
            style: theme.textTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Source: ${product.sources.join(", ")} \nBrand: ${product.brand}",
              //   maxLines: 2,
              //   style: theme.textTheme.bodyLarge,
              //   // overflow: TextOverflow.ellipsis,
              // ),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    // children: [
                    // text:TextSpan(
                    text: product.lowestPrices.length == 0
                        ? "Lowest price: 'N/A'"
                        : "Lowest price: ${NumberFormat('#,###').format(product.lowestPrices.last.toDouble())} L.E",
                    style: theme.textTheme.titleSmall,
                  ),
                  // ],
                ),
              ),
              // )
            ],
          ),
          trailing: GestureDetector(
            onTap: () => _deleteProduct(context),
            child: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }

  void _deleteProduct(BuildContext context) {
    savedItemsController.deleteProduct(product);
  }
}
