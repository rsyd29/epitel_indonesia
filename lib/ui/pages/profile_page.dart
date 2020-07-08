part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        // note: HEADER
        Container(
          decoration: BoxDecoration(
              color: accentColor3,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 50),
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 13,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: (userState.user.role == "admin")
                                      ? AssetImage("assets/bandage_admin.png")
                                      : AssetImage("assets/bandage_user.png"))),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToEditProfilePage(userState.user));
                            print(userState.user.uid);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF64B5F6), width: 1)),
                            child: Stack(
                              children: [
                                Loading(
                                    colorBg: Colors.transparent,
                                    color: accentColor1),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              (userState.user.profilePicture ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/edit_profile.png")
                                                  : NetworkImage(userState
                                                      .user.profilePicture)),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width - 2 * defaultMargin - 78,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          userState.user.email,
                          style: yellowTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Loading(colorBg: Colors.white, color: mainColor);
            }
          }),
        ),
        ReusableSizedBox(height: 10),
        ReusableStyleTextProfile(title: "Edit Profile"),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => ReusableList(
            icon: MdiIcons.accountEdit,
            title: "Edit Profile",
            onTap: () {
              context
                  .bloc<PageBloc>()
                  .add(GoToEditProfilePage((userState as UserLoaded).user));
            },
          ),
        ),
        ReusableSizedBox(height: 10),
        ReusableStyleTextProfile(title: "About The Application"),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => ReusableList(
            icon: MdiIcons.information,
            title: "About The Application",
            onTap: () {
              context
                  .bloc<PageBloc>()
                  .add(GoToAboutPage((userState as UserLoaded).user));
            },
          ),
        ),
        ReusableSizedBox(height: 10),
        NotReusableSizedBoxAndButton(
          app: "Epitel Indonesia",
          versi: "Version 1.0.0",
          text: "Sign Out",
          color: accentColor3,
          onPressed: () {
            context.bloc<UserBloc>().add(SignOut());
            AuthServices.signOut();

            return Flushbar(
              duration: Duration(milliseconds: 1500),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Color(0xFFFF5C83),
              message: "You have left the account",
            )..show(context);
          },
        ),
      ],
    );
  }
}
