/// Example demonstrating advanced set operations.
///
/// This example covers:
/// - Cartesian Product
/// - Power Set
/// - Partition Validation
/// - Nested Sets
///
/// Run with: `dart run example/advanced_operations.dart`
library;

import 'package:set_theory/set_theory.dart';

void main() {
  print('=== Advanced Set Operations ===\n');

  demonstrateCartesianProduct();
  demonstratePowerSet();
  demonstratePartition();
  demonstrateNestedSets();
}

/// Demonstrates Cartesian product operation.
void demonstrateCartesianProduct() {
  print('1. CARTESIAN PRODUCT');
  print('-' * 50);

  // 2D Cartesian Product
  final colors = CustomSet<String>(['red', 'green', 'blue']);
  final shapes = CustomSet<String>(['circle', 'square']);

  print('Colors = $colors');
  print('Shapes = $shapes\n');

  final product2D = AdvancedSetOperations.cartesianProduct(colors, shapes);
  print('Colors × Shapes:');
  for (var pair in product2D.elements) {
    print('  ($pair)');
  }
  print('Total combinations: ${product2D.cardinality}');
  print(
    'Formula: ${colors.cardinality} × ${shapes.cardinality} = ${colors.cardinality * shapes.cardinality}\n',
  );

  // 3D Cartesian Product
  final sizes = CustomSet<String>(['small', 'large']);
  final product3D = AdvancedSetOperations.cartesianProductN([
    colors,
    shapes,
    sizes,
  ]);

  print('Colors × Shapes × Sizes:');
  print('Total combinations: ${product3D.cardinality}');
  print(
    'Formula: ${colors.cardinality} × ${shapes.cardinality} × ${sizes.cardinality} = ${colors.cardinality * shapes.cardinality * sizes.cardinality}\n',
  );
}

/// Demonstrates power set operation.
void demonstratePowerSet() {
  print('2. POWER SET');
  print('-' * 50);

  final base = CustomSet<int>([1, 2, 3]);
  print('Base Set A = $base');
  print('|A| = ${base.cardinality}\n');

  final powerSet = base.powerSet;
  print('Power Set P(A):');

  int index = 0;
  for (var subset in powerSet.elements) {
    print('  ${index++}. $subset');
  }

  print('\n|P(A)| = ${powerSet.cardinality}');
  print('Formula: 2^${base.cardinality} = ${powerSet.cardinality}\n');

  // Empty set power set
  final empty = CustomSet<int>.empty();
  final emptyPowerSet = empty.powerSet;
  print('Power Set of Empty Set:');
  print('  P(∅) = $emptyPowerSet');
  print('  |P(∅)| = ${emptyPowerSet.cardinality}');
  print('  Formula: 2^0 = ${emptyPowerSet.cardinality}\n');
}

/// Demonstrates partition validation.
void demonstratePartition() {
  print('3. PARTITION VALIDATION');
  print('-' * 50);

  final original = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8]);
  print('Original Set = $original\n');

  // Valid partition
  final validPartitions = CustomSet<CustomSet<int>>([
    CustomSet([1, 2]),
    CustomSet([3, 4, 5]),
    CustomSet([6, 7, 8]),
  ]);
  print('Valid Partition: $validPartitions');
  print(
    'Is valid: ${AdvancedSetOperations.isPartition(validPartitions, original)}\n',
  );

  // Invalid partition (overlapping)
  final invalidPartitions1 = CustomSet<CustomSet<int>>([
    CustomSet([1, 2, 3]),
    CustomSet([3, 4, 5]), // Overlaps with 3
    CustomSet([6, 7, 8]),
  ]);
  print('Invalid Partition (overlapping): $invalidPartitions1');
  print(
    'Is valid: ${AdvancedSetOperations.isPartition(invalidPartitions1, original)}\n',
  );

  // Invalid partition (missing elements)
  final invalidPartitions2 = CustomSet<CustomSet<int>>([
    CustomSet([1, 2, 3]),
    CustomSet([4, 5]),
    // Missing 6, 7, 8
  ]);
  print('Invalid Partition (missing elements): $invalidPartitions2');
  print(
    'Is valid: ${AdvancedSetOperations.isPartition(invalidPartitions2, original)}\n',
  );
}

/// Demonstrates nested sets.
void demonstrateNestedSets() {
  print('4. NESTED SETS');
  print('-' * 50);

  // Create inner sets
  final innerSet1 = CustomSet<String>(['a', 'b']);
  final innerSet2 = CustomSet<String>(['c', 'd']);

  // Create set containing other sets
  final nested = CustomSet(['x', 'y', innerSet1, innerSet2]);

  print('Inner Set 1 = $innerSet1');
  print('Inner Set 2 = $innerSet2');
  print('Nested Set = $nested\n');

  print('Cardinality: ${nested.cardinality}');
  print('Contains "x": ${nested.contains('x')}');
  print('Contains innerSet1: ${nested.contains(innerSet1)}');
  print(
    'Contains "a": ${nested.contains('a')} (false - "a" is inside innerSet1)\n',
  );

  // Power set of nested structure
  final simple = CustomSet([innerSet1, innerSet2]);
  final simplePowerSet = simple.powerSet;
  print('Power Set of {Set1, Set2}:');
  print('  |P| = ${simplePowerSet.cardinality}');
}
