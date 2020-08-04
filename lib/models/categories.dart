

import 'dart:convert';

class Category {
  final int id;
  final String name;
  final String img;

  Category({this.id, this.name, this.img});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['term_id'],
    name: json['name'],
    img: json['image']);

  Map<String, dynamic> toJson() => {'term_id': id, 'name': name};
}

class Menu {
  final List<Category> categories;

  Menu({this.categories});

  factory Menu.fromRawJson(String str) =>
      Menu.fromJson(jsonDecode(str));

  factory Menu.fromJson(List<dynamic> json) => Menu(
    categories: List<Category>.from(
        json.map((x) => Category(
          id: x['term_id'],
          name: x['name']))
    )
  );

}