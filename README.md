vscode-mac

Sandbox to play with Visual Studio Code on my mac (using mono)

Created a makefile and configured some targets:
* clean
* restore
* build
* test
* run

Configured .settings/tasks.json so that:
* CMD+Shift+B will invoke make build
* CMD+Shift+T will invoke make test

Configured .settings/launch.json so that:
* target/App.exe can be debugged

Things that I would like to add:
* Watch changes to source code and start test running (like node-watch etc)
* Generate a template (like yeoman)
