class AssignmentData {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String lastDate;
  final String status;

  AssignmentData(this.subjectName, this.topicName, this.assignDate,
  this.lastDate, this.status);

}

List<AssignmentData> assignment=[
  AssignmentData("DSLD", "DC Circuits", "1st Jan'24", "7th Jan'24", "Pending"),
  AssignmentData("DAA", "Dijkstra Algorithm", "1st Jan'24", "7th Jan'24", "Pending"),
  AssignmentData("OR", "LPP", "8th Feb'24", "8th Feb'24", "Pending")
];