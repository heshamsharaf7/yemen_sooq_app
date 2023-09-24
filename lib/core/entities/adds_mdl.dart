import 'dart:io';

class AddsMdl {
  String? id;
  String? enteredDate;
    File? fileAddPath;
  String? addImgName;



  AddsMdl({
    this.id,
    this.enteredDate,
    this.addImgName,
    this.fileAddPath
  });
  AddsMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    enteredDate = json!['enteredDate'];
     addImgName = json['addImgName'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'enteredDate': enteredDate,
      'addImgName': addImgName,
    };
  }
}
