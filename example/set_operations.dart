/// Example demonstrating basic set operations.
///
/// This example focuses on fundamental set operations:
/// - Union
/// - Intersection
/// - Complement
/// - Difference
/// - Symmetric Difference
///
/// Run with: `dart run example/basic_operations.dart`
library;

import 'package:set_theory/set_theory.dart';

void main() {
  print('=== Basic Set Operations ===\n');

  // Define sets
  final a = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  final b = CustomSet<int>([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
  final universal = CustomSet<int>(List.generate(20, (i) => i + 1));

  print('Set A = $a');
  print('Set B = $b');
  print('Universal Set U = $universal\n');

  // Intersection
  print('1. INTERSECTION (A ∩ B)');
  print('   Elements in both A and B');
  final intersection = SetOperations.intersection(a, b);
  print('   Result: $intersection');
  print('   Cardinality: ${intersection.cardinality}\n');

  // Union
  print('2. UNION (A ∪ B)');
  print('   Elements in A or B or both');
  final union = SetOperations.union(a, b);
  print('   Result: $union');
  print('   Cardinality: ${union.cardinality}\n');

  // Complement
  print('3. COMPLEMENT');
  print("   Elements in U but not in the set");
  final complementA = SetOperations.complement(a, universal);
  final complementB = SetOperations.complement(b, universal);
  print("   A' = $complementA");
  print("   B' = $complementB\n");

  // Difference
  print('4. DIFFERENCE');
  print('   Elements in first set but not in second');
  final diffAB = SetOperations.difference(a, b);
  final diffBA = SetOperations.difference(b, a);
  print('   A - B = $diffAB');
  print('   B - A = $diffBA\n');

  // Symmetric Difference
  print('5. SYMMETRIC DIFFERENCE (A ⊕ B)');
  print('   Elements in A or B but not in both');
  final symmetricDiff = SetOperations.symmetricDifference(a, b);
  print('   Result: $symmetricDiff');
  print('   Cardinality: ${symmetricDiff.cardinality}\n');

  // Verify relationship: |A ∪ B| = |A| + |B| - |A ∩ B|
  print('6. VERIFICATION');
  print('   |A ∪ B| = ${union.cardinality}');
  print(
    '   |A| + |B| - |A ∩ B| = ${a.cardinality} + ${b.cardinality} - ${intersection.cardinality}',
  );
  print(
    '   Match: ${union.cardinality == a.cardinality + b.cardinality - intersection.cardinality}',
  );
}
