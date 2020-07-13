part of 'widgets.dart';

class BottomSheetWidget extends StatelessWidget {
  final String latitude,
      longitude,
      qrcode,
      date,
      time,
      account,
      result,
      text,
      buttonText;
  final IconData icon;
  final Color color;
  final Function onPressed;

  BottomSheetWidget(
      {this.latitude,
      this.longitude,
      this.account,
      this.qrcode,
      this.date,
      this.time,
      this.icon,
      this.color,
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
              Icon(icon, color: color, size: 50.0),
              Text(result,
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
                      Text("Account : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(account, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Date : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(date, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Time : ",
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold)),
                      Text(time, style: blackTextFont)
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Coordinat Point : ",
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
