import 'package:set_theory/models/custom_set.dart';

/// Represents a multiset (also known as a bag) containing elements with multiplicity.
///
/// Unlike a standard set, a multiset allows duplicate elements.
/// Each element has a multiplicity value representing how many times it appears.
///
/// Example:
/// ```dart
/// final ms = MultiSet<int>.fromIterable([1, 1, 1, 2, 2, 3]);
/// print(ms.multiplicity(1)); // Output: 3
/// print(ms.cardinality); // Output: 6 (total count including duplicates)
/// ```
class MultiSet<T> {
  final Map<T, int> _elements;

  /// Creates an empty multiset.
  MultiSet() : _elements = <T, int>{};

  /// Creates a multiset from an iterable of elements.
  ///
  /// Duplicate elements in [elements] increase the multiplicity.
  ///
  /// Example:
  /// ```dart
  /// final ms = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c']);
  /// ```
  MultiSet.fromIterable(Iterable<T> elements) : _elements = <T, int>{} {
    for (var element in elements) {
      add(element);
    }
  }

  /// Returns the multiplicity of [element] in this multiset.
  ///
  /// Multiplicity is the number of times an element appears.
  /// Returns 0 if the element is not present.
  ///
  /// Example:
  /// ```dart
  /// final ms = MultiSet<int>.fromIterable([1, 1, 2, 2, 2, 3]);
  /// print(ms.multiplicity(2)); // Output: 3
  /// ```
  int multiplicity(T element) => _elements[element] ?? 0;

  /// Returns the total cardinality of the multiset.
  ///
  /// This is the sum of all multiplicities (total count of all elements).
  ///
  /// Example:
  /// ```dart
  /// final ms = MultiSet<int>.fromIterable([1, 1, 2, 3]);
  /// print(ms.cardinality); // Output: 4
  /// ```
  int get cardinality => _elements.values.fold(0, (sum, count) => sum + count);

  /// Returns the number of unique elements in the multiset.
  ///
  /// This counts distinct elements regardless of multiplicity.
  int get uniqueCount => _elements.length;

  /// Returns true if the multiset contains no elements.
  bool get isEmpty => _elements.isEmpty;

  /// Adds [element] is not specified, adds the element once.
  ///
  /// If [count] is not specified, adds the element once.
  ///
  /// Example:
  /// ```dart
  /// final ms = MultiSet<String>();
  /// ms.add('a', 3);
  /// print(ms.multiplicity('a')); // Output: 3
  /// ```
  void add(T element, [int count = 1]) {
    if (count <= 0) return;
    _elements[element] = (_elements[element] ?? 0) + count;
  }

  /// Removes [element] from the multiset [count] times.
  ///
  /// If [count] is not specified, removes the element once.
  /// If multiplicity becomes zero or negative, the element is removed entirely.
  void remove(T element, [int count = 1]) {
    if (_elements.containsKey(element)) {
      _elements[element] = (_elements[element] ?? 0) - count;
      if (_elements[element]! <= 0) _elements.remove(element);
    }
  }

  /// Returns the union of this multiset with [other].
  ///
  /// The multiplicity of each element in the result is the maximum
  /// of its multiplicities in this multiset and [other].
  ///
  /// Example:
  /// ```dart
  /// final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'c']);
  /// final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);
  /// final result = p.union(q);
  /// // result = {'a': 3, 'b': 1, 'c': 2}
  /// ```
  MultiSet<T> union(MultiSet<T> other) {
    final result = MultiSet<T>();
    final allElements = {..._elements.keys, ...other._elements.keys};

    for (var element in allElements) {
      final count = _max(
        _elements[element] ?? 0,
        other._elements[element] ?? 0,
      );
      if (count > 0) result.add(element, count);
    }

    return result;
  }

  /// Returns the intersection of this multiset with [other].
  ///
  /// The multiplicity of each element in the result is the minimum
  /// of its multiplicities in this multiset and [other].
  ///
  /// Example:
  /// ```dart
  /// final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'c']);
  /// final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);
  /// final result = p.intersection(q);
  /// // result = {'a': 2, 'c': 1}
  /// ```
  MultiSet<T> intersection(MultiSet<T> other) {
    final result = MultiSet<T>();
    final allElements = {..._elements.keys, ...other._elements.keys};

    for (var element in allElements) {
      final count = _min(
        _elements[element] ?? 0,
        other._elements[element] ?? 0,
      );
      if (count > 0) result.add(element, count);
    }

    return result;
  }

  /// Returns the difference of this multiset with [other].
  ///
  /// The multiplicity of each element in the result is the multiplicity
  /// in this multiset minus the multiplicity in [other] (minimum 0).
  ///
  /// Example:
  /// ```dart
  /// final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'b']);
  /// final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'b']);
  /// final result = p.difference(q);
  /// // result = {'a': 1}
  /// ```
  MultiSet<T> difference(MultiSet<T> other) {
    final result = MultiSet<T>();

    for (var element in _elements.keys) {
      final count = (_elements[element] ?? 0) - (other._elements[element] ?? 0);
      if (count > 0) result.add(element, count);
    }

    return result;
  }

  /// Returns the sum of this multiset with [other].
  ///
  /// The multiplicity of each element in the result is the sum of
  /// its multiplicities in this multiset and [other].
  ///
  /// Example:
  /// ```dart
  /// final p = MultiSet<String>.fromIterable(['a', 'a', 'b']);
  /// final q = MultiSet<String>.fromIterable(['a', 'b', 'b']);
  /// final result = p.sum(q);
  /// // result = {'a': 3, 'b': 3}
  /// ```
  MultiSet<T> sum(MultiSet<T> other) {
    final result = MultiSet<T>();
    final allElements = {..._elements.keys, ...other._elements.keys};

    for (var element in allElements) {
      final count = (_elements[element] ?? 0) + (other._elements[element] ?? 0);
      if (count > 0) result.add(element, count);
    }

    return result;
  }

  /// Converts this multiset to a standard set.
  ///
  /// All duplicate elements are removed, keeping only unique elements.
  CustomSet<T> toSet() => CustomSet(_elements.keys);

  @override
  String toString() {
    if (isEmpty) return '∅';
    final entries = _elements.entries.map((e) => '${e.key}:${e.value}');
    return '{${entries.join(', ')}}';
  }

  int _max(int a, int b) => a > b ? a : b;
  int _min(int a, int b) => a < b ? a : b;
}
