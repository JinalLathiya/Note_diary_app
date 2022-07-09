import 'package:flutter/material.dart';
import 'pdf.dart';

bool isDark = false;

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context) => const Homepage(),
      },
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control.add(TextEditingController());
    show.add(n(Time: Time[0], controller: control[0]));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()  async {
              for(int i=0;i<show.length;i++)
              {
                datas.add(dairy(time: Time[datas.length], data: control[datas.length].text));
              }
              final pdffile =
              await CreateResume.generateCenteredText("Sample Text");
              CreateResume.openFile(pdffile);
            },
            icon: const Icon(Icons.download),
          ),
        ],
        title: const Text("Dairy"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: show.map((e) => e).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(show.length<12){
              control.add(TextEditingController());
              show.add(n(Time: Time[show.length], controller: control[show.length]));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
List<Widget> show = <Widget>[];
List<String> Time = <String>[
  "8:00AM",
  "9:00AM",
  "10:00AM",
  "11:00AM",
  "12:00AM",
  "1:00PM",
  "2:00PM",
  "3:00PM",
  "4:00PM",
  "5:00PM",
  "6:00PM",
  "7:00PM",
];
List<TextEditingController> control = <TextEditingController>[];
Widget n({required String Time, required TextEditingController controller}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(Time),
      const SizedBox(height: 5,),
      TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Enter Notes",
          label: Text("Notes"),
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );
}

class dairy{
  String data;
  String time;

  dairy({
    required this.time,
    required this.data,
  });
}

List<dairy> datas = <dairy>[];