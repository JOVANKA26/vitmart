import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final key = encrypt.Key.fromUtf8('1234567890123456'); // 16 chars
  static final iv = encrypt.IV.fromUtf8('abcdefghijklmnop'); // 16 chars

  static final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc),
  );

  static String encryptText(String text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  static String decryptText(String encryptedText) {
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}