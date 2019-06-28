object dmEvents: TdmEvents
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 269
  Width = 370
  object Database1: TIBDatabase
    Connected = True
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\EVENTS.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    SQLDialect = 1
    Left = 32
    Top = 164
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = Database1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 104
    Top = 164
  end
  object StoredProc1: TIBStoredProc
    Database = Database1
    Transaction = IBTransaction1
    StoredProcName = 'EVENTDEMO'
    Left = 208
    Top = 168
    ParamData = <
      item
        DataType = ftString
        Name = 'EVENT'
        ParamType = ptInput
      end>
  end
  object IBEventAlerter1: TIBEvents
    AutoRegister = False
    Database = Database1
    Registered = False
    OnEventAlert = IBEventAlerter1EventAlert
    Left = 292
    Top = 172
  end
end
