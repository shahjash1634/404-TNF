import 'package:connect/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Drawer Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Color myColor = Color(0xFF2f3b61);

  Future<void> _launchURL(String url) async {
    /*final Uri url = Uri.parse('172.18.116.11');
    if (!await launchUrl(url)) {
      throw Exception(
          'Could not launch ,please ensure college wifi connection');
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      drawer: Drawer(
          child: SingleChildScrollView(
        child: Container(
          color: myColor,
          child: Column(
            children: [
              DrawerHeader(
                child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Image.asset(
                    "assets/images/logo2.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ListTile(
                title: Text('Profile', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle profile option
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                title: Text('Announcements',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 1', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 2', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 3', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 4', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 5', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 6', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 7', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                color: myColor,
                child: ListTile(
                  title:
                      Text('Subject 8', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Divider(),
              ListTile(
                title:
                    Text('Course Reg.', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _launchURL('https://epayments.vjti.ac.in/');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Faculty feedback',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  _launchURL('https://epayments.vjti.ac.in/');
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      )),
      body: Center(
        child: Text('Welcome to the Homepage!'),
      ),
    );
  }
}
