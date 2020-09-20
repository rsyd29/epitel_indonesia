part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  bool showPassword = false;
  String deviceId = "";

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
    deviceIdController.text = deviceId;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor3)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Daftar Akun\nBaru",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget.registrationData
                                              .profilePicture ==
                                          null)
                                      ? AssetImage("assets/edit_profile.png")
                                      : FileImage(widget
                                          .registrationData.profilePicture),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profilePicture ==
                                  null) {
                                widget.registrationData.profilePicture =
                                    await getImage();
                              } else {
                                widget.registrationData.profilePicture = null;
                              }

                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget.registrationData
                                                  .profilePicture ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      deviceId = await getDeviceId().then((id) {
                        setState(() {
                          deviceIdController.text = id;
                        });
                        return id;
                      });
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: "$deviceId"))
                          .then((value) => Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                backgroundColor: Color(0xFFFF5C83),
                                message:
                                    "ID Perangkat Berhasil Disalin: $deviceId",
                              )..show(context));
                      print("Data Berhasil Disalin: $deviceId");
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        onChanged: (id) {
                          setState(() {});
                        },
                        style: greyTextFont,
                        controller: deviceIdController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: (deviceIdController.text == null)
                              ? deviceIdController.text
                              : "ID Perangkat",
                          hintText: "ID Perangkat",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Nama Lengkap",
                        hintText: "Nama Lengkap"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Alamat Email",
                        hintText: "Alamat Email"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: !this.showPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Kata Sandi",
                      hintText: "Kata Sandi",
                      suffixIcon: IconButton(
                          icon: Icon(MdiIcons.eye),
                          color:
                              this.showPassword ? accentColor3 : Colors.black38,
                          onPressed: () {
                            setState(
                                () => this.showPassword = !this.showPassword);
                          }),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: retypePasswordController,
                    obscureText: !this.showPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Ketik Ulang Kata Sandi",
                      hintText: "Ketik Ulang Kata Sandi",
                      suffixIcon: IconButton(
                          icon: Icon(MdiIcons.eye),
                          color:
                              this.showPassword ? accentColor3 : Colors.black38,
                          onPressed: () {
                            setState(
                                () => this.showPassword = !this.showPassword);
                          }),
                    ),
                  ),
                  SizedBox(height: 30),
                  FloatingActionButton(
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: mainColor,
                      elevation: 0,
                      onPressed: () {
                        if (!(nameController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            passwordController.text.trim() != "" &&
                            retypePasswordController.text.trim() != "" &&
                            deviceIdController.text.trim() != "")) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Silahkan isi semua data yang disediakan",
                          )..show(context);
                        } else if (passwordController.text !=
                            retypePasswordController.text) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message:
                                "Kata sandi dan ketik ulang kata sandi tidak sama",
                          )..show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Panjang kata sandi minimal 6 karakter",
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Alamat email salah format",
                          )..show(context);
                        } else {
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.password =
                              passwordController.text;
                          widget.registrationData.deviceId =
                              deviceIdController.text;

                          context
                              .bloc<PageBloc>()
                              .add(GoToPreferencePage(widget.registrationData));
                        }
                      }),
                  SizedBox(height: 50.0)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
