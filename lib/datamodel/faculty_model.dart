class Faculty {
  final String firstname;
  final String lastname;
  final String email;
  final String title;
  final String phone;
  final String office;
  final String image;

  Faculty({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.title,
    required this.phone,
    required this.office,
    required this.image,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      title: json['title'],
      phone: json['phone'],
      office: json['office'],
      image: json['image'],
    );
  }
}
