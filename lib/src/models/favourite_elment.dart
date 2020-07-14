
class FavouriteElement {
  final String id;
  final String posterURl;
  final String title;

  FavouriteElement(this.id, this.posterURl, this.title);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posterURl': posterURl,
      'title': title,
    };
  }

  static FavouriteElement fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return FavouriteElement(
      map['id'],
      map['posterURl'],
      map['title'],
    );
  }

}
