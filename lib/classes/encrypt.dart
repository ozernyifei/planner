
import 'dart:convert';
import 'dart:math';
// import 'dart:typed_data';
// import 'package:pointycastle/export.dart';

// class Encrypt {
  
//   Uint8List generatePBKDF2(String password, Uint8List salt) {
//   const iterations = 10000;
//   const keyLength = 32;
//   final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), iterations));
//   // ignore: cascade_invocations
//   pbkdf2.init(Pbkdf2Parameters(salt, iterations, keyLength));
//   final derivedKey = pbkdf2.process(utf8.encode(password));
//   return derivedKey;
//   }

//   String generateSalt() {
//     return base64Encode(SecureRandom().nextBytes(16));
//   }

// }


class SecureToken {

  Future<List<int>> generateRandomBytes(int length) async {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (_) => random.nextInt(256));

    for (var i = 0; i < length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }
  

  static Future<String> generateToken() async {
    final secureToken = SecureToken();
    
    final randomBytes = await secureToken.generateRandomBytes(32);
    final token = base64Encode(randomBytes);

    return token;
  }

  // static Future<String?> getStoredToken() async {
  //   final key = 'auth_token'; // Replace with your desired key name

  //   return await store.getString(key);
  // }
}
