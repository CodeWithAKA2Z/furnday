import 'package:flutter/material.dart';
import 'package:furnday/services/product_services.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/heading_section_text.dart';
import 'package:furnday/widgets/product/product_grid.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';

class ProductSection extends StatelessWidget {
  const ProductSection(
      {super.key,
      required this.headingText,
      required this.productGridType,
      required this.productServicesInstance});
  final String headingText;
  final ProductGridType productGridType;
  final ProductServices productServicesInstance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DecoratedCard(
        child: Column(
          children: [
            HeadingSectionText(
              headingText: headingText,
            ),
            ProductGrid(
              productGridType: productGridType,
              productServicesInstance: productServicesInstance,
            ),
          ],
        ),
      ),
    );
  }
}
