import 'package:flutter/material.dart';
import 'package:discorev/home.dart';
import 'package:discorev/messages.dart';
import 'package:discorev/profile.dart';
import 'package:discorev/favorites.dart';
import 'package:discorev/search.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
    '/profile': (context) => const ProfilePage(),
    '/search': (context) => const SearchPage(),
    '/messages': (context) => const MessagesPage(),
    '/favorites': (context) => const FavoritesPage(),
    // Ajoutez d'autres routes ici si nécessaire
  };
}