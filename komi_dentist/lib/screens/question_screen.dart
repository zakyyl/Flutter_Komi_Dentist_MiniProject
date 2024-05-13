// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:komi_dentist/screens/answer_screen.dart';
import 'package:komi_dentist/service/recomendation_service.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  void _getRecommendations() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await RecommendationService.getRecommendations(
  dentalConcern: 'Masalah gigi yang ingin diatasi',);
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return AnswerScreen(gptResponseData: result);
            },
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send a request. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'T A N Y A   K O M I ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(760),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Center(
              //   heightFactor: 4,
              //   child: Text(
              //     'T A N Y A   K O M I ',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(width: 10,),
              Center(
                child: Image.asset(
                  'assets/images/komi2.png', 
                  // width: 120,
                ),
              ),
              
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Center(
                  child: Text(
                    "",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'inputkan pertanyaan mengenai gigimu',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe your dental concern';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: isLoading && _formKey.currentState!.validate() != false
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: _getRecommendations,
                        
                        child: const Center(
                          child: Text("T A N Y A",style: TextStyle(color: Colors.blueAccent),),
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
