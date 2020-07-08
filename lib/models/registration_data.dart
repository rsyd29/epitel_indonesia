part of 'models.dart';

class RegistrationData {
  String uid;
  String name;
  String email;
  String password;
  String role;
  String noHp;
  String alamat;
  File profilePicture;
  String selectedGender;
  String selectedBranch;
  String status;
  String deviceId;

  RegistrationData({
    this.uid = "",
    this.name = "",
    this.email = "",
    this.password = "",
    this.role = "user",
    this.noHp = "",
    this.alamat = "",
    this.profilePicture,
    this.selectedGender = "",
    this.selectedBranch = "",
    this.status = "",
    this.deviceId = "",
  });
}
