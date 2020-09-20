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
          centerTitle: true,
          elevation: 0,
          backgroundColor: accentColor3,
          title: Text("Halaman Tambah Kategori", style: whiteTextFont),
          leading: GestureDetector(
            onTap: () {
              context.bloc<PageBloc>().add(GoToAdminPage());
            },
            child: Icon(MdiIcons.arrowLeft),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                // flex: 3,
                child: InkWell(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToAddUserPage(widget.user));
                    print("Tambah Karyawan, telah ditekan");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30)),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.account,
                          size: 130.0,
                          color: Colors.white,
                        ),
                        Text("Akun Karyawan".toUpperCase(),
                            style: whiteTextFont.copyWith(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(32, 16, 32, 8),
                  ),
                ),
              ),
              Flexible(
                // flex: 3,
                child: InkWell(
                  onTap: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToAddBranchPage(widget.user));
                    print("Tambah Cabang, telah ditekan");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30)),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.briefcase,
                          size: 130.0,
                          color: Colors.white,
                        ),
                        Text("Kantor Cabang".toUpperCase(),
                            style: whiteTextFont.copyWith(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(32, 16, 32, 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
