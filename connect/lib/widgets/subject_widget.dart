import 'package:connect/pages/subject_page.dart';
import 'package:flutter/material.dart';

class SubjectWidget extends StatelessWidget {
   final String documentId;

  const SubjectWidget({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        color: Color(0xFF7c7adf).withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(width: 0)),
        child: SizedBox(
          height: 100,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/1.png"),
              radius: 25,
            ),
            title:  Text(documentId,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            subtitle: const Text(
              "Professor name",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              iconSize: 25,
              color: Colors.white,
              onPressed: () {},
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SubjectPage()));
            },
          ),
        ),
      ),
    );
  }
}
