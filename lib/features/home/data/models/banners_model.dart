class BannerModel {
  int? id;
  String? imageUrl;


  BannerModel({this.id, this.imageUrl, });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = imageUrl;

    return data;
  }
}
