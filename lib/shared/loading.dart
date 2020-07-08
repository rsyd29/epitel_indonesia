part of 'shared.dart';

class Loading extends StatelessWidget {
  final Color colorBg;
  final Color color;
  final double size;

  Loading({this.colorBg, this.color, this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: colorBg,
        child: SpinKitCircle(
          color: color,
          size: size,
        ),
      ),
    );
  }
}
