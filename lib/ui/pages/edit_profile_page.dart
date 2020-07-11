part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  EditProfilePage(this.user);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
                        "Edit Your\nProfile",
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
                                                ? NetworkImage(profilePath)
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
                                    isDataEdited =
                                        (nameController.text.trim() !=
                                                    widget.user.name ||
                                                noHpController.text.trim() !=
                                                    widget.user.noHp ||
                                                alamatController.text.trim() !=
                                                    widget.user.alamat ||
                                                profilePath !=
                                                    widget.user.profilePicture)
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
                                          image: AssetImage((profilePath == "")
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
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "User ID",
                              hintText: (widget.user.uid == null)
                                  ? "User ID"
                                  : widget.user.uid),
                        ),
                      ),
                      SizedBox(height: 16),
                      AbsorbPointer(
                        child: TextField(
                          style: greyTextFont,
                          controller: deviceIdController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Device ID",
                              hintText: (widget.user.deviceId == null)
                                  ? "Device ID"
                                  : widget.user.deviceId),
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
                                ? "Email"
                                : widget.user.email,
                            labelText: "Email",
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: nameController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (nameController.text.trim() !=
                                        widget.user.name ||
                                    noHpController.text.trim() !=
                                        widget.user.noHp ||
                                    alamatController.text.trim() !=
                                        widget.user.alamat ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        style: blackTextFont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Full Name",
                          labelText: "Full Name",
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: noHpController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (nameController.text.trim() !=
                                        widget.user.name ||
                                    noHpController.text.trim() !=
                                        widget.user.noHp ||
                                    alamatController.text.trim() !=
                                        widget.user.alamat ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        style: blackTextFont,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Phone Number",
                          labelText: "Phone Number",
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: alamatController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (nameController.text.trim() !=
                                        widget.user.name ||
                                    noHpController.text.trim() !=
                                        widget.user.noHp ||
                                    alamatController.text.trim() !=
                                        widget.user.alamat ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        style: blackTextFont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Address",
                          labelText: "Address",
                        ),
                      ),
                      SizedBox(height: 10),
                      ReusableButton(
                        color: Colors.red[400],
                        disabledColor: Color(0xFFE4E4E4),
                        icons: MdiIcons.alertOctagram,
                        text: "Change Password",
                        textStyle: whiteTextFont.copyWith(
                            fontSize: 16,
                            color: (isUpdating)
                                ? Color(0xFFBEBEBE)
                                : Colors.white),
                        onPressed: (isUpdating)
                            ? null
                            : () async {
                                await AuthServices.resetPassword(
                                    widget.user.email);
                                return Flushbar(
                                  duration: Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message:
                                      "The link to change your password has been sent to your email address, please check your email address!",
                                )..show(context);
                              },
                      ),
                      SizedBox(height: 10),
                      (isUpdating)
                          ? Loading(
                              color: mainColor,
                              colorBg: Colors.white,
                            )
                          : ReusableButton(
                              color: mainColor,
                              disabledColor: Color(0xFFE4E4E4),
                              text: "Update My Profile",
                              textStyle: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: (isDataEdited)
                                      ? Colors.white
                                      : Color(0xFFBEBEBE)),
                              onPressed: (isDataEdited)
                                  ? () async {
                                      setState(() {
                                        isUpdating = true;
                                      });

                                      if (profileImageFile != null) {
                                        profilePath =
                                            await uploadImage(profileImageFile);
                                      }

                                      context.bloc<UserBloc>().add(UpdateData(
                                          role: rolePath,
                                          selectedBranch: branchPath,
                                          selectedGender: genderPath,
                                          name: nameController.text,
                                          noHp: noHpController.text,
                                          alamat: alamatController.text,
                                          profilePicture: profilePath));

                                      if (widget.user.role == "admin") {
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToAdminPage());
                                      } else {
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToUserPage());
                                      }

                                      return Flushbar(
                                        duration: Duration(milliseconds: 1500),
                                        flushbarPosition:
                                            FlushbarPosition.BOTTOM,
                                        backgroundColor: Color(0xFFFF5C83),
                                        message: "Update profile success",
                                      )..show(context);
                                    }
                                  : null,
                            ),
                      SizedBox(height: 20),
                    ],
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
