import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/features/home/presentation/providers/customer_image_provider.dart';

/// Testable subclass that overrides build() to skip the file-system _load()
/// and exposes a method to seed state without I/O.
class _FakeImageNotifier extends CustomerImageNotifier {
  _FakeImageNotifier(super.customerId);

  @override
  List<String> build() => [];

  void seed(List<String> paths) => state = List.of(paths);
}

final _fakeProvider =
    NotifierProvider.family<_FakeImageNotifier, List<String>, String>(
  (id) => _FakeImageNotifier(id),
);

void main() {
  group('CustomerImageNotifier state logic', () {
    test('initial state is empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(_fakeProvider('c1'));
      expect(state, isEmpty);
    });

    test('deleteImage removes the matching path from state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(_fakeProvider('c1').notifier);
      notifier.seed(['/img/a.jpg', '/img/b.jpg', '/img/c.jpg']);

      // deleteImage calls CatalogImageService.delete, which returns false for
      // non-existent paths but still updates state correctly.
      await notifier.deleteImage('/img/b.jpg');

      final state = container.read(_fakeProvider('c1'));
      expect(state, equals(['/img/a.jpg', '/img/c.jpg']));
      expect(state, hasLength(2));
    });

    test('deleteImage on absent path leaves state unchanged', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(_fakeProvider('c1').notifier);
      notifier.seed(['/img/a.jpg']);

      await notifier.deleteImage('/img/gone.jpg');

      final state = container.read(_fakeProvider('c1'));
      expect(state, equals(['/img/a.jpg']));
    });

    test('seeding multiple paths reflects in state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(_fakeProvider('c2').notifier);
      notifier.seed(['/img/x.jpg', '/img/y.jpg']);

      expect(container.read(_fakeProvider('c2')), hasLength(2));
    });
  });
}
