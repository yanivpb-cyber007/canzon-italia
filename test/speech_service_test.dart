import 'package:flutter_test/flutter_test.dart';
import 'package:canzon_italia/services/speech_service.dart';

void main() {
  final svc = SpeechService();

  group('SpeechService.isMatch', () {
    test('exact match returns true', () {
      expect(svc.isMatch('Sarà perché ti amo', 'Sarà perché ti amo'), isTrue);
    });

    test('case insensitive', () {
      expect(svc.isMatch('SARÀ PERCHÉ TI AMO', 'Sarà perché ti amo'), isTrue);
    });

    test('trailing punctuation stripped', () {
      expect(svc.isMatch('Sarà perché ti amo!', 'Sarà perché ti amo'), isTrue);
    });

    test('extra whitespace normalised', () {
      expect(svc.isMatch('Sarà  perché  ti  amo', 'Sarà perché ti amo'), isTrue);
    });

    test('wrong words returns false', () {
      expect(svc.isMatch('ciao bella', 'Sarà perché ti amo'), isFalse);
    });

    test('empty string does not match', () {
      expect(svc.isMatch('', 'Sarà perché ti amo'), isFalse);
    });

    test('partial match returns false', () {
      expect(svc.isMatch('Sarà perché', 'Sarà perché ti amo'), isFalse);
    });
  });
}
