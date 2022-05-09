# coingen

A WebSockets and Riverpod demo by Michael Ringlein. Build upon the default counter demo app of Flutter.

## What does this do?

It combines WebSockets with Riverpod.

The value of the counter or a custom message can be sent to WebSockets. Both - counter and message - can be read using the WebSocket's stream.

Rather than using the `StreamBuilder` to listen to new messages (via the WebSocket's stream), a `StreamProvider` from Riverpod is used instead.

## Web Demo

[https://flutterwebapps.com/portfolio/coingen/](https://flutterwebapps.com/portfolio/coingen/)

## Android Demo

Here you can download the .apk: [https://flutterwebapps.com/portfolio/coingen/apk](https://flutterwebapps.com/portfolio/coingen/apk)

Note: Your device needs to have an internet connection when using the apps since WebSockets needs to be able to connect to their server.



