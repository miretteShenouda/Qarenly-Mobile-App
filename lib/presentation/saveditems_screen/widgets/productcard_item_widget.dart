import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import '../../../controller/savedItems_controller.dart';
import '../../../model/product_model.dart';

class ProductcardItemWidget extends StatelessWidget {
  final Product product; // Change the parameter type to Product
  final SavedItemsController savedItemsController;

  const ProductcardItemWidget(
      {Key? key, required this.product, required this.savedItemsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: product.imageUrl, // Use laptop image URL
                height: 128.v,
                width: 104.h,
                radius: BorderRadius.circular(
                  30.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 11.h,
                  top: 15.v,
                  bottom: 3.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 115.h,
                      child: Text(
                        "Brand :${product.brand} \nSource: ${product.sources}Name:${product.name}\n",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 48.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              //text: "${product.price},
                              style: theme.textTheme.titleSmall!.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              // text: " ${laptop.currentPrice}",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                _deleteProduct(
                    context); // Handle the tap on the trash icon here
              },
              child: CustomImageView(
                imagePath: ImageConstant.imgOcticonTrash16,
                height: 25.adaptSize,
                width: 25.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Method to delete a product from Firebase and savedItems list
//   Future<void> deleteProduct(Product product) async {
//     try {
//       // Delete the product from Firebase
//       await _db.collection('Products').doc(product.id).delete();

//       // Remove the product from the savedItems list
//       savedItems.removeWhere((p) => p.id == product.id);
//     } catch (error) {
//       print("Error deleting product: $error");
//       // Handle error
//     }
//   }
  void _deleteProduct(BuildContext context) {
    savedItemsController.deleteProduct(product);
  }
}
