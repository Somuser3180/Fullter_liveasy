import 'package:flutter/material.dart';

class SelectProfile extends StatefulWidget {
  @override
  _SelectProfileState createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  // This variable will hold the selected value, initially null
  String? selectedProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            const Text(
              'Please select your profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Option 1: Profile 1
            Container(
              width: 300, // Set width
              height: 120, // Set height
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2), // Border color and width
              ),
              child: RadioListTile<String>(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipper',
                      style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                value: 'profile1', // The value for this option
                groupValue: selectedProfile, // The currently selected value
                onChanged: (String? value) {
                  setState(() {
                    selectedProfile = value; // Update the selected value
                  });
                },
                activeColor: Color(0xFF2E3B62), // Color of the radio button when selected
              ),
            ),
            // Option 2: Profile 2
            const SizedBox(height: 20),
            Container(
              width: 300, // Set width
              height: 120, // Set height
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2), // Border color and width
              ),
              child: RadioListTile<String>(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transporter',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                value: 'profile2', // The value for this option
                groupValue: selectedProfile, // The currently selected value
                onChanged: (String? value) {
                  setState(() {
                    selectedProfile = value; // Update the selected value
                  });
                },
                activeColor: Color(0xFF2E3B62), // Color of the radio button when selected
              ),
            ),
            const SizedBox(height: 20),
            // Optionally, show selected profile
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedProfile = null; // Reset selection to null
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Set border radius to 0
                ),
                backgroundColor: Color(0xFF2E3B62),
                padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                textStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
              ),
              child: const Text(
                'CONTINUE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
