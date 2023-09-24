class OrderMdl {
  String? id;
  String? serviceID;
  String? userID;
  String? providerID;
  String? enteredDate;
  int? orderStatues;
  int? quantity;
  String? address;
  String? phoneNo;
  String? postNo;
  String? famousPlace;

  OrderMdl(
      {this.id,
      this.serviceID,
      this.providerID,
      this.orderStatues,
      this.userID,
            this.address,
      this.phoneNo,
      this.postNo,
      this.enteredDate,
      this.famousPlace,
      this.quantity});
  OrderMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    serviceID = json!['serviceID'];
    enteredDate = json['enteredDate'];
    providerID = json['providerID'];
    userID = json['userID'];
    orderStatues = json['orderStatues'];
    quantity = json['quantity'];
    phoneNo = json['phoneNo'];
    famousPlace = json['famousPlace'];
    postNo = json['postNo'];
    address = json['address'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'serviceID': serviceID,
      'enteredDate': enteredDate,
      'providerID': providerID,
      'userID': userID,
      'orderStatues': orderStatues,
      'quantity': quantity,
            'address': address,
      'phoneNo': phoneNo,
      'famousPlace': famousPlace,
      'postNo': postNo,
    };
  }
}
