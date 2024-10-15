import 'package:dartz/dartz.dart';
import 'package:pokemon/core/use_case/use_case.dart';
import 'package:pokemon/domain/repositories/pokeemon_repository.dart';
import '../../core/error/failures.dart';

class RemoveFavorite implements UseCase<void, String> {
  final PokemonRepository repository;

  RemoveFavorite(this.repository);

  @override
  Future<Either<Failure, void>> call(String pokemonId) async {
    return await repository.removeFavorite(pokemonId);
  }
}
