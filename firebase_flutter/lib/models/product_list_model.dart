import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _defaultImage = "https://images.squarespace-cdn.com/content/v1/59d2bea58a02c78793a95114/1589398875141-QL8O2W7QS3B4MZPFWHJV/ke17ZwdGBToddI8pDm48kBVDUY_ojHUJPbTAKvjNhBl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QHyNOqBUUEtDDsRWrJLTmmV5_8-bAHr7cY_ioNsJS_wbCc47fY_dUiPbsewqOAk2CqqlDyATm2OxkJ1_5B47U/image-asset.jpeg";
final _numberFormat = NumberFormat("###,###.##", "en_US");

class ProductListModel extends ChangeNotifier {
  static List<Product> products = List.generate(
    15,
    (index) {
      return Product(id: index.toString(), name: "Product $index", image: _defaultImage, price: 1000);
    },
  );

  Orientation _orientation = Orientation.portrait;

  Orientation get orientation => _orientation;

  set orientation(Orientation orientation) {
    this._orientation = orientation;
    notifyListeners();
  }

  Product getByPosition(int position) => products[position];
}

@immutable
class Product {
  final String id;
  final String name;
  final String image;
  final int price;
  final String description;

  Product({this.id, this.name, this.image, this.price, this.description});

  String get formattedPrice => _numberFormat.format(price);

}
