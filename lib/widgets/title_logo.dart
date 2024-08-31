import 'package:flutter/cupertino.dart';

class TitleLogo extends StatelessWidget {
  const TitleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    double logoHeightFactor = MediaQuery
        .of(context)
        .size
        .height < 600 ? 0.2 : 0.1;

    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * logoHeightFactor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'discorev.png',
              height: MediaQuery
                  .of(context)
                  .size
                  .height * (logoHeightFactor - 0.05),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Discorev', // Remplacez par le nom de votre application
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}