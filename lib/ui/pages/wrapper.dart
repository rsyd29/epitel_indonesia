part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    User user;

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToCheckPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        // context.bloc<AbsenBloc>().add(GetAbsens(firebaseUser.uid));
        prevPageEvent = GoToCheckPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      } else if (prevPageEvent is GoToAddPage) {
        context.bloc<UserBloc>().add(GetUsers(firebaseUser.uid));
        prevPageEvent = GoToAddPage(user);
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registrationData)
                    : (pageState is OnPreferencePage)
                        ? PreferencePage(pageState.registrationData)
                        : (pageState is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(
                                pageState.registrationData)
                            : (pageState is OnAdminPage)
                                ? AdminPage()
                                : (pageState is OnUserPage)
                                    ? UserPage()
                                    : (pageState is OnEditProfilePage)
                                        ? EditProfilePage(pageState.user)
                                        : (pageState is OnAboutPage)
                                            ? AboutPage(pageState.user)
                                            : (pageState is OnAddPage)
                                                ? AddAdminPage()
                                                : (pageState
                                                        is OnUserDetailPage)
                                                    ? UserDetailPage(
                                                        pageState.user)
                                                    : CheckPage());
    // : MainPage());
  }
}
