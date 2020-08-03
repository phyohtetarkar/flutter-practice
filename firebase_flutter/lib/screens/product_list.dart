import 'package:firebase_flutter/models/product_list_model.dart';
import 'package:firebase_flutter/screens/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/services.dart';

class ProductList extends StatelessWidget {
  final String title;

  ProductList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ProductListModel>(context);
    var childCount = ProductListModel.products.length;
    var portrait = model.orientation == Orientation.portrait;

//    final sliverAppbar = SliverAppBar(
//      floating: true,
//      pinned: true,
//      title: Text(
//        "Products",
//        style: TextStyle(
//          fontFamily: "Roboto",
//          fontWeight: FontWeight.bold,
//        ),
//      ),
//      actions: <Widget>[
//        IconButton(
//          icon: const Icon(Icons.search),
//          tooltip: "Search",
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(portrait ? Icons.view_list : Icons.view_module),
//          tooltip: "View",
//          onPressed: () {
//            model.orientation =
//                portrait ? Orientation.landscape : Orientation.portrait;
//          },
//        ),
////        PopupMenuButton(
////          color: Colors.black,
////          itemBuilder: (context) {
////            return List.generate(1, (index) {
////              return PopupMenuItem(
////                textStyle: TextStyle(color: Colors.white),
////                value: 1,
////                child: Text("Add Product"),
////              );
////            });
////          },
////        ),
//      ],
//    );

//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(
//            statusBarColor: Colors.transparent
//        )
//    );

    var appBar = AppBar(
//      bottom: PreferredSize(
//        child: Divider(
//          height: 1.5,
//          thickness: 1.5,
//        ),
//        preferredSize: Size.fromHeight(1.5),
//      ),
      title: Text(
        "Products",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: "Search",
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(portrait ? Icons.view_module : Icons.view_list),
          tooltip: "View",
          onPressed: () {
            model.orientation =
                portrait ? Orientation.landscape : Orientation.portrait;
          },
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Consumer<ProductListModel>(builder: (context, model, child) {
        if (model.orientation == Orientation.portrait) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _ProductListItem(
                        product: model.getByPosition(index));
                  },
                  childCount: childCount,
                ),
              )
            ],
          );
        } else {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(2),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _ProductGridItem(
                          product: model.getByPosition(index));
                    },
                    childCount: childCount,
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String id;
  final String image;

  _ProductImage({
    Key key,
    @required this.id,
    @required this.image,
  })  : assert(id != null),
        assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//            boxShadow: [
//              BoxShadow(
//                  color: Colors.black.withOpacity(0.35),
//                  spreadRadius: 1.5,
//                  blurRadius: 8.5,
//                  offset: Offset(1, 1))
//            ]
            ),
        child: Hero(
          tag: id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductListItem extends StatelessWidget {
  final Product product;

  _ProductListItem({
    Key key,
    @required this.product,
  })  : assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            ProductDetail.route(product),
          );
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LimitedBox(
                maxHeight: 70,
                child: Row(
                  children: <Widget>[
                    _ProductImage(
                      id: product.id,
                      image: product.image,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      product.formattedPrice,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              indent: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGridItem extends StatelessWidget {
  final Product product;

  _ProductGridItem({
    Key key,
    @required this.product,
  })  : assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      margin: EdgeInsets.all(2),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 0.8),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: product.id,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: product.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product.formattedPrice,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    ProductDetail.route(product),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
