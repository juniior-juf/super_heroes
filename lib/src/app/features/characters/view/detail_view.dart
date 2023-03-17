import 'package:flutter/material.dart';
import 'package:super_heroes/src/domain/entities/entities.dart';
import 'package:super_heroes/src/util/colors/colors_app.dart';

class DetailView extends StatefulWidget {
  final CharacterEntity character;
  const DetailView({
    super.key,
    required this.character,
  });

  @override
  State<DetailView> createState() {
    return _DetailViewState();
  }
}

class _DetailViewState extends State<DetailView> {
  _DetailViewState();

  @override
  Widget build(BuildContext context) {
    final character = widget.character;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blue.shade800,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          '${character.thumbnail?.path}.${character.thumbnail?.extensionImage}',
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
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorsApp.red,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  character.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: ColorsApp.red,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  character.description ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (character.comics!.items!.isNotEmpty)
                BuildSection(
                  label: 'Comics',
                  resource: character.comics!,
                ),
              if (character.series!.items!.isNotEmpty)
                BuildSection(
                  label: 'Series',
                  resource: character.series!,
                ),
              if (character.stories!.items!.isNotEmpty)
                BuildSection(
                  label: 'Stories',
                  resource: character.stories!,
                ),
              if (character.events!.items!.isNotEmpty)
                BuildSection(
                  label: 'Events',
                  resource: character.events!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildSection extends StatefulWidget {
  final String label;
  final ResourceListEntity resource;
  const BuildSection({
    super.key,
    required this.label,
    required this.resource,
  });

  @override
  State<BuildSection> createState() => _BuildSectionState();
}

class _BuildSectionState extends State<BuildSection> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          color: ColorsApp.red,
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(
                  isVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 32,
                )
              ],
            ),
          ),
        ),
        if (isVisible)
          ...widget.resource.items!
              .map(
                (e) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(),
                      start: BorderSide(),
                      end: BorderSide(),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(e.name ?? '')),
                    ],
                  ),
                ),
              )
              .toList(),
      ],
    );
  }
}
