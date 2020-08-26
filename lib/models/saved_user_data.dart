

import 'dart:convert';

class SavedUserData {
  final String name;
  final String surname;
  final String email;

  SavedUserData({this.name, this.surname, this.email});

  factory SavedUserData.fromJson(Map<String, dynamic> json) => SavedUserData(
      name: json['name'],
      surname: json['surname'],
      email: json['email']
  );

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'surname': this.surname,
    'email': this.email,
  };
}