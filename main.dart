import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complete Web Form',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CompleteWebForm(),
    );
  }
}

class CompleteWebForm extends StatefulWidget {
  const CompleteWebForm({super.key});

  @override
  State<CompleteWebForm> createState() => _CompleteWebFormState();
}

class _CompleteWebFormState extends State<CompleteWebForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();

  // Dropdowns
  String? gender;
  String? country;

  // Date & Time
  DateTime? birthDate;
  TimeOfDay? preferredTime;

  // Sliders
  double satisfaction = 3;
  double progress = 50;
  RangeValues budgetRange = const RangeValues(20, 80);

  // Switch / Checkbox
  bool subscribe = false;
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Web Form")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const Text("Personal Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                // Full Name
                TextFormField(
                  controller: nameController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: "Full Name *",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? "Please enter your name" : null,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: emailController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: "Email Address *",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? "Please enter your email" : null,
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: passwordController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: "Password *",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? "Please enter a password" : null,
                ),
                const SizedBox(height: 16),

                // Phone
                TextFormField(
                  controller: phoneController,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 16),

                // Age
                TextFormField(
                  controller: ageController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.cake),
                  ),
                ),
                const SizedBox(height: 30),

                // Demographics
                const Text("Demographics",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                // Gender
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: const InputDecoration(
                    labelText: "Select your gender",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people),
                  ),
                  items: ["Male", "Female", "Other"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => gender = v),
                ),
                const SizedBox(height: 16),

                // Country
                DropdownButtonFormField<String>(
                  value: country,
                  decoration: const InputDecoration(
                    labelText: "Select your country",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.flag),
                  ),
                  items: ["Saudi Arabia", "UAE", "Egypt", "Jordan", "USA"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => country = v),
                ),
                const SizedBox(height: 30),

                // Date & Time
                const Text("Date & Time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) setState(() => birthDate = date);
                  },
                  child: Text(birthDate == null
                      ? "Birth Date"
                      : "Birth Date: ${birthDate!.toLocal()}".split(' ')[0]),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) setState(() => preferredTime = time);
                  },
                  child: Text(preferredTime == null
                      ? "Preferred Time"
                      : "Preferred Time: ${preferredTime!.format(context)}"),
                ),
                const SizedBox(height: 30),

                // Ratings & Preferences
                const Text("Ratings & Preferences",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                Text("Satisfaction Rating: ${satisfaction.toStringAsFixed(1)}"),
                Slider(
                  value: satisfaction,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  onChanged: (v) => setState(() => satisfaction = v),
                ),
                const SizedBox(height: 16),

                Text("Progress Level: ${progress.toInt()}%"),
                Slider(
                  value: progress,
                  min: 0,
                  max: 100,
                  onChanged: (v) => setState(() => progress = v),
                ),
                const SizedBox(height: 16),

                Text(
                    "Budget Range: \$${budgetRange.start.toInt()} - \$${budgetRange.end.toInt()}"),
                RangeSlider(
                  values: budgetRange,
                  min: 0,
                  max: 200,
                  onChanged: (v) => setState(() => budgetRange = v),
                ),
                const SizedBox(height: 30),

                // Preferences
                const Text("Preferences",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                SwitchListTile(
                  title: const Text("Subscribe to Newsletter"),
                  subtitle: const Text("Receive updates and promotions"),
                  value: subscribe,
                  onChanged: (v) => setState(() => subscribe = v),
                ),

                CheckboxListTile(
                  title: const Text("I agree to the Terms and Conditions"),
                  value: agree,
                  onChanged: (v) => setState(() => agree = v ?? false),
                ),
                const SizedBox(height: 30),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && agree) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Form Submitted!")),
                      );
                      print("=== FORM DATA ===");
                      print("Name: ${nameController.text}");
                      print("Email: ${emailController.text}");
                      print("Password: ${passwordController.text}");
                      print("Phone: ${phoneController.text}");
                      print("Age: ${ageController.text}");
                      print("Gender: $gender");
                      print("Country: $country");
                      print("Birth Date: $birthDate");
                      print("Preferred Time: $preferredTime");
                      print("Satisfaction: $satisfaction");
                      print("Progress: $progress");
                      print("Budget: $budgetRange");
                      print("Subscribe: $subscribe");
                      print("Agreed: $agree");
                    } else if (!agree) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("You must agree to the terms!")),
                      );
                    }
                  },
                  child: const Text("Submit Form"),
                ),

                // Reset Button
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    setState(() {
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      phoneController.clear();
                      ageController.clear();
                      gender = null;
                      country = null;
                      birthDate = null;
                      preferredTime = null;
                      satisfaction = 3;
                      progress = 50;
                      budgetRange = const RangeValues(20, 80);
                      subscribe = false;
                      agree = false;
                    });
                  },
                  child: const Text("Reset Form"),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
