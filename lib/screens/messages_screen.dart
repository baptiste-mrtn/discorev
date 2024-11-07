import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';
import '../widgets/custom_appbar.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppbar: 'Messagerie',
      ),
      bottomNavigationBar: const BottomNavbar(initialIndex:3),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 cartes par ligne
            childAspectRatio: 3 / 4, // Ajuste le ratio selon la taille souhaitée
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: contactList.length, // Le nombre total de contacts
          itemBuilder: (context, index) {
            final contact = contactList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(contact: contact),
                  ),
                );
              },
              child: ContactCard(contact: contact),
            );
          },
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(contact.photoUrl),
            radius: 30,
          ),
          SizedBox(height: 8),
          Text(
            '${contact.firstName} ${contact.lastName}',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            contact.jobTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            'Premier message: ${contact.firstMessageDate}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Contact {
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String firstMessageDate;

  Contact({
    required this.photoUrl,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.firstMessageDate,
  });
}

// Exemple de liste de contacts
final List<Contact> contactList = [
  Contact(
    photoUrl: 'https://example.com/photo1.jpg',
    firstName: 'John',
    lastName: 'Doe',
    jobTitle: 'Développeur Mobile',
    firstMessageDate: '12/09/2024',
  ),
  // Ajoute d'autres contacts ici
];
