==== VERSION INFO ====
 AUTHOR: Mathew DeLong  -  mathew.delong@embarcadero.com  -  http://blogs.embarcadero.com/mathewd
VERSION: 1
   DATE: November 10 / 2011

   
==== USING THE TDSServerConnectionMonitor COMPONENT ====
This demo Server (ConnectionMonitoringDemoServer) and demo client (ConnectionMonitoringDemoClient), as well as the HTML JavaScript-REST client found in the server project's root directory (WebClient.html) demonstrate how to use the TDSServerConnectionMonitor component, found in the DataSnapServerConnectionMonitoring package.


==== INTRO TO THE COMPONENT ====
The TDSServerConnectionMonitor, once installed into your IDE, can be found on the Tool Palette under the 'DataSnap Server' heading. You can add this component to a form with a TDSServer instance on it, or on another form with access to a TDSServer instance. In order for the component to become active, you must call 'Start' on it. This is done (instead of starting by default) to insure that all components have been registered with the TDSServer instance before registering with it. You can call Stop on the component if you want it to stop firing events.

The component exposes a Server property, which must be set. This must be the TDSServer instance to listen on. It also exposes three events: OnConnnect, OnDisconnect and OnHTTPTrace.

The OnConnect event lets you know of any TCP/IP, HTTP (tunnel) or HTTP (REST) connection. The connection for TCP/IP is the connection itself. For HTTP, the connection is the session. When the session is created, the connection is established, and when the session is closed, the connection is seen as being terminated. This doesn't account for any attempted HTTP requests that fail after connection to the server, but before successfully getting to the authentication step. (such as requests using expired session IDs.)

The item passed to the OnConnect event will contain a connection (TDSMonitoredConnection) which specifies the connection information, such as Client IP, Session ID, protocol and the date the connection was created. If the protocol is TCP/IP (pTCPIP) then you can cast this instance to TDSTCPMonitoredConnection, and get additional information specific to TCP. However, this should not be required.

The OnDisconnect event simply notifies you of the connections which are closing. The event is passed an item containing the connection being closed. This will be the same connection object that was passed to OnConnect.

The OnHTTPTrace event notifies you of any HTTP request, and the response being returned. Unless the request was for file dispatching (or some Non DataSnap-REST request) the event item will contain a Connection. The one exception is for the last request of an HTTP Tunnel connection as it is closing. If the connection isn't specified, it will be set to nil. In the event you also get access to the HTTP Request and HTTP Response being sent.

The TDSServerConnectionMonitor component also has a couple additional public methods (aside from start and Stop) of interest: ForEachConnection and GetConnectionForSession.

ForEachConnection allows you to iterate over each connection in a thread-safe way.

GetConnectionForSession allows you to get a connection (TDSMonitoredConnection) for a specific sessionId (Session.SessionName.) It returns nil if no connection can be found with the given Session ID.

There is also the ConnectionCount property, which returns the number of connections currently registered with the component.

The TDSMonitoredConnection class has a "Close" procedure on it. This procedure will close the connection in a way appropriate to which type of connection it is. For TCP/IP, it will call into the TCP channel and close it. For HTTP, the session will be closed through the session manager.


==== USING THE DEMO SERVER =====
NOTE: If you don't keep the "DSServerConnectionMonitoring" and "DSServerConnectionMonitoringTest" folders named the same, or in the same directory, you will need to change the server project's search path accordingly.

To use the demo DataSnap server (ConnectionMonitoringDemoServer) just make sure the DataSnapServerConnectionMonitoring project has been built and installed properly (right click on the target node in the Project Manager and select Install.) Then add the server project to your project manager, build and run it. The server will start automatically on HTTP port 8088 and TCP/IP port 211. (So make sure those ports are free before starting if you aren't sure.) The server will show a list of all the current DataSnap connections, a list of all the current sessions, and a list of uniquely named server channels, based on what heavyweight callbacks are registered.

If you click on a connection in the connection list, its corresponding session (if found) will be highlighted in the sessions list. Likewise, clicking on a session will highlight the corresponding connection. There is expected to be a 1-to-1 relationship between the two.

If you right-click on the callback channels list while one of the server channel name sis selected, you will have the context menu option to broadcast a message to all clients listening on that channel. The message broadcast will be the one typed into the "Message" field, below the callback channels list.

For the purpose of this demo, by default each client is set up to listen on a different server channel name, so it is possible to tell their heavyweight callback registrations apart on the server, and send a message to only one at a time. Keep in mind this is only for the sake of a simple demo, and they could have all been listening on the same server channel.

If you right-click on a connection in the connections list, you will have the option to close it. Likewise, if you right-click on a session, you will have the option to close that.

You will notice sessions show up in the list before their corresponding connections. This is done for the sake of the demo, because as of XE 2 update 2, some of the client information isn't populated right away after the OnConnect is fired. Waiting a set number of milliseconds in this demo project is a temporary workaround until this is resolved. (Probably with Update 3.)

On the HTTP Traffic tab, you can see all of the HTTP requests being issued. Except when not possible, the Session ID for the session issuing the request is also available. For HTTP tunneling, the HTTP requests aren't very fascinating in this log. The log doesn't log the request or response content stream.


==== USING THE DELPHI DEMO CLIENT ====
To use the Delphi demo client (ConnectionMonitoringDemoClient) make sure the server is running. Add the client to your project manager, build and run it. The client is set up to test both HTTP (tunnel) and TCP/IP protocols. You can register and unregister a heavyweight callback for each protocol. You can also call reverse-string. If a heavyweight callback is registered and receives a broadcast, it will show up in the text area. If a server kills the session or connection for a heavyweight callback, the client's button will change to the stopped position.

If the connection for the reverse string invocation is terminated on the server, the client will only know the next time it tries to invoke the reverse string.


==== USING THE JAVASCRIPT REST DEMO CLIENT ====
To launch the HTTP REST JavaScript client, you can go to the HTTP Traffic tab, and click on the 'Open Browser Client' button. This will open the /web/WebClient.html page, dispatched by the DataSnap Server. You can use this the same way as the Delphi clients. The main difference is that when you stop the heavyweight callback, the connection (session) isn't closed. You can click the 'Close Session' button to do so, or close the tab. Also, the reverse string and heavyweight callback will share the same connection (session.)
