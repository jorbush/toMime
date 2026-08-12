import 'package:flutter_test/flutter_test.dart';
import 'package:to_mime/providers/collections.dart';

void main() {
  group('Collections Provider Tests', () {
    test('Initial collections list is empty', () {
      final collectionsProvider = Collections();
      expect(collectionsProvider.collections, isEmpty);
      expect(collectionsProvider.selectedCollections, isEmpty);
    });

    test('fetchAndSetCollections does not throw', () async {
      final collectionsProvider = Collections();
      await collectionsProvider.fetchAndSetCollections();
      expect(collectionsProvider.collections, isEmpty);
    });
  });
}
