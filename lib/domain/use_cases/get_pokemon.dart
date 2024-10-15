import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/core/use_case/use_case.dart';
import 'package:pokemon/domain/repositories/pokeemon_repository.dart';
import '../../core/error/failures.dart';
import '../entities/pokemon.dart';

class GetPokemons implements UseCase<List<Pokemon>, GetPokemonsParams> {
  final PokemonRepository repository;

  GetPokemons(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> call(GetPokemonsParams params) async {
    return await repository.getPokemons(params.offset, params.limit);
  }
}

class GetPokemonsParams extends Equatable {
  final int offset;
  final int limit;

  GetPokemonsParams({required this.offset, required this.limit});

  @override
  List<Object> get props => [offset, limit];
}
