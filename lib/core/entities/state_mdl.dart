class StateMdl {
  String? id;
  String? name;
  String? enteredDate;

  StateMdl({
    this.id,
    this.name,
    this.enteredDate
  });
  StateMdl.fromJson(Map<String, dynamic>? json, String docId,
      {String? photoURL = ""}) {
    id = docId;
    name = json!['name'];
    enteredDate = json['enteredDate'];
    // photoUrl = json['photoUrl'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'enteredDate': enteredDate,
    };
  }
}
