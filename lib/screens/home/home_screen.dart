import '../../bloc/dictionary_cubit.dart';
import '../../screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  getDictionaryFormWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Spacer(),
          Text(
            "Search any word you want",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          TextField(
            controller: cubit.queryController,
            decoration: InputDecoration(
              hintText: "Search a word",

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.transparent),
              ),

              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                cubit.getWordSearched();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.all(16)),
              child: Text("SEARCH"),
            ),
          ),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  getErrorWidget(message, cubit) {
    return Center(child: Column(
      children: [
        Spacer(),
        Text(message, style: TextStyle(color: Colors.white),),
        ElevatedButton(
          onPressed: () {
            cubit.BackToMain();
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.all(16)),
          child: Text("Back to main page"),
        ),
        Spacer()
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState && state.words != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListScreen(state.words),
            ),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: cubit.state is WordSearchingState
              ? getLoadingWidget()
              : cubit.state is ErrorState
                  ? getErrorWidget("Some Error", cubit)
                  : cubit.state is NoWordSearchedState
                      ? getDictionaryFormWidget(context)
                      : Container()),
    );
  }
}
