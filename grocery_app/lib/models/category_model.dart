
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    List<Category> categories;

    CategoryModel({
        required this.categories,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    String categoryName;
    List<String> subcategories;

    Category({
        required this.categoryName,
        required this.subcategories,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["categoryName"],
        subcategories: List<String>.from(json["subcategories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "subcategories": List<dynamic>.from(subcategories.map((x) => x)),
    };
}
