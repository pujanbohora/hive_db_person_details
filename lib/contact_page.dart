import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'models/contact.dart';
import 'new_contact_form.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            NewContactForm(),
          ],
        ));
  }

  Widget _buildListView() {
    final contactsBox = Hive.box('contacts');

    return StreamBuilder(
        stream: contactsBox.watch(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: contactsBox.length,
              itemBuilder: (context, index) {
                final contact = contactsBox.getAt(index) as Contact;
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.age.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            contactsBox.putAt(
                                index, Contact(contact.name, contact.age + 1));
                          },
                          icon: Icon(Icons.refresh)),
                      IconButton(
                          onPressed: () {
                            contactsBox.deleteAt(index);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                );
              });
        });
  }
}
