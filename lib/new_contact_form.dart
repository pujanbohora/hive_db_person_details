import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'models/contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _age;

  void addContact(Contact contact) {
    print('Name: ${contact.name}, Age: ${contact.age}');
    final contactsBox = Hive.box('contacts');
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _age = value!,
                ),
              ),
            ],
          ),

          ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                final newContact = Contact(_name, int.parse(_age));
                addContact(newContact);
              },
              child: Text('Add New Contact'))
          
        ],
      ),
    );
  }
}
