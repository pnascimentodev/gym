import 'package:flutter/widgets.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
// Lista de Exercicios

  List<Workout> workoutList = [
    //defult workout
    Workout(
      name: "Costas/Bíceps",
      exercises: [
        Exercise(
          name: "Puxada Alta",
          weight: "10",
          reps: "12",
          sets: "4",
        ),
      ],
    ),
  ];

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  void addWorkout(
    String name,
  ) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );

    notifyListeners();
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
