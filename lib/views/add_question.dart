import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
   final String quizId;
  AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formkey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;

  DatabaseService databaseService=new DatabaseService();
   uploadQuestionData() async {
     if(_formkey.currentState.validate()){
       setState(() {
         _isLoading=true;
       });
       Map<String,String> mapQuestion={
         "question":question,
         "option1": option1,
         "option2": option2,
         "option3": option3,
         "option4": option4
       };
       await databaseService.addQuestionData(mapQuestion, widget.quizId)
       .then((value){
         setState(() {
           _isLoading=false;
         });
       });
     }
     
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body:_isLoading? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ): Form(
           key: _formkey,
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter question" : null,
                decoration: InputDecoration(hintText: "Question"),
                onChanged: (val) {
                  question = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Option 1" : null,
                decoration:
                    InputDecoration(hintText: "Option 1 (Correct answer)"),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Option 2" : null,
                decoration: InputDecoration(hintText: "Option 2"),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Option 3" : null,
                decoration: InputDecoration(hintText: "Option 3"),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Option 4" : null,
                decoration: InputDecoration(hintText: "Option 4"),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                     Navigator.pop(context);
                    },
                        child: blueButton(
                        context: context,
                        label: "Submit",
                        buttonWidth: MediaQuery.of(context).size.width / 2 - 36),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadQuestionData();
                      
                    },
                    child: blueButton(
                        context: context,
                        label: "Add question",
                        buttonWidth: MediaQuery.of(context).size.width / 2 - 36),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
