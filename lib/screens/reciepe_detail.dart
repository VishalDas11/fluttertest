import 'package:flutter/material.dart';
import 'package:fluttertest/model/reciepe_model.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({super.key, required this.reciepeModel});

  final ReciepeModel reciepeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Recipe Detail"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    reciepeModel.image.toString(),
                    fit: BoxFit.cover,
                  )),
              const SizedBox(height: 30),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    reciepeModel.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
