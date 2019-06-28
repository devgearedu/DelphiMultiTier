HOW TO USE:

NOTE:
- OpenSSL libraries (libeay32.dll and ssleay32.dl) are required on your path in order for this sample to work. http://www.openssl.org/

== Adding Accounts ==
- On the Accounts tab, choose the cloud service type (Azure or Amazon)
- Enter a unique display name for the new account
- For an Amazon account, set the Account name to your Access Key ID, and the Account Key to your Secret Access Key
- For an Azure account, set the account name and key as you'd expect
- Click the Add button

== Connecting to an Account ==
- Choose the connection you want to connect to in the Cloud dropdown box.
- On the Files tab, you will see the list of Containers (for Azure) or Buckets (for Amazon) at the root of the storage account
- you can double-click a container or bucket to drill into it and see its contents
- the contents are navigated as a virtual directory structure, with slash characters denoting folder names.
- You can specify a path in the text field above the file list and click Enter to be taken to that location

== File Transfers ==
- You can drag and drop a file from your local machine to the cloud (within a bucket/container)
- You can right click a file or directory/bucket/container and choose to upload or download it
- Active transfers will be shown on the transfers tab

== Logging and Proxy ==
- You can enable Info and Error logging on the logging tab.
- If you wish to debug the HTTP traffic, you can check "Use Proxy" on the Log tab, and run a proxy program such as Fiddler.