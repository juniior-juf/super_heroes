import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_heroes/src/app/components/button_number_pagination.dart';
import 'package:super_heroes/src/app/components/button_pagination.dart';
import 'package:super_heroes/src/app/features/characters/controller/character_controller.dart';
import 'package:super_heroes/src/app/features/characters/view/detail_view.dart';
import 'package:super_heroes/src/domain/domain.dart';

import 'package:super_heroes/src/util/colors/colors_app.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final CharacterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<CharacterController>();
    _controller.init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getCharacters(
        params: CharacterParams(
          limit: _controller.charactersAmountDefault,
          offset: _controller.allCharacters?.length,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BuildHeader(),
                  BuildFieldSearch(controller: _controller),
                ],
              ),
            ),
            BuildBody(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'BUSCA ',
          style: TextStyle(
            fontSize: 16,
            color: ColorsApp.red,
            fontWeight: FontWeight.w900,
            decoration: TextDecoration.underline,
            decorationThickness: 3.0,
          ),
        ),
        Text(
          'MARVEL',
          style: TextStyle(
            fontSize: 16,
            color: ColorsApp.red,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          'TESTE FRONT-END',
          style: TextStyle(
            fontSize: 16,
            color: ColorsApp.red,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class BuildFieldSearch extends StatefulWidget {
  final CharacterController controller;
  const BuildFieldSearch({
    super.key,
    required this.controller,
  });

  @override
  State<BuildFieldSearch> createState() => _BuildFieldSearchState();
}

class _BuildFieldSearchState extends State<BuildFieldSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nome do Personagem',
            style: TextStyle(
              color: ColorsApp.red,
            ),
          ),
          TextField(
            controller: widget.controller.searchController,
            textInputAction: TextInputAction.search,
            cursorColor: Colors.black12,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                widget.controller.getCharacters(
                  params: CharacterParams(
                    limit: widget.controller.charactersAmountDefault,
                    offset: widget.controller.allCharacters?.length,
                  ),
                );
              }
            },
            onSubmitted: (value) {
              widget.controller.getCharactersByName(
                params: CharacterParams(
                  limit: widget.controller.charactersAmountDefault,
                  nameStartsWith: value,
                  offset: widget.controller.filteredCharacters?.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BuildBody extends StatefulWidget {
  final CharacterController controller;

  const BuildBody({
    super.key,
    required this.controller,
  });

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller.addListener(() {
      if (!widget.controller.pageController.hasClients) return;
      widget.controller.navigateToPageSelected();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Consumer<CharacterController>(
        builder: (
          context,
          controller,
          _,
        ) {
          if (controller.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsApp.red,
              ),
            );
          }
          final charactersPages = controller.charactersPages;
          if (charactersPages == null) {
            return const Center(
              child: Text(
                'Ops! Ocorreu algum erro, tente novamente mais tarde.',
              ),
            );
          }
          if (charactersPages.isEmpty) {
            return const Center(child: Text('Nenhuma super heroi encontrado'));
          }
          return Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 12),
            color: ColorsApp.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 106.0, top: 8, bottom: 8),
                  child: Text(
                    'Nome',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 406,
                    child: PageView.builder(
                      itemCount: charactersPages.length,
                      itemBuilder: (context, index) {
                        return BuildCharacterList(
                          characters: charactersPages[index],
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                    ),
                  ),
                ),
                BuildBottomPage(controller: controller),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BuildCharacterList extends StatelessWidget {
  final List<CharacterEntity> characters;

  const BuildCharacterList({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: characters
            .map((character) => BuildChatacterItem(
                  name: character.name ?? '',
                  imageUrl:
                      '${character.thumbnail?.path}.${character.thumbnail?.extensionImage}',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return DetailView(character: character);
                      },
                    ));
                  },
                ))
            .toList(),
      ),
    );
  }
}

class BuildChatacterItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Function() onPressed;

  const BuildChatacterItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.blue.shade800,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: ColorsApp.red,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildBottomPage extends StatelessWidget {
  final CharacterController controller;

  const BuildBottomPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 72,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonPagination(
            icon: Icons.arrow_left_sharp,
            onPressed: () {
              if (controller.pageSelected != 0) {
                controller.changePage(controller.pageSelected - 1);
              }
            },
          ),
          Flexible(
            child: SizedBox(
              height: 32,
              child: PageView.builder(
                controller: controller.navigationPageController,
                padEnds: false,
                itemCount: controller.charactersPages?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: index != controller.charactersPages!.length - 1
                            ? 16
                            : 0),
                    child: ButtonNumberPagination(
                      number: index + 1,
                      isSelected: controller.pageSelected == index,
                      onPressed: () {
                        controller.changePage(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          ButtonPagination(
            icon: Icons.arrow_right_sharp,
            onPressed: () async {
              controller.changePage(controller.pageSelected + 1);
            },
          )
        ],
      ),
    );
  }
}
