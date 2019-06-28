WHAT THIS DEMONSTRATES:
There is a single DataSnap server and 3 clients in this sample. The server uses indy and accepts http requests on port 8080, and tcp/ip connections on port 211. Port 8080 also serves up web files, and has a JavaScript REST client available at /index.html.

The clients all register heavyweight callbacks, to demonstrate both the server and client heavyweight callback events. On the server, whenever a tunnel is created, closed or modified (callback added to it) a message is printed out into a log area. On each client, the button enablement is changed based on events.

For example, if you click the "start" button to start the first callback, an event is fired telling you the first callback started. The clients are programmed to catch that event, and change the button enablement for the callback's start button to DISABLED and its stop button to ENABLED. Furthermore, if the server (or anything) terminates the clients heavyweight callback, the event on the client is fired, and the button enablement is changed accordingly.



HOW TO USE:
- Import the server project and two Delphi client projects into your project group
- Compile and run the server and both clients.
- NOTE: if your port 8080 or 211 are already in use, change the server and clients' settings before running
- In the server, click the "open in browser" button to open the JavaScript REST client
- In each of the clients, click one of the "START" buttons. Note how the button enablement changes for the client. Note the messages logged on the server.
- Type a message in the text field on the server and click "broadcast". Note that the heavyweight callbacks are working, and the callback you registered for each client gets the message.
- Now, click the other callback's start button on each client. Notice the same things as for the first callback.
- Click one of the stop buttons, and notice again the button enablement changes and the logging on the server.
- Click the stop all button on the client, or the red X on the server. If you close the server, the clients should all be told of this, and their button enablement will change.
