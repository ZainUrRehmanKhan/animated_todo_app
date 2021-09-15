enum TaskType {
  General,
  Work,
  Personal,
}

//--------------------- find name of task type ----------------------//
String findNameFromTaskType(TaskType taskType){
  if(taskType == TaskType.General)
    return 'General';
  if(taskType == TaskType.Work)
    return 'Work';
  if(taskType == TaskType.Personal)
    return 'Personal';

  return '';
}

TaskType findTaskType(int index){
  if(index == 0)
    return TaskType.Personal;
  else if(index == 1)
    return TaskType.Work;
  else if(index == 2)
    return TaskType.General;

  return TaskType.Personal;
}