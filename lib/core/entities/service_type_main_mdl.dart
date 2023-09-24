import 'dart:io';

class ServiceTypeMainMdl {
  String? id;
  String? name;
  String? enteredDate;
    File? fileLogoPath;
  String? logoImgName;
  bool? isWeadding;



  ServiceTypeMainMdl({
    this.id,
    this.name,
    this.enteredDate,
    this.logoImgName,
    this.fileLogoPath,this.isWeadding
  });
  ServiceTypeMainMdl.fromJson(Map<String, dynamic>? json, String docId,
      {String? photoURL = ""}) {
    id = docId;
    name = json!['name'];
    enteredDate = json['enteredDate'];
     logoImgName = json['logoImgName'];
     isWeadding = json['isWeadding'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'enteredDate': enteredDate,
      'logoImgName': logoImgName,
      'isWeadding': isWeadding,
    };
  }
}
