part of 'pages.dart';

class EditKaryawanPage extends StatefulWidget {
  final User user;
  EditKaryawanPage(this.user);
  @override
  _EditKaryawanPageState createState() => _EditKaryawanPageState();
}

class _EditKaryawanPageState extends State<EditKaryawanPage> {
  final List<String> statuses = ['aktif', 'tidak aktif'];
  final List<String> roles = ['admin', 'user'];
  bool isUpdating = false;
  bool isDataEdited = false;
  String profilePath, _currentStatus, _currentRole, _currentBranch;
  File profileImageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profilePath = widget.user.profilePicture;
    nameController.text = widget.user.name;
    deviceIdController.text = widget.user.deviceId;
    branchController.text = widget.user.selectedBranch;
    statusController.text = widget.user.status;
    roleController.text = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToAddUserPage(widget.user));
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
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToAddUserPage(widget.user));

                                print("udah ke tap");
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
                              "Ubah Profil\nAkun Ini",
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
                                            Column(
                                              children: [
                                                Container(
                                                  height: 13,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      image: DecorationImage(
                                                          image: (widget.user
                                                                      .role ==
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
                                                                : (profilePath !=
                                                                        "")
                                                                    ? NetworkImage(
                                                                        profilePath)
                                                                    : AssetImage(
                                                                        "assets/edit_profile.png"),
                                                            fit:
                                                                BoxFit.cover))),
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                      child: (_currentStatus ==
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
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      widget.user.uid
                                                          .substring(0, 15)
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
                                                      child: (_currentStatus ==
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
                            TextField(
                              style: blackTextFont,
                              controller: nameController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (deviceIdController.text
                                                  .trim() !=
                                              widget.user.deviceId ||
                                          nameController.text.trim() !=
                                              widget.user.name ||
                                          _currentStatus !=
                                              widget.user.status ||
                                          _currentRole != widget.user.role ||
                                          _currentBranch !=
                                              widget.user.selectedBranch)
                                      ? true
                                      : false;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Nama Lengkap",
                                  hintText: "Nama Lengkap"),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              style: blackTextFont,
                              controller: deviceIdController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (deviceIdController.text
                                                  .trim() !=
                                              widget.user.deviceId ||
                                          nameController.text.trim() !=
                                              widget.user.name ||
                                          _currentStatus !=
                                              widget.user.status ||
                                          _currentRole != widget.user.role ||
                                          _currentBranch !=
                                              widget.user.selectedBranch)
                                      ? true
                                      : false;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "ID Perangkat",
                                  hintText: "ID Perangkat"),
                            ),
                            SizedBox(height: 16),
                            StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection('branchs')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Container(
                                    color: Colors.transparent,
                                  );
                                return Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: DropdownButtonFormField(
                                    value: _currentBranch ??
                                        widget.user.selectedBranch,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    hint: Text("Pilih Kantor Cabang"),
                                    items: snapshot.data.documents
                                        .map((DocumentSnapshot document) {
                                      String cabang = document.data['cabang'];
                                      return new DropdownMenuItem<String>(
                                        value: cabang,
                                        child: Text('Cabang $cabang'),
                                      );
                                    }).toList(),
                                    onChanged: (val) => setState(
                                      () {
                                        _currentBranch = val;
                                        setState(() {
                                          isDataEdited = (deviceIdController
                                                          .text
                                                          .trim() !=
                                                      widget.user.deviceId ||
                                                  nameController.text.trim() !=
                                                      widget.user.name ||
                                                  _currentStatus !=
                                                      widget.user.status ||
                                                  _currentRole !=
                                                      widget.user.role ||
                                                  _currentBranch !=
                                                      widget
                                                          .user.selectedBranch)
                                              ? true
                                              : false;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                value: _currentStatus ?? widget.user.status,
                                hint: Text("Pilih Status"),
                                items: statuses.map((status) {
                                  return DropdownMenuItem(
                                    value: status,
                                    child: Text('Status $status'),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() {
                                  _currentStatus = val;
                                  setState(() {
                                    isDataEdited = (deviceIdController.text
                                                    .trim() !=
                                                widget.user.deviceId ||
                                            nameController.text.trim() !=
                                                widget.user.name ||
                                            _currentStatus !=
                                                widget.user.status ||
                                            _currentRole != widget.user.role ||
                                            _currentBranch !=
                                                widget.user.selectedBranch)
                                        ? true
                                        : false;
                                  });
                                }),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                value: _currentRole ?? widget.user.role,
                                hint: Text("Pilih Status"),
                                items: roles.map((role) {
                                  return DropdownMenuItem(
                                    value: role,
                                    child: Text('Role $role'),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() {
                                  _currentRole = val;
                                  setState(() {
                                    isDataEdited = (deviceIdController.text
                                                    .trim() !=
                                                widget.user.deviceId ||
                                            nameController.text.trim() !=
                                                widget.user.name ||
                                            _currentStatus !=
                                                widget.user.status ||
                                            _currentRole != widget.user.role ||
                                            _currentBranch !=
                                                widget.user.selectedBranch)
                                        ? true
                                        : false;
                                  });
                                }),
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
                                            "Perbarui Profil Akun Ini",
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

                                                  String deviceId =
                                                      deviceIdController.text;
                                                  String name =
                                                      nameController.text;
                                                  String branch =
                                                      _currentBranch ??
                                                          widget.user
                                                              .selectedBranch;
                                                  String status =
                                                      _currentStatus ??
                                                          widget.user.status;
                                                  String role = _currentRole ??
                                                      widget.user.role;

                                                  print(
                                                      'deviceId: ' + deviceId);
                                                  print('name: ' + name);
                                                  print('branch: ' + branch);
                                                  print('status: ' + status);
                                                  print('role: ' + role);

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
                                                          'name': name,
                                                          'deviceId': deviceId,
                                                          'selectedBranch':
                                                              branch,
                                                          'status': status,
                                                          'role': role,
                                                        },
                                                      );
                                                    }
                                                  });

                                                  context.bloc<PageBloc>().add(
                                                      GoToAddUserPage(
                                                          widget.user));

                                                  return Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor:
                                                        Color(0xFFFF5C83),
                                                    message:
                                                        "Perbarui akun ${widget.user.name} telah berhasil",
                                                  )..show(context);
                                                }
                                              : null),
                                    ),
                                  ),
                            // SizedBox(height: 10.0),
                            // ReusableButton(
                            //   color: Colors.red[400],
                            //   disabledColor: Color(0xFFE4E4E4),
                            //   icons: MdiIcons.alertOctagram,
                            //   text: "Hapus Akun",
                            //   textStyle: whiteTextFont.copyWith(
                            //       fontSize: 16,
                            //       color: (isUpdating)
                            //           ? Color(0xFFBEBEBE)
                            //           : Colors.white),
                            //   onPressed: () {
                            //     showDialog(
                            //       builder: (context) => AlertDialog(
                            //         title: Text("Hapus Akun Ini"),
                            //         content: Text(
                            //             "Apakah Kamu yakin ingin menghapus akun ini?"),
                            //         actions: <Widget>[
                            //           InkWell(
                            //             borderRadius: BorderRadius.circular(3),
                            //             onLongPress: () {
                            //               final Firestore firestore =
                            //                   Firestore.instance;

                            //               DocumentReference documentTask =
                            //                   firestore.document(
                            //                       'absens/${widget.user.uid}');

                            //               documentTask
                            //                   .delete()
                            //                   .then((value) =>
                            //                       Navigator.of(context).pop())
                            //                   .then((value) => Flushbar(
                            //                         duration:
                            //                             Duration(seconds: 4),
                            //                         flushbarPosition:
                            //                             FlushbarPosition.BOTTOM,
                            //                         backgroundColor:
                            //                             Color(0xFFFF5C83),
                            //                         message:
                            //                             "Alamat email ini ${widget.user.email}, telah dihapus dari database",
                            //                       )..show(context));
                            //             },
                            //             child: Text(
                            //               'Benar',
                            //               style: blackTextFont,
                            //             ),
                            //           ),
                            //           FlatButton(
                            //             color: Colors.red,
                            //             onPressed: () =>
                            //                 Navigator.of(context).pop(),
                            //             child: Text(
                            //               'Batal',
                            //               style: whiteTextFont.copyWith(
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       context: context,
                            //     );
                            //   },
                            // ),
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
