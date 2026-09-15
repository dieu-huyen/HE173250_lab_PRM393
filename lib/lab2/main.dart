// EX1: Basic Syntax & Data Types

void main() async {
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

  // EX2: Collections & Operators

  // ----- List -----
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

  // EX3: Control Flow & Functions

  // ----- If / Else -----
  int score = 85;

  if (score >= 80) {
    print('\nIf/Else: Excellent');
  } else if (score >= 50) {
    print('\nIf/Else: Pass');
  } else {
    print('\nIf/Else: Fail');
  }

  // ----- Switch -----
  String grade = 'A';

  switch (grade) {
    case 'A':
      print('Switch: Excellent');
      break;
    case 'B':
      print('Switch: Good');
      break;
    case 'C':
      print('Switch: Average');
      break;
    default:
      print('Switch: Need improvement');
  }

  // ----- For loop -----
  print('\nFor loop:');

  for (int i = 1; i <= 5; i++) {
    print('Number: $i');
  }

  // ----- For-in loop -----
  print('\nFor-in loop:');

  for (String fruit in fruits) {
    print('Fruit: $fruit');
  }

  // ----- forEach -----
  print('\nforEach:');

  fruits.forEach((fruit) {
    print('Fruit: $fruit');
  });

  // ----- Normal function -----
  int addNumbers(int a, int b) {
    return a + b;
  }

  int sum = addNumbers(10, 20);
  print('\nNormal function: 10 + 20 = $sum');

  // ----- Arrow function -----
  int multiplyNumbers(int a, int b) => a * b;

  int product = multiplyNumbers(5, 4);
  print('Arrow function: 5 * 4 = $product');

  // EX4: Intro to OOP

  // Create a Car object using the named constructor.
  Car car = Car(
    brand: 'Toyota',
    model: 'Camry',
  );

  print('\n--- Exercise 4: OOP ---');
  print('Car brand: ${car.brand}');
  print('Car model: ${car.model}');
  car.drive();

  // Create an ElectricCar object.
  ElectricCar electricCar = ElectricCar(
    brand: 'Tesla',
    model: 'Model 3',
    batteryCapacity: 75,
  );

  print('Electric car brand: ${electricCar.brand}');
  print('Electric car model: ${electricCar.model}');
  print('Battery capacity: ${electricCar.batteryCapacity} kWh');
  electricCar.drive();

  // EX5: Async, Future, Null Safety & Streams

  print('\n--- Exercise 5: Async, Future, Null Safety & Streams ---');

  // Async/Await with Future.delayed().
  String message = await getMessage();
  print('Async/Await: $message');

  // ----- Null Safety -----
  String? nullableName;

  print('Nullable value: $nullableName');
  print('Using ?? : ${nullableName ?? 'Unknown'}');

  nullableName = 'Dieu';

  print('After assigning value: $nullableName');

  // ! means the value is not null.
  print('Using ! : ${nullableName!}');

  // ----- Stream -----
  print('\nStream values:');

  Stream<int> numberStream = countNumbers();

  await for (int number in numberStream) {
    print('Stream value: $number');
  }
}

// EX5: Future function

Future<String> getMessage() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Hello from Future!';
}

// EX5: Stream function

Stream<int> countNumbers() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i;
  }
}

// EX4: Car Class

class Car {
  String brand;
  String model;

  // Named constructor.
  Car({
    required this.brand,
    required this.model,
  });

  // Method.
  void drive() {
    print('Car $brand $model is driving.');
  }
}

// EX4: ElectricCar Class

class ElectricCar extends Car {
  int batteryCapacity;

  // Named constructor.
  ElectricCar({
    required String brand,
    required String model,
    required this.batteryCapacity,
  }) : super(
    brand: brand,
    model: model,
  );

  // Override the drive() method.
  @override
  void drive() {
    print(
      'Electric car $brand $model is driving with '
          '$batteryCapacity kWh battery.',
    );
  }
}