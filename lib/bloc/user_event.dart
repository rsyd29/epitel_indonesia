part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String uid;

  LoadUser(this.uid);

  @override
  List<Object> get props => [uid];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateData extends UserEvent {
  final String uid;
  final String name;
  final String profilePicture;
  final String noHp;
  final String alamat;
  final String selectedBranch;
  final String role;
  final String selectedGender;
  final String status;
  final String deviceId;

  UpdateData(
      {this.uid,
      this.name,
      this.profilePicture,
      this.noHp,
      this.alamat,
      this.selectedBranch,
      this.selectedGender,
      this.role,
      this.status,
      this.deviceId});

  @override
  List<Object> get props => [
        uid,
        name,
        profilePicture,
        noHp,
        alamat,
        selectedBranch,
        selectedGender,
        role,
        status,
        deviceId,
      ];
}
