part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({
    String uid = "",
    String name = "",
    String noHp = "",
    String role = "user",
    String alamat = "",
    String profilePicture = "",
    String selectedGender = "",
    String selectedBranch = "",
    String deviceId = "",
  }) =>
      User(
        this.uid,
        this.email,
        name: name,
        noHp: noHp,
        role: role,
        alamat: alamat,
        profilePicture: profilePicture,
        selectedGender: selectedGender,
        selectedBranch: selectedBranch,
        deviceId: deviceId,
      );

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
