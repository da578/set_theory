import 'package:set_theory/set_theory.dart';

void main() {
  print('=== Set Theory Demo in Dart ===\n');

  // Creating Sets
  print('1. CREATING SETS');
  final a = CustomSet<int>([1, 2, 3, 4]);
  final b = CustomSet<int>([3, 4, 5, 6]);
  print('A = $a');
  print('B = $b');
  print('');

  // Membership
  print('2. MEMBERSHIP');
  print('3 ∈ A: ${a.contains(3)}');
  print('5 ∈ A: ${a.contains(5)}');
  print('');

  // Cardinality
  print('3. CARDINALITY');
  print('|A| = ${a.cardinality}');
  print('|B| = ${b.cardinality}');
  print('');

  // Subsets
  print('4. SUBSETS');
  final c = CustomSet<int>([1, 2]);
  print('C = $c');
  print('C ⊆ A: ${c.isSubsetOf(a)}');
  print('C ⊂ A: ${c.isProperSubsetOf(a)}');
  print('');

  // Basic Operations
  print('5. BASIC OPERATIONS');
  print('A ∩ B = ${SetOperations.intersection(a, b)}');
  print('A ∪ B = ${SetOperations.union(a, b)}');
  print('A - B = ${SetOperations.difference(a, b)}');
  print('A ⊕ B = ${SetOperations.symmetricDifference(a, b)}');
  print('');

  // Universal Set and Complement
  print('6. COMPLEMENT');
  final universal = CustomSet<int>([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print('U = $universal');
  print("A' = ${SetOperations.complement(a, universal)}");
  print('');

  // Cartesian Product
  print('7. CARTESIAN PRODUCT');
  final x = CustomSet<int>([1, 2]);
  final y = CustomSet<String>(['a', 'b']);
  final cartesian = AdvancedSetOperations.cartesianProduct(x, y);
  print('X × Y = $cartesian');
  print('|X × Y| = ${cartesian.cardinality}');
  print('');

  // Power Set
  print('8. POWER SET');
  final small = CustomSet<int>([1, 2]);
  final powerSet = small.powerSet;
  print('P({1, 2}) = $powerSet');
  print('|P({1, 2})| = ${powerSet.cardinality}');
  print('');

  // Set Laws
  print('9. SET LAWS');
  print('Commutative Law (A ∪ B = B ∪ A): ${SetLaws.commutativeUnion(a, b)}');
  print('Distributive Law: ${SetLaws.distributiveUnion(a, b, c)}');
  print("De Morgan's Law: ${SetLaws.deMorganUnion(a, b, universal)}");
  print('');

  // Multiset
  print('10. MULTISET');
  final ms1 = MultiSet<String>.fromIterable(['a', 'a', 'b', 'c']);
  final ms2 = MultiSet<String>.fromIterable(['a', 'b', 'b', 'd']);
  print('P = $ms1');
  print('Q = $ms2');
  print('P ∪ Q = ${ms1.union(ms2)}');
  print('P ∩ Q = ${ms1.intersection(ms2)}');
  print('P - Q = ${ms1.difference(ms2)}');
  print('P + Q = ${ms1.sum(ms2)}');
  print('');

  // Inclusion-Exclusion Principle
  print('11. INCLUSION-EXCLUSION PRINCIPLE');
  final numbers = CustomSet<int>(List.generate(100, (i) => i + 1));
  final div3 = CustomSet.fromPredicate(numbers.elements, (x) => x % 3 == 0);
  final div5 = CustomSet.fromPredicate(numbers.elements, (x) => x % 5 == 0);
  final count = AdvancedSetOperations.inclusionExclusion2(div3, div5);
  print('Numbers 1-100 divisible by 3 or 5: $count');
  print('');

  print('=== Demo Complete ===');
}
