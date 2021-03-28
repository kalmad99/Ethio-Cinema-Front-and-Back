import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Cinema extends Equatable{
  Cinema({
    this.id, 
    @required this.name, 
    @required this.price, 
    @required this.vipprice, 
    @required this.capacity, 
    @required this.vipcapacity
  });

  final int id;
  final String name;
  final int price;
  final int vipprice;
  final int capacity;
  final int vipcapacity;

  @override
  List<Object> get props => [id, name, price, vipprice, capacity, vipcapacity];
  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      vipprice: json['vipprice'],
      capacity: json['capacity'],
      vipcapacity: json['vipcapacity'],
    );
  }
  
  @override
  String toString() => 'Cinema { id: $id, name: $name, price: $price, '
      'vipprice: $vipprice: capacity: $capacity, vipcapacity: $vipcapacity}';

}