/// Comprehensive example demonstrating Set Theory operations in Dart.
///
/// This example covers:
/// - Creating sets and multisets
/// - Basic set operations
/// - Advanced set operations
/// - Set laws verification
/// - Real-world applications
///
/// Run this example with: `dart run example/main.dart`
library;

import 'package:set_theory/set_theory.dart';

void main() {
  print('=== Set Theory Demo in Dart ===\n');

  demonstrateSetCreation();
  demonstrateBasicOperations();
  demonstrateSubsetOperations();
  demonstrateAdvancedOperations();
  demonstrateSetLaws();
  demonstrateMultiset();
  demonstrateInclusionExclusion();
  demonstrateRealWorldExamples();

  print('=== Demo Complete ===');
}

/// Demonstrates various ways to create sets.
void demonstrateSetCreation() {
  print('1. CREATING SETS');
  print('-' * 50);

  // Empty set
  final empty = CustomSet<int>.empty();
  print('Empty set: $empty');
  print('Is empty: ${empty.isEmpty}');
  print('Cardinality: ${empty.cardinality}\n');

  // Set with elements
  final numbers = CustomSet<int>([1, 2, 3, 4, 5]);
  print('Numbers: $numbers');
  print('Cardinality: ${numbers.cardinality}\n');

  // Set from predicate
  final universe = CustomSet<int>(List.generate(100, (i) => i + 1));
  final evenNumbers = CustomSet.fromPredicate(
    universe.elements,
    (x) => x % 2 == 0,
  );
  print('Even numbers (1-100): ${evenNumbers.cardinality} elements');
  print('First 10: ${evenNumbers.elements.take(10).toList()}\n');

  // Universal set
  final universal = CustomSet().universal([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print('Universal set: $universal\n');
}

/// Demonstrates basic set operations.
void demonstrateBasicOperations() {
  print('2. BASIC OPERATIONS');
  print('-' * 50);

  final a = CustomSet<int>([1, 2, 3, 4, 5]);
  final b = CustomSet<int>([4, 5, 6, 7, 8]);
  final universal = CustomSet<int>(List.generate(10, (i) => i + 1));

  print('A = $a');
  print('B = $b');
  print('Universal = $universal\n');

  // Intersection
  final intersection = SetOperations.intersection(a, b);
  print('A ∩ B = $intersection');

  // Union
  final union = SetOperations.union(a, b);
  print('A ∪ B = $union');

  // Complement
  final complementA = SetOperations.complement(a, universal);
  final complementB = SetOperations.complement(b, universal);
  print("A' = $complementA");
  print("B' = $complementB");

  // Difference
  final diffAB = SetOperations.difference(a, b);
  final diffBA = SetOperations.difference(b, a);
  print('A - B = $diffAB');
  print('B - A = $diffBA');

  // Symmetric Difference
  final symmetricDiff = SetOperations.symmetricDifference(a, b);
  print('A ⊕ B = $symmetricDiff\n');
}

/// Demonstrates subset and related operations.
void demonstrateSubsetOperations() {
  print('3. SUBSET OPERATIONS');
  print('-' * 50);

  final a = CustomSet<int>([1, 2, 3]);
  final b = CustomSet<int>([1, 2, 3, 4, 5]);
  final c = CustomSet<int>([1, 2, 3]);

  print('A = $a');
  print('B = $b');
  print('C = $c\n');

  // Subset
  print('A ⊆ B: ${a.isSubsetOf(b)}');
  print('A ⊆ C: ${a.isSubsetOf(c)}');
  print('B ⊆ A: ${b.isSubsetOf(a)}\n');

  // Proper Subset
  print('A ⊂ B: ${a.isProperSubsetOf(b)}');
  print('A ⊂ C: ${a.isProperSubsetOf(c)}\n');

  // Superset
  print('B ⊇ A: ${b.isSupersetOf(a)}');
  print('C ⊇ A: ${c.isSupersetOf(a)}\n');

  // Equality
  print('A = C: ${a.equals(c)}');
  print('A = B: ${a.equals(b)}\n');

  // Equivalence
  print('|A| = |B|: ${a.isEquivalentTo(b)}');
  print('|A| = |C|: ${a.isEquivalentTo(c)}\n');

  // Disjoint
  final d = CustomSet<int>([6, 7, 8]);
  print('A // D: ${a.isDisjointFrom(d)}');
  print('A // B: ${a.isDisjointFrom(b)}\n');
}

/// Demonstrates advanced set operations.
void demonstrateAdvancedOperations() {
  print('4. ADVANCED OPERATIONS');
  print('-' * 50);

  // Cartesian Product
  print('Cartesian Product:');
  final x = CustomSet<int>([1, 2]);
  final y = CustomSet<String>(['a', 'b']);
  final cartesian = AdvancedSetOperations.cartesianProduct(x, y);
  print('X = $x');
  print('Y = $y');
  print('X × Y = $cartesian');
  print('|X × Y| = ${cartesian.cardinality}\n');

  // Power Set
  print('Power Set:');
  final small = CustomSet<int>([1, 2]);
  final powerSet = small.powerSet;
  print('A = $small');
  print('P(A) = $powerSet');
  print('|P(A)| = ${powerSet.cardinality}');
  print('Formula: 2^${small.cardinality} = ${powerSet.cardinality}\n');

  // Partition
  print('Partition:');
  final original = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8]);
  final partitions = CustomSet<CustomSet<int>>([
    CustomSet([1]),
    CustomSet([2, 3, 4]),
    CustomSet([5, 6]),
    CustomSet([7, 8]),
  ]);
  print('Original: $original');
  print('Partitions: $partitions');
  print(
    'Is valid partition: ${AdvancedSetOperations.isPartition(partitions, original)}\n',
  );
}

/// Demonstrates set laws verification.
void demonstrateSetLaws() {
  print('5. SET LAWS VERIFICATION');
  print('-' * 50);

  final a = CustomSet<int>([1, 2, 3]);
  final b = CustomSet<int>([3, 4, 5]);
  final c = CustomSet<int>([5, 6, 7]);
  final universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9]);

  // Identity Laws
  print('Identity Laws:');
  print('  A ∪ ∅ = A: ${SetLaws.identityUnion(a)}');
  print('  A ∩ U = A: ${SetLaws.identityIntersection(a, universal)}\n');

  // Commutative Laws
  print('Commutative Laws:');
  print('  A ∪ B = B ∪ A: ${SetLaws.commutativeUnion(a, b)}');
  print('  A ∩ B = B ∩ A: ${SetLaws.commutativeIntersection(a, b)}\n');

  // Associative Laws
  print('Associative Laws:');
  print('  A ∪ (B ∪ C) = (A ∪ B) ∪ C: ${SetLaws.associativeUnion(a, b, c)}');
  print(
    '  A ∩ (B ∩ C) = (A ∩ B) ∩ C: ${SetLaws.associativeIntersection(a, b, c)}\n',
  );

  // Distributive Laws
  print('Distributive Laws:');
  print(
    '  A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C): ${SetLaws.distributiveUnion(a, b, c)}',
  );
  print(
    '  A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C): ${SetLaws.distributiveIntersection(a, b, c)}\n',
  );

  // De Morgan's Laws
  print("De Morgan's Laws:");
  print(
    "  (A ∩ B)' = A' ∪ B': ${SetLaws.deMorganIntersection(a, b, universal)}",
  );
  print('  (A ∪ B)\' = A\' ∩ B\': ${SetLaws.deMorganUnion(a, b, universal)}\n');

  // Complement Laws
  print('Complement Laws:');
  print('  A ∪ A\' = U: ${SetLaws.complementUnion(a, universal)}');
  print('  A ∩ A\' = ∅: ${SetLaws.complementIntersection(a, universal)}\n');
}

/// Demonstrates multiset operations.
void demonstrateMultiset() {
  print('6. MULTISET OPERATIONS');
  print('-' * 50);

  final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'c', 'd', 'd']);
  final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);

  print('P = $p');
  print('Q = $q\n');

  // Union
  final union = p.union(q);
  print('P ∪ Q = $union');
  print('  (max multiplicity for each element)\n');

  // Intersection
  final intersection = p.intersection(q);
  print('P ∩ Q = $intersection');
  print('  (min multiplicity for each element)\n');

  // Difference
  final difference = p.difference(q);
  print('P - Q = $difference');
  print('  (P multiplicity - Q multiplicity, min 0)\n');

  // Sum
  final sum = p.sum(q);
  print('P + Q = $sum');
  print('  (sum of multiplicities)\n');

  // Convert to Set
  final set = p.toSet();
  print('P as Set = $set');
  print('  (duplicates removed)\n');
}

/// Demonstrates inclusion-exclusion principle.
void demonstrateInclusionExclusion() {
  print('7. INCLUSION-EXCLUSION PRINCIPLE');
  print('-' * 50);

  // Two sets example
  print('Two Sets (divisible by 3 or 5):');
  final universal = CustomSet<int>(List.generate(100, (i) => i + 1));
  final div3 = CustomSet.fromPredicate(universal.elements, (x) => x % 3 == 0);
  final div5 = CustomSet.fromPredicate(universal.elements, (x) => x % 5 == 0);

  print('  |A| (div by 3) = ${div3.cardinality}');
  print('  |B| (div by 5) = ${div5.cardinality}');
  print(
    '  |A ∩ B| (div by 15) = ${SetOperations.intersection(div3, div5).cardinality}',
  );

  final count2 = AdvancedSetOperations.inclusionExclusion2(div3, div5);
  print(
    '  |A ∪ B| = ${div3.cardinality} + ${div5.cardinality} - ${SetOperations.intersection(div3, div5).cardinality} = $count2\n',
  );

  // Three sets example
  print('Three Sets (divisible by 3, 5, or 7):');
  final div7 = CustomSet.fromPredicate(universal.elements, (x) => x % 7 == 0);

  print('  |A| (div by 3) = ${div3.cardinality}');
  print('  |B| (div by 5) = ${div5.cardinality}');
  print('  |C| (div by 7) = ${div7.cardinality}');

  final count3 = AdvancedSetOperations.inclusionExclusion3(div3, div5, div7);
  print('  |A ∪ B ∪ C| = $count3\n');
}

/// Demonstrates real-world application examples.
void demonstrateRealWorldExamples() {
  print('8. REAL-WORLD EXAMPLES');
  print('-' * 50);

  // Example 1: Student Survey
  print('Example 1: Student Survey');
  print('  650 students have a dictionary');
  print('  150 students do not have a dictionary');
  print('  175 students have an encyclopedia');
  print('  50 students have neither\n');

  final totalStudents = 650 + 150;
  final hasDictionary = 650;
  final hasEncyclopedia = 175;
  final hasNeither = 50;
  final hasEitherOrBoth = totalStudents - hasNeither;
  final hasBoth = hasDictionary + hasEncyclopedia - hasEitherOrBoth;

  print('  Total students: $totalStudents');
  print('  Students with either or both: $hasEitherOrBoth');
  print('  Students with both: $hasBoth\n');

  // Example 2: Hardware Procurement
  print('Example 2: Hardware Procurement');
  print('  Department TI: 100 PC, 40 router, 5 server');
  print('  Department MS: 10 PC, 7 router, 2 mainframe\n');

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

  // Shareable
  final shareable = ti.union(ms);
  print('  a) Shareable (Union):');
  print('     PCs: ${shareable.multiplicity('PC')}');
  print('     Routers: ${shareable.multiplicity('router')}');
  print('     Servers: ${shareable.multiplicity('server')}');
  print('     Mainframes: ${shareable.multiplicity('mainframe')}\n');

  // Non-shareable
  final nonShareable = ti.sum(ms);
  print('  b) Non-shareable (Sum):');
  print('     PCs: ${nonShareable.multiplicity('PC')}');
  print('     Routers: ${nonShareable.multiplicity('router')}\n');

  // MS-only
  final msOnly = ms.difference(ti);
  print('  c) MS-only requirements (Difference):');
  print('     Mainframes: ${msOnly.multiplicity('mainframe')}\n');
}
