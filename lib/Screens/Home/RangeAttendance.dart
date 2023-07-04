import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RangeAttendance extends StatefulWidget {
  const RangeAttendance({Key? key}) : super(key: key);

  @override
  State<RangeAttendance> createState() => _RangeAttendanceState();
}

class _RangeAttendanceState extends State<RangeAttendance> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController FromDateController = TextEditingController();
  final TextEditingController ToDateController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  final TextEditingController batchController = TextEditingController();

  final subList = [
    "Operating Systems",
    "Analysis Of Algorithm",
    "Mathematics 4",
    "Formal Language and Automata Theory",
    "Universal Human Values",
    "Computer Networks",
  ];

  final batchList = [
    "A",
    "B",
    "C",
    "A1",
    "A2",
    "A3",
  ];
  String? value1;
  String? value2;
  String subName = "";
  String batchName = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.044;
    var height = size.height;
    var width = size.width;
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.12,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Get Attendance",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: height * 0.045),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children :[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'From',
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height * 0.063,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextFormField(
                    // keyboardType: TextInputType.datetime,
                    style: TextStyle(fontSize: 14),
                    autofocus: false,
                    controller: FromDateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter a valid Date ");
                      }
                      if (!RegExp(r'^(19|20)\d{2}-(0?[1-9]|1[0-2])-([1-9]|0?[1-9]|[12][0-9]|3[01])$')
                          .hasMatch(value)) {
                        return ("Please Enter a valid Date ");
                      }
                      DateTime inputDate = DateTime.parse(value);
                      if (inputDate.isAfter(DateTime.now())) {
                        return "Please enter a valid Date";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      FromDateController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: FromDateController.text.isEmpty
                          ? Container(
                        width: 0,
                      )
                          : IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 2,
                        ),
                        onPressed: () => FromDateController.clear(),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: 'DD / MM /YY',
                      hintStyle: TextStyle(fontSize: 14 * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                      ),
                      prefixIcon: const Icon(Icons.calendar_month),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100),
                        keyboardType: TextInputType.datetime,
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                        DateFormat('d-M-yyyy').format(pickedDate);


                        setState(() {
                          //dobstring = pickedDate.toIso8601String();
                          FromDateController.text = formattedDate;
                        });
                      } else {}
                    },
                  ),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'To',
                  style: GoogleFonts.notoSans(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height * 0.063,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextFormField(
                      // keyboardType: TextInputType.datetime,
                      style: TextStyle(fontSize: 14),
                      autofocus: false,
                      controller: ToDateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter a valid Date ");
                        }
                        if (!RegExp(r'^(19|20)\d{2}-(0?[1-9]|1[0-2])-([1-9]|0?[1-9]|[12][0-9]|3[01])$')
                            .hasMatch(value)) {
                          return ("Please Enter a valid Date ");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ToDateController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: ToDateController.text.isEmpty
                            ? Container(
                          width: 0,
                        )
                            : IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 2,
                          ),
                          onPressed: () => ToDateController.clear(),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: size.width * 0.005,
                            horizontal: size.width * 0.03),
                        isDense: true,
                        hintText: 'DD / MM /YY',
                        hintStyle: TextStyle(fontSize: 14 * 0.8),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                        ),
                        prefixIcon: const Icon(Icons.calendar_month),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(

                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('d-M-yyyy').format(pickedDate);


                          setState(() {
                            //dobstring = pickedDate.toIso8601String();
                            ToDateController.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select Subject',
                  style: GoogleFonts.notoSans(
                    fontSize: sizefont,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Select Subject:"),
                      value: value1,
                      isExpanded: true,
                      items: subList.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          this.value1 = value;
                          subName = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select Batch',
                  style: GoogleFonts.notoSans(
                    fontSize: sizefont,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Select Batch:"),
                      value: value2,
                      isExpanded: true,
                      items: batchList.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          this.value2 = value;
                          batchName = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.23),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.052,
                  decoration: BoxDecoration(
                    color:  Color(0xFF0056D2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: ()
                        {
                          if(_formKey.currentState!.validate()){
                            print(FromDateController.text);
                            print(ToDateController.text);
                            print(subController.text);
                            print(batchController.text);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const Login()));

                          }
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.notoSans(
                            fontSize: sizefont * 0.7,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ]
          ),
        ),
      ),
    );

  }
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ));
}
