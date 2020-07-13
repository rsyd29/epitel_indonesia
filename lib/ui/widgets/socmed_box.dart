part of 'widgets.dart';

class SocmedBox extends StatelessWidget {
  final Function onTap;
  final String socmed, acc;

  SocmedBox({@required this.onTap, this.socmed, this.acc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.only(bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.black)),
        child: Center(
            child: Column(
          children: [
            Text(
              socmed,
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w200),
            ),
            Text(
              acc,
              style: blackTextFont.copyWith(
                  fontSize: 10, fontWeight: FontWeight.w300),
            )
          ],
        )),
      ),
    );
  }
}
