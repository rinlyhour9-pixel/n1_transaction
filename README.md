# N1 Transaction

A driver-first Flutter UI prototype for N1 TRANSPORTATION. It uses local mock data and Material 3 only, so it is ready to extend with API, maps, and state management later.

## Run

On this macOS 13 development machine, VS Code uses Flutter 3.35.7 from
`.tooling/flutter`. The newer globally installed SDK fails during Dart VM
initialization because it requires macOS 14. Reload VS Code after changing SDKs
and open a new integrated terminal so its PATH uses the selected SDK.

To recreate the local SDK on another checkout:

```bash
git clone --branch 3.35.7 --depth 1 https://github.com/flutter/flutter.git .tooling/flutter
```

Use the project launcher in any terminal to select the local SDK reliably:

```bash
./flutterw pub get
./flutterw run
```

If the old initialization error remains visible, run **Developer: Reload Window**
from the VS Code command palette and open a new terminal. The old output may
remain in the output panel; check the latest messages. If Flutter reports that
it is waiting for the startup lock, let the other Flutter command finish first.

The app starts on a polished driver dashboard and includes Trips, Fuel, Profile, notifications, trip progress, loading confirmation, delivery proof, and fuel request flows.
