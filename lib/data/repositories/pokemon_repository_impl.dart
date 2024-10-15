import 'package:dartz/dartz.dart';
import 'package:pokemon/data/data_sources/favorites_local_data_source.dart';
import 'package:pokemon/data/data_sources/pokemon_remote_data_soource.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/domain/repositories/pokeemon_repository.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final FavoritesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons(
      int offset, int limit) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemons =
            await remoteDataSource.getPokemons(offset, limit);
        return Right(remotePokemons);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getFavorites() async {
    try {
      final localFavorites = await localDataSource.getFavorites();
      return Right(localFavorites);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Pokemon pokemon) async {
    try {
      await localDataSource.addFavorite(pokemon as PokemonModel);
      return Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String pokemonId) async {
    try {
      await localDataSource.removeFavorite(pokemonId);
      return Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
