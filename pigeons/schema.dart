import 'package:pigeon/pigeon.dart';

// Define a data class
class PigeonUserDetails {
  String userId; // Make this non-nullable
  String phoneNumber; // Make this non-nullable

  // Constructor to initialize values
  PigeonUserDetails({required this.userId, required this.phoneNumber});
}

// Define an interface for communication
@HostApi()
abstract class UserApi {
  PigeonUserDetails getUserDetails(); // Return a non-nullable value
}
