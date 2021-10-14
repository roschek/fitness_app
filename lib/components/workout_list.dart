import 'package:fit_proj/domain/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutList extends StatefulWidget {
  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  final workouts = <Workout>[
    Workout(
        title: 'test1',
        author: 'Max',
        description: 'NewOne',
        level: 'beginner'),
    Workout(
        title: 'test2',
        author: 'Dan',
        description: 'NewTwo',
        level: 'advanced'),
    Workout(
        title: 'test3',
        author: 'Alex',
        description: 'NewThree',
        level: 'intermediate'),
    Workout(
        title: 'test4',
        author: 'Sandra',
        description: 'NewFour',
        level: 'beginner'),
    Workout(
        title: 'test5',
        author: 'Devill',
        description: 'NewFive',
        level: 'beginner'),
    Workout(
        title: 'test6',
        author: 'Caroline',
        description: 'NewSix',
        level: 'intermediate'),
    Workout(
        title: 'test7',
        author: 'Katerine',
        description: 'NewSeven',
        level: 'beginner'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              decoration:
              const BoxDecoration(color: Color.fromRGBO(50, 65, 85, .8)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: const Icon(Icons.fitness_center, color: Colors.white),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.white24))),
                ),
                title: Text(
                  workouts[index].title,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1?.color,
                      fontWeight: FontWeight.bold),
                ),
                trailing:
                const Icon(Icons.keyboard_arrow_right, color: Colors.white),
                subtitle: _addSubtitle(context, workouts[index]),
              ),
            ),
          );
        });
  }
}

Widget _addSubtitle(BuildContext context, Workout workout) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch (workout.level) {
    case 'beginner':
      color = Colors.green;
      indicatorLevel = .33;
      break;
    case 'intermediate':
      color = Colors.yellow;
      indicatorLevel = .66;
      break;
    case 'advanced':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }

  return Row(
    children: <Widget>[
      Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).textTheme.subtitle1?.color,
            value: indicatorLevel,
            valueColor: AlwaysStoppedAnimation(color),
          )),
      const SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: Text(
          workout.level,
          style: const TextStyle(color: Colors.white),
        ),
      )
    ],
  );
}