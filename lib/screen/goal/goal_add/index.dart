import 'package:flutter/material.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Habit Tracker app"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: const Color.fromARGB(255, 139, 216, 255),
        alignment: Alignment.center,
        child: ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
          IconButton(
              onPressed: () {
                // TODO: Back button to the previous Navigator
              },
              icon: const Icon(Icons.arrow_back, color: Colors.grey)),
          const Center(
            child: Text(
              "Add New Goal",
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ),
          const InputField(),
        ]),
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
  String _priority = '1'; // Priority from 1 to 5
  DateTime? _dateTime; // Date
  TimeOfDay? _time; // Time
  // String _icon = '';
  final flagColor = {
    '1': Colors.red,
    '2': Colors.orange,
    '3': Colors.green,
    '4': Colors.blue,
    '5': Colors.blueGrey
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
        const Text("Emoji here."),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Goal title"),
              const SizedBox(height: 14),
              TextField(
                  decoration: InputDecoration(
                hintText: 'Enter your goal',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )),
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
              const Text("Goal Description (optional)"),
              const SizedBox(height: 14),
              TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Describe your goal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Center(
                  child: ElevatedButton(
                child: const Text("Add New"),
                onPressed: () {
                  // TODO: Add data to server
                },
              )),
            ],
          ),
        ),
      ],
    );
  }
}
