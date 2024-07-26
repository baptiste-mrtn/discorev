import 'package:discorev/screens/candidates/announce_list.dart';
import 'package:discorev/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:discorev/screens/home.dart';
import 'package:discorev/screens/messages.dart';
import 'package:discorev/screens/profile.dart';
import 'package:discorev/screens/favorites.dart';
import 'package:discorev/widgets/search.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
    '/intro': (context) => Intro(),
    '/profile': (context) => const ProfilePage(),
    '/search': (context) => const SearchPage(),
    '/messages': (context) => const MessagesPage(),
    '/favorites': (context) => const FavoritesPage(),
    '/announces': (context) => const AnnounceList(),
    // Ajoutez d'autres routes ici si nécessaire
  };
}