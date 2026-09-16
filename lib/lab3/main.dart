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