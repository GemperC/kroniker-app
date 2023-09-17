import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxcal_app/utils/screen_sizes.dart';
import 'package:luxcal_app/widgets/first_screen/logic.dart';
import 'package:luxcal_app/widgets/first_screen/styles.dart';

import '../../utils/theme.dart';

class FirstScreenWidget extends StatelessWidget {
  FirstScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          navigateToRouteWidget(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppTheme.of(context).bannerLightColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...backgroundRings(
                  5, 50, 140, 60, AppTheme.of(context).bannerColor),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ClipRect(
                        child: Image.asset("assets/images/face_image.png",
                            height: ScreenInfo(context).screenHeight * 0.22)),
                  ),
                  Flexible(child: Container()),
                  Text(
                    "Welcome To",
                    style: titleStyle_title,
                  ),
                  Text(
                    "LuxCal",
                    style: titleStyle_appname,
                  ),
                  Text(
                    "The extended Luxenberg & Arbisfeld \nFamily Nachas Calendar \n& Event Photo Album",
                    style: titleStyle_body,
                    textAlign: TextAlign.center,
                  ),
                  Flexible(child: Container()),
                  Text(
                    "Dedicated in loving memory to",
                    style: titleStyle_body,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Irwin Luxenberg, z'l",
                    style: titleStyle_bodyBold,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ז"ל',
                        style: titleStyle_bodyBold,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '  יצחק  יהודה  בן  אברהם',
                        style: titleStyle_bodyBold,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Flexible(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Click anywhere to continue",
                      style: titleStyle_body,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> backgroundRings(int ringCount, double ringThickness,
      double centerRadius, double padding, Color color) {
    List<Widget> rings = [];
    for (int i = 0; i < ringCount; i++) {
      double currentRadius = centerRadius + i * (ringThickness + padding);
      rings.add(
        Positioned.fill(
          child: CustomPaint(
            painter: RingPainter(ringThickness, currentRadius, color),
          ),
        ),
      );
    }
    return rings;
  }
}

class RingPainter extends CustomPainter {
  final double thickness;
  final double radius;
  final Color color;

  RingPainter(this.thickness, this.radius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}