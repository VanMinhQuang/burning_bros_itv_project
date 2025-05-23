import 'package:burning_bros/core/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}

abstract class HandleNetworkResult {
  void onConnectedNetwork([bool isConnect]);
}

mixin BaseMixin <T extends StatefulWidget> on State<T> implements HandleNetworkResult{
  bool networkState = false;

  bool _isDialogShowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnect();
  }

  Future<void> checkConnect() async {
    await checkOnlyConnect();
    onConnectedNetwork(networkState);
  }

  Future<void> checkOnlyConnect() async {
    networkState = await NetworkCheck().check();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  void showProgressDialog({String? message}) {
    if (_isDialogShowing) return;

    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.5),
      builder: (context) {
        return Stack(
          children: [
            const Center(
              child: CircularProgressIndicator(
                color: mainColor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            ),
          ],
        );
      },
    );
  }

  void hideProgressDialog() {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }


}