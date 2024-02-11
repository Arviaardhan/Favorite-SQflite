import 'dart:convert';

List<ApiModel> apiModelFromJson(String str) => List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));

String apiModelToJson(List<ApiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
  int id;
  String title;
  double price;
  String description;
  // Category category;
  String image;
  bool favorite;

  ApiModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    // required this.category,
    required this.image,
    this.favorite = false,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    // category: categoryValues.map[json["category"]]!,
    image: json["image"],
    favorite: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    // "category": categoryValues.reverse[category],
    "image": image,
  };
}

// enum Category {
//   ELECTRONICS,
//   JEWELERY,
//   MEN_S_CLOTHING,
//   WOMEN_S_CLOTHING
// }
//
// final categoryValues = EnumValues({
//   "electronics": Category.ELECTRONICS,
//   "jewelery": Category.JEWELERY,
//   "men's clothing": Category.MEN_S_CLOTHING,
//   "women's clothing": Category.WOMEN_S_CLOTHING
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
