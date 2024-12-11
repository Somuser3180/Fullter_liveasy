import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'selectProfile.dart';

class Verifyphone extends StatefulWidget {
  final String verificationId;
  final String mobileNumber;

  Verifyphone({required this.verificationId, required this.mobileNumber});

  @override
  _VerifyphoneState createState() => _VerifyphoneState();
}

class _VerifyphoneState extends State<Verifyphone> {
  TextEditingController _controller = TextEditingController();
  String otp = '';
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    // Log the verificationId to verify if it's passed correctly
    print("Verification ID received: ${widget.verificationId}, ${widget.mobileNumber}");
  }

  Future<void> verifyOTP() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  setState(() {
    isVerifying = true;
  });

  try {
    // Create the PhoneAuthCredential
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );
    print('Credential created: $credential, $otp');
    print(widget.verificationId.runtimeType); // Should print "String"
print(otp.runtimeType);  //

    // Use the credential to sign in the user
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    print("User signed in: ${userCredential.user}");

    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SelectProfile()),
    );
  } on FirebaseAuthException catch (e) {
    setState(() {
      isVerifying = false;
    });
    print("FirebaseAuthException: ${e.message}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? "Verification failed. Please try again."),
    ));
  } catch (e) {
    setState(() {
      isVerifying = false;
    });
    print("Unexpected error type: ${e.runtimeType}");
    print("Unexpected error details: $e");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Unexpected error occurred. Please try again."),
    ));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verify Phone',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 290,
              child: Text(
                "Code is sent to ${widget.mobileNumber}",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
           Container(
  margin: const EdgeInsets.symmetric(horizontal: 20), // Add horizontal margin
  child: TextField(
    controller: _controller,
    maxLength: 6,
    keyboardType: TextInputType.number,
    style: const TextStyle(fontSize: 24, letterSpacing: 16),
    decoration: InputDecoration(
      counterText: '',
      filled: true, // Enable background color
      fillColor: Color(0xFF93D2F3), // Set background color
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2E3B62), width: 1),
      ),
    ),
    onChanged: (value) {
      setState(() {
        otp = value;
      });
    },
  ),
),


            const SizedBox(height: 20),
            Container(
              width: 350,
              child: const Text(
                "Didn't receive the code? Request Again",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isVerifying
                  ? null
                  : () {
                      if (otp.length == 6) {
                        verifyOTP();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter a valid 6-digit OTP."),
                        ));
                      }
                    },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: Color(0xFF2E3B62),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              child: isVerifying
                  ? CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'VERIFY AND CONTINUE',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
