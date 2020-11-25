part of 'shared.dart';

double formatPositionLatitude(double num) {
  final position = num.toStringAsFixed(3).split("");

  num < 0 ? position.removeAt(5) : position.removeAt(4);

  final fixPosition = double.parse(position.join());
  return fixPosition;
}

double formatPositionLongitude(double num) {
  final position = num.toStringAsFixed(3).split("");

  num < 0 ? position.removeAt(7) : position.removeAt(6);

  final fixPosition = double.parse(position.join());
  return fixPosition;
}

Future<File> getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  return image;
}

Future<String> getScan() async {
  String qrCode = await scanner.scan();
  return qrCode;
}

Future<dynamic> getLocation() async {
  try {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.values[0]);
    return position;
  } catch (e) {
    print(e);
  }
}

Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
  return androidDeviceInfo.androidId;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  shouldReclip(CustomClipper<Path> oldClipper) => false;
}
