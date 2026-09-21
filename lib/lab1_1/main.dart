// Lab 1.1: Thiết kế hệ thống phương tiện giao thông
// OOP & Kế thừa cơ bản

// TODO 1: Định nghĩa lớp cha Vehicle
class Vehicle {
  String brand;
  int year;

  // Default Constructor
  Vehicle(this.brand, this.year);

  // Hàm khởi động phương tiện
  void startEngine() {
    print('Khởi động phương tiện...');
  }
}

// TODO 2: Định nghĩa lớp Car kế thừa từ Vehicle
class Car extends Vehicle {
  // Thuộc tính riêng của Car
  bool isElectric;

  // TODO 3: Constructor mặc định cho Car
  // Sử dụng super để truyền brand và year lên lớp Vehicle
  Car(String brand, int year, this.isElectric)
      : super(brand, year);

  // Named Constructor
  // Tự động gán brand = "Tesla"
  // Tự động gán isElectric = true
  Car.tesla(int year)
      : isElectric = true,
        super('Tesla', year);

  // TODO 4: Ghi đè hàm startEngine()
  @override
  void startEngine() {
    if (isElectric) {
      print('$brand ($year): Khởi động động cơ điện...');
    } else {
      print('$brand ($year): Khởi động động cơ xăng...');
    }
  }
}

// TODO 5 + TODO 6
void main() {
  // Khởi tạo một Car bình thường
  Car car1 = Car('Toyota', 2024, false);

  // Gọi hàm startEngine()
  car1.startEngine();

  // Khởi tạo Car bằng Named Constructor
  Car car2 = Car.tesla(2025);

  // Gọi hàm startEngine()
  car2.startEngine();
}