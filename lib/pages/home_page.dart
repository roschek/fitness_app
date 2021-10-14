import 'package:fit_proj/components/current_workout.dart';
import 'package:fit_proj/components/workout_list.dart';
import 'package:fit_proj/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../domain/workout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('My Fitness'),
        leading: const Icon(Icons.fitness_center),
        actions: [
          ElevatedButton(
            child: Text('Выйти'),
            onPressed: () {
              AuthService().logOut();
            },
          )
        ],
      ),
      body: _selectedIndex == 1 ? WorkoutList() : const CurrentWorkout(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Мои  упражнения'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'Поиск воркаутов')
        ],
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
