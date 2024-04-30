
import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';


class Encrypt {
  
  Uint8List generatePBKDF2(String password, Uint8List salt) {
  const iterations = 10000;
  const keyLength = 32;
  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), iterations));
  // ignore: cascade_invocations
  pbkdf2.init(Pbkdf2Parameters(salt, iterations, keyLength));
  final derivedKey = pbkdf2.process(utf8.encode(password));
  return derivedKey;
  }

  String generateSalt() {
    return base64Encode(SecureRandom().nextBytes(16));
  }

}
