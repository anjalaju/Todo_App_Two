import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descripcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0E1D3E),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task', style: themeData.textTheme.displayMedium),
              SizedBox(height: 5),
              Divider(height: 4, color: Colors.white, endIndent: 50),

              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is Mandatory';
                  }
                  return null;
                },
                controller: titlecontroller,
                decoration: InputDecoration(
                  // labelText: "Phone Number",
                  hintText: "Enter your title",
                  hintStyle: themeData.textTheme.displaySmall,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  //   borderSide: const BorderSide(color: Colors.red),
                  // ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 186, 10, 213),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                // maxLength: 10,
              ),

              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Descrip is Mandatory';
                  }
                  return null;
                },
                controller: descripcontroller,
                decoration: InputDecoration(
                  // labelText: "Phone Number",
                  hintText: "Enter your Descrip",
                  hintStyle: themeData.textTheme.displaySmall,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  //   borderSide: const BorderSide(color: Colors.red),
                  // ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 186, 10, 213),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                // maxLength: 10,
              ),

              SizedBox(height: 40),

              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    const Size(double.infinity, 50),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 8, 79, 136),
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                },
                child: const Text("Submit", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 

