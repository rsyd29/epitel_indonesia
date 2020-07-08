part of 'models.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String noHp;
  final String role;
  final String alamat;
  final String profilePicture;
  final String selectedGender;
  final String selectedBranch;
  final String status;
  final String deviceId;

  User(
    this.uid,
    this.email, {
    this.name,
    this.noHp,
    this.role,
    this.alamat,
    this.profilePicture,
    this.selectedGender,
    this.selectedBranch,
    this.status,
    this.deviceId,
  });

  User copyWith({
    String uid,
    String role,
    String name,
    String profilePicture,
    String noHp,
    String alamat,
    String selectedBranch,
    String selectedGender,
    String status,
    String deviceId,
  }) =>
      User(this.uid, this.email,
          role: role ?? this.role,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          noHp: noHp ?? this.noHp,
          alamat: alamat ?? this.alamat,
          selectedBranch: selectedBranch ?? this.selectedBranch,
          selectedGender: selectedGender ?? this.selectedGender,
          status: status ?? this.status,
          deviceId: deviceId ?? this.deviceId);

  @override
  String toString() {
    return "[$uid] - $name, $email";
  }

  @override
  List<Object> get props => [
        uid,
        email,
        name,
        noHp,
        role,
        alamat,
        profilePicture,
        selectedGender,
        selectedBranch,
        status,
        deviceId,
      ];
}
