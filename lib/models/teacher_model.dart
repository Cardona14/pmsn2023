class TaskModel {
  
  int? idProf;
  int? idCareer;
  String? nameProf;
  String? emailProf;

  TaskModel({this.idProf,this.nameProf, this.emailProf, this.idCareer});
  factory TaskModel.fromMap(Map<String,dynamic> map){
    return TaskModel(
      idProf: map['idProf'],
      nameProf: map['nameProf'],
      idCareer: map['idCareer'],
      emailProf: map['email']
    );
  }
}