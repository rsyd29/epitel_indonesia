part of 'pages.dart';

class AddAdminPage extends StatefulWidget {
  final User user;

  AddAdminPage(this.user);
  @override
  _AddAdminPageState createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToAdminPage());
          return;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: accentColor3,
              title: Text('Tambah Akun', style: whiteTextFont),
              leading: GestureDetector(
                onTap: () {
                  context.bloc<PageBloc>().add(GoToAdminPage());
                },
                child: Icon(MdiIcons.arrowLeft),
              ),
            ),
            body: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
              if (userState is UserLoaded) {
                return Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("users")
                        .orderBy("status", descending: true)
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
                            String currentStatus = list[index]['uid'];
                            return GestureDetector(
                              onTap: () async {
                                print("masuk menggunakan : " + currentStatus);
                                User detailUser = await UserServices.getUser(
                                    list[index]['uid']);
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToUserDetailPage(detailUser));
                              },
                              child: ListTile(
                                leading: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: (list[index]['profilePicture'] !=
                                                "")
                                            ? NetworkImage(
                                                list[index]['profilePicture'])
                                            : AssetImage(
                                                "assets/edit_profile.png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                title: Text(
                                    list[index]['name'] +
                                        " \n" +
                                        list[index]['email'],
                                    style:
                                        blackTextFont.copyWith(fontSize: 12.0)),
                                subtitle: Text(
                                  list[index]['selectedBranch'],
                                  style: greyTextFont.copyWith(fontSize: 10.0),
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: (list[index]['status'] == 'aktif')
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    list[index]['role'] +
                                        " " +
                                        list[index]['status'],
                                    style: whiteTextFont.copyWith(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              } else {
                return Loading();
              }
            })));
  }
}

// class MemberViewer extends StatelessWidget {
//   final List<User> users;
//   MemberViewer(this.users);
//   @override
//   Widget build(BuildContext context) {
//     var sortedUsers = users;
//     sortedUsers.sort((user1, user2) => user1.uid.compareTo(user2.uid));
//     return ListView.builder(
//       itemCount: sortedUsers.length,
//       itemBuilder: (_, index) => GestureDetector(
//         onTap: () {
//           context.bloc<PageBloc>().add(GoToUserDetailPage(sortedUsers[index]));
//         },
//         child: ListTile(
//             leading: Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     image: (sortedUsers[index].profilePicture != "")
//                         ? NetworkImage(sortedUsers[index].profilePicture)
//                         : AssetImage("assets/edit_profile.png"),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             title: Text(
//                 sortedUsers[index].name + " \n" + sortedUsers[index].email,
//                 style: blackTextFont.copyWith(fontSize: 12.0)),
//             subtitle: Text(
//               sortedUsers[index].selectedBranch,
//               style: greyTextFont.copyWith(fontSize: 10.0),
//             ),
//             trailing: Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     color: (sortedUsers[index].status == 'active')
//                         ? Colors.green
//                         : Colors.red,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Text(sortedUsers[index].status,
//                     style: whiteTextFont.copyWith(
//                         fontSize: 10.0, fontWeight: FontWeight.bold)))),
//       ),
//     );
//   }
// }
