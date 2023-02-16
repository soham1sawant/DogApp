class FavouritesModel {
  
  FavouritesModel({required this.likes});

  FavouritesModel.fromJson(Map<String, dynamic>? json) {
    likes = List.castFrom<dynamic, String>(json!['likes'] as List<dynamic>);
  }
  
  late final List<String> likes;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['likes'] = likes;
    return data;
  }
}
