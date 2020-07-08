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

class GoToEditProfilePage extends PageEvent {
  final User user;

  GoToEditProfilePage(this.user);
  @override
  List<Object> get props => [user];
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
