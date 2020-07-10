void main() {
  preformTask();
}

void preformTask() async {
  task1();
  String task2Result = await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration d = Duration(seconds: 5);
  String result;
  //sleep(d);
  await Future.delayed(d, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  print('results after awaiting');
  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2Data');
}
