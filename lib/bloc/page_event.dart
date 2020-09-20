part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToUserPage extends PageEvent {
  final int bottomNavBarIndex;

  GoToUserPage({this.bottomNavBarIndex = 0});
  @override
  List<Object> get props => [bottomNavBarIndex];
}

class GoToAdminPage extends PageEvent {
  final int bottomNavBarIndex;

  GoToAdminPage({this.bottomNavBarIndex = 0});
  @override
  List<Object> get props => [bottomNavBarIndex];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToRegistrationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;
  GoToPreferencePage(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToCheckPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToEditUserPage extends PageEvent {
  final User user;

  GoToEditUserPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToEditKaryawanPage extends PageEvent {
  final User user;

  GoToEditKaryawanPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToEditBranchPage extends PageEvent {
  final Branch branch;

  GoToEditBranchPage(this.branch);
  @override
  List<Object> get props => [branch];
}

class GoToAboutPage extends PageEvent {
  final User user;

  GoToAboutPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToRecapPage extends PageEvent {
  final User user;

  GoToRecapPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToApplyPage extends PageEvent {
  final User user;

  GoToApplyPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToAddPage extends PageEvent {
  final User user;

  GoToAddPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToUserDetailPage extends PageEvent {
  final User user;

  GoToUserDetailPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToAddUserPage extends PageEvent {
  final User user;

  GoToAddUserPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToAddBranchPage extends PageEvent {
  final User user;

  GoToAddBranchPage(this.user);
  @override
  List<Object> get props => [user];
}
