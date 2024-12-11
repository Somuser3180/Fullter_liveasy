import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth.dart'; // Import the new screen


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_outlined,
              size: 100, // Changed to a more relevant icon
            ),
            const SizedBox(height: 20),
            const Text(
              'Please select your Language',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: 290, // Set fixed width

              child: const Text(
                'You can change the language at any time.',
                style: TextStyle(fontSize: 20),
                softWrap: true,
                textAlign: TextAlign.center,// Optionally, add this to handle overflow
              ),
            ),

            const SizedBox(height: 50, width: 50),
            Container(
              width: 216,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2), // Border color and width
                // Optional: Rounded corners
              ),
              child: DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue ?? selectedLanguage;
                  });
                },
                underline: SizedBox(), // Remove the default underline
                icon: Icon(Icons.arrow_drop_down, color: Colors.black), // Dropdown icon
                isExpanded: true, // Make the button take up the full width
                items: <String>['English', 'Spanish', 'French']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return <String>['English', 'Spanish', 'French']
                      .map<Widget>((String value) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out text and icon
                      children: <Widget>[
                        Text(value), // Text on the
                      ],
                    );
                  }).toList();
                },
              ),
            ),


            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()), // NextPage is the new screen
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Set border radius to 0
                ),
                backgroundColor: Color(0xFF2E3B62),
                padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Color(0xFFFFFFFF)),
              ),
              child:  Text('Next', style: TextStyle(
                color: Colors.white)),
            ),
            Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    'assets/pic2.png',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.contain, // Optional: Ensures the image maintains its aspect ratio
                  ),
                ),
                Positioned(

                  child: Image.asset(
                    'assets/pic1.png',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.contain, // Optional: Ensures the image maintains its aspect ratio
                  ),
                ),
              ],
            )




          ],
        ),
      ),
    );
  }
}