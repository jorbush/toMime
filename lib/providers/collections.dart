// Desde este preveedor se gestionará tanto laas colecciones
// que compre el usuario como las que seleccione para el juego
import 'package:flutter/foundation.dart';
import '../models/collection.dart';

class Collections with ChangeNotifier {
  List<Collection> _collections = [];

  Collections();

  List<Collection> get collections {
    return [..._collections];
  }

  List<Collection> get selectedCollections {
    // return collections which isSelected
  }

  Future<void> fetchAndSetCollections() async {
    // TODO: Get collections data from firebase
    // FireBase will store the collection price and if is already bought
    // Here we need to set this parameters for each collection
    notifyListeners();
  }

  void setCollectionSelected(String id) {
    // TODO
  }

  void buyCollection(String id) {
    // TODO
  }
}
