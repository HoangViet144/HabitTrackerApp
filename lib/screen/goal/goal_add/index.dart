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
        padding: const EdgeInsets.all(20.0),
        color: const Color.fromARGB(255, 139, 216, 255),
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          const Icon(Icons.arrow_back, color: Colors.black),
          const Center(
            child: Text(
              "Add New Goal",
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ),
          Center(
              child: ElevatedButton(
            child: const Text("Add New"),
            onPressed: () {},
          )),
          const InputField()
        ]),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text("Goal title"),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Enter your goal'),
          ),
          const Text("Goal Description (optional)"),
          TextField(
            decoration: InputDecoration(
              hintText: 'Describe your goal.',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const Text("Priority"),
          OutlinedButton(
            onPressed: () {},
            child: const Text("1", style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              side: const BorderSide(width: 2, color: Colors.red),
            ),
          ),
          const Text("Due date"),
          OutlinedButton(
            onPressed: () {},
            child: const Text("Date picker"),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          const Text("Due Time (optional)"),
          OutlinedButton(
            onPressed: () {},
            child: const Text("Time picker"),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          Center(
              child: ElevatedButton(
            child: Text("Add New"),
            onPressed: () {},
          ))
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
