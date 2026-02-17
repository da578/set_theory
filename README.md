# Set Theory Library

A comprehensive implementation of Set Theory operations in Dart, following standard mathematical notation and principles. This library provides tools for working with sets, multisets, and various set operations commonly used in discrete mathematics and computer science.

## Features

- **CustomSet**\
Standard set implementation with unique elements
- **MultiSet** \
Set implementation allowing duplicate elements with multiplicity
- **Basic Operations** \
Union, Intersection, Complement, Difference, Symmetric Difference
- **Advanced Operations** \
Cartesian Product, Power Set, Partition Validation
- **Set Laws** \
Verification methods for all standard set theory laws
- **Inclusion-Exclusion Principle**: For 2 and 3 sets
- **Type-Safe** \
Full generic support for any data type
- **Well-Tested** \
Comprehensive unit test coverage

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  set_theory: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:set_theory/set_theory.dart';

void main() {
  // Create sets
  final a = CustomSet<int>([1, 2, 3, 4]);
  final b = CustomSet<int>([3, 4, 5, 6]);

  // Basic operations
  final union = SetOperations.union(a, b);
  final intersection = SetOperations.intersection(a, b);
  final difference = SetOperations.difference(a, b);

  print('A = $a');                    // Output: {1, 2, 3, 4}
  print('B = $b');                    // Output: {3, 4, 5, 6}
  print('A ∪ B = $union');            // Output: {1, 2, 3, 4, 5, 6}
  print('A ∩ B = $intersection');     // Output: {3, 4}
  print('A - B = $difference');       // Output: {1, 2}
}
```

## Usage Guide

### Creating Sets

```dart
// Empty set
final empty = CustomSet<int>.empty();

// Set with elements
final numbers = CustomSet<int>([1, 2, 3, 4, 5]);

// Set from predicate
final universe = CustomSet<int>(List.generate(100, (i) => i + 1));
final evenNumbers = CustomSet.fromPredicate(
  universe.elements,
  (x) => x % 2 == 0,
);

// Universal set
final universal = CustomSet.universal([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
```

### Set Operations

```dart
final a = CustomSet<int>([1, 2, 3, 4, 5]);
final b = CustomSet<int>([4, 5, 6, 7, 8]);
final universal = CustomSet<int>(List.generate(10, (i) => i + 1));

// Intersection (A ∩ B)
final intersection = SetOperations.intersection(a, b);
print('A ∩ B = $intersection');  // Output: {4, 5}

// Union (A ∪ B)
final union = SetOperations.union(a, b);
print('A ∪ B = $union');  // Output: {1, 2, 3, 4, 5, 6, 7, 8}

// Complement (A')
final complement = SetOperations.complement(a, universal);
print("A' = $complement");  // Output: {6, 7, 8, 9, 10}

// Difference (A - B)
final difference = SetOperations.difference(a, b);
print('A - B = $difference');  // Output: {1, 2, 3}

// Symmetric Difference (A ⊕ B)
final symmetricDiff = SetOperations.symmetricDifference(a, b);
print('A ⊕ B = $symmetricDiff');  // Output: {1, 2, 3, 6, 7, 8}
```

### Subset Operations

```dart
final a = CustomSet<int>([1, 2, 3]);
final b = CustomSet<int>([1, 2, 3, 4, 5]);
final c = CustomSet<int>([1, 2, 3]);

// Subset (A ⊆ B)
print(a.isSubsetOf(b));        // Output: true
print(a.isSubsetOf(c));        // Output: true

// Proper Subset (A ⊂ B)
print(a.isProperSubsetOf(b));  // Output: true
print(a.isProperSubsetOf(c));  // Output: false (equal sets)

// Superset (A ⊇ B)
print(b.isSupersetOf(a));      // Output: true

// Equality (A = B)
print(a.equals(c));            // Output: true

// Equivalence (|A| = |B|)
print(a.isEquivalentTo(b));    // Output: false
```

### Advanced Operations

```dart
// Cartesian Product (A × B)
final x = CustomSet<int>([1, 2]);
final y = CustomSet<String>(['a', 'b']);
final cartesian = AdvancedSetOperations.cartesianProduct(x, y);
print('X × Y = $cartesian');
// Output: {(1, a), (1, b), (2, a), (2, b)}

// Power Set (P(A))
final small = CustomSet<int>([1, 2]);
final powerSet = small.powerSet;
print('P({1, 2}) = $powerSet');
// Output: {∅, {1}, {2}, {1, 2}}
print('|P({1, 2})| = ${powerSet.cardinality}');  // Output: 4

// Partition Validation
final original = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8]);
final partitions = CustomSet<CustomSet<int>>([
  CustomSet([1]),
  CustomSet([2, 3, 4]),
  CustomSet([5, 6]),
  CustomSet([7, 8]),
]);
print(AdvancedSetOperations.isPartition(partitions, original));
// Output: true
```

### Set Laws Verification

```dart
final a = CustomSet<int>([1, 2, 3]);
final b = CustomSet<int>([3, 4, 5]);
final universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9]);

// Verify Commutative Law
print(SetLaws.commutativeUnion(a, b));      // Output: true
print(SetLaws.commutativeIntersection(a, b)); // Output: true

// Verify Distributive Law
print(SetLaws.distributiveUnion(a, b, c));     // Output: true
print(SetLaws.distributiveIntersection(a, b, c)); // Output: true

// Verify De Morgan's Law
print(SetLaws.deMorganUnion(a, b, universal));      // Output: true
print(SetLaws.deMorganIntersection(a, b, universal)); // Output: true

// Verify Identity Laws
print(SetLaws.identityUnion(a));           // Output: true
print(SetLaws.identityIntersection(a, universal)); // Output: true
```

### Inclusion-Exclusion Principle

```dart
// Two sets
final universal = CustomSet<int>(List.generate(100, (i) => i + 1));
final div3 = CustomSet.fromPredicate(
  universal.elements,
  (x) => x % 3 == 0,
);
final div5 = CustomSet.fromPredicate(
  universal.elements,
  (x) => x % 5 == 0,
);

final count = AdvancedSetOperations.inclusionExclusion2(div3, div5);
print('Numbers 1-100 divisible by 3 or 5: $count');
// Output: 47

// Three sets
final div7 = CustomSet.fromPredicate(
  universal.elements,
  (x) => x % 7 == 0,
);

final count3 = AdvancedSetOperations.inclusionExclusion3(div3, div5, div7);
print('Numbers 1-100 divisible by 3, 5, or 7: $count3');
```

### Multiset Operations

```dart
// Create multisets
final p = MultiSet<String>.fromIterable(['a', 'a', 'a', 'c', 'd', 'd']);
final q = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c', 'c']);

// Union (max multiplicity)
final union = p.union(q);
print('P ∪ Q = $union');
// Output: {a:3, b:1, c:2, d:2}

// Intersection (min multiplicity)
final intersection = p.intersection(q);
print('P ∩ Q = $intersection');
// Output: {a:2, c:1}

// Difference
final difference = p.difference(q);
print('P - Q = $difference');
// Output: {a:1, d:2}

// Sum
final sum = p.sum(q);
print('P + Q = $sum');
// Output: {a:5, b:1, c:3, d:2}

// Convert to standard set
final set = p.toSet();
print('P as Set = $set');
// Output: {a, c, d}
```

## Mathematical Notation Reference

| Operation | Notation | Dart Method |
|-----------|----------|-------------|
| Membership | x ∈ A | `set.contains(x)` |
| Not Member | x ∉ A | `!set.contains(x)` |
| Subset | A ⊆ B | `a.isSubsetOf(b)` |
| Proper Subset | A ⊂ B | `a.isProperSubsetOf(b)` |
| Superset | A ⊇ B | `a.isSupersetOf(b)` |
| Union | A ∪ B | `SetOperations.union(a, b)` |
| Intersection | A ∩ B | `SetOperations.intersection(a, b)` |
| Complement | A' or A̅ | `SetOperations.complement(a, universal)` |
| Difference | A - B | `SetOperations.difference(a, b)` |
| Symmetric Difference | A ⊕ B | `SetOperations.symmetricDifference(a, b)` |
| Cartesian Product | A × B | `AdvancedSetOperations.cartesianProduct(a, b)` |
| Power Set | P(A) or 2^A | `set.powerSet` |
| Cardinality | \|A\| or n(A) | `set.cardinality` |
| Empty Set | ∅ or {} | `CustomSet.empty()` |
| Equivalent | A ~ B | `a.isEquivalentTo(b)` |
| Disjoint | A // B | `a.isDisjointFrom(b)` |

## Real-World Examples

### Example 1: Student Survey

```dart
// Survey results from a dormitory
// 650 students have a dictionary
// 150 students do not have a dictionary
// 175 students have an encyclopedia
// 50 students have neither

final totalStudents = 650 + 150;  // 800
final hasDictionary = 650;
final hasEncyclopedia = 175;
final hasNeither = 50;
final hasEitherOrBoth = totalStudents - hasNeither;  // 750

// Students with both dictionary and encyclopedia
final hasBoth = hasDictionary + hasEncyclopedia - hasEitherOrBoth;

print('Total students: $totalStudents');
print('Students with both: $hasBoth');  // Output: 75
```

### Example 2: Hardware Procurement

```dart
// Department requirements
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

// a) Shareable resources (Union - max)
final shareable = ti.union(ms);
print('PCs needed: ${shareable.multiplicity('PC')}');  // Output: 100

// b) Non-shareable resources (Sum)
final nonShareable = ti.sum(ms);
print('Total PCs: ${nonShareable.multiplicity('PC')}');  // Output: 110

// c) MS-only requirements (Difference)
final msOnly = ms.difference(ti);
print('Mainframes: ${msOnly.multiplicity('mainframe')}');  // Output: 2
```

## Running Tests

```bash
# Run all tests
dart test

# Run with coverage
dart test --coverage=coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

## Running Examples

```bash
# Run the main example
dart run example/main.dart

# Run specific example
dart run example/advanced_operations.dart
```

## Generating Documentation

```bash
# Generate API documentation
dart doc

# Serve documentation locally
dart doc --serve
```

## Project Structure

```txt
set_theory/
├── lib/
│   ├── set_theory.dart          # Main library export
│   ├── models/
│   │   ├── custom_set.dart      # CustomSet class
│   │   └── multiset.dart        # MultiSet class
│   ├── operations/
│   │   ├── basic_operations.dart    # Basic set operations
│   │   ├── advanced_operations.dart # Advanced operations
│   │   └── set_laws.dart            # Set law verification
│   └── utils/
│       └── cardinality.dart     # Cardinality utilities
├── test/
│   └── set_theory_test.dart     # Unit tests
├── example/
│   ├── main.dart                # Main example
│   ├── basic_operations.dart    # Basic operations example
│   ├── advanced_operations.dart # Advanced operations example
│   └── real_world.dart          # Real-world examples
├── pubspec.yaml                 # Package configuration
├── CHANGELOG.md                 # Version history
├── LICENSE                      # MIT License
└── README.md                    # This file
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Based on standard set theory principles from discrete mathematics
- Inspired by mathematical notation used in academic literature
- Built with Dart's strong type system for type safety

## Support

For issues and feature requests, please use the [GitHub Issues](https://github.com/yourusername/set_theory/issues) page.

For questions about set theory concepts, please refer to:
- [Discrete Mathematics and Its Applications](https://www.mheducation.com/highered/product/discrete-mathematics-its-applications-rosen/M9780073383095.html) by Kenneth Rosen
- [Introduction to Set Theory](https://www.routledge.com/Introduction-to-Set-Theory/Jech-Hrbacek/p/book/9780824779153) by Karel Hrbacek and Thomas Jech

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.
