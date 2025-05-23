import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'firebase_options_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Firestore Connection Tests', () {
    setUpAll(() async {
      await Firebase.initializeApp(
        options: TestFirebaseOptions.currentPlatform,
      );
    });

    test('should connect to Firestore and read/write data', () async {
      // Get Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Test collection reference
      final testCollection = firestore.collection('test_collection');

      // Test document data
      final testData = {
        'name': 'Test Product',
        'price': 99.99,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Write test
      final docRef = await testCollection.add(testData);
      expect(docRef.id, isNotEmpty);

      // Read test
      final docSnapshot = await docRef.get();
      expect(docSnapshot.exists, isTrue);
      expect(docSnapshot.data()?['name'], equals('Test Product'));
      expect(docSnapshot.data()?['price'], equals(99.99));

      // Cleanup
      await docRef.delete();
    });

    test('should handle errors gracefully', () async {
      final firestore = FirebaseFirestore.instance;

      // Test invalid collection
      expect(
        () async => await firestore.collection('').get(),
        throwsA(isA<FirebaseException>()),
      );
    });
  });
}
