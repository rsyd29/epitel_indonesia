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
                                .add(GoToUserDetailPage(userState.user));
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
        ReusableStyleTextProfile(title: "Ubah Profil"),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => ReusableList(
            icon: MdiIcons.accountEdit,
            title: "Ubah Profil",
            onTap: () {
              context
                  .bloc<PageBloc>()
                  .add(GoToEditUserPage((userState as UserLoaded).user));
            },
          ),
        ),
        ReusableSizedBox(height: 5),
        ReusableStyleTextProfile(title: "Lihat Profil"),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => ReusableList(
            icon: MdiIcons.accountBox,
            title: "Lihat Profil",
            onTap: () {
              context
                  .bloc<PageBloc>()
                  .add(GoToUserDetailPage((userState as UserLoaded).user));
            },
          ),
        ),
        ReusableSizedBox(height: 5),
        // ReusableStyleTextProfile(title: "Tentang Aplikasi"),
        // BlocBuilder<UserBloc, UserState>(
        //   builder: (_, userState) => ReusableList(
        //     icon: MdiIcons.information,
        //     title: "Tentang Aplikasi",
        //     onTap: () {
        //       context
        //           .bloc<PageBloc>()
        //           .add(GoToAboutPage((userState as UserLoaded).user));
        //     },
        //   ),
        // ),
        // ReusableSizedBox(height: 3),
        NotReusableSizedBoxAndButton(
          app: "Epitel Indonesia",
          versi: "Versi 3.0.1",
          text: "Keluar Akun",
          color: accentColor3,
          onPressed: () {
            showDialog(
              builder: (context) => AlertDialog(
                title: Text("Keluar Akun"),
                content: Text("Kamu yakin ingin keluar dari akun ini?"),
                actions: <Widget>[
                  FlatButton(
                    // color: Colors.white.withOpacity(0.5),
                    onPressed: () {
                      context.bloc<UserBloc>().add(SignOut());
                      AuthServices.signOut()
                          .then((value) => Navigator.of(context).pop())
                          .then((value) => Flushbar(
                                duration: Duration(seconds: 3),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message:
                                    "Kamu telah keluar dari akun, terima kasih untuk hari ini",
                              )..show(context));
                    },
                    child: Text(
                      'Keluar',
                      style: blackTextFont,
                    ),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Batal',
                      style:
                          whiteTextFont.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              context: context,
            );
          },
        ),
      ],
    );
  }
}
