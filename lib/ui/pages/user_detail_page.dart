part of 'pages.dart';

class UserDetailPage extends StatefulWidget {
  final User user;
  UserDetailPage(this.user);
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool isUpdating = false;
  bool isDataEdited = false;
  String profilePath, rolePath, genderPath, branchPath;
  File profileImageFile;

  TextEditingController deviceIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  @override
  void initState() {
    super.initState();
    rolePath = widget.user.role;
    branchPath = widget.user.selectedBranch;
    genderPath = widget.user.selectedGender;
    profilePath = widget.user.profilePicture;
    deviceIdController.text = widget.user.deviceId;
    emailController.text = widget.user.email;
    nameController.text = widget.user.name;
    noHpController.text = widget.user.noHp;
    alamatController.text = widget.user.alamat;
    uidController.text = widget.user.uid;
    statusController.text = widget.user.status;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        if (widget.user.role == 'admin') {
          context.bloc<PageBloc>().add(GoToAdminPage(bottomNavBarIndex: 1));
        } else {
          context.bloc<PageBloc>().add(GoToUserPage(bottomNavBarIndex: 1));
        }
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Lihat Profil\nKamu",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      // note: ID CARD
                      Container(
                        height: 185,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: accentColor3,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: Offset(0, 5))
                            ]),
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper: CardReflectionClipper(),
                              child: Container(
                                height: 185,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0)
                                        ])),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Container(
                                            height: 13,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                    image: (widget.user.role ==
                                                            "admin")
                                                        ? AssetImage(
                                                            "assets/bandage_admin.png")
                                                        : AssetImage(
                                                            "assets/bandage_user.png"))),
                                          ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: (profileImageFile !=
                                                              null)
                                                          ? FileImage(
                                                              profileImageFile)
                                                          : (profilePath != "")
                                                              ? NetworkImage(
                                                                  profilePath)
                                                              : AssetImage(
                                                                  "assets/edit_profile.png"),
                                                      fit: BoxFit.cover))),
                                        ],
                                      ),
                                      Container(
                                        width: 18,
                                        height: 18,
                                        margin: EdgeInsets.only(
                                            left: 160, right: 4),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: accentColor1),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.user.name,
                                        style: yellowTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        widget.user.email,
                                        style: whiteNumberFont.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        (widget.user.noHp == "")
                                            ? "-"
                                            : widget.user.noHp,
                                        style: whiteTextFont.copyWith(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Cabang",
                                            style: whiteTextFont.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                widget.user.selectedBranch,
                                                style: whiteTextFont.copyWith(
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                height: 14,
                                                width: 14,
                                                child: (widget.user.status ==
                                                        'aktif')
                                                    ? Image.asset(
                                                        'assets/ic_check_active.png')
                                                    : Image.asset(
                                                        'assets/ic_check_notactive.png'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "ID Pengguna",
                                            style: whiteTextFont.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                widget.user.uid
                                                    .substring(0, 15)
                                                    .toUpperCase(),
                                                style: whiteNumberFont.copyWith(
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              SizedBox(
                                                height: 14,
                                                width: 14,
                                                child: (statusController.text ==
                                                        'aktif')
                                                    ? Image.asset(
                                                        'assets/ic_check_active.png')
                                                    : Image.asset(
                                                        'assets/ic_check_notactive.png'),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ReusableButton(
                    color: Colors.red[400],
                    disabledColor: Color(0xFFE4E4E4),
                    icons: MdiIcons.alertOctagram,
                    text: "Ganti Kata Sandi",
                    textStyle: whiteTextFont.copyWith(
                        fontSize: 16, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text("Ganti Kata Sandi"),
                          content: Text(
                              "Link untuk mengubah kata sandi anda berada di email Anda ${widget.user.email}"),
                          actions: <Widget>[
                            FlatButton(
                              // color: Colors.white.withOpacity(0.5),
                              onPressed: () {
                                print("Link telah terkirim ke alamat email " +
                                    widget.user.email);
                                AuthServices.resetPassword(widget.user.email)
                                    .then(
                                        (value) => Navigator.of(context).pop())
                                    .then((value) => Flushbar(
                                          duration: Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          backgroundColor: Color(0xFFFF5C83),
                                          message:
                                              "Link untuk mengubah kata sandi Anda telah dikirim ke alamat email Anda ${widget.user.email}, silakan periksa alamat email Anda!",
                                        )..show(context));
                              },
                              child: Text(
                                'Kirim Link',
                                style: blackTextFont,
                              ),
                            ),
                            FlatButton(
                              color: Colors.red[400],
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'Batal',
                                style: whiteTextFont.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: defaultMargin),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.user.role == 'admin') {
                      context
                          .bloc<PageBloc>()
                          .add(GoToAdminPage(bottomNavBarIndex: 1));
                    } else {
                      context
                          .bloc<PageBloc>()
                          .add(GoToUserPage(bottomNavBarIndex: 1));
                    }
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
