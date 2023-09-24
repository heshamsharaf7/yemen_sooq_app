class DeliverSattionMdl {
  String? id;
  String? address;
  String? enteredDate;
  String? phoneNo;
  String? postNo;
  String? typeName;
  String? famousPlace;
  String? userID;
  DeliverSattionMdl(
      {this.id,
      this.address,
      this.phoneNo,
      this.postNo,
      this.enteredDate,
      this.userID,
      this.famousPlace,
      this.typeName});
  DeliverSattionMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    address = json!['address'];
    enteredDate = json['enteredDate'];
    phoneNo = json['phoneNo'];
    famousPlace = json['famousPlace'];
    postNo = json['postNo'];
    typeName = json['typeName'];
    userID = json['userID'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'address': address,
      'enteredDate': enteredDate,
      'phoneNo': phoneNo,
      'famousPlace': famousPlace,
      'postNo': postNo,
      'typeName': typeName,
      'userID': userID,
    };
  }
}
