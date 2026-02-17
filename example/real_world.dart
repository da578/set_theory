/// Example demonstrating real-world applications of set theory.
///
/// This example shows practical use cases:
/// - Survey analysis
/// - Resource management
/// - Database queries
/// - Access control
///
/// Run with: `dart run example/real_world.dart`
library;

import 'package:set_theory/set_theory.dart';

void main() {
  print('=== Real-World Set Theory Applications ===\n');

  demonstrateSurveyAnalysis();
  demonstrateResourceManagement();
  demonstrateDatabaseQueries();
  demonstrateAccessControl();
}

/// Demonstrates survey analysis using set operations.
void demonstrateSurveyAnalysis() {
  print('1. SURVEY ANALYSIS');
  print('-' * 50);

  // Student course enrollment survey
  final totalStudents = 500;
  final mathStudents = 320;
  final physicsStudents = 280;
  final bothSubjects = 150;

  print('Course Enrollment Survey:');
  print('  Total students: $totalStudents');
  print('  Math students: $mathStudents');
  print('  Physics students: $physicsStudents');
  print('  Both subjects: $bothSubjects\n');

  // Using inclusion-exclusion
  final eitherSubject = mathStudents + physicsStudents - bothSubjects;
  final neitherSubject = totalStudents - eitherSubject;
  final mathOnly = mathStudents - bothSubjects;
  final physicsOnly = physicsStudents - bothSubjects;

  print('Analysis:');
  print('  Either subject: $eitherSubject');
  print('  Neither subject: $neitherSubject');
  print('  Math only: $mathOnly');
  print('  Physics only: $physicsOnly\n');
}

/// Demonstrates resource management using multisets.
void demonstrateResourceManagement() {
  print('2. RESOURCE MANAGEMENT');
  print('-' * 50);

  // Office equipment inventory
  final office1 = MultiSet<String>.fromIterable([
    ...List.filled(20, 'laptop'),
    ...List.filled(15, 'monitor'),
    ...List.filled(10, 'keyboard'),
    ...List.filled(5, 'printer'),
  ]);

  final office2 = MultiSet<String>.fromIterable([
    ...List.filled(15, 'laptop'),
    ...List.filled(20, 'monitor'),
    ...List.filled(12, 'keyboard'),
    ...List.filled(3, 'printer'),
    ...List.filled(2, 'scanner'),
  ]);

  print('Office 1 Inventory: $office1');
  print('Office 2 Inventory: $office2\n');

  // Shareable resources (union - max)
  final shareable = office1.union(office2);
  print('Shareable Resources (can be shared):');
  print('  $shareable\n');

  // Total resources needed (sum)
  final total = office1.sum(office2);
  print('Total Resources (cannot share):');
  print('  $total\n');

  // Office 2 unique needs (difference)
  final office2Only = office2.difference(office1);
  print('Office 2 Unique Requirements:');
  print('  $office2Only\n');
}

/// Demonstrates database query simulation.
void demonstrateDatabaseQueries() {
  print('3. DATABASE QUERIES');
  print('-' * 50);

  // Simulating database records
  final allUsers = CustomSet<int>(List.generate(1000, (i) => i + 1));

  // Users who purchased product A
  final productA = CustomSet.fromPredicate(
    allUsers.elements,
    (x) => x % 7 == 0,
  );

  // Users who purchased product B
  final productB = CustomSet.fromPredicate(
    allUsers.elements,
    (x) => x % 11 == 0,
  );

  // Users who purchased product C
  final productC = CustomSet.fromPredicate(
    allUsers.elements,
    (x) => x % 13 == 0,
  );

  print('User Purchase Analysis (1000 users):');
  print('  Product A buyers: ${productA.cardinality}');
  print('  Product B buyers: ${productB.cardinality}');
  print('  Product C buyers: ${productC.cardinality}\n');

  // Users who bought A and B
  final aAndB = SetOperations.intersection(productA, productB);
  print('Bought A and B: ${aAndB.cardinality}');

  // Users who bought A or B
  final aOrB = SetOperations.union(productA, productB);
  print('Bought A or B: ${aOrB.cardinality}');

  // Users who bought A but not B
  final aNotB = SetOperations.difference(productA, productB);
  print('Bought A but not B: ${aNotB.cardinality}');

  // Users who bought exactly one of A or B
  final exactlyOne = SetOperations.symmetricDifference(productA, productB);
  print('Bought exactly one of A or B: ${exactlyOne.cardinality}\n');
}

/// Demonstrates access control using set operations.
void demonstrateAccessControl() {
  print('4. ACCESS CONTROL');
  print('-' * 50);

  // Define user groups
  final admins = CustomSet<String>(['alice', 'bob', 'charlie']);
  final managers = CustomSet<String>(['bob', 'david', 'eve']);
  final developers = CustomSet<String>(['charlie', 'eve', 'frank', 'grace']);

  print('User Groups:');
  print('  Admins: $admins');
  print('  Managers: $managers');
  print('  Developers: $developers\n');

  // Resource access definitions
  print('Resource Access Rules:');

  // Admin panel: admins only
  final adminPanel = admins;
  print('  Admin Panel: $adminPanel');

  // Project files: managers OR developers
  final projectFiles = SetOperations.union(managers, developers);
  print('  Project Files: $projectFiles');

  // Sensitive data: admins AND managers
  final sensitiveData = SetOperations.intersection(admins, managers);
  print('  Sensitive Data: $sensitiveData');

  // Dev tools: developers NOT managers
  final devTools = SetOperations.difference(developers, managers);
  print('  Dev Tools: $devTools');

  // Meeting room: everyone EXCEPT admins (admins have private room)
  final allUsers = SetOperations.union(
    SetOperations.union(admins, managers),
    developers,
  );
  final meetingRoom = SetOperations.difference(allUsers, admins);
  print('  Meeting Room: $meetingRoom\n');

  // Check specific user access
  final testUser = 'eve';
  print('Access Check for "$testUser":');
  print('  Can access Admin Panel: ${adminPanel.contains(testUser)}');
  print('  Can access Project Files: ${projectFiles.contains(testUser)}');
  print('  Can access Sensitive Data: ${sensitiveData.contains(testUser)}');
  print('  Can access Dev Tools: ${devTools.contains(testUser)}');
  print('  Can access Meeting Room: ${meetingRoom.contains(testUser)}');
}
