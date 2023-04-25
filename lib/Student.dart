class Student {
  final String name;
  final String student_ID;
  final String studentMajor;
  final String studentResidence;
  final String studentEmail;
  final String studentMovie;
  final String studentFood;
  final String studentDateOfBirth;
  final String studentYearGroup;
  final String dateCreated;
  final String timeCreated;

  Student({required this.name, 
  required this.student_ID, 
  required this.studentMajor, 
  required this.studentResidence,
  required this.studentEmail,
  required this.studentMovie,
  required this.studentFood,
  required this.studentDateOfBirth,
  required this.studentYearGroup,
  required this.dateCreated,
  required this.timeCreated
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      student_ID: json['student_ID'],
      studentMajor: json['major'],
      studentResidence:json['residence'], 
      studentEmail:json['email'],
      studentFood:json['fav_food'],
      studentMovie: json['fav_movie'],
      studentDateOfBirth: json['dob'],
      studentYearGroup: json['year_group'],
      dateCreated:json["date_created"],
      timeCreated:json["time_created"]



    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'student_ID': student_ID, 
        'Fav_food': studentFood,
        'Fav_movie':studentMovie, 
        'dob':studentDateOfBirth,
        'email':studentEmail,
        'major': studentMajor,
        'residence': studentResidence,
        'year_group':studentYearGroup,
        'date_created':dateCreated,
        'time_created':timeCreated
      };
}
