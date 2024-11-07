import 'package:discorev/services/general_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends GeneralService{

  UserService(super.endpoint);

  Future setAccountType(int accountType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accountType', accountType);
  }

  Future<int> getAccountType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("accountype :");
    print(prefs.getInt('accountType'));
    return prefs.getInt('accountType') ?? -1;
  }

}