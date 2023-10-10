Here's a README.md file for your DioHandler package based on your provided README example:

```markdown
# DioHandler

![Pub Version](https://img.shields.io/pub/v/dio_handler)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

---

## Introduction

DioHandler is a Flutter package designed to simplify network API calls using the Dio HTTP client. It provides utility functions and customization options to streamline API request handling in your Flutter applications.

## Features

- Simplified API calls with Dio.
- Customizable error and loading dialogs.
- Network connectivity check.
- Callback time measurement (in debug mode).

---

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Import](#import-the-package)
  - [Create an Instance](#create-a-diohandler-instance)
  - [Make API Requests](#make-api-requests)
  - [Load Previously Generated Images](#load-a-previously-generated-image)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)

---

## Installation

To use DioHandler in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  dio_handler: ^1.0.0 # Replace with the latest version
```

Then, run `flutter pub get` to install the package.

---

## Usage

### Import the Package

First, import the `dio_handler` package in your Dart file:

```dart
import 'package:dio_handler/dio_handler.dart';
```

### Create a DioHandler Instance

Create an instance of `DioHandler` by providing a Dio instance and other optional parameters:

```dart
final Dio dio = Dio(); // Initialize a Dio instance

final DioHandler dioHandler = DioHandler(
  dio: dio, // Pass the Dio instance to DioHandler
  customErrorDialog: MyCustomErrorDialog(), // Optional: Provide a custom error dialog widget
  customLoadingDialog: MyCustomLoadingDialog(), // Optional: Provide a custom loading dialog widget
  isCheckNetworkConnectivity: true, // Optional: Enable network connectivity check
  isAlertDialogs: true, // Optional: Show alert dialogs for errors
  isCallBackTime: true, // Optional: Measure API callback time (debug mode)
);
```

Replace `MyCustomErrorDialog()` and `MyCustomLoadingDialog()` with your actual custom error and loading dialog widgets if needed.

### Make API Requests

To make an API request and handle responses, use the `callAPI()` method:

```dart
dioHandler.callAPI(
  serviceUrl: 'https://api.example.com/data',
  method: 'GET',
  success: (response) {
    // Handle successful response here
    print('API Request Successful');
    print(response.data);
  },
  error: (error) {
    // Handle error response here
    print('API Request Error');
    print(error);
  },
  showProcess: true, // Set to true to display a loading dialog
);
```

### Load a Previously Generated Image

You can use the `loadLastImage()` method to load a previously generated image:

```dart
File? imageFile = await dioHandler.loadLastImage();
if (imageFile != null) {
  // Display or process the loaded image
}
```

This can be useful for scenarios where you want to work with previously generated images.

---

## Example

You can find an example of how to use DioHandler in the `example` folder of this package. To run the example, follow these steps:

1. Clone this repository.
2. Navigate to the `example` folder.
3. Run `flutter run` to launch the example app.

---

## Get in touch

If you have any questions, feel free to reach out:

- Email: chhapawalaarfaz@gmail.com
- GitHub: https://github.com/Arfaz123

---

## Contributing

Contributions to the `dio_handler` package are welcome! If you find a bug or want to add a new feature, feel free to open an issue or submit a pull request.

## Contributors

<a href="https://github.com/Arfaz123/dio_handler/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Arfaz123/dio_handler" />
</a>

---

## License

This package is released under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to explore the features of the DioHandler package and customize it to suit your needs. If you have any questions or feedback, don't hesitate to reach out. Happy coding!
```