class User {
int id;
String name;

// TODO 1: email có thể nhận giá trị null
String? email;

User({
required this.id,
required this.name,
this.email,
});

// TODO 2: Factory constructor
factory User.fromJson(Map<String, dynamic> json) {
return User(
id: json['id'],
name: json['name'] ?? "Khách",
email: json['email'],
);
}

void showProfile() {
// TODO 3: Nếu email null thì hiển thị "Chưa cập nhật"
print(
"ID: $id | Tên: $name | Email: ${email ?? "Chưa cập nhật"}",
);
}
}

void main() {
Map<String, dynamic> rawData1 = {
"id": 1,
"name": "Nam",
"email": "nam@fpt.edu.vn"
};

Map<String, dynamic> rawData2 = {
"id": 2,
"name": null,
"email": null
};

// TODO 4: Khởi tạo User từ JSON
User user1 = User.fromJson(rawData1);
User user2 = User.fromJson(rawData2);

user1.showProfile();
user2.showProfile();
}

