import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication package
import 'verifyPhone.dart'; // Import the VerifyPhone screen
import 'package:firebase_core/firebase_core.dart'; // Firebase Core package

// Initialize Firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthPage());
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String mobileNumber = ''; // State to hold the mobile number input
  TextEditingController _controller = TextEditingController(); // Controller for TextField
  String verificationId = ''; // Store verification ID from Firebase

  // Function to send OTP
  Future<void> sendOTP() async {
    print('sending otp');
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$mobileNumber', // Phone number with country code
      verificationCompleted: (PhoneAuthCredential credential) async {
        // If the verification is auto-completed, sign in automatically
        await _auth.signInWithCredential(credential);
        print("Phone number automatically verified and user signed in!");
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        print("Verification failed: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Verification failed: ${e.message ?? 'Please try again.'}"),
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save verification ID and proceed to next screen
        this.verificationId = verificationId;
        print("OTP Sent to +91$mobileNumber , $verificationId");
        // Navigate to VerifyPhone page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Verifyphone(verificationId: verificationId, mobileNumber : mobileNumber)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // This will be called after 60 seconds if OTP is not entered
        this.verificationId = verificationId;
        print("Auto retrieval timeout");
      },
    );
  }

  // Function to validate mobile number
  bool isMobileNumberValid(String number) {
    // Check if the mobile number contains exactly 10 digits (excluding the country code)
    return RegExp(r'^[0-9]{10}$').hasMatch(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            const Text(
              'Please enter your Mobile Number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 290, // Set fixed width
              child: const Text(
                "You'll receive a 6 digit code to verify next",
                style: TextStyle(fontSize: 20),
                softWrap: true,
                textAlign: TextAlign.center, // Optionally, add this to handle overflow
              ),
            ),
            const SizedBox(height: 20),
            // Updated TextField with fixed "+91" prefix and icon first
            Container(
              width: 350,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2), // Border color and width
              ),
              child: Row(
                children: [
                  Text(
                    '🇮🇳',
                    style: TextStyle(fontSize: 24), // Adjust font size as needed
                  ),
                  const SizedBox(width: 10), // Space between icon and "+91"
                  const Text(
                    '+91 -',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10), // Space between "+91" and TextField
                  Expanded(
                    child: TextField(
                      controller: _controller, // Connect the controller to the TextField
                      onChanged: (value) {
                        setState(() {
                          mobileNumber = value; // Update the mobile number state
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Mobile Number', // Placeholder text
                        border: InputBorder.none, // Remove the default border
                      ),
                      keyboardType: TextInputType.number, // Numeric keyboard for mobile number
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate mobile number before sending OTP
                if (mobileNumber.isNotEmpty && isMobileNumberValid(mobileNumber)) {
                  sendOTP(); // Send OTP when button is pressed
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter a valid mobile number'),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Set border radius to 0
                ),
                backgroundColor: Color(0xFF2E3B62),
                padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Color(0xFFFFFFFF)),
              ),
              child: Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
