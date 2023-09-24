
import 'dart:io';

class ServiceTypeMdl {
  String? id;
  String? name;
  String? enteredDate;
  String? parentService;
    File? fileLogoPath;
  String? logoImgName;
  ServiceTypeMdl({
    this.id,
    this.parentService,
    this.name,
    this.enteredDate,    this.logoImgName,
    this.fileLogoPath
  });
  ServiceTypeMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    name = json!['name'];
    enteredDate = json['enteredDate'];
     parentService = json['parentService'];     logoImgName = json['logoImgName'];

  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'enteredDate': enteredDate,
      'parentService': parentService,      'logoImgName': logoImgName,

    };
  }
}
