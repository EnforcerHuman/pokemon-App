import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemons(int offset, int limit);
  Future<Either<Failure, List<Pokemon>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(Pokemon pokemon);
  Future<Either<Failure, void>> removeFavorite(String pokemonId);
}
