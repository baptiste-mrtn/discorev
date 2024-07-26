import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/screens/auth/register.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<Widget> _slideItems;

  @override
  void initState() {
    super.initState();
    // Initialisez la liste de slideItem dans initState
    _slideItems = [
      slideItem(
        imagePath: 'img/artisan.jpg',
        text:
            'Transformons vos ambitions en opportunités pour les talents de demain',
      ),
      slideItem(
        imagePath: 'img/artisan.jpg',
        text: 'Chaque expérience compte',
      ),
      slideItem(
        imagePath: 'img/artisan.jpg',
        text: 'Connecte avec les meilleurs',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int nbSlides = _slideItems.length;
    return Scaffold(
        body: Stack(children: [
      PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: _slideItems),
      Positioned(
        bottom: 30.0,
        left: 16.0,
        right: 16.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Text(
                'Précédent',
                style: TextStyle(
                  color: _currentPage > 0 ? CustomColors.secondaryColorYellow : CustomColors.tertiaryColorWhite,
                ),
              ),
            ),
            _currentPage == nbSlides-1
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text('Commencer'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text('Suivant'),
                  )
          ],
        ),
      ),
    ]));
  }

  Widget slideItem({required String imagePath, required String text}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5), // Assombrir l'image de fond
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
