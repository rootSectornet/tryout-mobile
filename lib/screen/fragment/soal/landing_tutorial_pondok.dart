import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LandingTutorialPondok extends StatefulWidget {
  final int idPaket;
  final int idJenjang;
  final int idTryout;
  final int sekolahTujuan;

  const LandingTutorialPondok(
      {Key key,
      this.idPaket,
      this.idJenjang,
      this.idTryout,
      this.sekolahTujuan})
      : super(key: key);

  @override
  _LandingTutorialPondokState createState() => _LandingTutorialPondokState(
      this.idPaket, this.idJenjang, this.idTryout, this.sekolahTujuan);
}

class _LandingTutorialPondokState extends State<LandingTutorialPondok> {
  _LandingTutorialPondokState(
      int idPaket, int idJenjang, int idTryout, int sekolahTujuan);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FancyOnBoarding(
      pageList: [
        PageModel(
            color: Color(0xfffd7878),
            heroImagePath: "assets/img/alquran.png",
            title: Center(
              child: Text(
                "Membaca Al-Quran",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "Membaca soal text, & menjawab dengan merekam suara",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            icon: Icon(
              Icons.arrow_right_alt,
              color: Color(0xfffd7878),
            )),
        PageModel(
            color: Color(0xff753de7),
            heroImagePath: "assets/img/ibadah.png",
            title: Center(
              child: Text(
                "Ibadah",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "Terbagi jadi 2 mata pelajaran: Ammaliyah jawab dengan video, Qoliyah jawab dengan rekaman suara",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            icon: Icon(
              Icons.arrow_right_alt,
              color: Color(0xff753de7),
            )),
        PageModel(
            color: Color(0xff3da3e7),
            heroImagePath: "assets/img/imla.png",
            title: Center(
              child: Text(
                "Imla",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "Mendengarkan soal berupa audio, dan menjawab dengan merekam suara jawaban",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            icon: Icon(
              Icons.arrow_right_alt,
              color: Color(0xff3da3e7),
            )),
        PageModel(
            color: Color(0xffFFE044),
            heroImagePath: "assets/img/bhsindo.png",
            title: Center(
              child: Text(
                "Berhitung & bhs",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "membaca soal text dan menjawab dengan foto",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            icon: Icon(
              Icons.done,
              color: Color(0xffFFE044),
            )),
      ],
      bottomMargin: 10,
      showSkipButton: true,
      skipButton: Padding(
        padding: EdgeInsets.only(top: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            print("On Skip pressed");
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                "Skip",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      onSkipButtonPressed: () {
        print("On Skip pressed");
      },
      onDoneButtonPressed: () {
        print("On Done Pressed");
      },
      doneButton: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            print("On Done Pressed");
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                "Done",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
