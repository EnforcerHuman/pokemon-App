import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pokemon_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<PokemonModel>> getFavorites();
  Future<void> addFavorite(PokemonModel pokemon);
  Future<void> removeFavorite(String pokemonId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final FirebaseFirestore firestore;
  final String userId;

  FavoritesLocalDataSourceImpl(this.firestore, this.userId);

  @override
  Future<List<PokemonModel>> getFavorites() async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    return snapshot.docs
        .map((doc) => PokemonModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> addFavorite(PokemonModel pokemon) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(pokemon.id.toString())
        .set(pokemon.toJson());
  }

  @override
  Future<void> removeFavorite(String pokemonId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(pokemonId)
        .delete();
  }
}
