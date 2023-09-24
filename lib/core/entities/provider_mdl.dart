import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderMdl {
  String? id;
  String? name;
  String? address;
  String? enteredDate;
  List? services;
  String? state;
  String? description;
  int? gender;
  String? logoImgName;
  String? backgroundImgName;
  bool? verfied;
  GeoPoint? locationMap;
  File? fileLogoPath;
  File? fileBackgroundPath;
  String? userID;
  String? policies;
  List? chattingUsers;
  List? consumers;
  String? token;

  ProviderMdl(
      {this.id,
      this.name,
      this.enteredDate,
      this.address,
      this.description,
      this.gender,
      this.locationMap,
      this.logoImgName,
      this.backgroundImgName,
      this.services,
      this.policies,
      this.chattingUsers,
      this.state,
      this.verfied,
      this.token,
      this.fileLogoPath,
      this.fileBackgroundPath,
      this.userID});
  ProviderMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    name = json!['name'];
    address = json['address'];
    enteredDate = json['enteredDate'];
    services = json['services'];
    backgroundImgName = json['backgroundImgName'];
    state = json['state'];
    gender = json['gender'];
    logoImgName = json['logoImgName'];
    verfied = json['verfied'];
    locationMap = json['locationMap'];
    userID = json['userID'];
    policies = json['policies'];
    description = json['description'];
    chattingUsers = json['chattingUsers'];
    consumers = json['consumers'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'address': address,
      'enteredDate': enteredDate,
      'services': services,
      'state': state,
      'gender': gender,
      'logoImgName': logoImgName,
      'verfied': verfied, 'locationMap': locationMap,
      'userID': userID,
      'backgroundImgName': backgroundImgName,
      'policies': policies,
      'description': description,
      'chattingUsers': chattingUsers,
      'consumers': consumers,
      'token': token,
    };
  }
}
