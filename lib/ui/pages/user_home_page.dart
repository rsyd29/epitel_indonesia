part of 'pages.dart';

class HomeUserPage extends StatefulWidget {
  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  bool isAddMember = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return Scaffold(
      body: Stack(
        children: [
          // NOTE: CONTENT
          BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('absens')
                        .where('uid', isEqualTo: userState.user.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.hasError) {
                        return Text('Something error');
                      }
                      if (querySnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Loading(color: mainColor, colorBg: Colors.white);
                      } else {
                        final list = querySnapshot.data.documents;
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (_, index) {
                              String absenID = list[index]['aid'];
                              DateTime dateTime =
                                  list[index]['checkIn'].toDate();
                              return GestureDetector(
                                onTap: () {
                                  print(
                                      "masuk menggunakan absenID: " + absenID);
                                },
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      top: index == 0 ? 166 : 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        color: Color(0xFF00AFF0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(list[index]['name'],
                                                style: yellowTextFont.copyWith(
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              children: [
                                                Icon(MdiIcons.mapMarker,
                                                    color: Colors.white),
                                                SizedBox(width: 5),
                                                Text(list[index]['location'],
                                                    style:
                                                        whiteTextFont.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                            10.0,
                                            16.0,
                                            10.0,
                                            16.0,
                                          ),
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    MdiIcons.mapMarker,
                                                    color: Colors.green,
                                                    size: 50,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("$dateTime",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text("Check In",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      10)),
                                                      Text("$dateTime",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  fontSize: 10))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    MdiIcons.mapMarker,
                                                    color: Colors.red,
                                                    size: 50,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("$dateTime",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text("Check Out",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      10)),
                                                      Text("$dateTime",
                                                          style: blackTextFont
                                                              .copyWith(
                                                                  fontSize: 10))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              );
            } else {
              return Loading();
            }
          }),

          // NOTE: HEADER
          Container(
            height: 155,
            color: accentColor3,
          ),
          BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return SafeArea(
                child: ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                      height: 150,
                      color: accentColor3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 24.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 13,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: (userState.user.role ==
                                                      "admin")
                                                  ? AssetImage(
                                                      "assets/bandage_admin.png")
                                                  : AssetImage(
                                                      "assets/bandage_user.png"))),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.bloc<PageBloc>().add(
                                            GoToEditProfilePage(
                                                userState.user));
                                        print(userState.user.uid);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFF64B5F6),
                                                width: 1)),
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
                                                      image: (userState.user
                                                                  .profilePicture ==
                                                              ""
                                                          ? AssetImage(
                                                              "assets/edit_profile.png")
                                                          : NetworkImage(userState
                                                              .user
                                                              .profilePicture)),
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
                                      width:
                                          size.width - 2 * defaultMargin - 78,
                                      child: Text(
                                        userState.user.name,
                                        style: whiteTextFont.copyWith(
                                            fontSize: 18),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Text(
                                      userState.user.email,
                                      style: yellowTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Row(children: [
                              Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAddMember = !isAddMember;
                                    });
                                  },
                                  child: Text(
                                    "Today",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: !isAddMember
                                            ? Colors.white
                                            : Color(0xFF007CDB)),
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                    height: 4.0,
                                    width: size.width * 0.5,
                                    color: !isAddMember
                                        ? accentColor1
                                        : Colors.transparent),
                              ]),
                              Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAddMember = !isAddMember;
                                    });
                                  },
                                  child: Text(
                                    "Yesterday",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: isAddMember
                                            ? Colors.white
                                            : Color(0xFF007CDB)),
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                    height: 4.0,
                                    width: size.width * 0.5,
                                    color: isAddMember
                                        ? accentColor1
                                        : Colors.transparent),
                              ]),
                            ]),
                          )
                        ],
                      )),
                ),
              );
            } else {
              return Loading();
            }
          }),
        ],
      ),
    );
  }
}

class RecapMemberUser extends StatelessWidget {
  final List<User> users;

  RecapMemberUser(this.users);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (_, index) => Container(
              margin: EdgeInsets.only(top: index == 0 ? 150.0 : 20.0),
            ));
  }
}
