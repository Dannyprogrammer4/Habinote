
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:animated_fab_button_menu/animated_fab_button_menu.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';

int days = 31;
int CurrentDay = 1;
int CurrentMonth = 1;
int CurrentYear = 2026;
int year = 2026;
String type = "";
String emotion = "good";

List<JournalEntry> journals = [];
 Future<void> saveJournals() async {
  final prefs = await SharedPreferences.getInstance();

  final jsonList =
      journals.map((e) => e.toJson()).toList();

  await prefs.setString(
    "journals",
    jsonEncode(jsonList),
  );
}
Future<void> loadJournals() async {
  final prefs = await SharedPreferences.getInstance();

  final data = prefs.getString("journals");

  if (data == null) return;

  final decoded = jsonDecode(data);

  journals = (decoded as List)
      .map((e) => JournalEntry.fromJson(e))
      .toList();
}


void main() {
  Date();
  
  runApp(const MyApp());
  
}

 void Date() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
    if (date.month == 4 || date.month == 6 || date.month == 11 || date.month == 9) {
      days = 30;
    } else if (date.month == 2) {
      days = 28;
    } else {  
      days = 31;
    }
    CurrentMonth = date.month;
  CurrentDay = date.day;
  CurrentYear = date.year;
  
} 

class MyApp extends StatefulWidget {
  const MyApp({super.key}); 
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Habinote',
       localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
       ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: emotion == "bad"
              ? Colors.black
              : Colors.green,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black, // or white depending on your theme
          ),
        ),
      ),
      home: MyHomePage(
        title: 'Habinote',
        onEmotionChanged: (newEmotion) {
          setState(() {
            emotion = newEmotion;
          });
          
        },
        emotion: emotion,
      ),
      
      
    );
    
  }
  
}



class NoAnimationFABAnimator extends FloatingActionButtonAnimator {
  const NoAnimationFABAnimator();

  @override
  Offset getOffset({required Offset begin, required Offset end, required double progress}) {
    // Return the final position immediately without interpolation
    return end;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    // Return a constant value to stop rotation
    return const AlwaysStoppedAnimation(1.0);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    // Return a constant value to stop scaling
    return const AlwaysStoppedAnimation(1.0);
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onEmotionChanged,
    required this.emotion,
  });

  final String title;
  final Function(String) onEmotionChanged;
   final String emotion;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class PromptBlock extends BlockEmbed {
  PromptBlock({
    required String id,
    required String text,
  }) : super(
          'prompt',
          jsonEncode({
            'id': id,
            'text': text,
          }),
        );

  static PromptBlock create({
    required String id,
    required String text,
  }) {
    return PromptBlock(
      id: id,
      text: text,
    );
  }
}


class DocumentPage extends StatefulWidget {
 final String type;

  const DocumentPage({
    super.key,
    required this.type,
  });

  @override
  State<DocumentPage> createState() => _DocumentPageState();

  
}

class _DocumentPageState extends State<DocumentPage> {
  
  late QuillController controller;

  late Delta originalDelta;
  @override
void initState() {
  super.initState();

  // FIRST initialize controller
  
controller = QuillController.basic();
  // insert locked prompt block
  if (type == "Goals") {
    
      controller.document.insert(
    0,
    "\n\n\n\n\n\n ",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "When is the deadline?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Time-bound",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "How does it fit into your broader objectives?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Relevant",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text:
      "Evaluate the feasibility of your goal.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Attainable",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "How will you track your advancement?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: "Measurable",
    ),
    
  );
  controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: "What exactly do you want to achieve?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );

  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: "Specific",
    ),
    
  );
  
    
  controller.document.insert(
    0,
    "\n\n",

  );

  controller.document.insert(
    0,
    PromptBlock.create(
      id: "summary",
      text:
      "Identify a goal that is specific, measurable, achievable, relevant, and time-bound (SMART). Break it into actionable steps, each with its own deadline",
    ),
    
  );

  
  
  } 
  if (type == "Gratitude") {
     controller.document.insert(
    0,
    "\n\n\n\n\n\n ",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What is one thing I want to notice or appreciate more tomorrow?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Tomorrow's Appreciation Goal",
    ),
    
  );
 controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "How does focusing on gratitude make me feel right now?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Reflection",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What lesson, experience, or opportunity am I thankful for?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What I Learned Today",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n ",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What is something ordinary that made your life better today?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Something Small I Take for Granted",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Who made a positive impact on my day, and why?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Appreciate Someone",
    ),
    
  );
      controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What was the highlight of today?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Best Part of My Day",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "3.  ",
    ),
    
  );
   controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "2.  ",
    ),
    
  );
   controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "1.  ",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Write down three things that you are grateful for today.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "3 Things I am Grateful For",
    ),
    
  );
  controller.document.insert(
    0,
    "\n\n",

  );
    

  controller.document.insert(
    0,
    PromptBlock.create(
      id: "summary",
      text: 
      "Take a moment to focus on the positive aspects of your life. This journal helps you recognize things you appreciate, reflect on meaningful moments, and build a habit of gratitude.",
    ),
    
  );

  }
  if (type == "5-minute Journal") {
    controller.document.insert(
    0,
    "\n\n\n\n\n\n\n\n\n\n\n ",

  );
   
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What's one small change that could make tomorrow even better?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What Could I Improve Tomorrow",
    ),
    
  );
 
      controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Reflect on a lesson, insight, or experience from the day.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What Did I Learn Today?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
 controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
     controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "3.  ",
    ),
    
  );
   controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "2.  ",
    ),
    
  );
   controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "1.  ",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Write down three cool/amazing things that happened today.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "3 Amazing Things That Happened Today",
    ),
    
  );
    controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "3.  ",
    ),
    
  );
   controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "2.  ",
    ),
    
  );
   controller.document.insert(
    0,
    "\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "",
    ),
    
  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "other",
      text: 
      "1.  ",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Write down three things that you are grateful for today.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "3 Things I am Grateful For",
    ),
    
  );
  controller.document.insert(
    0,
    "\n\n",

  );

    controller.document.insert(
      0,
      PromptBlock.create(
        id: "summary",
        text: 
        "Spend a few minutes each day focusing on gratitude, intention, and reflection. This simple practice can help you end your days with perspective.",
      ),
      
    );
  

  
  
  }
  if (type == "Reset") {
     controller.document.insert(
    0,
    "\n\n\n\n\n\n\n\n\n\n\n\n ",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "How do you want to restart tomorrow?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Intention for Tomorrow",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Something simple to improve how I feel.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "One Small Thing I Can Do Next",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
  controller.document.insert(
    0,
    PromptBlock.create(
      id: "summary",
      text: 
      "“Instead of ________, I can think ________.”",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
     controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Try to shift perspective.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Reframe the Situation",
    ),
    
  );
      controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Let go of what you can’t change.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What Is NOT in My Control?",
    ),
    
  );
    
        controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "List what you can actually change or influence.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What Is in My Control?",
    ),
    
  );
        controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Choose or describe emotions.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What Am I Feeling Right Now?",
    ),
    
  );
    controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Briefly describe what made today difficult.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "What Happened?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n\n",

  );
    controller.document.insert(
      0,
      PromptBlock.create(
        id: "summary",
        text: 
        "This journal helps you process difficult days, release stress, and reset your mindset. The goal isn’t to fix everything—it’s to clear your thoughts and regain control for tomorrow.",
      ),
      
    );
  }
  if (type == "Idea Vault"){
      controller.document.insert(
    0,
    "\n\n\n\n\n\n\n\n\n ",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What's one small action you could take to explore this idea?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Next Step",
    ),
    
  );
     controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What challenge, need, or opportunity does this idea address?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Problem It Solves",
    ),
    
  );
    
    controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "What makes this idea exciting, useful, or unique?",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Why Is It Interesting?",
    ),
    
  );
      controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Describe the idea in a few sentences.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "The Idea",
    ),
    
  );
      controller.document.insert(
    0,
    "\n\n\n\n\n\n",

  );
    controller.document.insert(
    0,
    PromptBlock.create(
      id: "info",
      text: 
      "Give your idea a short, memorable name.",
    ),
    
  );
  controller.document.insert(
    0,
    "\n",

  );
   controller.document.insert(
    0,
    PromptBlock.create(
      id: "title",
      text: 
      "Idea Title",
    ),
    
  );
  controller.document.insert(
    0,
    "\n\n",

  );
    controller.document.insert(
      0,
      PromptBlock.create(
        id: "summary",
        text: 
        "Capture ideas before they disappear. Whether it's an app, business, invention, story, project, or random thought, this journal helps you organize and develop your ideas for the future.",
      ),
    );
  }
  

  
  
  // save original document AFTER insert
 



}

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Wrap(
                    alignment: WrapAlignment.start,
                    
              children: [
                Text(
                  "$type ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                Text(
                "$CurrentMonth-$CurrentDay-$CurrentYear",
                style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]
            ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // toolbar
            Row(
            children: [
            QuillSimpleToolbar(
              controller: controller,
            ),
            IconButton(
            icon: const Icon(Icons.save),
              onPressed: () async {
                final entry = JournalEntry(
                  id: DateTime.now()
                      .millisecondsSinceEpoch
                      .toString(),

                  title: widget.type,

                  type: widget.type,

                  date: DateTime.now().toString(),

                  content:
                      jsonEncode(controller.document.toDelta().toJson()),
                );

                journals.add(entry);

                await saveJournals();

                Navigator.pop(context);
              },
            ),
            ]
            ),

           Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 197, 215, 178),
                  width: 5,
                ),

                borderRadius: BorderRadius.circular(20),

                
              ),

              child: QuillEditor.basic(
                controller: controller,
                scrollController: ScrollController(),
                focusNode: FocusNode(),
                
                config: QuillEditorConfig(
                  
                  embedBuilders: [
                    PromptEmbedBuilder(),
                  ],
                ),
              ),
            ),
          )
          ],
        ),
      ),
    );

  }
}
class JournalCalendarPage extends StatefulWidget {
  const JournalCalendarPage({super.key});

  @override
  State<JournalCalendarPage> createState() =>
      _JournalCalendarPageState();
}

class _JournalCalendarPageState
    extends State<JournalCalendarPage> {

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  bool sameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  List<JournalEntry> journalsForDay(DateTime day) {
    return journals.where((journal) {
      final date = DateTime.parse(journal.date);

      return sameDay(date, day);
    }).toList();
  }
  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Journal Calendar"),
    ),

    body: Column(
      children: [
        TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2100),
          focusedDay: focusedDay,

          eventLoader: (day) {
            return journalsForDay(day);
          },
          headerStyle: const HeaderStyle(
             formatButtonVisible: false,
            titleCentered: true,

            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color:  emotion == "good" ? const Color.fromARGB(255, 204, 221, 185) : const Color.fromARGB(255, 205, 194, 198),
              shape: BoxShape.circle,
            ),

            todayDecoration: BoxDecoration(
              color:  emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
              shape: BoxShape.circle,
            ),
          ),


          onDaySelected: (selected, focused) {
            setState(() {
              
              selectedDay = selected;
              focusedDay = focused;
            });
          },
        ),

        Expanded(
          child: ListView(
            children: journalsForDay(
              selectedDay ?? DateTime.now(),
            ).map((journal) {
              return ListTile(
                      title: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 50,   
                          height: 115,// 👈 controls size
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Icon(
                                  
                                    Icons.volunteer_activism,
                                    size: 100,  
                                  
                                  

                                  ),
                              ),
                              const SizedBox(width: 50),
                              const Text(
                                "Gratitude",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              
                              
                              
                            ],
                          ),
                        ),
                      ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DocumentPage(
                        // existingJournal: journal,
                        type: journal.type,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
}
  
class JournalEntry {
  String id;
  String title;
  String type;
  String date;
  String content;

  JournalEntry({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "date": date,
        "content": content,
      };

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json["id"],
      title: json["title"],
      type: json["type"],
      date: json["date"],
      content: json["content"],
    );
  }
}
class PromptEmbedBuilder extends EmbedBuilder {

  @override
  String get key => 'prompt';

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {

    
    final data =
        jsonDecode(embedContext.node.value.data);
    
    final id = data['id'];
    final text = data['text'];
    
    TextStyle style = const TextStyle(
      fontSize: 16,
    );

    if (id == "title") {
      style = const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: "Times New Roman",
      );
    }

    if (id == "summary") {
      style = const TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.italic,
      );
    }
     if (id == "info") {
      style = const TextStyle(
        fontSize: 14,
        
      );
    }

    
    return AbsorbPointer(
     

      child: Text(
        text,
        style: style,
      ),
      );
    
    
  }
}

class _MyHomePageState extends State<MyHomePage> {
 
  late TextEditingController controller;
  String name = ""; 
  List<String> Years = <String>[ '${DateTime.now().year - 1}' , '${DateTime.now().year - 2}', '${DateTime.now().year - 3}', '${DateTime.now().year - 4}'];
  late String dropdownValue;
    int currentPageIndex = 0;
    List<Map<String, dynamic>> get habits {
      return habitHistory[currentMonthKey] ?? [];
    }
    late String currentMonthKey;
    Map<String, List<Map<String, dynamic>>> habitHistory = {};
    late final List<Widget> pages;

    @override
    void initState() {
      super.initState();
        
      dropdownValue = Years.first; 
      currentMonthKey = getMonthKey(DateTime.now());
      
      pages = [
        Center(child: Text("Home")),
        Journal(),
        Habits(),
        Center(child: Text("Settings")),
        
      ];
      
      loadHabits();
      
      
      
    }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }


  

  
Widget _buildPage() {
  switch (currentPageIndex) {
    case 0:
      return Journal();
    case 1:
      return Habits();
    case 2:
      return Center(child: Text("Meditation"));
    case 3:
      return Center(child: Text("Settings"));
    default:
      return Center(child: Text("Error"));
  }
}

double getCompletion(List<bool> habit) {
  int completed = habit.where((e) => e).length;
  return completed / (habit.length - 1); // value between 0.0 → 1.0
}
  



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(title: Text(widget.title)),
      body: _buildPage(),
       bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
         
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Habits',
          ),
           NavigationDestination(
            icon: Icon(Icons.self_improvement),
            label: 'Meditation',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      
      floatingActionButton: currentPageIndex == 1
    ? Row(
      
        mainAxisSize: MainAxisSize.min, // 🔴 important
        children: [
          Transform.translate(
            offset: Offset(0, 429),
            child: FloatingActionButton(
            
            onPressed: () async {
              final name = await openDialog();
              if (name == null || name.isEmpty) return;

              setState(() {
                if (!habitHistory.containsKey(currentMonthKey)) {
                  habitHistory[currentMonthKey] = [];
                }

                habitHistory[currentMonthKey]!.add({
                  "name": name,
                  "days": List<bool>.filled(CurrentDay + 1, false),
                });
                saveHabits();
              });
              
            },
            tooltip: 'Add a Habit',
            child: const Icon(Icons.add),
          ),
          ),
          
          const SizedBox(width: 20),
          //Delete habit
          FabMenu(
            fabBackgroundColor: widget.emotion == "good" ? const Color.fromARGB(255, 204, 235, 169) : const Color.fromARGB(255, 229, 216, 221),
            fabIcon: const Icon(Icons.delete, color: Colors.black),
            elevation: 2.0,
            closeMenuButton: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            overlayOpacity: 1,
            overlayColor: widget.emotion == "good" ? const Color.fromARGB(255, 204, 235, 169) : const Color.fromARGB(255, 229, 221, 224),
            
            children: [
              if (habits.isEmpty)
                MenuItem(
                  title: "No Habits Yet",
                  onTap: () {},
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                for (var habit in habits)
                  MenuItem(
                    title: habit["name"],
                    onTap: () {
                      setState(() {
                        habits.remove(habit);
                      });
                      saveHabits();
                      Navigator.pop(context);
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ],
          ),
          
        
        ]
    
          
    

        
      )
    : null,
      

        
        
      floatingActionButtonAnimator: const NoAnimationFABAnimator(),    
    );
    
    
    
  }
   Widget Habits() {
    DateTime now = DateTime.now();
    List<DateTime> monthsOfYear = List.generate(12, (i) {
      return DateTime(int.parse(dropdownValue), i + 1);
    });
  

  

  return SingleChildScrollView(
    child: Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const SizedBox(height: 60),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          
          child: Table(
            border: TableBorder.all(width: 1, color: Colors.black, borderRadius: BorderRadius.circular(20)),
            children: [
              TableRow(
                children: [
                  tableCell(text: "Day", Bold: true),
                  ...habits.map((h) => tableCell(text: h["name"], Bold: true)),
                ],
              ),

              for (int n = 1; n <= CurrentDay; n++)
                TableRow(
                  children: [
                    tableCell(text: n.toString(), Bold: true),

                    ...habits.map((habit) {
                      return habitCell(
                        filled: n < habit["days"].length
                        ? habit["days"][n]
                        : false,
                        onTap: () {
                          setState(() {
                            if (n < habit["days"].length) {
                              habit["days"][n] = !habit["days"][n];
                            }
                          });
                          saveHabits();
                        },
                        filledColor: Colors.green,
                      );
                    }),
                  ],
                ),
            ],
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Stats:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              habits.isEmpty
              ? const Text(
                  "No habits to display",
                  style: TextStyle(fontSize: 16),
                )
              :
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...habits.map((habit) {
                      return SizedBox(
                        width: 150,
                        child: fancyGauge(
                          getCompletion(habit["days"]),
                          habit["name"],
                        ),
                      );
                    }),
                  
                ],
              ),

              const SizedBox(height: 40), // prevents cutoff
              
            ],
            
          ),
          
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
              Text(
                'History: ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
                SizedBox(
                  width: 110, // 👈 control width here
                  child: DropdownButtonFormField<String>(
                    value: dropdownValue,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    items: Years.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                ),
                ],
              ),
              const SizedBox(height: 20),
              habits.isEmpty
              ? const Text(
                  "No habits to display",
                  style: TextStyle(fontSize: 16),
                )
               
              :

             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: monthsOfYear.map((date) {
                  final key = getMonthKey(date);
                  final monthHabits = habitHistory[key] ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getMonthNameFromDate(date)} ${date.year}",
                        style: const TextStyle(fontSize: 20),
                      ),

                      monthHabits.isEmpty
                          ? const Text("No habits this month")
                          : Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: monthHabits.map((habit) {
                                return SizedBox(
                                  width: 150,
                                  child: fancyGauge(
                                    getCompletion(habit["days"]),
                                    habit["name"],
                                  ),
                                );
                              }).toList(),
                            ),

                      const SizedBox(height: 30),
                    ],
                  );
                }).toList(),
              ), 
              const SizedBox(height: 30),
            ],
          ),
        ),
        
          
            
      ] 
    )
        
  );
  
}

  Widget Journal() {
    
    return SingleChildScrollView(
      child: 
    Align (
      alignment: Alignment.centerLeft,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Good Afternoon!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'How was your day?',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          TextButton.icon(
            onPressed: () => widget.onEmotionChanged("good"),
            icon: const Text("😊", style: TextStyle(fontSize: 24)),
            label: const Text("Good"),
          ),

          TextButton.icon(
            onPressed: () => widget.onEmotionChanged("bad"),
            icon: const Text("😞", style: TextStyle(fontSize: 24)),
            label: const Text("Bad"),
          ),

          const SizedBox(height: 20),
           const Text(
            'Daily Entry',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose a template from below',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
           Wrap(
                alignment: WrapAlignment.start,
                 runSpacing: 20,  
                
          children: [
          InkWell(
              onTap: () {
                type = "Goals";
                 Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const DocumentPage(type: "Goals"),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 150,   
                height: 145,// 👈 controls size
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Goals",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        size: 100,

                        ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                type = "Gratitude";
                 Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const DocumentPage(type: "Gratitude"),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 150,   
                height: 145,// 👈 controls size
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Gratitude",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.volunteer_activism,
                        size: 100,

                        ),
                    ),
                  ],
                ),
              ),
            ),
            
             InkWell(
              onTap: () {
                type = "5-minute Journal";
                 Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const DocumentPage(type: "5-minute Journal"),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 150,   
                height: 145,// 👈 controls size
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "5-minute Journal",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.timer,
                        size: 100,

                        ),
                    ),
                  ],
                ),
              ),
            ),
            
            
            const SizedBox(width: 10),
             InkWell(
              onTap: () {
                type = "Reset";
                 Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const DocumentPage(type: "Reset"),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 150,   
                height: 145,// 👈 controls size
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Reset",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.refresh,
                        size: 100,

                        ),
                    ),
                  ],
                ),
              ),
            ),

             InkWell(
              onTap: () {
                type = "Idea Vault";
                 Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const DocumentPage(type: "Idea Vault"),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 150,   
                height: 145,// 👈 controls size
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Idea Vault",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.lightbulb,
                        size: 100,

                        ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
             InkWell(
              onTap: () {
                type = "Blank";
                 Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const DocumentPage(type: "Blank"),
                  ),
                );

              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 150,   
                height: 145,// 👈 controls size
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.emotion == "good" ? const Color.fromARGB(255, 219, 237, 198) : const Color.fromARGB(255, 229, 216, 221),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Blank",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.insert_drive_file,
                        size: 100,

                        ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
          ),
          const SizedBox(height: 20),
           const Text(
            'History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Use calendar below to find past journal entries.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20), 
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_month),
            label: const Text("Journal Calendar"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JournalCalendarPage(),
                ),
              );
            },
          ), 

          
        ],
      )
      )
    )
    );
    
  }
 
    Future<void> saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(habitHistory);
    await prefs.setString('habitHistory', encoded);
  }
  Future<void> loadHabits() async {
  final prefs = await SharedPreferences.getInstance();
  final String? data = prefs.getString('habitHistory');

  if (data != null) {
    final decoded = jsonDecode(data) as Map<String, dynamic>;

    setState(() {
      habitHistory = decoded.map((key, value) {
        return MapEntry(
          key,
          (value as List).map((habit) {
            return {
              "name": habit["name"],
              "days": List<bool>.from(habit["days"]),
            };
          }).toList(),
        );
      });
    });
  }
}
  Future<String?> openDialog() => showDialog<String>(
          context: context, 
          builder:(context) => AlertDialog(
            title: Text("New Habit"),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: "Enter a new Habit"),
              controller: controller, 
              onSubmitted: (_) => submit(),
            ),
            actions: [
              TextButton(
                child: Text("SUBMIT"),
                onPressed: () {
                  submit();
                }
              ),
            ]
          ),
      );
      void submit() {
        Navigator.of(context).pop(controller.text);

        controller.clear();
      }
  
}


  
  
 

  Widget tableCell({
    required String text,
    Color? color,
    bool Bold = false, 
  }) {
    return Container(
      height: 40,
      width: 40, // keeps the cell square
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
          fontWeight: Bold ? FontWeight.w800 : FontWeight.normal,
          ),
        ),
        ),
      ),
    );
  }

  Widget habitCell({
    required bool filled,
    required VoidCallback onTap,
    Color filledColor = Colors.red,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? filledColor : Colors.transparent,
        ),
      ),
    );
}

Widget fancyGauge(double percent, String habit) {
  return SizedBox(
    height: 300,
    child: SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 100,
          majorTickStyle: MajorTickStyle(length: 0),
          minorTickStyle: MinorTickStyle(length: 0),

          showLabels: false,

  
          axisLineStyle: AxisLineStyle(
            thickness: 10,
          ),
          pointers: [
            RangePointer(
              value: percent * 100,

              width: 10,
              color: Colors.green,
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: Center( 
              child: Text(
                "$habit \n${(percent * 100).toInt()}%",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              ),
              positionFactor: 0,
              
            ),
          ],
        ),
      ],
    ),
  );
}





Color lighten(Color color, double amount) {
  return Color.lerp(color, Colors.white, amount)!;
}

  class ChartData {
        ChartData(this.x, this.y);
        final int x;
        final double y;
    }


  String getMonthNameFromDate(DateTime date) {
  const months = [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
  ];

  return months[date.month - 1];
}

  String getMonthKey(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}";
}