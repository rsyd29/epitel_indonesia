part of 'widgets.dart';

class BottomSheetBranch extends StatefulWidget {
  @override
  _BottomSheetBranchState createState() => _BottomSheetBranchState();
}

class _BottomSheetBranchState extends State<BottomSheetBranch> {
  final List<String> statuses = ['aktif', 'tidak aktif'];

  //NOTE:Form Values
  bool isUpdating = false;
  bool isDataEdited = false;

  String _currentCabang;
  String _currentKota;
  String _currentQrCode;
  String _currentStatus;
  String _currentLat;
  String _currentLong;

  TextEditingController cabangController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController qrCodeController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
            )),
        child: Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 8, defaultMargin, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  "Tambah Kantor Cabang",
                  style: blackTextFont.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (val) => setState(() {
                    _currentCabang = val;
                    isDataEdited = (cabangController.text.trim() != null &&
                            kotaController.text.trim() != null &&
                            qrCodeController.text.trim() != null &&
                            latController.text.trim() != null &&
                            longController.text.trim() != null &&
                            _currentStatus != null)
                        ? true
                        : false;
                  }),
                  validator: (val) =>
                      val.isEmpty ? 'Silahkan Masukkan Nama Cabang' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Cabang",
                      hintText: "Masukkan Nama Cabang"),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  onChanged: (val) => setState(() {
                    _currentKota = val;
                    isDataEdited = (cabangController.text.trim() != null &&
                            kotaController.text.trim() != null &&
                            qrCodeController.text.trim() != null &&
                            latController.text.trim() != null &&
                            longController.text.trim() != null &&
                            _currentStatus != null)
                        ? true
                        : false;
                  }),
                  validator: (val) =>
                      val.isEmpty ? 'Silahkan Masukkan Nama  Kota' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Kota",
                      hintText: "Masukkan Nama Kota"),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  onChanged: (val) => setState(() {
                    _currentQrCode = val;
                    isDataEdited = (cabangController.text.trim() != null &&
                            kotaController.text.trim() != null &&
                            qrCodeController.text.trim() != null &&
                            latController.text.trim() != null &&
                            longController.text.trim() != null &&
                            _currentStatus != null)
                        ? true
                        : false;
                  }),
                  validator: (val) =>
                      val.isEmpty ? 'Silahkan Masukkan Data QR Code' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "QR Code",
                      hintText: "Masukkan Data QR Code"),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() {
                          _currentLat = val;
                          isDataEdited =
                              (cabangController.text.trim() != null &&
                                      kotaController.text.trim() != null &&
                                      qrCodeController.text.trim() != null &&
                                      latController.text.trim() != null &&
                                      longController.text.trim() != null &&
                                      _currentStatus != null)
                                  ? true
                                  : false;
                        }),
                        validator: (val) => val.isEmpty
                            ? 'Silahkan Masukkan Titik Koordinat Latitude'
                            : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Latitude",
                            hintText: "Latitude"),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() {
                          _currentLong = val;
                          isDataEdited =
                              (cabangController.text.trim() != null &&
                                      kotaController.text.trim() != null &&
                                      qrCodeController.text.trim() != null &&
                                      latController.text.trim() != null &&
                                      longController.text.trim() != null &&
                                      _currentStatus != null)
                                  ? true
                                  : false;
                        }),
                        validator: (val) => val.isEmpty
                            ? 'Silahkan Masukkan Titik Koordinat Longitude'
                            : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Longitude",
                            hintText: "Longitude"),
                      ),
                    ),
                  ],
                ),
                DropdownButtonFormField(
                  hint: Text("Pilih Status"),
                  items: statuses.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text('$status'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() {
                    _currentStatus = val;
                    isDataEdited = (cabangController.text.trim() != null &&
                            kotaController.text.trim() != null &&
                            qrCodeController.text.trim() != null &&
                            latController.text.trim() != null &&
                            longController.text.trim() != null &&
                            _currentStatus != null)
                        ? true
                        : false;
                  }),
                ),
                SizedBox(height: 10.0),
                (isUpdating)
                    ? Loading(
                        color: mainColor,
                        colorBg: Colors.white,
                      )
                    : SizedBox(
                        height: 45,
                        width: 250,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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

                                  String cabang = _currentCabang;
                                  String kota = _currentKota;
                                  String qrCode = _currentQrCode;
                                  String latitude = _currentLat;
                                  String longitude = _currentLong;
                                  String status = _currentStatus;

                                  print(cabang);
                                  print(kota);
                                  print(qrCode);
                                  print(latitude);
                                  print(longitude);
                                  print(status);

                                  DocumentReference documentReference =
                                      Firestore.instance
                                          .collection('branchs')
                                          .document();

                                  documentReference.setData({
                                    'bid': documentReference.documentID ?? "",
                                    'cabang': cabang ?? "",
                                    'latitude': latitude ?? "",
                                    'longitude': longitude ?? "",
                                    'kota': kota ?? "",
                                    'qrcode': qrCode ?? "",
                                    'status': status ?? "",
                                  });

                                  Navigator.of(context).pop();
                                  return Flushbar(
                                    duration: Duration(milliseconds: 1500),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message:
                                        "Cabang $cabang telah berhasil ditambahkan",
                                  )..show(context);
                                }
                              : null,
                        ),
                      ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetScan extends StatelessWidget {
  final String viewLatitude,
      viewLongitude,
      latitude,
      longitude,
      location,
      qrcode,
      date,
      time,
      account,
      result,
      text,
      buttonText;
  final IconData icon;
  final Color colorIc;
  final Function onPressed;

  BottomSheetScan(
      {this.viewLatitude,
      this.viewLongitude,
      this.latitude,
      this.longitude,
      this.location,
      this.account,
      this.qrcode,
      this.date,
      this.time,
      this.icon,
      this.colorIc,
      this.result,
      this.text,
      this.buttonText,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
            )),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: colorIc, size: 50.0),
              Text(result.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: blackTextFont.copyWith(
                      fontSize: 24.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: blackTextFont.copyWith(fontSize: 18.0),
              ),
              SizedBox(height: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Nama Lengkap : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(account, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tanggal : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(date, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Waktu : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(time, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Lokasi : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(location, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Data QR Code : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(qrcode, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Titik Koordinat : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(viewLatitude + ', ', style: blackTextFont),
                      Text(viewLongitude, style: blackTextFont),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Titik Koordinat Database : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(latitude + ', ', style: blackTextFont),
                      Text(longitude, style: blackTextFont),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              RaisedButton(
                onPressed: onPressed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                child: Text(
                  buttonText,
                  style: whiteTextFont,
                ),
                color: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void openLocationSettingsConfiguration() {
  final AndroidIntent intent = const AndroidIntent(
    action: 'action_location_source_settings',
  );
  intent.launch();
}
