// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'assignment_data.dart';
import 'package:flutter/material.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments', style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,),
        backgroundColor:  Color.fromARGB(230, 11,15,92),
        centerTitle: true,
      ),
      body:Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: assignment.length,
                itemBuilder: (context, int index){
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 100
                              ,
                              height: 30.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                  colors: [Color.fromARGB(230, 11,15,92), Color.fromARGB(230, 54, 63, 216)],
                                  begin: const FractionalOffset(0, 0),
                                  end: const FractionalOffset(0.5, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
      borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(
                                  child: Text(
                                    assignment[index].subjectName,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(230, 247, 247, 247)
                                    ),
            
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                                width: 10,
                              ),
                              Text(assignment[index].topicName,
                              style: TextStyle(
                                color: Color.fromARGB(230, 11,15,92),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                              
                              ), 
                              SizedBox(
                                height: 8,
                                width: 10,
                              ),
                              AssignmentDetailRow(
                                title : 'Assign Date', 
                                statusValue: assignment[index].assignDate,
                              ),
                              SizedBox(
                                height: 8,
                                width: 10,
                              ),
                              AssignmentDetailRow(
                                title : 'Last Date', 
                                statusValue: assignment[index].lastDate
                                ),
                                SizedBox(
                                height: 8,
                                width: 10,
                              ),
                              AssignmentDetailRow(
                                title: 'Status', 
                                statusValue: assignment[index].status
                                ),
                                SizedBox(
                                height: 8,
                                width: 10,
                              ),
                              if(assignment[index].status == 'Pending')
                              AssignmentButton(title: 'To be submitted'
                              , onPressed: (){

                              })
                              




                              
                              
                              

                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            )
            )
        ],
      ),
    );
  }
}

class AssignmentDetailRow extends StatelessWidget {
  const AssignmentDetailRow({
    Key? key,
    required this.title,
    required this.statusValue,
  }) : super(key: key);
final String title;
final String statusValue;

  @override
  Widget build(BuildContext context) {
    return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
                                children: [
                                  Text(title,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                  ),
                                  Text(title,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  )
                                ],
                                
                              );
  }
}

class AssignmentButton extends StatelessWidget {
  const AssignmentButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
final String title;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
child: Container(
  width: double.infinity,
  height: 40,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromARGB(230, 11,15,92), Color.fromARGB(230, 54, 63, 216)],
      begin: const FractionalOffset(0, 0),
      end: const FractionalOffset(0.5, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      ),
      borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(
                                  child: Text(
                                    title,
                                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  
                                  ),
                                ),
    
  ),
  
);


    
  }
}
