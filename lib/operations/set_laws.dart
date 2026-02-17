import 'package:set_theory/models/custom_set.dart';
import 'package:set_theory/operations/set_operations.dart';

/// Provides verification methods for standard set theory laws.
///
/// These laws are fundamental identities in set algebra that can be used
/// to prove set equivalences and simplify set expressions.
///
/// Each method returns true if the law holds for the given sets.
class SetLaws {
  /// Verifies the Identity Law for Union.
  ///
  /// Law: A ∪ ∅ = A
  ///
  /// The union of any set with the empty set equals the original set.
  static bool identityUnion<T>(CustomSet<T> a) {
    final empty = CustomSet<T>.empty();
    return SetOperations.union(a, empty).equals(a);
  }

  /// Verifies the Identity Law for Intersection.
  ///
  /// Law: A ∩ U = A
  ///
  /// The intersection of any set with the universal set equals the original set.
  static bool identityIntersection<T>(CustomSet<T> a, CustomSet<T> universal) =>
      SetOperations.intersection(a, universal).equals(a);

  /// Verifies the Null/Domination Law for Intersection.
  ///
  /// Law: A ∩ ∅ = ∅
  ///
  /// The intersection of any set with the empty set equals the empty set.
  static bool nullIntersection<T>(CustomSet<T> a) {
    final empty = CustomSet<T>.empty();
    return SetOperations.intersection(a, empty).isEmpty;
  }

  /// Verifies the Null/Domination Law for Union.
  ///
  /// Law: A ∪ U = U
  ///
  /// The union of any set with the universal set equals the universal set.
  static bool nullUnion<T>(CustomSet<T> a, CustomSet<T> universal) =>
      SetOperations.union(a, universal).equals(universal);

  /// Verifies the Complement Law for Union.
  ///
  /// Law: A ∪ A' = U
  ///
  /// The union of a set and its complement equals the universal set.
  static bool complementUnion<T>(CustomSet<T> a, CustomSet<T> universal) {
    final complement = SetOperations.complement(a, universal);
    return SetOperations.union(a, complement).equals(universal);
  }

  /// Verifies the Complement Law for Intersection.
  ///
  /// Law: A ∩ A' = ∅
  ///
  /// The intersection of a set and its complement equals the empty set.
  static bool complementIntersection<T>(
    CustomSet<T> a,
    CustomSet<T> universal,
  ) {
    final complement = SetOperations.complement(a, universal);
    return SetOperations.intersection(a, complement).isEmpty;
  }

  /// Verifies the Idempotent Law for Union.
  ///
  /// Law: A ∪ A = A
  ///
  /// The union of a set with itself equals the original set.
  static bool idempotentUnion<T>(CustomSet<T> a) =>
      SetOperations.union(a, a).equals(a);

  /// Verifies the Idempotent Law for Intersection.
  ///
  /// Law: A ∩ A = A
  ///
  /// The intersection of a set with itself equals the original set.
  static bool idempotentIntersection<T>(CustomSet<T> a) =>
      SetOperations.intersection(a, a).equals(a);

  /// Verifies the Involution Law.
  ///
  /// Law: (A')' = A
  ///
  /// The complement of the complement of a set equals the original set.
  static bool involution<T>(CustomSet<T> a, CustomSet<T> universal) {
    final complement1 = SetOperations.complement(a, universal);
    final complement2 = SetOperations.complement(complement1, universal);
    return complement2.equals(a);
  }

  /// Verifies the Absorption Law for Union.
  ///
  /// Law: A ∪ (A ∩ B) = A
  ///
  /// The union of a set with its intersection with another set equals the original set.
  static bool absorptionUnion<T>(CustomSet<T> a, CustomSet<T> b) {
    final intersection = SetOperations.intersection(a, b);
    return SetOperations.union(a, intersection).equals(a);
  }

  /// Verifies the Absorption Law for Intersection.
  ///
  /// Law: A ∩ (A ∪ B) = A
  ///
  /// The intersection of a set with its union with another set equals the original set.
  static bool absorptionIntersection<T>(CustomSet<T> a, CustomSet<T> b) {
    final union = SetOperations.union(a, b);
    return SetOperations.intersection(a, union).equals(a);
  }

  /// Verifies the Commutative Law for Union.
  ///
  /// Law: A ∪ B = B ∪ A
  ///
  /// The order of sets in a union operation does not matter.
  static bool commutativeUnion<T>(CustomSet<T> a, CustomSet<T> b) =>
      SetOperations.union(a, b).equals(SetOperations.union(b, a));

  /// Verifies the Commutative Law for Intersection.
  ///
  /// Law: A ∩ B = B ∩ A
  ///
  /// The order of sets in an intersection operation does not matter.
  static bool commutativeIntersection<T>(CustomSet<T> a, CustomSet<T> b) =>
      SetOperations.intersection(a, b).equals(SetOperations.intersection(b, a));

  /// Verifies the Associative Law for Union.
  ///
  /// Law: A ∪ (B ∪ C) = (A ∪ B) ∪ C
  ///
  /// The grouping of sets in a union operation does not matter.
  static bool associativeUnion<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> c,
  ) {
    final left = SetOperations.union(a, SetOperations.union(b, c));
    final right = SetOperations.union(SetOperations.union(a, b), c);
    return left.equals(right);
  }

  /// Verifies the Associative Law for Intersection.
  ///
  /// Law: A ∩ (B ∩ C) = (A ∩ B) ∩ C
  ///
  /// The grouping of sets in an intersection operation does not matter.
  static bool associativeIntersection<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> c,
  ) {
    final left = SetOperations.intersection(
      a,
      SetOperations.intersection(b, c),
    );
    final right = SetOperations.intersection(
      SetOperations.intersection(a, b),
      c,
    );
    return left.equals(right);
  }

  /// Verifies the Distributive Law for Union over Intersection.
  ///
  /// Law: A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C)
  ///
  /// Union distributes over intersection.
  static bool distributiveUnion<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> c,
  ) {
    final left = SetOperations.union(a, SetOperations.intersection(b, c));
    final right = SetOperations.intersection(
      SetOperations.union(a, b),
      SetOperations.union(a, c),
    );
    return left.equals(right);
  }

  /// Verifies the Distributive Law for Intersection over Union.
  ///
  /// Law: A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)
  ///
  /// Intersection distributes over union.
  static bool distributiveIntersection<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> c,
  ) {
    final left = SetOperations.intersection(a, SetOperations.union(b, c));
    final right = SetOperations.union(
      SetOperations.intersection(a, b),
      SetOperations.intersection(a, c),
    );
    return left.equals(right);
  }

  /// Verifies De Morgan's Law for Intersection.
  ///
  /// Law: (A ∩ B)' = A' ∪ B'
  ///
  /// The complement of an intersection equals the union of the complements.
  static bool deMorganIntersection<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> universal,
  ) {
    final intersection = SetOperations.intersection(a, b);
    final complementIntersection = SetOperations.complement(
      intersection,
      universal,
    );
    final complementA = SetOperations.complement(a, universal);
    final complementB = SetOperations.complement(b, universal);
    final unionComplements = SetOperations.union(complementA, complementB);
    return complementIntersection.equals(unionComplements);
  }

  /// Verifies De Morgan's Law for Union.
  ///
  /// Law: (A ∪ B)' = A' ∩ B'
  ///
  /// The complement of a union equals the intersection of the complements.
  static bool deMorganUnion<T>(
    CustomSet<T> a,
    CustomSet<T> b,
    CustomSet<T> universal,
  ) {
    final union = SetOperations.union(a, b);
    final complementUnion = SetOperations.complement(union, universal);
    final complementA = SetOperations.complement(a, universal);
    final complementB = SetOperations.complement(b, universal);
    final intersectionComplements = SetOperations.intersection(
      complementA,
      complementB,
    );
    return complementUnion.equals(intersectionComplements);
  }

  /// Verifies the Law 0/1 for Empty Set Complement.
  ///
  /// Law: ∅' = U
  ///
  /// The complement of the empty set equals the universal set.
  static bool lawZero<T>(CustomSet<T> universal) {
    final empty = CustomSet<T>.empty();
    return SetOperations.complement(empty, universal).equals(universal);
  }

  /// Verifies the Law 0/1 for Universal Set Complement.
  ///
  /// Law: U' = ∅
  ///
  /// The complement of the universal set equals the empty set.
  static bool lawOne<T>(CustomSet<T> universal) =>
      SetOperations.complement(universal, universal).isEmpty;
}
