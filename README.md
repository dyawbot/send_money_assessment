# send_money_assessment
Guide to Run the App

1. Clone the Repository: First, clone the repository to your local machine.

2. Set Up the Project: Navigate to the project directory in your terminal and run the following commands:
    
    flutter clean
    flutter pub get

3. Generate Code: Run the build runner to generate necessary code:
    
    flutter pub run build_runner build --delete-conflicting-outputs

4. Build the Application: To create a release APK for your device, use:
    
    flutter build apk --release

5. Run or Install the App:

    To install the APK on your device, locate the generated APK file in the build/app/outputs/flutter-apk/ directory and install it manually.

    Alternatively, you can run the app in debug mode using the following command in your terminal:

        flutter run

        or press F5 in your IDE to start debugging.


6. Run Unit Tests:
    To run all unit tests, use: 
        flutter test


    To run a specific test file, use
        flutter test domain/domain_entity_test.dart
        flutter test repo_test/user_transaction_api_test.dart

        
Feel free to reach out if you encounter any issues or need further assistance.
