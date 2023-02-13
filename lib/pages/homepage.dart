import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var boxData = Hive.box('studentData');

  writeData() async {
    await boxData.put(boxData.length + 1, [
      nameController.text,
      ageController.text,
      rollController.text,
    ]);
    nameController.text = "";
    ageController.text = "";
    rollController.text = "";
  }

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var rollController = TextEditingController();

  List<Widget> studentCards() {
    List<Widget> studentList = [];
    for (var i = 1; i < boxData.length + 1; i++) {
      studentList.add(
        Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 60,
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.7),
          ),
          child: Column(
            children: [
              Text(
                "Student Name: ${boxData.get(i)[0]}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Student Age: ${boxData.get(i)[1]}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Student Rollno: ${boxData.get(i)[2]}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return studentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              const Text("Add student",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter the student name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    hintText: "Enter the student Age",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: rollController,
                  decoration: const InputDecoration(
                    hintText: "Enter the student roll number",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  writeData();
                }),
                child: const Text("Add student"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    runSpacing: 40,
                    children: studentCards(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
