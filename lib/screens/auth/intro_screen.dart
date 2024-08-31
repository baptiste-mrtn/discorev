import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/screens/auth/register_screen.dart';
import 'package:discorev/widgets/title_logo.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  final int accountType;

  IntroScreen({required this.accountType});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<Widget> _slideItems;

  @override
  void initState() {
    super.initState();
    // Initialisez la liste de slideItem dans initState
    if (widget.accountType == 1) {
      _slideItems = [
        slideItem(
          imagePath: 'img/intro_candidat_1.png',
          text:
          'Bienvenue sur Discorev \n'
            'Trouvez facilement votre stage ou alternance idéale. \n'
              'Commencez dès maintenant !',
        ),
        slideItem(
          imagePath: 'img/intro_candidat_2.png',
          text: 'Explorez des opportunités adaptées à votre profil. \n'
              'Filtrez, sauvegardez, et choisissez.',
        ),
        slideItem(
          imagePath: 'img/intro_candidat_3.png',
          text: 'Postulez rapidement avec un profil unique. \n'
              'Suivez vos candidatures en temps réel.',
        ),
      ];
    } else if (widget.accountType == 2) {
      _slideItems = [
        slideItem(
          imagePath: 'img/intro_recruteur_1.png',
          text:
          'Trouvez les meilleurs talents pour vos stages et alternances en quelques clics. \n'
              'Simplifiez votre recrutement dès aujourd\'hui !',
        ),
        slideItem(
          imagePath: 'img/intro_recruteur_2.png',
          text: 'Accédez à une sélection de candidats adaptés à vos besoins. \n'
              'Filtrez, explorez, et sauvegardez les profils intéressants.',
        ),
        slideItem(
          imagePath: 'img/intro_recruteur_3.png',
          text: 'Publiez vos offres et gérez les candidatures en un seul endroit. \n'
              'Trouvez le bon candidat rapidement.',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    int nbSlides = _slideItems.length;

    return Scaffold(
      body: Column(
        children: [
          // Logo et nom de l'application
          const TitleLogo(),
          // Slides
          // Slides
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: nbSlides,
              itemBuilder: (context, index) {
                return _slideItems[index];
              },
            ),
          ),
          // Indicateurs de page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(nbSlides, (int index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: _currentPage == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? CustomColors.primaryColorYellow : CustomColors.primaryColorBlue,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16.0),
          // Bouton "Continuer"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < nbSlides - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  // Redirection vers la page RegisterScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(accountType: widget.accountType),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primaryColorBlue, // Couleur bleue du bouton
              ),
              child: const Text('Continuer'),
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget slideItem({required String imagePath, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 250.0,
          width: 250.0,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.grey,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
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
