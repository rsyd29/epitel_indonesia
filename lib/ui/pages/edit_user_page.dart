part of 'pages.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  EditUserPage(this.user);
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final List<String> statuses = ['aktif', 'tidak aktif'];

  bool isUpdating = false;
  bool isDataEdited = false;
  String profilePath, rolePath, branchPath, genderPath;
  File profileImageFile;

  TextEditingController uidController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profilePath = widget.user.profilePicture;
    uidController.text = widget.user.uid;
    deviceIdController.text = widget.user.deviceId;
    emailController.text = widget.user.email;
    nameController.text = widget.user.name;
    noHpController.text = widget.user.noHp;
    alamatController.text = widget.user.alamat;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));

    return WillPopScope(
      onWillPop: () {
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
            Container(color: accentColor3),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => Padding(
                            padding: EdgeInsets.only(top: 20),
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
                                return;
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ubah Profil\nKamu",
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: 90,
                              height: 104,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: (profileImageFile != null)
                                                  ? FileImage(profileImageFile)
                                                  : (profilePath != "")
                                                      ? NetworkImage(
                                                          profilePath)
                                                      : AssetImage(
                                                          "assets/edit_profile.png"),
                                              fit: BoxFit.cover))),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (profilePath == "") {
                                          profileImageFile = await getImage();

                                          if (profileImageFile != null) {
                                            profilePath =
                                                basename(profileImageFile.path);
                                          }
                                        } else {
                                          profileImageFile = null;
                                          profilePath = "";
                                        }

                                        setState(() {
                                          isDataEdited = (profilePath !=
                                                      widget.user
                                                          .profilePicture ||
                                                  noHpController.text.trim() !=
                                                      widget.user.noHp ||
                                                  alamatController.text
                                                          .trim() !=
                                                      widget.user.alamat)
                                              ? true
                                              : false;
                                        });
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage((profilePath ==
                                                        "")
                                                    ? "assets/btn_add_photo.png"
                                                    : "assets/btn_del_photo.png"))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AbsorbPointer(
                              child: TextField(
                                style: greyTextFont,
                                controller: uidController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelText: "ID Pengguna",
                                    hintText: "ID Pengguna"),
                              ),
                            ),
                            SizedBox(height: 16),
                            AbsorbPointer(
                              child: TextField(
                                style: greyTextFont,
                                controller: deviceIdController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelText: "ID Perangkat",
                                    hintText: "ID Perangkat"),
                              ),
                            ),
                            SizedBox(height: 16),
                            AbsorbPointer(
                              child: TextField(
                                style: greyTextFont,
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: (widget.user.email == null)
                                      ? "Alamat Email"
                                      : widget.user.email,
                                  labelText: "Alamat Email",
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            (widget.user.role == "user")
                                ? AbsorbPointer(
                                    child: TextField(
                                      style: greyTextFont,
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Nama Lengkap",
                                        labelText: "Nama Lengkap",
                                      ),
                                    ),
                                  )
                                : TextField(
                                    style: blackTextFont,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: "Nama Lengkap",
                                      labelText: "Nama Lengkap",
                                    ),
                                  ),
                            SizedBox(height: 16),
                            TextField(
                              controller: noHpController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (profilePath !=
                                              widget.user.profilePicture ||
                                          noHpController.text.trim() !=
                                              widget.user.noHp ||
                                          alamatController.text.trim() !=
                                              widget.user.alamat)
                                      ? true
                                      : false;
                                });
                              },
                              style: blackTextFont,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Nomor Handphone",
                                labelText: "Nomor Handphone",
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: alamatController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (profilePath !=
                                              widget.user.profilePicture ||
                                          noHpController.text.trim() !=
                                              widget.user.noHp ||
                                          alamatController.text.trim() !=
                                              widget.user.alamat)
                                      ? true
                                      : false;
                                });
                              },
                              style: blackTextFont,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Alamat",
                                labelText: "Alamat",
                              ),
                            ),
                            SizedBox(height: 16),
                            (isUpdating)
                                ? Loading(
                                    color: mainColor,
                                    colorBg: Colors.white,
                                  )
                                : BlocBuilder<UserBloc, UserState>(
                                    builder: (_, userState) => SizedBox(
                                      height: 45,
                                      width: 250,
                                      child: RaisedButton(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            "Perbarui Profil Saya",
                                            style: whiteTextFont.copyWith(
                                                fontSize: 16,
                                                color: (isDataEdited)
                                                    ? Colors.white
                                                    : Color(0xFFBEBEBE)),
                                          ),
                                          disabledColor: Color(0xFFE4E4E4),
                                          color: mainColor,
                                          onPressed: (isDataEdited)
                                              ? () async {
                                                  setState(() {
                                                    isUpdating = true;
                                                  });

                                                  if (profileImageFile !=
                                                      null) {
                                                    profilePath =
                                                        await uploadImage(
                                                            profileImageFile);
                                                  }

                                                  context.bloc<UserBloc>().add(
                                                      UpdateData(
                                                          profilePicture:
                                                              profilePath,
                                                          noHp: noHpController
                                                              .text,
                                                          alamat:
                                                              alamatController
                                                                  .text));

                                                  if (widget.user.role ==
                                                      "admin") {
                                                    context
                                                        .bloc<PageBloc>()
                                                        .add(GoToAdminPage(
                                                            bottomNavBarIndex:
                                                                1));
                                                  } else {
                                                    context
                                                        .bloc<PageBloc>()
                                                        .add(GoToUserPage(
                                                            bottomNavBarIndex:
                                                                1));
                                                  }

                                                  return Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor:
                                                        Color(0xFFFF5C83),
                                                    message:
                                                        "Memperbarui profile berhasil",
                                                  )..show(context);
                                                }
                                              : null),
                                    ),
                                  ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
