import 'package:firebase_flutter/models/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetail extends StatelessWidget {
  static MaterialPageRoute route(Product product) => MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      );

  final Product product;

  ProductDetail({
    Key key,
    @required this.product,
  })  : assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliverAppbar = SliverAppBar(
      expandedHeight: 200,
      floating: true,
      pinned: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: product.id,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppbar,
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        product.formattedPrice,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
