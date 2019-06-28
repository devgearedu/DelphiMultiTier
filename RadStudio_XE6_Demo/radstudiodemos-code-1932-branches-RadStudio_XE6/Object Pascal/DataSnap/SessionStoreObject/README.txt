WHAT THIS DEMONSTRATES:
How to store TObject instances in a session. You can then use the stored objects in later server method invocations, or however you want.

HOW TO USE:
- Import the project into your project group
- Compile and run the server
- Copy the URL in the server's first text field into a browser and go to it
  - This will invoke the "StoreObject" server method, creating a new instance of "TMySessionClass" with some values stored in it.
- Go back to the server and see there is now a URL in the second text field. Copy that, and pase that into your browser
  - This will invoke the "GetObject" server method, passing in the object's "id" and returning the values stored within the stored object
- In the browser, note what is returned.
- If you change the value passed in to the "GetObject" invocation (the "id" of the object... which defaults to "abc" in this example) to an ID that doesn't have an object stored in the session (such as "abcd") and invoke the method again, the server method will return an error message, saying no object was found.