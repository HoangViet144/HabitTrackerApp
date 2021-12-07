import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker_app/model/goal.dart';
import 'package:habit_tracker_app/model/index.dart';

const storage = FlutterSecureStorage();

void storeGoalList(List<Goal> goalList) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  if (user == null) return Future.error("null user");
  final uid = user.uid;

  await storage.write(key: uid, value: jsonEncode(goalList));
}

void loadGoalList(context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  if (user == null) return Future.error("null user");
  final uid = user.uid;

  String? json = await storage.read(key: uid);
  if (json != null) {
    Iterable l = jsonDecode(json);
    List<Goal> goals = List<Goal>.from(l.map((model) => Goal.fromJson(model)));

    print("Goal ne" + goals.length.toString());
    AppStateWidget.of(context).setGoalList(goals);
    // appState.currentState!.setGoalList(goals);
  }

  loadGoalListRemote(context);
}

void loadGoalListRemote(context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  if (user == null) return Future.error("null user");
  final uid = user.uid;

  FirebaseFirestore.instance.collection(uid).get().then((value) {
    List<Goal> goals = [];
    for (var doc in value.docs) {
      goals.add(Goal.fromJson(doc.data()));
    }
    print("hehe");
    print(goals.length);
    AppStateWidget.of(context).addNotExistGoals(goals);
    // appState.currentState!.addNotExistGoals(goals);
  });
}

void addGoalRemote(Goal goal) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  if (user == null) return Future.error("null user");
  final uid = user.uid;

  FirebaseFirestore.instance
      .collection(uid)
      .doc(goal.id)
      .set(goal.toJson(), SetOptions(merge: true))
      .then((value) => print("successfulled added"))
      .catchError((error) => print("Failed to merge data: $error"));
}

void removeGoalRemote(String id) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  if (user == null) return Future.error("null user");
  final uid = user.uid;

  FirebaseFirestore.instance.collection(uid).doc(id).delete();
}

Future<UserCredential> login(username, password, context) async {
  return await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: username,
    password: password,
  );
}

Future<UserCredential> register(username, password, context) async {
  return await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: username,
    password: password,
  );
}

void logout() async {
  await FirebaseAuth.instance.signOut();
}
