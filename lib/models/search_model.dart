class SearchModel {
  late bool status;
  late Data data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}
class Data {
  late int currentPage;
  List<Product>? data =[];
  Data.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
      json['data'].forEach((element)
      {
        data!.add(Product.fromJson(element));
      });
  }
}
class Product {
  late int id;
  late int price;
  late String image;
  late String name;
  late String description;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
