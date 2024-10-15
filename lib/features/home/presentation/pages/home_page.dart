import 'package:flutter/material.dart';
import 'package:pokemon/features/home/presentation/widgets/pokemon_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent - controller.position.pixels <=
          200) {
        // User is within 100 pixels from the bottom of the scroll
        print('Almost reached max scroll');
        print('Current scroll position: ${controller.position.pixels}');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth < 350
                ? 1
                : constraints.maxWidth < 600
                    ? 2
                    : 4;

            return GridView.builder(
              controller: controller, // Attach the scroll controller
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.75,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 6, // Displaying 6 items
              itemBuilder: (context, index) {
                // Sample data
                final pokemons = [
                  {
                    'name': 'Bulbasaur',
                    'number': '001',
                    'color': const Color(0xFFE0F2F1)
                  },
                  {
                    'name': 'Ivysaur',
                    'number': '002',
                    'color': const Color(0xFFE1F5FE)
                  },
                  {
                    'name': 'Venusaur',
                    'number': '003',
                    'color': const Color(0xFFE1F5FE)
                  },
                  {
                    'name': 'Charmander',
                    'number': '004',
                    'color': const Color(0xFFFFF3E0)
                  },
                  {
                    'name': 'Charmeleon',
                    'number': '005',
                    'color': const Color(0xFFFFEBEE)
                  },
                  {
                    'name': 'Charizard',
                    'number': '006',
                    'color': const Color(0xFFFFF3E0)
                  },
                ];
                return PokemonCard(
                  name: pokemons[index]['name'] as String,
                  number: pokemons[index]['number'] as String,
                  color: pokemons[index]['color'] as Color,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
