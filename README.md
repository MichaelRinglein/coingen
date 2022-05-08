# coingen

A WebSockets and Riverpod demo by Michael Ringlein. Build upon the default counter demo app of Flutter.

## What does this do?

It combines WebSockets with Riverpod. 

The the value of the counter or a custom message can be send to WebSockets. Both, counter and message, can be read using WebSockets' stream. 

But instead of using the `StreamBuilder` to listen to new messages (via the WebSockets' stream), a `StreamProvider` from Riverpod is used instead.




