import 'dart:io';
// import 'package:multi_image_picker/multi_image_picker.dart';

class ProviderServicesMdl {
  String? id;
  String? name;
  bool? type;
  String? enteredDate;
  String? details;
  double? price;
  int? currency;
  List? imgs;
  String? mainImg;
  String? video;
  String? youtubeLink;
  bool? isLock;
  File? mainImgPath;
  File? videoImgPath;
  // List<Asset>? imgsPaths;
  String? providerID;
  String? serviceID;
  // List<Rating>? ratings;
  int? gender;
List< dynamic>? ratings;


  ProviderServicesMdl(
      {this.id,
      this.name,
      this.enteredDate,
      this.type,
      this.details,
      this.price,
      this.currency,
      this.imgs,
      this.mainImg,
      this.video,
      this.youtubeLink,
      this.isLock,
      this.mainImgPath,
      this.serviceID,
      this.ratings,
      this.providerID,
      this.videoImgPath}) {
    // imgs = [];
    // imgsPaths = [];
  }
  ProviderServicesMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    name = json!['name'];
    enteredDate = json['enteredDate'];
    type = json['type'];
    details = json['details'];
    price = json['price'];
    currency = json['currency'];
    imgs = json['imgs'];
    youtubeLink = json['youtubeLink'];
    isLock = json['isLock'];
    mainImg = json['mainImg'];
    video = json['video'];
    serviceID = json['serviceID'];
    providerID = json['providerID'];
    ratings=json['ratings'];

    // for(int i=0;i<json['ratings'].length;i++)
    // {
    //   ratings!.add(Rating.fromJson(json['ratings'][i]));
    // }
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'enteredDate': enteredDate,
      'type': type,
      'details': details,
      'price': price,
      'currency': currency,
      'imgs': imgs,
      'youtubeLink': youtubeLink,
      'isLock': isLock,
      'mainImg': mainImg,
      'video': video,
      'providerID': providerID,
      'serviceID': serviceID,
      // 'ratings': ratings.map((e) => Rating.fromJson(e)),
    };
  }
}

class Rating {
  String? userId;
  double? rating;
  String? serviceID;

  Rating({
    this.userId,
    this.rating,
    this.serviceID
  });
  Rating.fromJson(Map<String, dynamic>? json) {
    userId = json!['userId'];
    rating = json['rating'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'userId': userId,
      'rating': rating,
    };
  }
}
