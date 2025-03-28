import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:todo_app/screens/login_page.dart';
import 'package:todo_app/services/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 8, 79, 136),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff0E1D3E),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      children: [
                        Text('hi', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                        Text('Anjal', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;

                        // FirebaseAuth.instance.signOut()
                        AuthService().logOut().then(
                          (value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (Route<dynamic> route) =>
                                false, // Remove all previous routes
                          ),
                        );
                        print(user!.uid);
                      },
                      icon: Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Yor To_dos',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    color: Color.fromARGB(255, 1, 30, 53),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.circle_outlined),
                      ),
                      title: Text(
                        'Todo One',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      subtitle: Text(
                        'Complete the assignment',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              color: Colors.red,
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
