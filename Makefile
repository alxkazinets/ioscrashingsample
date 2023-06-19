@PHONY: runapp
runapp:
	make kill
	make simulator
	make build
	make launch

@PHONY: kill
kill:
	/bin/bash -c 'sudo kill $$(ps aux | grep -i "Simulator" | grep -v grep | awk "{print \$$2}")'

	rm -rf Archive.xcarchive

@PHONY: simulator
simulator:
	open -a Simulator 

@PHONY: runserver
runserver:
	python3 -m venv venv
	pip3 install -r be/requirements.txt
	python3 be/server.py

@PHONY: build
build:
	xcodebuild -project ios/KSCrashSample.xcodeproj -scheme KSCrashSample -configuration Release clean archive -archivePath "Archive.xcarchive" -destination 'platform=iOS Simulator,name=iPhone 14'

@PHONY: launch
launch:
	xcrun simctl install booted Archive.xcarchive/Products/Applications/KSCrashSample.app
	xcrun simctl launch booted some.dev.KSCrashSample