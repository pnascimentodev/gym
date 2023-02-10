import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym/data/workout_data.dart';
import 'package:gym/pages/workout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    MainAxisAlignment.center;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Inserir novo treino"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          //cancel button

          MaterialButton(
            onPressed: cancel,
            child: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          // ok button
          MaterialButton(
            onPressed: save,
            child: Icon(
              Icons.verified,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // workout page

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPage(
            workoutName: workoutName,
          ),
        ));
  }

  //cancel
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  //save
  void save() {
    // name from text controller

    String newWorkoutName = newWorkoutNameController.text;

    // workoutdata list

    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leadingWidth: 500,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.event_note_sharp,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(value.getWorkoutList()[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () =>
                        goToWorkoutPage(value.getWorkoutList()[index].name),
                  ),
                )),
      ),
    );
  }
}
