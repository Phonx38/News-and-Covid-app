import 'package:flutter/material.dart';
import 'datasource.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Faqs',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ExpansionTile(
                  title: Text(
                    DataSource.questionAnswers[index]['question'],
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(DataSource.questionAnswers[index]['answer']),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}