import 'package:discorev/models/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:discorev/services/general_service.dart';
import 'package:discorev/screens/recruiter/dashboard_screen.dart';

import '../../widgets/bottom_navbar.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _salaryRangeController = TextEditingController();
  final GeneralService jobService = GeneralService('/jobs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publier une annonce'),
      ),
      bottomNavigationBar: const BottomNavbar(initialIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre du Job',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir le titre du job';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir la description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _salaryRangeController,
                decoration: const InputDecoration(
                  labelText: 'Fourchette de salaire',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir la fourchette de salaire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final res = await jobService.addOne({
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'salary_range': _salaryRangeController.text,
                    });

                    if (res.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: CustomColors.tertiaryColorWhite,
                          content: Text('Annonce ajoutée avec succès !',
                          style: TextStyle(color: Colors.green)),
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: CustomColors.tertiaryColorWhite,
                          content: Text('Erreur lors de l\'ajout de l\'annonce.',
                              style: TextStyle(color: Colors.red)),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
