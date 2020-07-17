part of 'services.dart';

class UserServices {
  FirebaseUser user;
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');
  static Future<void> updateUser(User user) async {
    await _userCollection.document(user.uid).setData({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
      'noHp': user.noHp ?? "",
      'role': user.role ?? "user",
      'alamat': user.alamat ?? "",
      'profilePicture': user.profilePicture ?? "",
      'selectedGender': user.selectedGender ?? "",
      'selectedBranch': user.selectedBranch ?? "",
      'status': user.status ?? "tidak aktif",
      'deviceId': user.deviceId ?? "",
    });
    return UpdateUserData(user: user);
  }

  static Future<User> getUser(String uid) async {
    DocumentSnapshot snapshot = await _userCollection.document(uid).get();

    return User(
      snapshot.data['uid'],
      snapshot.data['email'],
      name: snapshot.data['name'],
      noHp: snapshot.data['noHp'],
      role: snapshot.data['role'],
      alamat: snapshot.data['alamat'],
      profilePicture: snapshot.data['profilePicture'],
      selectedGender: snapshot.data['selectedGender'],
      selectedBranch: snapshot.data['selectedBranch'],
      status: snapshot.data['status'],
      deviceId: snapshot.data['deviceId'],
    );
  }

  static Future<List<User>> getUsers(String uid) async {
    QuerySnapshot snapshot = await _userCollection.getDocuments();

    var documents =
        snapshot.documents.where((document) => document.data['uid'] == uid);

    List<User> users = [];
    for (var document in documents) {
      users.add(User(
        document.data['uid'],
        document.data['email'],
        name: document.data['name'],
        noHp: document.data['noHp'],
        role: document.data['role'],
        alamat: document.data['alamat'],
        profilePicture: document.data['profilePicture'],
        selectedGender: document.data['selectedGender'],
        selectedBranch: document.data['selectedBranch'],
        status: document.data['status'],
        deviceId: document.data['deviceId'],
      ));
    }
    return users;
  }
}

class UpdateUserData {
  final User user;
  final User uid;

  UpdateUserData({this.user, this.uid});
}
