class NotificationMdl {
  String? id;
  String? title;
  String? desc;
  bool? isSeen;
  String? enteredDate;
  // String? senderID;
  String? reciverID;

  NotificationMdl({
    this.id,
    this.title,
// this.senderID,
this.reciverID,
    this.desc,
    this.enteredDate,
    this.isSeen
  });
  NotificationMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    title = json!['title'];
    enteredDate = json['enteredDate'];
    desc = json['desc'];
    isSeen = json['isSeen'];
    // senderID = json['senderID'];
    reciverID = json['reciverID'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
      'enteredDate': enteredDate,
      'desc': desc,
      'isSeen': isSeen,
      // 'senderID': senderID,
      
      'reciverID': reciverID,
    };
  }
}
