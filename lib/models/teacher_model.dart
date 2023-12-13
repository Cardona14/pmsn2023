class TeacherModel {
  
  int? idTeacher;
  int? idCareer;
  String? nameTeacher;
  String? emailTeacher;

  TeacherModel({this.idTeacher,this.nameTeacher, this.emailTeacher, this.idCareer});
  factory TeacherModel.fromMap(Map<String,dynamic> map){
    return TeacherModel(
      idTeacher: map['idTeacher'],
      nameTeacher: map['nameTeacher'],
      idCareer: map['idCareer'],
      emailTeacher: map['emailTeacher']
    );
  }
}