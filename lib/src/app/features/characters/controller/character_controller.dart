import 'package:flutter/material.dart';
import 'package:super_heroes/src/domain/domain.dart';
import 'package:super_heroes/src/domain/entities/character_data_entity.dart';

class CharacterController extends ChangeNotifier {
  final GetCharactersUseCase getCharactersUseCase;
  CharacterDataEntity? characterData;
  List<CharacterEntity>? allCharacters;
  List<CharacterEntity>? filteredCharacters;
  List<List<CharacterEntity>>? charactersPages;
  late final TextEditingController searchController;
  late final PageController pageController;
  late final PageController navigationPageController;
  final int charactersPerPage = 4;
  final int charactersAmountDefault = 25;
  int pageSelected = 0;
  bool? isLoading;

  CharacterController({
    required this.getCharactersUseCase,
  });

  void init() {
    searchController = TextEditingController();
    pageController = PageController(initialPage: pageSelected);
    const pagesVisible = 1 / 5;
    navigationPageController = PageController(
      initialPage: pageSelected,
      viewportFraction: pagesVisible,
    );
  }

  // Get all the charcacters
  Future<void> getCharacters({
    bool firstRequest = true,
    CharacterParams? params,
  }) async {
    if (firstRequest) {
      allCharacters = [];
      charactersPages = [];
      isLoading = true;
      notifyListeners();
    }
    characterData = await getCharactersUseCase(params!);
    if (characterData == null) {
      allCharacters = null;
      isLoading = false;
      notifyListeners();
    } else {
      allCharacters?.addAll(characterData!.results!);
      isLoading = false;
      addCharactersByPage(characters: allCharacters!);
    }
  }

  // Get all the charcacters by name
  Future<void> getCharactersByName({
    bool firstRequest = true,
    CharacterParams? params,
  }) async {
    if (firstRequest) {
      pageSelected = 0;
      filteredCharacters = [];
      charactersPages = [];
      isLoading = true;
      notifyListeners();
    }
    characterData = await getCharactersUseCase(params!);

    if (characterData == null) {
      filteredCharacters = null;
      isLoading = false;
      notifyListeners();
    } else {
      filteredCharacters?.addAll(characterData!.results!);
      isLoading = false;
      addCharactersByPage(characters: filteredCharacters!);
    }
  }

  // Adds the number of characters per page
  Future<void> addCharactersByPage({
    required List<CharacterEntity> characters,
  }) async {
    charactersPages = [];
    List<CharacterEntity> addedCharacters = [];

    final amountPages = getNumberPages(
      totalChacacters: characters.length,
      amountCharactersPerPage: charactersPerPage,
    );

    for (var i = 0; i < amountPages; i++) {
      final isLastPage = i == amountPages - 1;
      final remaining = isLastPage
          ? characters.length - addedCharacters.length
          : charactersPerPage;

      final start = addedCharacters.length;
      final end = start + remaining;
      final sublist = characters.sublist(start, end);

      addedCharacters.addAll(sublist);
      charactersPages?.add(sublist);
    }
    notifyListeners();
  }

  // Get the exact number of pages
  int getNumberPages({
    required int totalChacacters,
    required int amountCharactersPerPage,
  }) {
    final amountPages = (totalChacacters / amountCharactersPerPage);
    return amountPages > amountPages.round()
        ? amountPages.round() + 1
        : amountPages.round();
  }

  // Change page
  void changePage(int page) {
    if (page < charactersPages!.length) {
      pageSelected = page;
      notifyListeners();
    }
  }

  // Navigate between pages
  void navigateToPageSelected() {
    final currentPage = pageController.page;
    if (pageSelected != currentPage) {
      getMoreCharacters();
      pageController.animateToPage(
        pageSelected,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      navigationPageController.animateToPage(
        pageSelected,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // Get more characters to add to the list
  void getMoreCharacters() {
    if (searchController.text.isEmpty) {
      if (allCharacters!.length < characterData!.total!) {
        getCharacters(
          firstRequest: false,
          params: CharacterParams(
            limit: charactersAmountDefault,
            offset: allCharacters?.length,
          ),
        );
      }
    } else {
      if (filteredCharacters!.length < characterData!.total!) {
        getCharactersByName(
          firstRequest: false,
          params: CharacterParams(
            limit: charactersAmountDefault,
            nameStartsWith: searchController.text,
            offset: filteredCharacters?.length,
          ),
        );
      }
    }
  }
}
