import 'package:flutter/material.dart';
import 'dart:math';
import 'package:habit_tracker_app/component/my_drawer.dart';
import 'package:habit_tracker_app/model/goal.dart';
import 'package:habit_tracker_app/model/index.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({Key? key}) : super(key: key);
  void _tmp(context) {
    AppStateWidget.of(context).addGoal(Goal(dueDate: new DateTime(2000)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/create-goal");
              },
              child: Row(
                children: [
                  const Text("Add goal"),
                  Icon(
                    Icons.add_circle_outline,
                    size: 20,
                  ),
                ],
              ))
        ],
      ),
      drawer: const MyDrawer(),
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final int count = 0;
  final List<Color> colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.brown,
    Colors.purple
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: AppStateScope.of(context).goalList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        final randomNumber = Random().nextInt(7);
        if (index == 0) {
          return Column(
            children: [
              GoalTitle(),
            ],
          );
        } else {
          if (AppStateScope.of(context).goalList[index-1].progress==100) {
            return Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.lightGreen,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.circle,
                        size: 60,
                        color: colors[randomNumber],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${AppStateScope.of(context).goalList[index - 1].description}',
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                              'Due date: ${AppStateScope.of(context).goalList[index - 1].dueDate}',
                              style: const TextStyle(
                                fontSize: 10,
                              )),
                          Row(
                            children: [
                              Text(
                                  'Progress: ${AppStateScope.of(context).goalList[index - 1].progress}%',
                                  style: const TextStyle(
                                    fontSize: 10,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  'Priority: ${AppStateScope.of(context).goalList[index - 1].priority}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.access_alarm),
                            onPressed: () {
                              Goal newGoal =
                              AppStateScope.of(context).goalList[index - 1];
                              newGoal = newGoal.copyWith(progress: 100);
                              AppStateWidget.of(context).updateGoal(newGoal);
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ),
                  ],
                ));
          }
          else {
            return
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Text(
                  'Goal no.${index} unfinished',
                  style: const TextStyle(
                    fontSize: 15,
                  ),)
                  ],
                );
          }
        }
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class GoalTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Achievements',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.orangeAccent,
          ),
        ),
        Icon(
          Icons.check_box,
          size: 40,
          color: Colors.orangeAccent,
        ),
        const SizedBox(
          height: 60.0,
        ),
      ],
    );
  }
}
