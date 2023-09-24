class MessageMdl {
  String? id;
  String? message;
  bool? isSeen;
  String? enteredDate;
  String? senderID;
  String? reciverID;

  MessageMdl(
      {this.id,
      this.message,
      this.senderID,
      this.reciverID,
      this.enteredDate,
      this.isSeen});
  MessageMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    message = json!['message'];
    enteredDate = json['enteredDate'];
    isSeen = json['isSeen'];
    senderID = json['senderID'];
    reciverID = json['reciverID'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'message': message,
      'enteredDate': enteredDate,
      'isSeen': isSeen,
      'senderID': senderID,
      'reciverID': reciverID,
    };
  }
}
