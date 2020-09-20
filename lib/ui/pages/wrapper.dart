part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToCheckPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        prevPageEvent = GoToCheckPage();
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
                                ? AdminPage(
                                    bottomNavBarIndex:
                                        pageState.bottomNavBarIndex,
                                  )
                                : (pageState is OnUserPage)
                                    ? UserPage(
                                        bottomNavBarIndex:
                                            pageState.bottomNavBarIndex,
                                      )
                                    : (pageState is OnEditUserPage)
                                        ? EditUserPage(pageState.user)
                                        : (pageState is OnEditKaryawanPage)
                                            ? EditKaryawanPage(pageState.user)
                                            : (pageState is OnEditBranchPage)
                                                ? EditBranchPage(
                                                    pageState.branch)
                                                : (pageState is OnAboutPage)
                                                    ? AboutPage(pageState.user)
                                                    : (pageState is OnAddPage)
                                                        ? AddAdminPage(
                                                            pageState.user)
                                                        : (pageState
                                                                is OnUserDetailPage)
                                                            ? UserDetailPage(
                                                                pageState.user)
                                                            : (pageState
                                                                    is OnAddUserPage)
                                                                ? UserAddPage(
                                                                    pageState
                                                                        .user)
                                                                : (pageState
                                                                        is OnAddBranchPage)
                                                                    ? BranchAddPage(
                                                                        pageState
                                                                            .user)
                                                                    : CheckPage());
  }
}
