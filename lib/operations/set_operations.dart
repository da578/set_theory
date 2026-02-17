import 'package:set_theory/models/custom_set.dart';

/// Provides basic set operations as defined in set theory.
///
/// This class contains static methods for fundamental set operations
/// including intersection, union, complement, difference, and symmetric difference.
///
/// All operations follow standard mathematical notation and properties.
class SetOperations {
  /// Returns the intersection of two sets.
  ///
  /// Notation: A ∩ B = {x | x ∈ A and x ∈ B}
  ///
  /// The intersection contains all elements that are present in both sets.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([2, 4, 6, 8, 10]);
  /// final b = CustomSet<int>([4, 10, 14, 18]);
  /// final result = SetOperations.intersection(a, b);
  /// // result = {4, 10}
  /// ```
  static CustomSet<T> intersection<T>(CustomSet<T> a, CustomSet<T> b) =>
      CustomSet(a.elements.where(b.contains));

  /// Returns the union of two sets.
  ///
  /// Notation: A ∪ B = {x | x ∈ A or x ∈ B}
  ///
  /// The union contains all elements that are in either set or both.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([2, 5, 8]);
  /// final b = CustomSet<int>([7, 5, 22]);
  /// final result = SetOperations.union(a, b);
  /// // result = {2, 5, 7, 8, 22}
  /// ```
  static CustomSet<T> union<T>(CustomSet<T> a, CustomSet<T> b) =>
      CustomSet({...a.elements, ...b.elements});

  /// Returns the complement of a set with respect to a universal set.
  ///
  /// Notation: A' or A̅ = {x | x ∈ U and x ∉ A}
  ///
  /// The complement contains all elements in the universal set that are
  /// not in the given set.
  ///
  /// Example:
  /// ```dart
  /// final universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9]);
  /// final a = CustomSet<int>([1, 3, 7, 9]);
  /// final result = SetOperations.complement(a, universal);
  /// // result = {2, 4, 6, 8}
  /// ```
  static CustomSet<T> complement<T>(CustomSet<T> a, CustomSet<T> universal) =>
      CustomSet(universal.elements.where((e) => !a.contains(e)));

  /// Returns the difference of two sets.
  ///
  /// Notation: A - B = {x | x ∈ A and x ∉ B}
  ///
  /// The difference contains all elements that are in the first set
  /// but not in the second set.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3, 4, 5]);
  /// final b = CustomSet<int>([2, 4]);
  /// final result = SetOperations.difference(a, b);
  /// // result = {1, 3, 5}
  /// ```
  static CustomSet<T> difference<T>(CustomSet<T> a, CustomSet<T> b) =>
      CustomSet(a.elements.where((e) => !b.contains(e)));

  /// Returns the symmetric difference of two sets.
  ///
  /// Notation: A ⊕ B = (A ∪ B) - (A ∩ B)
  ///
  /// The symmetric difference contains all elements that are in either set
  /// but not in both.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([2, 4, 6]);
  /// final b = CustomSet<int>([2, 3, 5]);
  /// final result = SetOperations.symmetricDifference(a, b);
  /// // result = {3, 4, 5, 6}
  /// ```
  static CustomSet<T> symmetricDifference<T>(CustomSet<T> a, CustomSet<T> b) {
    final unionSet = union(a, b);
    final intersectionSet = intersection(a, b);
    return difference(unionSet, intersectionSet);
  }

  /// Returns the symmetric difference using alternative formula.
  ///
  /// Notation: A ⊕ B = (A - B) ∪ (B - A)
  ///
  /// This is mathematically equivalent to [symmetricDifference] but
  /// uses a different computation approach.
  static CustomSet<T> symmetricDifferenceAlt<T>(
    CustomSet<T> a,
    CustomSet<T> b,
  ) {
    final aMinusB = difference(a, b);
    final bMinusA = difference(b, a);
    return union(aMinusB, bMinusA);
  }
}
