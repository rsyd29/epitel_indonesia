part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> gender = [
    "Pria",
    "Wanita",
  ];

  final List<String> branch = [
    "Cibitung",
    "Cikampek",
    "Kosambi",
    "Karawang",
    "Kodau Jatiasih",
    "Kaliabang",
    "A Pettarani",
    "Jatinegara",
    "Antang Makassar",
    "Bekasi Timur",
    "Sukabumi",
    "Manado",
  ];

  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  String selectedGender = "Pria";
  String selectedBranch = "Jatinegara";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";

        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 20, bottom: 4),
                    child: GestureDetector(
                        onTap: () {
                          widget.registrationData.password = "";
                          context.bloc<PageBloc>().add(
                              GoToRegistrationPage(widget.registrationData));
                          return;
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  Text(
                    "Silahkan Pilih\nJenis Kelamin",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenderWidgets(context),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Silahkan Pilih\nTempatmu Bekerja",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateBranchWidgets(context),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: FloatingActionButton(
                        child: Icon(Icons.arrow_forward),
                        elevation: 0,
                        backgroundColor: mainColor,
                        onPressed: () {
                          widget.registrationData.selectedGender =
                              selectedGender;
                          widget.registrationData.selectedBranch =
                              selectedBranch;

                          context.bloc<PageBloc>().add(
                              GoToAccountConfirmationPage(
                                  widget.registrationData));
                        }),
                  ),
                  SizedBox(height: 50.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenderWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.gender
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGender == e,
              onTap: () {
                setState(() {
                  selectedGender = e;
                });
              },
            ))
        .toList();
  }

  List<Widget> generateBranchWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.branch
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedBranch == e,
              onTap: () {
                setState(() {
                  selectedBranch = e;
                });
              },
            ))
        .toList();
  }
}
