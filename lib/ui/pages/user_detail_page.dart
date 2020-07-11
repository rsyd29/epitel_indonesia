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
  String _profilePath;
  File profileImageFile;

  TextEditingController statusController = TextEditingController();

  TextEditingController roleController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profilePath = widget.user.profilePicture;
    statusController.text = widget.user.status;
    roleController.text = widget.user.role;
    deviceIdController.text = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToAddPage(widget.user));
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
                                context.bloc<PageBloc>().add(GoToAddPage(
                                    (userState as UserLoaded).user));
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
                              "Edit This\nUser Profile",
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 175),
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: (profileImageFile !=
                                                                null)
                                                            ? FileImage(
                                                                profileImageFile)
                                                            : (_profilePath !=
                                                                    "")
                                                                ? NetworkImage(
                                                                    _profilePath)
                                                                : AssetImage(
                                                                    "assets/edit_profile.png"),
                                                        fit: BoxFit.cover))),
                                            Container(
                                              width: 18,
                                              height: 18,
                                              margin: EdgeInsets.only(right: 4),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
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
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              widget.user.email,
                                              style: whiteNumberFont.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              (widget.user.noHp == "")
                                                  ? "-"
                                                  : widget.user.noHp,
                                              style: whiteTextFont.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
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
                                                  "Branch",
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      widget
                                                          .user.selectedBranch,
                                                      style: whiteTextFont
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    SizedBox(
                                                      height: 14,
                                                      width: 14,
                                                      child: (statusController
                                                                  .text ==
                                                              'active')
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
                                                  "User ID",
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      widget.user.uid
                                                          .substring(0, 18)
                                                          .toUpperCase(),
                                                      style: whiteNumberFont
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    SizedBox(
                                                      height: 14,
                                                      width: 14,
                                                      child: (statusController
                                                                  .text ==
                                                              'active')
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
                            TextField(
                              style: blackTextFont,
                              controller: deviceIdController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited =
                                      (deviceIdController.text.trim() !=
                                                  widget.user.deviceId ||
                                              (((statusController.text ==
                                                          'active') ||
                                                      (statusController.text ==
                                                          'not active')) &&
                                                  ((roleController.text ==
                                                          'user') ||
                                                      (roleController.text ==
                                                          'admin'))))
                                          ? true
                                          : false;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Device ID",
                                  hintText: (widget.user.deviceId == null)
                                      ? "Device ID"
                                      : widget.user.deviceId),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: statusController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited =
                                      (deviceIdController.text.trim() !=
                                                  widget.user.deviceId ||
                                              (((statusController.text ==
                                                          'active') ||
                                                      (statusController.text ==
                                                          'not active')) &&
                                                  ((roleController.text ==
                                                          'user') ||
                                                      (roleController.text ==
                                                          'admin'))))
                                          ? true
                                          : false;
                                });
                              },
                              style: (statusController.text == 'active')
                                  ? blackTextFont.copyWith(color: Colors.green)
                                  : blackTextFont.copyWith(color: Colors.red),
                              decoration: InputDecoration(
                                  helperText: "fill 'active' or 'not active'",
                                  helperStyle:
                                      blackTextFont.copyWith(color: Colors.red),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Status",
                                  labelText: "Status"),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: roleController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited =
                                      (deviceIdController.text.trim() !=
                                                  widget.user.deviceId ||
                                              (((statusController.text ==
                                                          'active') ||
                                                      (statusController.text ==
                                                          'not active')) &&
                                                  ((roleController.text ==
                                                          'user') ||
                                                      (roleController.text ==
                                                          'admin'))))
                                          ? true
                                          : false;
                                });
                              },
                              style: blackTextFont,
                              decoration: InputDecoration(
                                  helperText: "fill 'user' or 'admin'",
                                  helperStyle:
                                      blackTextFont.copyWith(color: Colors.red),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Role",
                                  labelText: "Role"),
                            ),
                            SizedBox(height: 20),
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
                                            "Update This User",
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

                                                  String status =
                                                      statusController.text;
                                                  String role =
                                                      roleController.text;

                                                  print(
                                                      'update user: ' + status);

                                                  final Firestore firestore =
                                                      Firestore.instance;

                                                  DocumentReference
                                                      documentTask =
                                                      firestore.document(
                                                          'users/${widget.user.uid}');
                                                  firestore.runTransaction(
                                                      (transaction) async {
                                                    DocumentSnapshot task =
                                                        await transaction
                                                            .get(documentTask);
                                                    if (task.exists) {
                                                      await transaction.update(
                                                        task.reference,
                                                        {
                                                          'role': role,
                                                          'status': status,
                                                        },
                                                      );
                                                    }
                                                  });

                                                  context
                                                      .bloc<PageBloc>()
                                                      .add(GoToAdminPage());

                                                  return Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor:
                                                        Color(0xFFFF5C83),
                                                    message:
                                                        "Update ${widget.user.name} success",
                                                  )..show(context);
                                                }
                                              : null),
                                    ),
                                  ),
                            SizedBox(height: 20),
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

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
