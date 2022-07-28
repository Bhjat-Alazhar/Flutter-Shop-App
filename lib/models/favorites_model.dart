class FavoritesModel {
  late bool status;
  String? message;
  late Data data;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}
class Data {
  late int currentPage;
  List<FavData> data =[];
  Data.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
      json['data'].forEach((element)
      {
        data.add(FavData.fromJson(element));
      });
  }
}

class FavData {
  late int id;
  late Product product;
  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}
class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
