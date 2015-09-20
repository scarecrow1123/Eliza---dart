import '../lib/eliza.dart';
import 'dart:io';

void commandInterface() {
  stdout.write("Therapist\n--------");
  stdout.write("Task to the program by typing in plain English, using normal upper-");
  stdout.writeln("and lower-case letters and punctuation. Enter 'quit' when done.");
  stdout.writeln("\n\nHello. How are you feeling today?");
  var s = "";
  var therapist = new Eliza();
  while (s != "quit") {
    s = stdin.readLineSync();
    stdout.writeln(therapist.respond(s));
  }
}

void main() {
  commandInterface();
}