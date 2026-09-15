void main() {
  // Khai báo biến bằng các kiểu dữ liệu khác nhau.
  int age = 23;
  double height = 1.50;
  String name = 'Dieu';
  bool isStudent = true;

  // In các biến bằng cách sử dụng nội suy chuỗi.
  print('Name: $name');
  print('Age: $age');
  print('Height: $height m');
  print('Is student: $isStudent');

    // Nội suy chuỗi với một biểu thức.
  print('Next year, age will be ${age + 1}.');
  List<String> fruits = ['Apple', 'Banana', 'Orange'];

  // Access an element using its index.
  print('\nList of fruits: $fruits');
  print('First fruit: ${fruits[0]}');

  // Add a new element to the List.
  fruits.add('Mango');
  print('After add Mango: $fruits');

  // Remove an element from the List.
  fruits.remove('Banana');
  print('After remove Banana: $fruits');

  // ----- Set -----
  // A Set stores unique values.
  Set<int> numbers = {1, 2, 3, 3, 4};

  print('\nSet of numbers: $numbers');
  print('Set does not contain duplicate values.');

  // ----- Map -----
  Map<String, dynamic> student = {
    'name': 'Dieu',
    'age': 23,
    'isStudent': true,
  };

  // Access values in a Map using keys.
  print('\nStudent name: ${student['name']}');
  print('Student age: ${student['age']}');
  print('Is student: ${student['isStudent']}');

  // ----- Arithmetic operators -----
  int a = 10;
  int b = 3;

  print('\nArithmetic operators:');
  print('a + b = ${a + b}');
  print('a - b = ${a - b}');
  print('a * b = ${a * b}');
  print('a / b = ${a / b}');
  print('a % b = ${a % b}');

  // ----- Comparison operators -----
  print('\nComparison operators:');
  print('a > b: ${a > b}');
  print('a < b: ${a < b}');
  print('a == b: ${a == b}');
  print('a != b: ${a != b}');

  // ----- Logical operators -----
  bool x = true;
  bool y = false;

  print('\nLogical operators:');
  print('x && y: ${x && y}');
  print('x || y: ${x || y}');
  print('!x: ${!x}');

  // ----- Ternary operator -----
  String result = age >= 18 ? 'Adult' : 'Minor';

  print('\nTernary operator result: $result');
}