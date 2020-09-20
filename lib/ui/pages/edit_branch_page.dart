part of 'pages.dart';

class EditBranchPage extends StatefulWidget {
  final Branch branch;
  const EditBranchPage(this.branch);
  @override
  _EditBranchPageState createState() => _EditBranchPageState();
}

class _EditBranchPageState extends State<EditBranchPage> {
  final List<String> statuses = ['aktif', 'tidak aktif'];

  bool isUpdating = false;
  bool isDataEdited = false;
  String _currentStatus;

  TextEditingController bidController = TextEditingController();
  TextEditingController cabangController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController qrCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bidController.text = widget.branch.bid;
    cabangController.text = widget.branch.cabang;
    kotaController.text = widget.branch.kota;
    latController.text = widget.branch.latitude;
    longController.text = widget.branch.longitude;
    qrCodeController.text = widget.branch.qrcode;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
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
                                Navigator.pop(context);

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
                              "Ubah Data\nKantor Cabang Ini",
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            QrImage(data: qrCodeController.text, size: 150.0),
                            SizedBox(height: 16),
                            AbsorbPointer(
                              child: TextField(
                                style: greyTextFont,
                                controller: bidController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: (widget.branch.bid == null)
                                      ? "ID Cabang"
                                      : widget.branch.bid,
                                  labelText: "ID Cabang",
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              style: blackTextFont,
                              controller: cabangController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (bidController.text.trim() !=
                                              widget.branch.bid ||
                                          cabangController.text.trim() !=
                                              widget.branch.cabang ||
                                          kotaController.text.trim() !=
                                              widget.branch.kota ||
                                          qrCodeController.text.trim() !=
                                              widget.branch.qrcode ||
                                          latController.text.trim() !=
                                              widget.branch.latitude ||
                                          longController.text.trim() !=
                                              widget.branch.longitude ||
                                          _currentStatus !=
                                              widget.branch.status)
                                      ? true
                                      : false;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Cabang",
                                  hintText: "Masukkan Nama Cabang"),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              style: blackTextFont,
                              controller: kotaController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (bidController.text.trim() !=
                                              widget.branch.bid ||
                                          cabangController.text.trim() !=
                                              widget.branch.cabang ||
                                          kotaController.text.trim() !=
                                              widget.branch.kota ||
                                          qrCodeController.text.trim() !=
                                              widget.branch.qrcode ||
                                          latController.text.trim() !=
                                              widget.branch.latitude ||
                                          longController.text.trim() !=
                                              widget.branch.longitude ||
                                          _currentStatus !=
                                              widget.branch.status)
                                      ? true
                                      : false;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Kota",
                                  hintText: "Masukkan Nama Kota"),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              style: blackTextFont,
                              controller: qrCodeController,
                              onChanged: (text) {
                                setState(() {
                                  isDataEdited = (bidController.text.trim() !=
                                              widget.branch.bid ||
                                          cabangController.text.trim() !=
                                              widget.branch.cabang ||
                                          kotaController.text.trim() !=
                                              widget.branch.kota ||
                                          qrCodeController.text.trim() !=
                                              widget.branch.qrcode ||
                                          latController.text.trim() !=
                                              widget.branch.latitude ||
                                          longController.text.trim() !=
                                              widget.branch.longitude ||
                                          _currentStatus !=
                                              widget.branch.status)
                                      ? true
                                      : false;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Qr Code",
                                  hintText: "Qr Code"),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: blackTextFont,
                                    controller: latController,
                                    onChanged: (text) {
                                      setState(() {
                                        isDataEdited = (bidController.text
                                                        .trim() !=
                                                    widget.branch.bid ||
                                                cabangController.text.trim() !=
                                                    widget.branch.cabang ||
                                                kotaController.text.trim() !=
                                                    widget.branch.kota ||
                                                qrCodeController.text.trim() !=
                                                    widget.branch.qrcode ||
                                                latController.text.trim() !=
                                                    widget.branch.latitude ||
                                                longController.text.trim() !=
                                                    widget.branch.longitude ||
                                                _currentStatus !=
                                                    widget.branch.status)
                                            ? true
                                            : false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        labelText: "Latitude",
                                        hintText: "Latitude"),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: blackTextFont,
                                    controller: longController,
                                    onChanged: (text) {
                                      setState(() {
                                        isDataEdited = (bidController.text
                                                        .trim() !=
                                                    widget.branch.bid ||
                                                cabangController.text.trim() !=
                                                    widget.branch.cabang ||
                                                kotaController.text.trim() !=
                                                    widget.branch.kota ||
                                                qrCodeController.text.trim() !=
                                                    widget.branch.qrcode ||
                                                latController.text.trim() !=
                                                    widget.branch.latitude ||
                                                longController.text.trim() !=
                                                    widget.branch.longitude ||
                                                _currentStatus !=
                                                    widget.branch.status)
                                            ? true
                                            : false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        labelText: "Longitude",
                                        hintText: "Longitude"),
                                  ),
                                ),
                              ],
                            ),
                            DropdownButtonFormField(
                              value: _currentStatus ?? widget.branch.status,
                              hint: Text("Pilih Status"),
                              items: statuses.map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text('$status'),
                                );
                              }).toList(),
                              onChanged: (val) => setState(() {
                                _currentStatus = val;
                                isDataEdited = (bidController.text.trim() !=
                                            widget.branch.bid ||
                                        cabangController.text.trim() !=
                                            widget.branch.cabang ||
                                        kotaController.text.trim() !=
                                            widget.branch.kota ||
                                        qrCodeController.text.trim() !=
                                            widget.branch.qrcode ||
                                        latController.text.trim() !=
                                            widget.branch.latitude ||
                                        longController.text.trim() !=
                                            widget.branch.longitude ||
                                        _currentStatus != widget.branch.status)
                                    ? true
                                    : false;
                              }),
                            ),
                            SizedBox(height: 16.0),
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
                                            "Simpan".toUpperCase(),
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

                                                  String cabang =
                                                      cabangController.text;
                                                  String kota =
                                                      kotaController.text;
                                                  String qrCode =
                                                      qrCodeController.text;
                                                  String latitude =
                                                      latController.text;
                                                  String longitude =
                                                      longController.text;
                                                  String status =
                                                      _currentStatus ??
                                                          widget.branch.status;

                                                  print('update cabang: ' +
                                                      cabang);
                                                  print('kota: ' + kota);
                                                  print('qrcode: ' + qrCode);
                                                  print('latitude:' + latitude);
                                                  print('longitude: ' +
                                                      longitude);
                                                  print('status: ' + status);

                                                  final Firestore firestore =
                                                      Firestore.instance;

                                                  DocumentReference
                                                      documentTask =
                                                      firestore.document(
                                                          'branchs/${widget.branch.bid}');
                                                  firestore.runTransaction(
                                                      (transaction) async {
                                                    DocumentSnapshot task =
                                                        await transaction
                                                            .get(documentTask);
                                                    if (task.exists) {
                                                      await transaction.update(
                                                        task.reference,
                                                        {
                                                          'cabang': cabang,
                                                          'kota': kota,
                                                          'qrcode': qrCode,
                                                          'latitude': latitude,
                                                          'longitude':
                                                              longitude,
                                                          'status': status,
                                                        },
                                                      );
                                                    }
                                                  });

                                                  Navigator.pop(context);

                                                  return Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor:
                                                        Color(0xFFFF5C83),
                                                    message:
                                                        "Perbarui cabang ${widget.branch.cabang} telah berhasil",
                                                  )..show(context);
                                                }
                                              : null),
                                    ),
                                  ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ],
                    )
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
