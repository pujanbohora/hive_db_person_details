import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db_person_details/models/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'contact_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tutorial',
      home: FutureBuilder(
          future: Hive.openBox('contacts'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //check future is completed i.e, box is open
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return ContactPage();
              }
            } else {
              return const Scaffold();
            }
          }),
    );
  }

  @override
  void dispose() {
    Hive.box('contacts').compact();

    // Hive.close(); Closes all hive box
    Hive.box('contacts').close();
    super.dispose();
  }
}
