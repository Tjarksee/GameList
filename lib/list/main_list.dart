import 'package:game_list/list/list_class.dart';
import 'package:game_list/screens/game_class.dart';

class MainList {
  List<GameItem> favList = [];

  bool contains1(favGameItem) {
    GameItem fav = favGameItem;
    final foundGames = favList.where(
        (element) => element.gameItemInfo.gameID == fav.gameItemInfo.gameID);
    if (foundGames.isNotEmpty) {
      return true;
    }
    return false;
  }

  void removeFav(favGameItem) {
    GameItem fav = favGameItem;
    favList.removeWhere(
        (element) => element.gameItemInfo.gameID == fav.gameItemInfo.gameID);
  }

  void addFav(favGameItem) {
    GameItem fav = favGameItem;

    favList.add(fav);
  }

  List<GameItem> getFavList() {
    return favList;
  }
}
