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
  String _profilePath, _rolePath, _genderPath, _branchPath, _statusPath;
  File profileImageFile;

  Status selectedStatus;
  List<Status> statuses = [Status("active"), Status("not active")];
  List<DropdownMenuItem> generateStatus(List<Status> statuses) {
    List<DropdownMenuItem> items = [];
    for (var item in statuses) {
      items.add(DropdownMenuItem(child: Text(item.status), value: item));
    }
    return items;
  }

  Branch selectedBranch;
  List<Branch> branchs = [
    Branch("Cibitung"),
    Branch("Cikampek"),
    Branch("Kosambi"),
    Branch("Karawang"),
    Branch("Kodau Jatiasih"),
    Branch("Kaliabang"),
    Branch("A Pettarani"),
    Branch("Jatinegara"),
    Branch("Antang Makassar"),
    Branch("Bekasi Timur"),
    Branch("Sukabumi"),
    Branch("Manado"),
  ];
  List<DropdownMenuItem> generateBranch(List<Branch> branchs) {
    List<DropdownMenuItem> items = [];
    for (var item in branchs) {
      items.add(DropdownMenuItem(child: Text(item.branch), value: item));
    }
    return items;
  }

  // static const menuStatus = <String>["active", "not active"];
  // final List<DropdownMenuItem<String>> _dropDownMenuStatus =
  //     menuStatus.map((String value) => DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         ));

  // static const menuBranch = <String>[
  //   "Cibitung",
  //   "Cikampek",
  //   "Kosambi",
  //   "Karawang",
  //   "Kodau Jatiasih",
  //   "Kaliabang",
  //   "A Pettarani",
  //   "Jatinegara",
  //   "Antang Makassar",
  //   "Bekasi Timur",
  //   "Sukabumi",
  //   "Manado",
  // ];
  // final List<DropdownMenuItem<String>> _dropDownMenuBranch =
  //     menuBranch.map((String value) => DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         ));
  TextEditingController uidController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _rolePath = widget.user.role;
    _branchPath = widget.user.selectedBranch;
    _statusPath = widget.user.status;
    _genderPath = widget.user.selectedGender;
    _profilePath = widget.user.profilePicture;
    deviceIdController.text = widget.user.deviceId;
    emailController.text = widget.user.email;
    nameController.text = widget.user.name;
    noHpController.text = widget.user.noHp;
    statusController.text = widget.user.status;
    branchController.text = widget.user.selectedBranch;
    uidController.text = widget.user.uid;
    roleController.text = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              context.bloc<PageBloc>().add(
                                  GoToAddPage((userState as UserLoaded).user));
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
                                                          : (_profilePath != "")
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
                                            nameController.text,
                                            style: yellowTextFont.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            emailController.text,
                                            style: whiteNumberFont.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            (noHpController.text == "")
                                                ? "-"
                                                : noHpController.text,
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
                                                    branchController.text,
                                                    style: whiteTextFont
                                                        .copyWith(fontSize: 12),
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
                                                    uidController.text
                                                        .substring(0, 18)
                                                        .toUpperCase(),
                                                    style: whiteNumberFont
                                                        .copyWith(fontSize: 12),
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
                                isDataEdited = (deviceIdController.text
                                                .trim() !=
                                            widget.user.deviceId ||
                                        (((statusController.text == 'active') ||
                                                (statusController.text ==
                                                    'not active')) &&
                                            ((roleController.text == 'user') ||
                                                (roleController.text ==
                                                    'admin'))))
                                    ? true
                                    : false;
                                // isDataEdited =
                                //     (deviceIdController.text.trim() !=
                                //                 widget.user.deviceId ||
                                //             statusController.text.trim() !=
                                //                 widget.user.status ||
                                //             roleController.text.trim() !=
                                //                 widget.user.role)
                                //         ? true
                                //         : false;
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
                          // Container(
                          //   decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Color(0xFFBBBBBB), width: 1),
                          //       borderRadius: BorderRadius.circular(10)),
                          //   padding: EdgeInsets.all(8),
                          //   child: DropdownButton(
                          //     isExpanded: true,
                          //     style: blackTextFont.copyWith(
                          //         fontSize: 16, fontWeight: FontWeight.w400),
                          //     items: generateStatus(statuses),
                          //     value: selectedStatus,
                          //     hint: Text("Choose status"),
                          //     onChanged: (item) =>
                          //         setState(() => selectedStatus = item),
                          //   ),
                          // ),
                          TextField(
                            controller: statusController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited = (deviceIdController.text
                                                .trim() !=
                                            widget.user.deviceId ||
                                        (((statusController.text == 'active') ||
                                                (statusController.text ==
                                                    'not active')) &&
                                            ((roleController.text == 'user') ||
                                                (roleController.text ==
                                                    'admin'))))
                                    ? true
                                    : false;
                                // isDataEdited =
                                //     (deviceIdController.text.trim() !=
                                //                 widget.user.deviceId ||
                                //             statusController.text.trim() !=
                                //                 widget.user.status ||
                                //             roleController.text.trim() !=
                                //                 widget.user.role)
                                //         ? true
                                //         : false;
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
                          // Container(
                          //   decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Color(0xFFBBBBBB), width: 1),
                          //       borderRadius: BorderRadius.circular(10)),
                          //   padding: EdgeInsets.all(8),
                          //   child: DropdownButton(
                          //     isExpanded: true,
                          //     style: blackTextFont.copyWith(
                          //         fontSize: 16, fontWeight: FontWeight.w400),
                          //     items: generateBranch(branchs),
                          //     value: selectedBranch,
                          //     hint: Text("Choose branch"),
                          //     onChanged: (item) =>
                          //         setState(() => selectedBranch = item),
                          //   ),
                          // ),
                          TextField(
                            controller: roleController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited = (deviceIdController.text
                                                .trim() !=
                                            widget.user.deviceId ||
                                        (((statusController.text == 'active') ||
                                                (statusController.text ==
                                                    'not active')) &&
                                            ((roleController.text == 'user') ||
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

                                                // var user = await FirebaseAuth.instance
                                                //     .currentUser();

                                                // Firestore.instance
                                                //     .collection('users')
                                                //     .document(user.uid)
                                                //     .updateData({
                                                //   'status': statusController.text,
                                                //   'deviceId': deviceIdController.text,
                                                // });

                                                // User updateUser = (userState
                                                //         as UserLoaded)
                                                //     .user
                                                //     .copyWith(
                                                //       role: _rolePath,
                                                //       selectedBranch: _branchPath,
                                                //       selectedGender: _genderPath,
                                                //       name: nameController.text,
                                                //       noHp: noHpController.text,
                                                //       profilePicture: _profilePath,
                                                //       status: _statusPath,
                                                //       deviceId: deviceIdController.text,
                                                //     );

                                                // final Firestore firestore =
                                                //     Firestore.instance;

                                                // firestore
                                                //     .collection('users')
                                                //     .document(uidController.text)
                                                //     .updateData({
                                                //   'role': _rolePath,
                                                //   'selectedBranch': _branchPath,
                                                //   'selectedGender': _genderPath,
                                                //   'name': nameController.text,
                                                //   'noHp': noHpController.text,
                                                //   'profilePicture': _profilePath,
                                                //   'status': _statusPath,
                                                //   'deviceId': deviceIdController.text,
                                                // });

                                                // await UserServices.updateUser(
                                                //     updateUser);

                                                // context.bloc<UserBloc>().add(UpdateData(
                                                //     role: _rolePath,
                                                //     selectedBranch: _branchPath,
                                                //     selectedGender: _genderPath,
                                                //     name: nameController.text,
                                                //     noHp: noHpController.text,
                                                //     status: _statusPath,
                                                //     deviceId: deviceIdController.text,
                                                //     profilePicture: _profilePath));

                                                final Firestore firestore =
                                                    Firestore.instance;

                                                DocumentReference documentTask =
                                                    firestore
                                                        .collection('users')
                                                        .document(
                                                            uidController.text);
                                                firestore.runTransaction(
                                                    (transaction) async {
                                                  DocumentSnapshot task =
                                                      await transaction
                                                          .get(documentTask);

                                                  await transaction.update(
                                                    task.reference,
                                                    {
                                                      'role': _rolePath,
                                                      'selectedBranch':
                                                          _branchPath,
                                                      'selectedGender':
                                                          _genderPath,
                                                      'name':
                                                          nameController.text,
                                                      'noHp':
                                                          noHpController.text,
                                                      'status': selectedStatus,
                                                      'deviceId':
                                                          deviceIdController
                                                              .text,
                                                      'profilePicture':
                                                          _profilePath
                                                    },
                                                  );
                                                });

                                                print('update user: ' +
                                                    uidController.text);

                                                context.bloc<PageBloc>().add(
                                                    GoToAddPage((userState
                                                            as UserLoaded)
                                                        .user));

                                                return Flushbar(
                                                  duration: Duration(
                                                      milliseconds: 1500),
                                                  flushbarPosition:
                                                      FlushbarPosition.BOTTOM,
                                                  backgroundColor:
                                                      Color(0xFFFF5C83),
                                                  message:
                                                      "Update profile success",
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

class Status {
  String status;
  Status(this.status);
}

class Branch {
  String branch;
  Branch(this.branch);
}
