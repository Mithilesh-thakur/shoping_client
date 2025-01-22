import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "number")
  int? number;

  User({
    this.id,
    this.name,
    this.number,
  });

  // Factory constructor for creating a new User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Method for converting a User instance to a JSON map
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
