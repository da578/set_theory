import 'dart:collection';

/// Represents a mathematical set containing unique elements.
///
/// A set is a collection of distinct objects, called elements or members.
/// This implementation follows standard set theory principles where:
/// - Order of elements does not matter
/// - Duplicate elements are automatically removed
/// - All elements must be of the same type [T]
///
/// Example:
/// ```dart
/// final numbers = CustomSet<int>([1, 2, 3, 4]);
/// final letters = CustomSet<String>(['a', 'b', 'c']);
/// ```
class CustomSet<T> {
  final Set<T> _elements;

  /// Creates an empty set.
  ///
  /// Example:
  /// ```dart
  /// final emptySet = CustomSet<int>.empty();
  /// ```
  CustomSet.empty() : _elements = <T>{};

  /// Creates a set from an iterable of elements.
  ///
  /// Duplicate elements are automatically removed.
  /// If [elements] is null, creates an empty set.
  ///
  /// Example:
  /// ```dart
  /// final numbers = CustomSet<int>([1, 2, 3, 4]);
  /// final fromSet = CustomSet<int>({5, 6, 7});
  /// ```
  CustomSet([Iterable<T>? elements])
    : _elements = elements != null ? elements.toSet() : <T>{};

  /// Creates a set from a predicate function applied to a universe.
  ///
  /// Only elements from [universe] that satisfy [predicate] are included.
  ///
  /// Example:
  /// ```dart
  /// final universe = CustomSet<int>(List.generate(100, (i) => i + 1));
  /// final evenNumbers = CustomSet.fromPredicate(
  ///   universe.elements,
  ///   (x) => x % 2 == 0,
  /// );
  /// ```
  CustomSet.fromPredicate(Iterable<T> universe, bool Function(T) predicate)
    : _elements = universe.where(predicate).toSet();

  /// Returns an unmodifiable view of the set elements.
  ///
  /// This prevents external modification of the internal set structure.
  UnmodifiableSetView<T> get elements => UnmodifiableSetView(_elements);

  /// Returns the cardinality (number of elements) in the set.
  ///
  /// Notation: |A| or n(A)
  ///
  /// Example:
  /// ```dart
  /// final set = CustomSet<int>([1, 2, 3]);
  /// print(set.cardinality); // Output: 3
  /// ```
  int get cardinality => _elements.length;

  /// Returns true if the set contains no elements.
  ///
  /// A set with cardinality 0 is called an empty set or null set.
  /// Notation: ∅ or {}
  bool get isEmpty => _elements.isEmpty;

  /// Returns true if the set contains at least one element.
  bool get isNotEmpty => _elements.isNotEmpty;

  /// Checks if [element] is a member of this set.
  ///
  /// Notation: x ∈ A
  ///
  /// Returns `true` if [element] is in the set, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final set = CustomSet<int>([1, 2, 3]);
  /// print(set.contains(2)); // Output: true
  /// print(set.contains(5)); // Output: false
  /// ```
  bool contains(T element) => _elements.contains(element);

  /// Adds [element] to the set.
  ///
  /// If the element already exists, the set remains unchanged.
  /// Returns `true` if the element was added, `false` if it already existed.
  bool add(T element) => _elements.add(element);

  /// Removes [element] from the set.
  ///
  /// Returns `true` if the element was removed, `false` if it was not found.
  bool remove(T element) => _elements.remove(element);

  /// Removes all elements from the set.
  ///
  /// After this operation, the set will be empty.
  void clear() => _elements.clear();

  /// Checks if this set is a subset of [other].
  ///
  /// Notation: A ⊆ B
  ///
  /// Returns `true` if every element of this set is also in [other].
  /// An empty set is a subset of any set.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3]);
  /// final b = CustomSet<int>([1, 2, 3, 4, 5]);
  /// print(a.isSubsetOf(b)); // Output: true
  /// ```
  bool isSubsetOf(CustomSet<T> other) =>
      _elements.every(other._elements.contains);

  /// Checks if this set is a proper subset of [other].
  ///
  /// Notation: A ⊂ B
  ///
  /// Returns `true` if this set is a subset of [other] and not equal to [other].
  /// At least one element must exist in [other] that is not in this set.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3]);
  /// final b = CustomSet<int>([1, 2, 3]);
  /// final c = CustomSet<int>([1, 2, 3, 4]);
  /// print(a.isProperSubsetOf(b)); // Output: false (equal sets)
  /// print(a.isProperSubsetOf(c)); // Output: true
  /// ```
  bool isProperSubsetOf(CustomSet<T> other) =>
      isSubsetOf(other) && cardinality < other.cardinality;

  /// Checks if this set is a superset of [other].
  ///
  /// Notation: A ⊇ B
  ///
  /// Returns `true` if every element of [other] is also in this set.
  bool isSupersetOf(CustomSet<T> other) => other.isSubsetOf(this);

  /// Checks if this set is a proper superset of [other].
  ///
  /// Notation: A ⊃ B
  ///
  /// Returns `true` if this set is a superset of [other] and not equal to [other].
  bool isProperSupersetOf(CustomSet<T> other) => other.isProperSubsetOf(this);

  /// Checks if this set is equal to [other].
  ///
  /// Notation: A = B
  ///
  /// Two sets are equal if they contain exactly the same elements.
  /// Order does not matter, and duplicates are ignored.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3]);
  /// final b = CustomSet<int>([3, 2, 1]);
  /// print(a.equals(b)); // Output: true
  /// ```
  bool equals(CustomSet<T> other) =>
      cardinality == other.cardinality && isSubsetOf(other);

  /// Checks if this set is equivalent to [other].
  ///
  /// Notation: A ~ B
  ///
  /// Two sets are equivalent if they have the same cardinality.
  /// The actual elements do not need to be the same.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3, 4]);
  /// final b = CustomSet<String>(['a', 'b', 'c', 'd']);
  /// print(a.isEquivalentTo(b)); // Output: true
  /// ```
  bool isEquivalentTo(CustomSet<T> other) => cardinality == other.cardinality;

  /// Checks if this set is disjoint from [other].
  ///
  /// Notation: A // B
  ///
  /// Two sets are disjoint if they have no elements in common.
  /// Their intersection is the empty set.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3]);
  /// final b = CustomSet<int>([4, 5, 6]);
  /// print(a.isDisjointFrom(b)); // Output: true
  /// ```
  bool isDisjointFrom(CustomSet<T> other) =>
      _elements.every((e) => !other._elements.contains(e));

  @override
  bool operator ==(Object other) => other is CustomSet<T> && equals(other);

  @override
  int get hashCode => _elements.hashCode;

  @override
  String toString() {
    if (isEmpty) return '∅';
    return '{${_elements.join(', ')}}';
  }

  /// Returns the intersection of this set with [other].
  ///
  /// Notation: A ∩ B = {x | x ∈ A and x ∈ B}
  ///
  /// The intersection contains all elements that are present in both sets.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([2, 4, 6, 8, 10]);
  /// final b = CustomSet<int>([4, 10, 14, 18]);
  /// final result = a.intersection(b);
  /// // result = {4, 10}
  /// ```
  CustomSet<T> intersection(CustomSet<T> other) =>
      CustomSet(_elements.where(other._elements.contains));

  /// Returns the union of this set with [other].
  ///
  /// Notation: A ∪ B = {x | x ∈ A or x ∈ B}
  ///
  /// The union contains all elements that are in either set or both.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([2, 5, 8]);
  /// final b = CustomSet<int>([7, 5, 22]);
  /// final result = a.union(b);
  /// // result = {2, 5, 7, 8, 22}
  /// ```
  CustomSet<T> union(CustomSet<T> other) =>
      CustomSet({..._elements, ...other._elements});

  /// Returns the complement of this set with respect to [universal].
  ///
  /// Notation: A' or A̅ = {x | x ∈ U and x ∉ A}
  ///
  /// The complement contains all elements in the universal set that are
  /// not in this set.
  ///
  /// Example:
  /// ```dart
  /// final universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9]);
  /// final a = CustomSet<int>([1, 3, 7, 9]);
  /// final result = a.complement(universal);
  /// // result = {2, 4, 6, 8}
  /// ```
  CustomSet<T> complement(CustomSet<T> universal) =>
      CustomSet(universal._elements.where((e) => !_elements.contains(e)));

  /// Returns the difference of this set with [other].
  ///
  /// Notation: A - B = {x | x ∈ A and x ∉ B}
  ///
  /// The difference contains all elements that are in this set
  /// but not in [other].
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2, 3, 4, 5]);
  /// final b = CustomSet<int>([2, 4]);
  /// final result = a.difference(b);
  /// // result = {1, 3, 5}
  /// ```
  CustomSet<T> difference(CustomSet<T> other) =>
      CustomSet(_elements.where((e) => !other._elements.contains(e)));

  /// Returns the symmetric difference of this set with [other].
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
  /// final result = a.symmetricDifference(b);
  /// // result = {3, 4, 5, 6}
  /// ```
  CustomSet<T> symmetricDifference(CustomSet<T> other) {
    final unionSet = union(other);
    final intersectionSet = intersection(other);
    return unionSet.difference(intersectionSet);
  }

  /// Returns the power set of this set.
  ///
  /// Notation: P(A) or 2^A
  ///
  /// The power set contains all possible subsets of this set,
  /// including the empty set and the set itself.
  /// If |A| = n, then |P(A)| = 2^n.
  ///
  /// Example:
  /// ```dart
  /// final a = CustomSet<int>([1, 2]);
  /// final powerSet = a.powerSet;
  /// // P(A) = {∅, {1}, {2}, {1, 2}}
  /// print(powerSet.cardinality); // Output: 4
  /// ```
  CustomSet<CustomSet<T>> get powerSet {
    final List<CustomSet<T>> subsets = [];
    final List<T> elementList = _elements.toList();
    final int total = 1 << elementList.length; // 2^n

    for (int i = 0; i < total; i++) {
      final List<T> subset = [];
      for (int j = 0; j < elementList.length; j++) {
        if ((i & (1 << j)) != 0) subset.add(elementList[j]);
      }
      subsets.add(CustomSet(subset));
    }

    return CustomSet<CustomSet<T>>(subsets);
  }

  /// Creates a universal set from the given elements.
  ///
  /// The universal set contains all elements under consideration
  /// for a particular discussion or problem.
  /// Notation: U or S
  CustomSet<T> universal(Iterable<T> elements) => CustomSet(elements);

  /// Creates an empty set.
  ///
  /// This is a convenience method for creating empty sets.
  CustomSet<T> emptySet() => CustomSet.empty();
}
