/// A comprehensive library for Set Theory operations in Dart.
///
/// This library provides implementations of:
/// - Standard sets with unique elements
/// - Multisets with element multiplicity
/// - Basic set operations (union, intersection, complement, etc.)
/// - Advanced operations (Cartesian product, power set, etc.)
/// - Set law verification methods
///
/// Example usage:
/// ```dart
/// import 'package:set_theory/set_theory.dart';
///
/// void main() {
///   final a = CustomSet<int>([1, 2, 3]);
///   final b = CustomSet<int>([3, 4, 5]);
///
///   final union = SetOperations.union(a, b);
///   print('A ∪ B = $union'); // Output: {1, 2, 3, 4, 5}
///
///   final intersection = SetOperations.intersection(a, b);
///   print('A ∩ B = $intersection'); // Output: {3}
/// }
/// ```

export 'models/custom_set.dart';
export 'models/multiset.dart';
export 'operations/set_operations.dart';
export 'operations/advanced_set_operations.dart';
export 'operations/set_laws.dart';
