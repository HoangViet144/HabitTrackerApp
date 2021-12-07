import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/goal.dart' show Goal;
import 'package:habit_tracker_app/model/index.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: const Color.fromARGB(255, 139, 216, 255),
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: <Widget>[
            const SizedBox(height: 50.0),
            IconButton(
              iconSize: 35.0,
              alignment: Alignment.topLeft,
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            const Center(
              child: Text(
                "Add New Goal",
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
            const InputField(),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController title = TextEditingController(); // title
  String _priority = '1'; // Priority from 1 to 5
  DateTime? _dateTime; // Date
  TimeOfDay? _time; // Time
  TextEditingController description = TextEditingController(); //
  // String _icon = '';
  final flagColor = {
    '1': Colors.red,
    '2': Colors.orange,
    '3': Colors.green,
    '4': Colors.blue,
    '5': Colors.blueGrey,
  };

  String _showDate(DateTime? date) {
    return date == null
        ? "Select the due date"
        : date.day.toString() +
            "/" +
            date.month.toString() +
            "/" +
            date.year.toString();
  }

  String _showTime(TimeOfDay? time) {
    return time == null
        ? "Select the time of a day"
        : time.hour.toString() + ":" + time.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 11.0),
        Center(
          child: Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Icon"),
            ),
          ),
        ),
        const SizedBox(height: 11.0),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Goal title"),
              const SizedBox(height: 14),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Enter your goal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Priority"),
              const SizedBox(height: 14),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['1', '2', '3', '4', '5'].map((index) {
                    return IconButton(
                      icon: index == _priority
                          ? Icon(Icons.flag_rounded, color: flagColor[index])
                          : Icon(Icons.emoji_flags_rounded,
                              color: flagColor[index]),
                      onPressed: () {
                        if (_priority != index) {
                          setState(() {
                            _priority = index;
                          });
                        }
                      },
                    );
                  }).toList()),
              const SizedBox(height: 24),
              const Text("Time to notify (optional)"),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  ).then((pickedDated) {
                    setState(() {
                      _dateTime = pickedDated;
                    });
                  });
                },
                child: Text(_showDate(_dateTime)),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Due Time (optional)"),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 10, minute: 47),
                  ).then((pickedTime) {
                    setState(() {
                      _time = pickedTime;
                    });
                  });
                },
                child: Text(_showTime(_time)),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Goal Description (optional)"),
              const SizedBox(height: 14),
              TextField(
                controller: description,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Describe your goal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                  child: ElevatedButton(
                child: const Text("Add New"),
                onPressed: () {
                  final Goal newGoal = Goal(
                    description: description.text,
                    progress: 0,
                    priority: int.parse(_priority),
                    dueDate: _dateTime,
                  );
                  AppStateWidget.of(context).addGoal(newGoal);
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
              )),
            ],
          ),
        ),
      ],
    );
  }
}
