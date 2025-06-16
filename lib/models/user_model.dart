class User {
  int? id;
  String? name;
  String? email;
  String? password;
  DateTime? dob;
  String? gender;
  String? phone;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.dob,
    this.gender,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'dob': dob!.toIso8601String(),
      'gender': gender,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      dob: DateTime.parse(map['dob']),
      gender: map['gender'],
      phone: map['phone'],
    );
  }
}
