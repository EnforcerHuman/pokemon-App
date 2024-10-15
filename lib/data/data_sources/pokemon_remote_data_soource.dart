import 'package:dio/dio.dart';
import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemons(int offset, int limit);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PokemonModel>> getPokemons(int offset, int limit) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((json) => PokemonModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}
