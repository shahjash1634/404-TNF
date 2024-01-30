import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class Profile {
  String name;
  String email;
  String bio;
  String imageUrl;
  String semester;
  String year;
  String course;

  Profile({
    required this.name,
    required this.email,
    required this.bio,
    required this.imageUrl,
    required this.semester,
    required this.year,
    required this.course,
  });
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile userProfile = Profile(
    name: 'John Doe',
    email: 'john.doe@example.com',
    bio: 'Flutter Developer',
    imageUrl: 'https://example.com/profile_image.jpg',
    semester: '5th',
    year: '3rd',
    course: 'Computer Science',
  );

  @override
  Widget build(BuildContext context) {
    Color myColor = Color(0xFF2f3b61);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editProfile(context);
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: myColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userProfile.imageUrl),
                ),
                SizedBox(height: 16),
                Text(
                  userProfile.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  userProfile.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Semester: ${userProfile.semester}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'Year: ${userProfile.year}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'Course: ${userProfile.course}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  userProfile.bio,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editProfile(BuildContext context) async {
    // Navigate to the profile editing page
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage(userProfile)),
    );

    if (updatedProfile != null) {
      // Update the profile if the user made changes
      setState(() {
        userProfile = updatedProfile;
      });
    }
  }
}

class EditProfilePage extends StatefulWidget {
  final Profile initialProfile;

  EditProfilePage(this.initialProfile);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController semesterController;
  late TextEditingController yearController;
  late TextEditingController courseController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialProfile.name);
    emailController = TextEditingController(text: widget.initialProfile.email);
    semesterController =
        TextEditingController(text: widget.initialProfile.semester);
    yearController = TextEditingController(text: widget.initialProfile.year);
    courseController =
        TextEditingController(text: widget.initialProfile.course);
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = Color(0xFF2f3b61);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue, // Set the AppBar color to blue
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: myColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: semesterController,
                decoration: InputDecoration(
                  labelText: 'Semester',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: courseController,
                decoration: InputDecoration(
                  labelText: 'Course',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _saveChanges(context);
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    // Save the changes and navigate back to the profile page
    final updatedProfile = Profile(
      name: nameController.text,
      email: emailController.text,
      bio: widget.initialProfile.bio,
      imageUrl: widget.initialProfile.imageUrl,
      semester: semesterController.text,
      year: yearController.text,
      course: courseController.text,
    );

    Navigator.pop(context, updatedProfile);
  }
}
