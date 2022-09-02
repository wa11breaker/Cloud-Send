# Cloud Send
Upload, share and manage your files for free.

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

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

## Credit
[Rive animation](https://rive.app/community/798-1554-tree-demo/)
>>>>>>> ed538eea5a4d4575dfd7538f32ecaef1e0bbd5c2

## License

MIT

**Free Software, Hell Yeah!**
