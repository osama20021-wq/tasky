// ignore_for_file: constant_identifier_names

enum TaskItemActionEnum {
  delete(name: "Delete"),
  Done(name: "Done | UnDone"),
  edit(name: "Edit");

  final String name;

  const TaskItemActionEnum({required this.name});
}
