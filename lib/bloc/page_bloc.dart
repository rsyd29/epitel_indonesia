import 'dart:async';

import 'package:Epitel_Indonesia/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToUserPage) {
      yield OnUserPage(bottomNavBarIndex: event.bottomNavBarIndex);
    } else if (event is GoToAdminPage) {
      yield OnAdminPage(bottomNavBarIndex: event.bottomNavBarIndex);
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToCheckPage) {
      yield OnCheckPage();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } else if (event is GoToAboutPage) {
      yield OnAboutPage(event.user);
    } else if (event is GoToAddPage) {
      yield OnAddPage(event.user);
    } else if (event is GoToUserDetailPage) {
      yield OnUserDetailPage(event.user);
    }
  }
}
