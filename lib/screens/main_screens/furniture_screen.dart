import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/services/product_services.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';
import 'package:furnday/widgets/product/product_section.dart';

class FurnitureScreen extends StatelessWidget {
  const FurnitureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          ProductSection(
            headingText: "Furniture",
            productGridType: ProductGridType.furnitureProducts,
            productServicesInstance: ProductServices(),
          )
        ],
      ),
    );
  }
}
