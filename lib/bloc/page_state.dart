part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnUserPage extends PageState {
  final int bottomNavBarIndex;

  OnUserPage({this.bottomNavBarIndex = 0});
  @override
  List<Object> get props => [bottomNavBarIndex];
}

class OnAdminPage extends PageState {
  final int bottomNavBarIndex;

  OnAdminPage({this.bottomNavBarIndex = 0});
  @override
  List<Object> get props => [bottomNavBarIndex];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnPreferencePage extends PageState {
  final RegistrationData registrationData;

  OnPreferencePage(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnRoleCheckPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditUserPage extends PageState {
  final User user;

  OnEditUserPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnEditKaryawanPage extends PageState {
  final User user;

  OnEditKaryawanPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnEditBranchPage extends PageState {
  final Branch branch;

  OnEditBranchPage(this.branch);
  @override
  List<Object> get props => [branch];
}

class OnAboutPage extends PageState {
  final User user;

  OnAboutPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnRecapPage extends PageState {
  final User user;

  OnRecapPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnApplyPage extends PageState {
  final User user;

  OnApplyPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnAddPage extends PageState {
  final User user;

  OnAddPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnUserDetailPage extends PageState {
  final User user;

  OnUserDetailPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnAddUserPage extends PageState {
  final User user;

  OnAddUserPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnAddBranchPage extends PageState {
  final User user;

  OnAddBranchPage(this.user);
  @override
  List<Object> get props => [user];
}
