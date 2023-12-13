class SignUpModel {
  final String name;
  final String email;
  final String phonenumber;
  final String password;
  SignUpModel({
    required this.name,
    required this.email,
    required this.phonenumber,
    required this.password
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phonenumber;
    data["password"] = this.password;
    return data;
  }
}