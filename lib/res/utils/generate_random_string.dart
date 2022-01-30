import 'dart:math';

class GetTraceId{
  String generateRandomString() {
    const _chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    String genKey = getRandomString(6);
    return genKey.toUpperCase();

  }
}