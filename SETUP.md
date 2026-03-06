# CanzonItalia — Setup Guide

## Step 1: Install Flutter (one-time)

1. Download Flutter SDK: https://docs.flutter.dev/get-started/install/windows/mobile
2. Extract to `C:\flutter`
3. Add `C:\flutter\bin` to your Windows PATH
4. Open a new terminal and run: `flutter doctor`
5. Install any missing items it reports

## Step 2: Install VS Code Extensions

- Open VS Code → Extensions (Ctrl+Shift+X)
- Install: **Flutter** (Dart installs automatically)

## Step 3: Create the Flutter Project

Open a terminal in this folder and run:

```bash
flutter create . --org com.yourname --platforms ios,android
```

> This generates the iOS/Android native scaffolding around the `lib/` code that's already here.
> When asked to overwrite `pubspec.yaml`, say **no** (keep the existing one).
> The `lib/` folder already contains all the app code.

## Step 4: Install Dart Dependencies

```bash
flutter pub get
```

## Step 5: Slice the Audio

1. Install ffmpeg: https://ffmpeg.org/download.html → extract to `C:\ffmpeg`, add to PATH
2. Install Audacity: https://www.audacityteam.org
3. Open your MP3 of "Sarà Perché Ti Amo" in Audacity
4. Note the exact start/end timestamp (MM:SS.mmm) for each lyric line
5. Update `slice_audio.bat` with your timestamps
6. Place your MP3 file next to `slice_audio.bat`
7. Double-click `slice_audio.bat` to generate all `assets/audio/sara_line_XX.mp3` files
8. Listen to each sliced file to verify correctness

## Step 6: Update Lyrics in Code

Open `lib/models/song_library.dart` and verify/update:
- The Italian text for each line (must match exactly what the speech recognizer will hear)
- The English translations
- Add/remove `SongLine` entries to match your actual audio slices

## Step 7: Run on Android Emulator (for testing on Windows)

```bash
flutter emulators --launch  # start an Android emulator
flutter run
```

> Note: Speech recognition and microphone work best on a real device.

## Step 8: Build for iOS via Codemagic

1. Push this folder to a GitHub repository
2. Create a free account at https://codemagic.io
3. Connect your GitHub repo
4. The `codemagic.yaml` file handles the build automatically
5. Download the `.app` artifact from the Codemagic dashboard

## iOS Permissions (already configured)

`ios/Runner/Info.plist` already contains the required permission strings for microphone and speech recognition. These are added when you run `flutter create .` — the native iOS project will include them.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `flutter: command not found` | Restart terminal after updating PATH |
| Speech not recognized | Test on a real iPhone, not simulator |
| Audio not playing | Check file names match `audioFile` in `song_library.dart` |
| Level 2 stays locked | Complete ALL lines in Level 1 first |
