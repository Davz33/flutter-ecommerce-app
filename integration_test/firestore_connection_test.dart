import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapp/firebase_options.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Firestore Connection Integration Tests', () {
    setUpAll(() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    });

    testWidgets('should connect to Firestore and read/write data',
        (tester) async {
      final firestore = FirebaseFirestore.instance;
      final testCollection = firestore.collection('test_collection');
      final testData = {
        'name': 'Test Product',
        'price': 99.99,
        'createdAt': FieldValue.serverTimestamp(),
      };
      final docRef = await testCollection.add(testData);
      expect(docRef.id, isNotEmpty);
      final docSnapshot = await docRef.get();
      expect(docSnapshot.exists, isTrue);
      expect(docSnapshot.data()?['name'], equals('Test Product'));
      expect(docSnapshot.data()?['price'], equals(99.99));
      await docRef.delete();
    });

    testWidgets('should handle errors gracefully', (tester) async {
      final firestore = FirebaseFirestore.instance;
      expect(
        () async => await firestore.collection('').get(),
        throwsA(isA<FirebaseException>()),
      );
    });
  });
}
