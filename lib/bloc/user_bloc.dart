import 'dart:async';

import 'package:Epitel_Indonesia/models/models.dart';
import 'package:Epitel_Indonesia/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.uid);

      yield UserLoaded(user);
    } else if (event is GetUsers) {
      List<User> users = await UserServices.getUsers(event.uid);

      yield UsersLoaded(users);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      User updatedUser = (state as UserLoaded).user.copyWith(
          uid: event.uid,
          name: event.name,
          noHp: event.noHp,
          alamat: event.alamat,
          selectedBranch: event.selectedBranch,
          role: event.role,
          selectedGender: event.selectedGender,
          profilePicture: event.profilePicture,
          deviceId: event.deviceId,
          status: event.status);
      await UserServices.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    } else if (event is UpdateDataUsers) {
      User updatedUser = (state as UserLoaded).user.copyWith(
          uid: event.uid,
          name: event.name,
          noHp: event.noHp,
          alamat: event.alamat,
          selectedBranch: event.selectedBranch,
          role: event.role,
          selectedGender: event.selectedGender,
          profilePicture: event.profilePicture,
          deviceId: event.deviceId,
          status: event.status);
      await UserServices.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    }
  }
}
