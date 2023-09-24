class UserMdl {
  String? id;
  String? name;
  String? enteredDate;
  bool? isProviderOwner;
  bool? isAdmin;
  List? chattingUsers;
  String? token;
  UserMdl(
      {this.id,
      this.name,
      this.chattingUsers,
      this.token,
      this.enteredDate,
      this.isProviderOwner});
  UserMdl.fromJson(Map<String, dynamic>? json, String docId) {
    id = docId;
    name = json!['name'];
    enteredDate = json['enteredDate'];
    isProviderOwner = json['isProviderOwner'];
    chattingUsers = json['chattingUsers'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'enteredDate': enteredDate,
      'isProviderOwner': isProviderOwner,
      'chattingUsers': chattingUsers,
      'token': token,
    };
  }
}
