import '../../model/word_response.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final WordResponse wordResponse;

  DetailScreen(this.wordResponse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "${wordResponse.word}",
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final meaning = wordResponse.meanings[index];
                  final definitions = meaning.definitions;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meaning.partOfSpeech,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8,),
                      ListView.separated(
                        itemBuilder: (context, index) => Column(
                          children: [
                            Text("Defination : "+ definitions[index].definition, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            SizedBox(height: 4,),
                            Text("Sentence  : ${definitions[index].example}", style: TextStyle(color: Colors.white),),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 8,),
                        itemCount: definitions.length,
                        shrinkWrap: true,
                      )
                    ],
                  );
                },
                itemCount: wordResponse.meanings.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 32,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
