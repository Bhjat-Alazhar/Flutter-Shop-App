class CategoriesProductModel {
  late bool status;
  late CategoriesProductDataModel data;

  CategoriesProductModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoriesProductDataModel.fromJson(json['data']);
  }
}
class CategoriesProductDataModel {
  late int currentPage;
  List<Product> data = [];

  CategoriesProductDataModel.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(Product.fromJson(element));
    });
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
