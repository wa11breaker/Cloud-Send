# Cloud Send
Upload, share and manage your files for free.

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Cloud Send is a flutter application that uses Firebase storage for storage, bloc for state management, and Rive for illustration and animation.

## Features and TODO
- [x] Upload and share files
- [ ] Integrate url shortener api
- [x] Display QR code of link once the file is uploaded
- [ ] Set upload maximum file size as 100 MB 
- [ ] Delete file after 7 days
- [ ] Migrate to layered architecture
- [ ] Setup firebase emulators
- [ ] Login and Sign-Up using firebase auth
- [ ] File view count and download count
- [ ] Welcome screen for downloading file

## Screenshots
![Alt text](/screenshots/Screenshot1.png?raw=true)
![Alt text](/screenshots/Screenshot2.png?raw=true)
![Alt text](/screenshots/Screenshot3.png?raw=true)

## Prerequisites
In order to use Cloud Send you must have Flutter and Flutterfire CLI installed on your machine.

## Installing
1. Clone this repo
2. Run ```flutter pub get```
3. Follow [this](https://firebase.google.com/docs/flutter/setup?platform=web) to configure firebase.

4. Go to firebase console and select ```Storage```

5. From there select ```Rules``` and change the rule as below
```js
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if true // request.auth != null;
    }
  }
}
```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
