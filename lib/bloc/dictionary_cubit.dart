import '../model/word_response.dart';
import '../repo/word_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final WordRepository _repository;

  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  final queryController = TextEditingController();

  Future getWordSearched() async {
    //change state and return it to ui
    emit(WordSearchingState());

    try {
      final words =
          await _repository.getWordsFromDictionary(queryController.text);

      if (words == null) {
        emit(ErrorState("There is some issue"));
      } else {
        emit(WordSearchedState(words));
        // emit(NoWordSearchedState());
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }

  void BackToMain() async {
    emit(NoWordSearchedState());
  }
}

abstract class DictionaryState {}

//Initial state
class NoWordSearchedState extends DictionaryState {}

class WordSearchingState extends DictionaryState {}

class WordSearchedState extends DictionaryState {
  final List<WordResponse> words;

  WordSearchedState(this.words);
}

class ErrorState extends DictionaryState {
  final message;

  ErrorState(this.message);
}
