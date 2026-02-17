import 'package:set_theory/models/custom_set.dart';
import 'package:set_theory/operations/set_operations.dart';

/// Provides advanced set operations beyond the basic operations.
///
/// This class includes operations such as Cartesian product, power set,
/// partition validation, and the inclusion-exclusion principle.
class AdvancedSetOperations {
  /// Returns the Cartesian product of two sets.
  ///
  /// Notation: A × B = {(a, b) | a ∈ A and b ∈ B}
  ///
  /// The Cartesian product contains all ordered pairs where the first
  /// element is from set A and the second is from set B.
  ///
  /// If either set is empty, the result is an empty set.
  /// |A × B| = |A| × |B|
  ///
  /// Example:
  /// ```dart
  /// final c = CustomSet<int>([1, 2, 3]);
  /// final d = CustomSet<String>(['a', 'b']);
  /// final result = AdvancedSetOperations.cartesianProduct(c, d);
  /// // result = {(1, 'a'), (1, 'b'), (2, 'a'), (2, 'b'), (3, 'a'), (3, 'b')}
  /// ```
  static CustomSet<(T, U)> cartesianProduct<T, U>(
    CustomSet<T> a,
    CustomSet<U> b,
  ) {
    if (a.isEmpty || b.isEmpty) return CustomSet.empty();

    final List<(T, U)> pairs = [];
    for (var elementA in a.elements) {
      for (var elementB in b.elements) {
        pairs.add((elementA, elementB));
      }
    }

    return CustomSet(pairs);
  }

  /// Returns the Cartesian product of n sets.
  ///
  /// Notation: A₁ × A₂ × ... × Aₙ = {(a₁, a₂, ..., aₙ) | aᵢ ∈ Aᵢ}
  ///
  /// Returns all possible n-tuples where each element comes from
  /// the corresponding set in the list.
  ///
  /// If any set is empty or the list is empty, returns an empty set.
  static CustomSet<List<T>> cartesianProductN<T>(List<CustomSet<T>> sets) {
    if (sets.isEmpty) return CustomSet.empty();
    if (sets.any((s) => s.isEmpty)) return CustomSet.empty();

    List<List<T>> result = [[]];
    for (var set in sets) {
      final List<List<T>> newResult = [];
      for (var prefix in result) {
        for (var element in set.elements) {
          newResult.add([...prefix, element]);
        }
      }
      result = newResult;
    }

    return CustomSet(result);
  }

  /// Checks if a collection of sets forms a valid partition of the original set.
  ///
  /// A partition of set A is a collection of non-empty subsets A₁, A₂, ... such that:
  /// 1. A₁ ∪ A₂ ∪ ... = A (union equals original)
  /// 2. Aᵢ ∩ Aⱼ = ∅ for i ≠ j (all subsets are pairwise disjoint)
  ///
  /// Example:
  /// ```dart
  /// final original = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8]);
  /// final partitions = CustomSet<CustomSet<int>>([
  ///   CustomSet([1]),
  ///   CustomSet([2, 3, 4]),
  ///   CustomSet([5, 6]),
  ///   CustomSet([7, 8]),
  /// ]);
  /// print(AdvancedSetOperations.isPartition(partitions, original)); // Output: true
  /// ```
  static bool isPartition<T>(
    CustomSet<CustomSet<T>> partitions,
    CustomSet<T> original,
  ) {
    // Check all partitions are non-empty
    for (var partition in partitions.elements) {
      if (partition.isEmpty) return false;
    }

    // Check union of all partitions equals original
    CustomSet<T> unionSet = CustomSet.empty();
    for (var partition in partitions.elements) {
      unionSet = SetOperations.union(unionSet, partition);
    }

    if (!unionSet.equals(original)) return false;

    // Check all partitions are pairwise disjoint
    final partitionList = partitions.elements.toList();
    for (int i = 0; i < partitionList.length; i++) {
      for (int j = i + 1; j < partitionList.length; j++) {
        if (!partitionList[i].isDisjointFrom(partitionList[j])) return false;
      }
    }

    return true;
  }

  /// Applies the inclusion-exclusion principle for two sets.
  ///
  /// Formula: |A ∪ B| = |A| + |B| - |A ∩ B|
  ///
  /// This calculates the cardinality of the union without actually
  /// computing the union, which can be more efficient for large sets.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3, 4, 5]);
  /// final b = CustomSet<int>([4, 5, 6, 7, 8]);
  /// final count = AdvancedSetOperations.inclusionExclusion2(a, b);
  /// print(count); // Output: 8
  /// ```
  static int inclusionExclusion2<T>(CustomSet<T> a, CustomSet<T> b) =>
      a.cardinality +
      b.cardinality -
      SetOperations.intersection(a, b).cardinality;

  /// Applies the inclusion-exclusion principle for three sets.
  ///
  /// Formula: |A ∪ B ∪ C| = |A| + |B| + |C| - |A ∩ B| - |A ∩ C| - |B ∩ C| + |A ∩ B ∩ C|
  ///
  /// This extends the two-set formula to handle three sets.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3, 4]);
  /// final b = CustomSet<int>([3, 4, 5, 6]);
  /// final c = CustomSet<int>([5, 6, 7, 8]);
  /// final count = AdvancedSetOperations.inclusionExclusion3(a, b, c);
  /// print(count); // Output: 8
  /// ```
  static int inclusionExclusion3<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> c,
  ) =>
      a.cardinality +
      b.cardinality +
      c.cardinality -
      SetOperations.intersection(a, b).cardinality -
      SetOperations.intersection(a, c).cardinality -
      SetOperations.intersection(b, c).cardinality +
      SetOperations.intersection(
        SetOperations.intersection(a, b),
        c,
      ).cardinality;
}
