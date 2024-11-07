import 'dart:convert';
import 'package:discorev/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../services/general_service.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/splash_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final CardSwiperController controller = CardSwiperController();
  late Future _jobsFuture;
  final GeneralService jobService = GeneralService('/jobs');

  double _opacity = 0.0;
  String _swipeActionText = '';
  Color _swipeActionColor = Colors.transparent;

  bool showCandidates = false; // Switch pour les candidats ou jobs
  bool useCardSwiper = true; // Switch pour le mode d'affichage

  @override
  initState() {
    super.initState();
    _jobsFuture = getJobs();
  }

  getJobs() async {
    return await jobService.findAll();
  }

  List<Map<String, dynamic>> parseJobs(dynamic message) {
    print('Raw message to parse: $message');

    if (message is List) {
      try {
        return message.map((job) => job as Map<String, dynamic>).toList();
      } catch (e) {
        print('Erreur lors de l\'analyse des données: $e');
        return [];
      }
    } else if (message is String) {
      try {
        final List<dynamic> jobsJson = jsonDecode(message);
        return jobsJson.map((job) => job as Map<String, dynamic>).toList();
      } catch (e) {
        print('Erreur lors de l\'analyse des données: $e');
        return [];
      }
    } else {
      print('Le type de message n\'est ni une chaîne JSON ni une liste');
      return [];
    }
  }

  void _onSwipeCompleted(CardSwiperDirection direction, int index) {
    // Logique pour chaque direction
    setState(() {
      _opacity = 0.0; // Réinitialise l'opacité après un swipe
      if (direction == CardSwiperDirection.right) {
        // Ajouter le job ou candidat aux favoris
        _swipeActionText = 'Mettre en favoris';
        _swipeActionColor = Colors.red.withOpacity(0.5);
      } else if (direction == CardSwiperDirection.left) {
        _swipeActionText = 'Ignorer';
        _swipeActionColor = Colors.grey.withOpacity(0.5);
      }
      // Ajoute d'autres actions si nécessaire
    });
    // Insère ici ta logique d'ajout aux favoris ou d'autres actions
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(titleAppbar: 'Rechercher'),
      bottomNavigationBar: const BottomNavbar(initialIndex: 0),
      body: Column(
        children: [
          // Barre de recherche avec icônes et texte
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0), // Ajoute un padding global
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Localisation',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Secteur',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Logique de filtre et fermeture de la fenêtre
                                      Navigator.pop(context);
                                      // Filtrer les résultats ici
                                    },
                                    child: const Text('Enregistrer'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Rechercher',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (query) {
                      // Logique pour la recherche
                    },
                  ),
                ),
              ],
            ),
          ),
          // Les deux interrupteurs pour filtrer les candidats/jobs et le mode d'affichage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Text("Afficher les candidats"),
                  Switch(
                    value: showCandidates,
                    onChanged: (value) {
                      setState(() {
                        showCandidates = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Affichage en liste"),
                  Switch(
                    value: !useCardSwiper,
                    onChanged: (value) {
                      setState(() {
                        useCardSwiper = !value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          // Contenu principal (FutureBuilder pour afficher les résultats)
          Expanded(
            child: FutureBuilder(
              future: _jobsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final jobs = parseJobs(snapshot.data!.message);
                  if (jobs.isEmpty) {
                    return const Center(child: Text('Aucune donnée disponible.'));
                  } else {
                    // Choix du mode d'affichage (CardSwiper ou liste)
                    return useCardSwiper
                        ? CardSwiper(
                      controller: controller,
                      cardsCount: jobs.length,
                      numberOfCardsDisplayed:
                      jobs.length < 3 ? jobs.length : 3,
                      isLoop: false,
                      onUndo: _onUndo,
                      onSwipe: _onSwipe,
                      cardBuilder: (context, index, _, __) {
                        return buildJobCard(jobs[index], screenWidth);
                      },
                    )
                        : ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        return buildJobCard(jobs[index], screenWidth);
                      },
                    );
                  }
                } else {
                  return const Center(child: Text('Une erreur est survenue.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire une carte avec les informations du job
  Widget buildJobCard(Map<String, dynamic> job, double screenWidth) {
    return SizedBox(
      width: screenWidth,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Affichage de la photo de profil
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      job['photoUrl'] ?? 'https://via.placeholder.com/50',
                    ),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom de l'entreprise ou du candidat
                      Text(
                        job['name']?.toString() ?? 'Nom non disponible',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Type de compte
                      Text(
                        job['accountType']?.toString() ?? 'Type de compte non spécifié',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Localisation
              Text(
                job['location']?.toString() ?? 'Localisation non disponible',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                job['description']?.toString() ?? 'Description non disponible',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Fourchette de salaire (facultatif)
              Text(
                'Fourchette de salaire: ${job['salary_range']?.toString() ?? 'Non spécifiée'}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    _onSwipeCompleted(direction, previousIndex);
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undone from the ${direction.name}',
    );
    return true;
  }

  void _onDragging(direction, position, swipeProgress) {
    setState(() {
      // Mise à jour de l'opacité en fonction de la progression du swipe
      _opacity = swipeProgress.clamp(0.0, 1.0);
      if (direction == CardSwiperDirection.right) {
        _swipeActionText = 'Mettre en favoris';
        _swipeActionColor = Colors.red.withOpacity(_opacity);
      } else if (direction == CardSwiperDirection.left) {
        _swipeActionText = 'Ignorer';
        _swipeActionColor = Colors.grey.withOpacity(_opacity);
      }
      // Ajouter d'autres directions si besoin
    });
  }
}
