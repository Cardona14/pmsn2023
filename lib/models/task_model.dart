class TaskModel {
  
  int? idTask;
  int? idTeacher;
  int? stateTask;
  String? nameTask;
  String? descTask;
  String? dateExp;
  String? dateAlert;

  TaskModel({this.idTask,this.nameTask,this.descTask,this.stateTask, this.dateExp, this.dateAlert, this.idTeacher});
  factory TaskModel.fromMap(Map<String,dynamic> map){
    return TaskModel(
      idTask: map['idTask'],
      nameTask: map['nameTask'],
      descTask: map['descTask'],
      stateTask: map['stateTask'],
      dateExp: map['dateExp'],
      dateAlert: map['dateAlert'],
      idTeacher: map['idTeacher'],
    );
  }
}