import 'package:test/test.dart';
import 'package:set_theory/set_theory.dart';

void main() {
  group('CustomSet - Basic Operations', () {
    test('Create empty set', () {
      final set = CustomSet<int>.empty();
      expect(set.isEmpty, isTrue);
      expect(set.cardinality, equals(0));
    });

    test('Create set with elements', () {
      final set = CustomSet<int>([1, 2, 3, 4]);
      expect(set.cardinality, equals(4));
      expect(set.contains(1), isTrue);
      expect(set.contains(5), isFalse);
    });

    test('Duplicate elements are removed', () {
      final set = CustomSet<int>([1, 2, 2, 3, 3, 3]);
      expect(set.cardinality, equals(3));
      expect(set.elements, equals({1, 2, 3}));
    });

    test('Order does not matter', () {
      final set1 = CustomSet<int>([1, 2, 3]);
      final set2 = CustomSet<int>([3, 2, 1]);
      expect(set1.equals(set2), isTrue);
    });
  });

  group('CustomSet - Subset Operations', () {
    test('isSubsetOf', () {
      final a = CustomSet<int>([1, 2, 3]);
      final b = CustomSet<int>([1, 2, 3, 4, 5]);
      expect(a.isSubsetOf(b), isTrue);
      expect(b.isSubsetOf(a), isFalse);
    });

    test('isProperSubsetOf', () {
      final a = CustomSet<int>([1, 2, 3]);
      final b = CustomSet<int>([1, 2, 3]);
      final c = CustomSet<int>([1, 2, 3, 4]);

      expect(a.isProperSubsetOf(b), isFalse); // A = B
      expect(a.isProperSubsetOf(c), isTrue);
    });

    test('Empty set is subset of any set', () {
      final empty = CustomSet<int>.empty();
      final any = CustomSet<int>([1, 2, 3]);
      expect(empty.isSubsetOf(any), isTrue);
      expect(empty.isSubsetOf(empty), isTrue);
    });
  });

  group('Set Operations - Basic', () {
    test('Intersection', () {
      final a = CustomSet<int>([2, 4, 6, 8, 10]);
      final b = CustomSet<int>([4, 10, 14, 18]);
      final result = SetOperations.intersection(a, b);
      expect(result.cardinality, equals(2));
      expect(result.contains(4), isTrue);
      expect(result.contains(10), isTrue);
    });

    test('Union', () {
      final a = CustomSet<int>([2, 5, 8]);
      final b = CustomSet<int>([7, 5, 22]);
      final result = SetOperations.union(a, b);
      expect(result.cardinality, equals(5));
      expect(result.contains(2), isTrue);
      expect(result.contains(5), isTrue);
      expect(result.contains(7), isTrue);
      expect(result.contains(8), isTrue);
      expect(result.contains(22), isTrue);
    });

    test('Complement', () {
      final universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9]);
      final a = CustomSet<int>([1, 3, 7, 9]);
      final result = SetOperations.complement(a, universal);
      expect(result.cardinality, equals(5));
      expect(result.contains(2), isTrue);
      expect(result.contains(4), isTrue);
      expect(result.contains(6), isTrue);
      expect(result.contains(8), isTrue);
    });

    test('Difference', () {
      final a = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      final b = CustomSet<int>([2, 4, 6, 8, 10]);
      final result = SetOperations.difference(a, b);
      expect(result.cardinality, equals(5));
      expect(result.contains(1), isTrue);
      expect(result.contains(3), isTrue);
      expect(result.contains(5), isTrue);
      expect(result.contains(7), isTrue);
      expect(result.contains(9), isTrue);
    });

    test('Symmetric Difference', () {
      final a = CustomSet<int>([2, 4, 6]);
      final b = CustomSet<int>([2, 3, 5]);
      final result = SetOperations.symmetricDifference(a, b);
      expect(result.cardinality, equals(4));
      expect(result.contains(3), isTrue);
      expect(result.contains(4), isTrue);
      expect(result.contains(5), isTrue);
      expect(result.contains(6), isTrue);
      expect(result.contains(2), isFalse);
    });

    test('Symmetric Difference (Alternative)', () {
      final a = CustomSet<int>([2, 4, 6]);
      final b = CustomSet<int>([2, 3, 5]);
      final result1 = SetOperations.symmetricDifference(a, b);
      final result2 = SetOperations.symmetricDifferenceAlt(a, b);
      expect(result1.equals(result2), isTrue);
    });
  });

  group('Set Operations - Advanced', () {
    test('Cartesian Product', () {
      final c = CustomSet<int>([1, 2, 3]);
      final d = CustomSet<String>(['a', 'b']);
      final result = AdvancedSetOperations.cartesianProduct(c, d);
      expect(result.cardinality, equals(6));
      expect(result.contains((1, 'a')), isTrue);
      expect(result.contains((1, 'b')), isTrue);
      expect(result.contains((2, 'a')), isTrue);
      expect(result.contains((2, 'b')), isTrue);
      expect(result.contains((3, 'a')), isTrue);
      expect(result.contains((3, 'b')), isTrue);
    });

    test('Cartesian Product with empty set', () {
      final a = CustomSet<int>([1, 2, 3]);
      final empty = CustomSet<String>.empty();
      final result = AdvancedSetOperations.cartesianProduct(a, empty);
      expect(result.isEmpty, isTrue);
    });

    test('Power Set', () {
      final a = CustomSet<int>([1, 2]);
      final powerSet = a.powerSet;
      expect(powerSet.cardinality, equals(4)); // 2^2 = 4
    });

    test('Power Set empty set', () {
      final empty = CustomSet<int>.empty();
      final powerSet = empty.powerSet;
      expect(powerSet.cardinality, equals(1)); // 2^0 = 1, contains {∅}
    });

    test('Partition', () {
      final original = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8]);
      final partitions = CustomSet<CustomSet<int>>([
        CustomSet([1]),
        CustomSet([2, 3, 4]),
        CustomSet([5, 6]),
        CustomSet([7, 8]),
      ]);
      expect(AdvancedSetOperations.isPartition(partitions, original), isTrue);
    });

    test('Not a Partition - overlapping', () {
      final original = CustomSet<int>([1, 2, 3, 4]);
      final partitions = CustomSet<CustomSet<int>>([
        CustomSet([1, 2]),
        CustomSet([2, 3]), // Overlap with 2
        CustomSet([4]),
      ]);
      expect(AdvancedSetOperations.isPartition(partitions, original), isFalse);
    });
  });

  group('Set Laws', () {
    late CustomSet<int> a;
    late CustomSet<int> b;
    late CustomSet<int> c;
    late CustomSet<int> universal;

    setUp(() {
      a = CustomSet<int>([1, 2, 3]);
      b = CustomSet<int>([3, 4, 5]);
      c = CustomSet<int>([5, 6, 7]);
      universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });

    test('Identity Law - Union', () {
      expect(SetLaws.identityUnion(a), isTrue);
    });

    test('Identity Law - Intersection', () {
      expect(SetLaws.identityIntersection(a, universal), isTrue);
    });

    test('Null Law - Intersection', () {
      expect(SetLaws.nullIntersection(a), isTrue);
    });

    test('Null Law - Union', () {
      expect(SetLaws.nullUnion(a, universal), isTrue);
    });

    test('Complement Law - Union', () {
      expect(SetLaws.complementUnion(a, universal), isTrue);
    });

    test('Complement Law - Intersection', () {
      expect(SetLaws.complementIntersection(a, universal), isTrue);
    });

    test('Idempotent Law - Union', () {
      expect(SetLaws.idempotentUnion(a), isTrue);
    });

    test('Idempotent Law - Intersection', () {
      expect(SetLaws.idempotentIntersection(a), isTrue);
    });

    test('Involution Law', () {
      expect(SetLaws.involution(a, universal), isTrue);
    });

    test('Absorption Law - Union', () {
      expect(SetLaws.absorptionUnion(a, b), isTrue);
    });

    test('Absorption Law - Intersection', () {
      expect(SetLaws.absorptionIntersection(a, b), isTrue);
    });

    test('Commutative Law - Union', () {
      expect(SetLaws.commutativeUnion(a, b), isTrue);
    });

    test('Commutative Law - Intersection', () {
      expect(SetLaws.commutativeIntersection(a, b), isTrue);
    });

    test('Associative Law - Union', () {
      expect(SetLaws.associativeUnion(a, b, c), isTrue);
    });

    test('Associative Law - Intersection', () {
      expect(SetLaws.associativeIntersection(a, b, c), isTrue);
    });

    test('Distributive Law - Union', () {
      expect(SetLaws.distributiveUnion(a, b, c), isTrue);
    });

    test('Distributive Law - Intersection', () {
      expect(SetLaws.distributiveIntersection(a, b, c), isTrue);
    });

    test("De Morgan's Law - Intersection", () {
      expect(SetLaws.deMorganIntersection(a, b, universal), isTrue);
    });

    test("De Morgan's Law - Union", () {
      expect(SetLaws.deMorganUnion(a, b, universal), isTrue);
    });

    test('Law 0/1 - Zero', () {
      expect(SetLaws.lawZero(universal), isTrue);
    });

    test('Law 0/1 - One', () {
      expect(SetLaws.lawOne(universal), isTrue);
    });
  });

  group('Inclusion-Exclusion Principle', () {
    test('Two sets', () {
      final universal = CustomSet<int>(List.generate(100, (i) => i + 1));
      final a = CustomSet.fromPredicate(universal.elements, (x) => x % 3 == 0);
      final b = CustomSet.fromPredicate(universal.elements, (x) => x % 5 == 0);

      final calculated = AdvancedSetOperations.inclusionExclusion2(a, b);
      final actual = SetOperations.union(a, b).cardinality;

      expect(calculated, equals(actual));
      expect(calculated, equals(47));
    });

    test('Three sets', () {
      final universal = CustomSet<int>(List.generate(200, (i) => i + 1));
      final a = CustomSet.fromPredicate(universal.elements, (x) => x % 3 == 0);
      final b = CustomSet.fromPredicate(universal.elements, (x) => x % 5 == 0);
      final c = CustomSet.fromPredicate(universal.elements, (x) => x % 7 == 0);

      final calculated = AdvancedSetOperations.inclusionExclusion3(a, b, c);
      final actual = SetOperations.union(
        SetOperations.union(a, b),
        c,
      ).cardinality;

      expect(calculated, equals(actual));
    });
  });

  group('MultiSet Operations', () {
    test('Create MultiSet', () {
      final ms = MultiSet<int>.fromIterable([1, 1, 1, 2, 2, 3]);
      expect(ms.cardinality, equals(6));
      expect(ms.uniqueCount, equals(3));
      expect(ms.multiplicity(1), equals(3));
      expect(ms.multiplicity(2), equals(2));
      expect(ms.multiplicity(3), equals(1));
    });

    test('MultiSet Union (max multiplicity)', () {
      final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'c', 'd', 'd']);
      final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);
      final result = p.union(q);

      expect(result.multiplicity('a'), equals(3)); // max(3, 2)
      expect(result.multiplicity('b'), equals(1)); // max(0, 1)
      expect(result.multiplicity('c'), equals(2)); // max(1, 2)
      expect(result.multiplicity('d'), equals(2)); // max(2, 0)
    });

    test('MultiSet Intersection (min multiplicity)', () {
      final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'c', 'd', 'd']);
      final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);
      final result = p.intersection(q);

      expect(result.multiplicity('a'), equals(2)); // min(3, 2)
      expect(result.multiplicity('b'), equals(0)); // min(0, 1)
      expect(result.multiplicity('c'), equals(1)); // min(1, 2)
      expect(result.multiplicity('d'), equals(0)); // min(2, 0)
    });

    test('MultiSet Difference', () {
      final p = MultiSet<String>.fromIterable([
        'a',
        'a',
        'a',
        'b',
        'b',
        'c',
        'd',
        'd',
        'e',
      ]);
      final q = MultiSet<String>.fromIterable([
        'a',
        'a',
        'b',
        'b',
        'b',
        'c',
        'c',
        'd',
        'd',
        'f',
      ]);
      final result = p.difference(q);

      expect(result.multiplicity('a'), equals(1)); // 3 - 2
      expect(result.multiplicity('b'), equals(0)); // 2 - 3 = 0
      expect(result.multiplicity('c'), equals(0)); // 1 - 1
      expect(result.multiplicity('d'), equals(0)); // 2 - 2
      expect(result.multiplicity('e'), equals(1)); // 1 - 0
      expect(result.multiplicity('f'), equals(0)); // 0 - 1 = 0
    });

    test('MultiSet Sum', () {
      final p = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);
      final q = MultiSet<String>.fromIterable(['a', 'b', 'b', 'd']);
      final result = p.sum(q);

      expect(result.multiplicity('a'), equals(3)); // 2 + 1
      expect(result.multiplicity('b'), equals(3)); // 1 + 2
      expect(result.multiplicity('c'), equals(2)); // 2 + 0
      expect(result.multiplicity('d'), equals(1)); // 0 + 1
    });

    test('MultiSet to Set conversion', () {
      final ms = MultiSet<int>.fromIterable([1, 1, 1, 2, 2, 3]);
      final set = ms.toSet();
      expect(set.cardinality, equals(3));
      expect(set.contains(1), isTrue);
      expect(set.contains(2), isTrue);
      expect(set.contains(3), isTrue);
    });
  });

  group('Real-world Examples', () {
    test('Students with dictionaries and encyclopedias', () {
      final totalStudents = 650 + 150; // 800
      final hasDictionary = 650;
      final hasEncyclopedia = 175;
      final hasNeither = 50;
      final hasEitherOrBoth = totalStudents - hasNeither; // 750

      final hasBoth = hasDictionary + hasEncyclopedia - hasEitherOrBoth;

      expect(hasBoth, equals(75));
      expect(hasEitherOrBoth, equals(750));
      expect(totalStudents, equals(800));
    });

    test('Hardware procurement (Multiset)', () {
      final ti = MultiSet<String>.fromIterable([
        ...List.filled(100, 'PC'),
        ...List.filled(40, 'router'),
        ...List.filled(5, 'server'),
      ]);

      final ms = MultiSet<String>.fromIterable([
        ...List.filled(10, 'PC'),
        ...List.filled(7, 'router'),
        ...List.filled(2, 'mainframe'),
      ]);

      // Shareable (Union - max)
      final shareable = ti.union(ms);
      expect(shareable.multiplicity('PC'), equals(100));
      expect(shareable.multiplicity('router'), equals(40));
      expect(shareable.multiplicity('server'), equals(5));
      expect(shareable.multiplicity('mainframe'), equals(2));

      // Non-shareable (Sum)
      final nonShareable = ti.sum(ms);
      expect(nonShareable.multiplicity('PC'), equals(110));
      expect(nonShareable.multiplicity('router'), equals(47));

      // Only MS not needed by TI (Difference)
      final msOnly = ms.difference(ti);
      expect(msOnly.multiplicity('mainframe'), equals(2));
      expect(msOnly.multiplicity('PC'), equals(0));
      expect(msOnly.multiplicity('router'), equals(0));
    });
  });

  group('Edge Cases', () {
    test('Empty set operations', () {
      final empty = CustomSet<int>.empty();
      final nonEmpty = CustomSet<int>([1, 2, 3]);

      expect(SetOperations.union(empty, empty).isEmpty, isTrue);
      expect(SetOperations.intersection(empty, nonEmpty).isEmpty, isTrue);
      expect(
        SetOperations.difference(nonEmpty, empty).equals(nonEmpty),
        isTrue,
      );
      expect(SetOperations.difference(empty, nonEmpty).isEmpty, isTrue);
    });

    test('Set with itself', () {
      final a = CustomSet<int>([1, 2, 3]);

      expect(SetOperations.union(a, a).equals(a), isTrue);
      expect(SetOperations.intersection(a, a).equals(a), isTrue);
      expect(SetOperations.difference(a, a).isEmpty, isTrue);
      expect(SetOperations.symmetricDifference(a, a).isEmpty, isTrue);
    });

    test('Nested sets', () {
      final innerSet1 = CustomSet<String>(['a', 'b', 'c']);
      final innerSet2 = CustomSet<String>(['a', 'c']);
      final r = CustomSet(['a', 'b', innerSet1, innerSet2]);

      expect(r.cardinality, equals(4));
      expect(r.contains('a'), isTrue);
      expect(r.contains(innerSet1), isTrue);
      expect(r.contains('c'), isFalse);
    });
  });
}
