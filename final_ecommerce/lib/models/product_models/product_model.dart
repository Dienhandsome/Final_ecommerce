
import 'dart:convert';
//Json dùng để truyền dữ liệu của hệ thống
ProductModel productModelFromJson(String str) => ProductModel.fromJson(jsonDecode(str));

String productModelToJson(ProductModel data) => jsonEncode(data.toJson());

class ProductModel {
  String image;
  String id;
  bool isFavouraite;
  String name;
  double price;
  String description;
  String status;

  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.status,
    required this.description,
    required this.isFavouraite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description:json["description"] ,
        image: json["image"],
        isFavouraite:false ,
        price: double.parse(json["price"].toString()),
        status:  json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFvourite": isFavouraite,
        "price": price,
        "status":status
      };
}

