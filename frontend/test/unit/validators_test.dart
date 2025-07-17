import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/utils/validators.dart';

void main() {
  group('Validators', () {
    test('validateEmail - empty', () {
      expect(Validators.validateEmail(null), 'Email is required');
      expect(Validators.validateEmail(''), 'Email is required');
    });

    test('validateEmail - invalid formats', () {
      expect(Validators.validateEmail('test'), 'Please enter a valid email');
      expect(Validators.validateEmail('test@'), 'Please enter a valid email');
      expect(Validators.validateEmail('test@test'), 'Please enter a valid email');
    });

    test('validateEmail - valid formats', () {
      expect(Validators.validateEmail('test@test.com'), null);
      expect(Validators.validateEmail('user.name+tag@domain.co'), null);
    });

    test('validatePassword - empty', () {
      expect(Validators.validatePassword(null), 'Password is required');
      expect(Validators.validatePassword(''), 'Password is required');
    });

    test('validatePassword - too short', () {
      expect(Validators.validatePassword('12345'), 'Password must be at least 6 characters');
    });

    test('validatePassword - valid', () {
      expect(Validators.validatePassword('123456'), null);
      expect(Validators.validatePassword('securepassword'), null);
    });

    test('validateName - empty', () {
      expect(Validators.validateName(null), 'Name is required');
      expect(Validators.validateName(''), 'Name is required');
    });

    test('validateName - too short', () {
      expect(Validators.validateName('a'), 'Name must be at least 2 characters');
    });

    test('validateName - valid', () {
      expect(Validators.validateName('John'), null);
      expect(Validators.validateName('Anna'), null);
    });
  });
}