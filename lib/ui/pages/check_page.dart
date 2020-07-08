part of 'pages.dart';

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  String androidid = "";
  @override
  void initState() {
    super.initState();
    getDeviceinfo();
  }

  void getDeviceinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo;
    androidDeviceInfo = await deviceInfo.androidInfo;
    if (this.mounted) {
      setState(() {
        deviceId = androidDeviceInfo
            .androidId; // instantiate Android Device Infoformation
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) {
        if (userState is UserLoaded) {
          if (userState.user.role == 'admin' &&
              userState.user.status == 'active' &&
              userState.user.deviceId == deviceId) {
            return AdminPage();
          } else if (userState.user.role == 'user' &&
              userState.user.status == 'active' &&
              userState.user.deviceId == deviceId) {
            return UserPage();
          } else {
            return ErrorPage(userState.user);
          }
        } else {
          return Loading(colorBg: Colors.white, color: mainColor);
        }
      },
    );
  }
}
