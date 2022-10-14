class Student {
  final int id;
  final String name;
  final String about;
  final String email;
  final String password;

  const Student(
      {required this.id,
      required this.name,
      required this.about,
      required this.email,
      required this.password});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        name: json['name'],
        about: json['about'],
        email: json['email'],
        password: json['password']);
  }
}
