This project is configure on Android Platform only

To setup this project, please follow the steps below:

1. Put release.keystore and key.properties file into moovup_test_mobile/android directory
2. Put dev.env and prd.env into moovup_test_mobile directory 
3. Use following command to generate necessary file using command: dart run build_runner build -d

Use bellow command to run the project on dev flavor:
flutter run --flavor dev

if you want to run the project via IDE(VSCode/Android studio), make sure to add Build flavor(dev/prd) in the run Configuration 