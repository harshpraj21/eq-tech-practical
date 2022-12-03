import 'dart:convert';

List<ProductModel> productModelListFromJson(String str) =>
    List<ProductModel>.from(
      json.decode(str).map((x) => ProductModel.fromJson(x)),
    );

String productModelListToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel.fromJson(Map<String, dynamic> json) {
    productCategory = json['productCategory'];
    productCompany = json['productCompany'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'];
    productQty = json['productQty'];
    productTitle = json['productTitle'];
    productImage = json['productImage'];
  }

  ProductModel({
    this.productCategory,
    this.productCompany,
    this.productDescription,
    this.productPrice,
    this.productQty,
    this.productTitle,
    this.productImage,
  });
  String? productCategory;
  String? productCompany;
  String? productDescription;
  String? productPrice;
  String? productQty;
  String? productTitle;
  String? productImage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productCategory'] = productCategory;
    data['productCompany'] = productCompany;
    data['productDescription'] = productDescription;
    data['productPrice'] = productPrice;
    data['productQty'] = productQty;
    data['productTitle'] = productTitle;
    data['productImage'] = productImage;

    return data;
  }
}
