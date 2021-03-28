import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Movie extends Equatable {
  Movie(
      {this.id,
      @required this.title,
      @required this.image,
      @required this.overview,
      @required this.release_date,
      @required this.rating});

  final int id;
  final String title;
  final String image;
  final String overview;
  final String release_date;
  final double rating;

  @override
  List<Object> get props => [id, title, image, overview, release_date, rating];

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      image: json['poster_path'],
      overview: json['overview'],
      release_date: json['release_date'],
      rating: json['rating'],
    );
  }

  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     id: json['Id'],
  //     title: json['Title'],
  //     image: json['Image'],
  //     overview: json['Overview'],
  //     release_date: json['ReleaseDate'],
  //     rating: json['IMDBRating'],
  //   );
  // }

  Movie.selectedMovie(
      {this.id,
      this.title,
      this.image,
      this.overview,
      this.release_date,
      this.rating});

  @override
  String toString() => 'Movie { id: $id, title: $title, poster_path: $image, '
      'overview: $overview: release_date: $release_date, rating: $rating}';
}
