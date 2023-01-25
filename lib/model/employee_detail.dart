
class Employee {
  String id;
  String fullName;
  String phoneNumber,imageurl;
  String email;

  double salary;
  int years;
  bool isActive;
  bool showButtons;
  Employee({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.salary,
   required this.years,
    required this.imageurl,
    this.isActive=false,
    this.showButtons =false
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "full_name": fullName,
    "phone_number": phoneNumber,
    "email": email,

    "salary": salary,
    "years":years,
    "isActive":isActive,
    "image":imageurl,
    "showButtons":showButtons
  };

}