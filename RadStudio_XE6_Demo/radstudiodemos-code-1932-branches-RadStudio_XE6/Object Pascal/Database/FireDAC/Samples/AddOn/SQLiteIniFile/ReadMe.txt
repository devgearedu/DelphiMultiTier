What is TFDSQLiteIniFile
------------------------

The TFDSQLiteIniFile is SQLite based implementation of the 
TIniFile VCL base class. For details, see Demo application.


Why TFDSQLiteIniFile ?
----------------------

1) Access time to any Key is not dependent on the Keys number. 
TFDSQLiteIniFile may handle thousands of the keys without any
performance degradation.

2) TFDSQLiteIniFile has additional methods - Read / WriteStrigs, 
Read / WriteStreams - an application can store memos, files and
other large objects in the FDSQliteIniFile.

3) The IniFile data can be queried with a SQL and presented as 
a DataSet.

License
-------

The TFDSQLiteIniFile is absolutely free.

Author
------

Branko Burdian, burdian@siol.net

History
-------

2010-Mar-15  First release.
2010-May-31  Added possibility of stream compression.
2010-Jun-01  procedure StartTransaction -> function StartTransaction
2010-Sep-20  TSQLiteCollationCompareStringW.Constructor is changed in 4.0.3.
             Added SQLite password
