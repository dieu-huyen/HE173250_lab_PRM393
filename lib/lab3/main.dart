import 'dart:async';
import 'dart:convert';

// Ex 1 - Product Model & Repository

// Product model
class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}

// Kho lưu trữ quản lý các sản phẩm
class ProductRepository {
  // Danh sách các sản phẩm hiện có
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 1200.0),
    Product(id: 2, name: 'Mouse', price: 25.5),
    Product(id: 3, name: 'Keyboard', price: 50.0),
  ];

  // broadcast() allows multiple listeners
  final StreamController<Product> _controller =
  StreamController<Product>.broadcast();

  // Trả về tất cả sản phẩm một cách bất đồng bộ
  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_products);
  }

  // Cập nhật thông tin sản phẩm mới theo thời gian thực
  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  // Thêm sản phẩm và gửi qua luồng
  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  // Đóng bộ điều khiển luồng
  void dispose() {
    _controller.close();
  }
}

Future<void> main() async {
  print('========== EXERCISE 1 ==========');

  final repository = ProductRepository();

  // Thông báo về các sản phẩm được thêm vào trong thời gian thực
  final subscription = repository.liveAdded().listen((product) {
    print('Live added: $product');
  });

  // Nhận tất cả sản phẩm bằng cách sử dụng Future
  final products = await repository.getAll();

  print('All products:');

  for (final product in products) {
    print(product);
  }

  // Add a new product
  repository.addProduct(
    Product(
      id: 4,
      name: 'Headphones',
      price: 80.0,
    ),
  );

  // Chờ để xử lý luồng
  await Future.delayed(const Duration(milliseconds: 100));

  // Clean up
  await subscription.cancel();
  repository.dispose();

  print('========== EXERCISE 1 COMPLETED ==========');
  await exercise2();
  await exercise3();
  await exercise4();
  await exercise5();
}

// Ex 2 - User Repository with JSON

// User model
class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  // Tạo đối tượng Người dùng từ dữ liệu JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}

// Kho lưu trữ chịu trách nhiệm lấy thông tin người dùng.
class UserRepository {

  // Mô phỏng việc lấy dữ liệu JSON từ API.
  Future<List<User>> fetchUsers() async {
    // Mô phỏng độ trễ mạng
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    // Phản hồi JSON giả mạo từ API
    const jsonString = '''
    [
      {
        "name": "Alice",
        "email": "alice@example.com"
      },
      {
        "name": "Bob",
        "email": "bob@example.com"
      },
      {
        "name": "Charlie",
        "email": "charlie@example.com"
      }
    ]
    ''';

    // Chuyển đổi chuỗi JSON thành đối tượng Dart.
    final List<dynamic> jsonList = jsonDecode(jsonString);

    // Chuyển đổi mỗi đối tượng JSON thành một đối tượng Người dùng.
    return jsonList
        .map(
          (json) => User.fromJson(
        json as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}

// Run Ex2
Future<void> exercise2() async {
  print('\n========== EXERCISE 2 ==========');

  final repository = UserRepository();

  // Lấy thông tin người dùng bất đồng bộ
  final users = await repository.fetchUsers();

  print('Users fetched from JSON:');

  for (final user in users) {
    print(user);
  }

  print('========== EXERCISE 2 COMPLETED ==========');
}

// EXERCISE 3 - Async + Microtask Debugging

Future<void> exercise3() async {
  print('\n========== EXERCISE 3 ==========');

  print('1. Start');

  Future(() {
    print('4. Future');
  });

  Future.microtask(() {
    print('3. Microtask');
  });

  Future.delayed(const Duration(milliseconds: 100), () {
    print('5. Future.delayed');
  });

  print('2. End');

  // Wait for asynchronous tasks to complete
  await Future.delayed(const Duration(milliseconds: 200));

  print('========== EXERCISE 3 COMPLETED ==========');
}


// EXERCISE 4 - Stream Transformation

Future<void> exercise4() async {
  print('\n========== EXERCISE 4 ==========');

  // Tạo một Stream chứa các số từ 1 đến 5
  final numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  // Biến đổi mỗi số bằng cách nhân với 2
  final doubledNumbers = numbers.map((number) => number * 2);

  print('Doubled numbers:');

  // Đọc từng phần tử trong Stream
  await for (final number in doubledNumbers) {
    print(number);
  }

  print('========== EXERCISE 4 COMPLETED ==========');
}


// EXERCISE 5 - Factory Constructor & Cache

class ProductCache {
  final int id;
  final String name;
  final double price;

  static final Map<int, ProductCache> _cache = {};

  ProductCache._({
    required this.id,
    required this.name,
    required this.price,
  });

  // Factory constructor dùng cache để tái sử dụng object.
  factory ProductCache({
    required int id,
    required String name,
    required double price,
  }) {
    if (_cache.containsKey(id)) {
      return _cache[id]!;
    }

    final product = ProductCache._(
      id: id,
      name: name,
      price: price,
    );

    _cache[id] = product;
    return product;
  }

  @override
  String toString() {
    return 'ProductCache(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}

Future<void> exercise5() async {
  print('\n========== EXERCISE 5 ==========');

  // Tạo ProductCache lần đầu với id = 1
  final product1 = ProductCache(
    id: 1,
    name: 'Laptop',
    price: 1200.0,
  );

  // Tạo lại với cùng id -> lấy object từ cache
  final product2 = ProductCache(
    id: 1,
    name: 'Laptop',
    price: 1200.0,
  );

  print('Product 1: $product1');
  print('Product 2: $product2');

  // Kiểm tra hai biến có cùng object hay không
  print('Same instance: ${identical(product1, product2)}');

  // id khác -> tạo object mới
  final product3 = ProductCache(
    id: 2,
    name: 'Mouse',
    price: 25.5,
  );

  print('Product 3: $product3');

  print('========== EXERCISE 5 COMPLETED ==========');
}
