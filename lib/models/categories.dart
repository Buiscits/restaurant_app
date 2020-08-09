

import 'dart:convert';

class Item {

  final String name;
  final int itemId;
  final double price;
  final int quantity;

  Item({this.name, this.itemId, this.price, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      name: json['post_title'],
      itemId: json['ID'],
      price: double.parse(json['price'][0]),
      quantity: 1);

  Map<String, dynamic> toJson() => {'post_title': name, 'ID': itemId, 'price': ['$price'], 'quantity': quantity};
}

class CategoryItems {
  final List<Item> items;

  CategoryItems({this.items});

  factory CategoryItems.fromRawJson(String str) =>
      CategoryItems.fromJson(jsonDecode(str));

  factory CategoryItems.fromJson(List<dynamic> json) => CategoryItems(
      items: List<Item>.from(
          json.map((x) => Item(
              name: x['post_title'],
              itemId: x['ID'],
              price: double.parse(x['price'][0]),
              quantity: 1))
      )
  );
}

class Category {
  final int id;
  final String name;
  final String img;

  Category({this.id, this.name, this.img});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['ID'],
    name: json['name'],
    img: json['image']);

  Map<String, dynamic> toJson() => {'ID': id, 'name': name, 'image': img};
}

class Menu {
  final List<Category> categories;

  Menu({this.categories});

  factory Menu.fromRawJson(String str) =>
      Menu.fromJson(jsonDecode(str));

  factory Menu.fromJson(List<dynamic> json) => Menu(
    categories: List<Category>.from(
        json.map((x) => Category(
          id: x['ID'],
          name: x['name'],
          img: x['image']))
    )
  );
}