import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:stroktrail/base_widgets/LoadingWidget.dart';
import 'package:stroktrail/dataSource/weather_api_service.dart';
import 'package:stroktrail/utils/validation_util.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  GlobalKey<FormState> loginKey = GlobalKey();

  bool _visiblePassword = false;

  void validate() async {
    if (loginKey.currentState?.validate() ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();

      SmartDialog.show(
          widget: loadingWidget,
          backDismiss: false,
          clickBgDismissTemp: false,
          isLoadingTemp: true);
      final weather = await WeatherApiService.getWeather();
      SmartDialog.dismiss();
      // progressDialog.hide();
      showFlash(
        context: context,
        transitionDuration: const Duration(milliseconds: 200),
        duration: const Duration(seconds: 2),
        builder: (_, controller) {
          return Flash(
            borderColor: Colors.black,
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            borderWidth: 2,
            behavior: FlashBehavior.floating,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            controller: controller,
            position: FlashPosition.bottom,
            onTap: controller.dismiss,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _rowDataBuilder("Country", weather.name ?? ""),
                _rowDataBuilder("Temp", "${weather.main?.temp ?? 0}°C"),
                _rowDataBuilder(
                    "Feels Like", "${weather.main?.feelsLike ?? 0}°C"),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(40),
              child: Image.network(
                  "https://is4-ssl.mzstatic.com/image/thumb/Purple115/v4/39/2a/62/392a626f-99ea-b8f7-aa6d-5875686fb761/AppIcon-1x_U007emarketing-85-220-0-9.png/1200x600wa.png")),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: loginKey,
              child: Center(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          decorationColor: Colors.red
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: ValidationUtil.validateEmail,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: _visiblePassword,
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _visiblePassword = !_visiblePassword;
                            });
                          },
                          icon: Icon(
                            _visiblePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: ValidationUtil.validatePassword,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: validate,
                      child: const Text("Login"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _rowDataBuilder(String name, String value) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [Text(name), Expanded(child: Container()), Text(value)],
        ),
      );
}
