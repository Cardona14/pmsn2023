class TaskModel {
  
  int? idTask;
  int? idProf;
  String? nameTask;
  String? dscTask;
  String? statusTask;
  DateTime? dateExp;
  DateTime? dateRem;

  TaskModel({this.idTask,this.nameTask,this.dscTask,this.statusTask, this.dateExp, this.dateRem, this.idProf});
  factory TaskModel.fromMap(Map<String,dynamic> map){
    return TaskModel(
      idTask: map['idTask'],
      nameTask: map['nameTask'],
      dscTask: map['dscTask'],
      statusTask: map['sttTask'],
      dateExp: map['sttTask'],
      dateRem: map['sttTask'],
      idProf: map['sttTask'],
    );
  }
}