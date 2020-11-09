part of 'pages.dart';

class BranchAddPage extends StatefulWidget {
  final User user;
  BranchAddPage(this.user);
  @override
  _BranchAddPageState createState() => _BranchAddPageState();
}

class _BranchAddPageState extends State<BranchAddPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToAddPage(widget.user));
          return;
        },
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print("Tambah kantor cabang");
                  return showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheetBranch();
                      });
                },
                child: Icon(MdiIcons.plus, size: 35.0)),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: accentColor3,
              title: Text('Tambah Kantor Cabang', style: whiteTextFont),
              leading: GestureDetector(
                onTap: () {
                  context.bloc<PageBloc>().add(GoToAddPage(widget.user));
                },
                child: Icon(MdiIcons.arrowLeft),
              ),
            ),
            body: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
              if (userState is UserLoaded) {
                return Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("branchs")
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
                            String currentBranch = list[index]['cabang'];
                            String currentBid = list[index]['bid'];
                            return Card(
                              elevation: 2,
                              child: InkWell(
                                onLongPress: () {
                                  showDialog(
                                    builder: (context) => AlertDialog(
                                      title: Text("Hapus Data Ini"),
                                      content: Text(
                                          "Apakah Kamu yakin ingin menghapus cabang ini?"),
                                      actions: <Widget>[
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          onLongPress: () {
                                            final Firestore firestore =
                                                Firestore.instance;

                                            DocumentReference documentTask =
                                                firestore.document(
                                                    'branchs/$currentBid');

                                            documentTask
                                                .delete()
                                                .then((value) =>
                                                    Navigator.of(context).pop())
                                                .then((value) => Flushbar(
                                                      duration:
                                                          Duration(seconds: 4),
                                                      flushbarPosition:
                                                          FlushbarPosition
                                                              .BOTTOM,
                                                      backgroundColor:
                                                          Color(0xFFFF5C83),
                                                      message:
                                                          "Cabang ini $currentBranch, telah dihapus dari database",
                                                    )..show(context));
                                          },
                                          child: Text(
                                            'Benar',
                                            style: blackTextFont,
                                          ),
                                        ),
                                        FlatButton(
                                          color: Colors.red,
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
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
                                onTap: () async {
                                  print("Masuk ke cabang : " + currentBranch);
                                  Branch detailBranch =
                                      await BranchServices.getBranch(
                                          currentBid);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            EditBranchPage(detailBranch)),
                                  );
                                },
                                child: ListTile(
                                  leading: GestureDetector(
                                      child: Hero(
                                        tag: list[index]['cabang'],
                                        child: QrImage(
                                            data: list[index]['qrcode'],
                                            size: 60.0,
                                            padding: EdgeInsets.all(0)),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) => Scaffold(
                                                        body: Center(
                                                            child: Hero(
                                                      tag: 'QR-Code',
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          QrImage(
                                                              data: list[index]
                                                                  ['qrcode'],
                                                              size: 150.0,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0)),
                                                          Text(
                                                            list[index]
                                                                ['qrcode'],
                                                            style: blackTextFont
                                                                .copyWith(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    )))));
                                      }),
                                  title: Text(
                                      list[index]['cabang'] +
                                          " \n" +
                                          list[index]['kota'],
                                      style: blackTextFont.copyWith(
                                          fontSize: 12.0)),
                                  subtitle: Text(
                                    list[index]['latitude'] +
                                        ", " +
                                        list[index]['longitude'],
                                    style:
                                        greyTextFont.copyWith(fontSize: 10.0),
                                  ),
                                  trailing: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color:
                                            (list[index]['status'] == 'aktif')
                                                ? Colors.green
                                                : Colors.red,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      list[index]['status'],
                                      style: whiteTextFont.copyWith(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
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
