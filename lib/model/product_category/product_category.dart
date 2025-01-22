import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;



  ProductCategory({
    this.id,
    this.name,

  });

  // Factory constructor for creating a new User instance from a JSON map
  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);

  // Method for converting a User instance to a JSON map
  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
