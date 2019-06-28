object Form58: TForm58
  Left = 0
  Top = 0
  Caption = 'Delphi DataSnap Client'
  ClientHeight = 466
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    622
    466)
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 7
    Top = 98
    Width = 41
    Height = 13
    Caption = 'URLPath'
  end
  object Label8: TLabel
    Left = 9
    Top = 71
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label7: TLabel
    Left = 9
    Top = 44
    Width = 39
    Height = 13
    Caption = 'Protocol'
  end
  object Label6: TLabel
    Left = 9
    Top = 17
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label1: TLabel
    Left = 8
    Top = 182
    Width = 55
    Height = 13
    Caption = 'Class Name'
  end
  object Label2: TLabel
    Left = 8
    Top = 206
    Width = 66
    Height = 13
    Caption = 'Method Name'
  end
  object Label3: TLabel
    Left = 22
    Top = 125
    Width = 26
    Height = 13
    Caption = 'User:'
  end
  object Label4: TLabel
    Left = 17
    Top = 151
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 416
    Top = 259
    Width = 71
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Repeat Count:'
    ExplicitLeft = 406
  end
  object LabelTime: TLabel
    Left = 500
    Top = 283
    Width = 6
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '0'
    ExplicitLeft = 490
  end
  object Label11: TLabel
    Left = 416
    Top = 283
    Width = 26
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Time:'
    ExplicitLeft = 406
  end
  object EditURLPath: TEdit
    Left = 77
    Top = 95
    Width = 288
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
    OnChange = EditChange
  end
  object EditPort: TEdit
    Left = 77
    Top = 68
    Width = 73
    Height = 21
    TabOrder = 5
    Text = '211'
    OnChange = EditChange
  end
  object ComboBoxProtocol: TComboBox
    Left = 77
    Top = 41
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'tcp/ip'
    OnChange = ComboBoxProtocolChange
    Items.Strings = (
      'tcp/ip'
      'http')
  end
  object EditHost: TEdit
    Left = 77
    Top = 14
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'localhost'
    OnChange = EditChange
  end
  object ButtonEchoString: TButton
    Left = 415
    Top = 228
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'EchoString'
    TabOrder = 12
    OnClick = ButtonEchoStringClick
  end
  object EditValue: TEdit
    Left = 8
    Top = 230
    Width = 401
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 11
    Text = 'Echo this  text'
  end
  object EditServerClass: TEdit
    Left = 77
    Top = 179
    Width = 332
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 9
    Text = 'TServerMethods1'
  end
  object ButtonCloseConnection: TButton
    Left = 16
    Top = 270
    Width = 105
    Height = 25
    Caption = 'Close Connection'
    TabOrder = 14
    OnClick = ButtonCloseConnectionClick
  end
  object EditMethodName: TEdit
    Left = 77
    Top = 203
    Width = 332
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 10
    Text = 'ReverseString'
  end
  object EditUser: TEdit
    Left = 77
    Top = 122
    Width = 156
    Height = 21
    TabOrder = 7
    OnChange = EditChange
  end
  object EditPassword: TEdit
    Left = 77
    Top = 149
    Width = 156
    Height = 21
    TabOrder = 8
    OnChange = EditChange
  end
  object Memo1: TMemo
    Left = 8
    Top = 328
    Width = 598
    Height = 92
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 15
    WordWrap = False
  end
  object ButtonClear: TButton
    Left = 531
    Top = 433
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Clear'
    TabOrder = 16
    OnClick = ButtonClearClick
  end
  object CheckBoxBasicHTTPAuth: TCheckBox
    Left = 170
    Top = 41
    Width = 186
    Height = 17
    Caption = 'Basic Authentication'
    TabOrder = 2
    OnClick = OnCheckBoxClick
  end
  object CheckBoxUseHTTPProxy: TCheckBox
    Left = 170
    Top = 64
    Width = 178
    Height = 17
    Caption = 'Use HTTP Proxy (e.g.; Fiddler)'
    TabOrder = 3
    OnClick = OnCheckBoxClick
  end
  object GroupBoxFilters: TGroupBox
    Left = 362
    Top = 8
    Width = 242
    Height = 121
    Caption = 'Filters'
    TabOrder = 4
    object LabelRSAKeyLength: TLabel
      Left = 84
      Top = 37
      Width = 81
      Height = 13
      Caption = 'RSA Key Length:'
    end
    object LabelRSAKeyExponent: TLabel
      Left = 84
      Top = 64
      Width = 94
      Height = 13
      Caption = 'RSA Key Exponent:'
    end
    object LabelPC1Key: TLabel
      Left = 12
      Top = 91
      Width = 44
      Height = 13
      Caption = 'PC1 Key:'
    end
    object CheckBoxRSA: TCheckBox
      Left = 12
      Top = 15
      Width = 45
      Height = 17
      Caption = 'RSA'
      TabOrder = 0
      OnClick = FilterChange
    end
    object CheckBoxPC1: TCheckBox
      Left = 12
      Top = 38
      Width = 50
      Height = 17
      Caption = 'PC1'
      TabOrder = 1
    end
    object CheckBoxZLib: TCheckBox
      Left = 12
      Top = 61
      Width = 50
      Height = 17
      Caption = 'ZLib'
      TabOrder = 2
    end
    object EditRSAKeyLength: TEdit
      Left = 184
      Top = 34
      Width = 49
      Height = 21
      TabOrder = 4
      Text = '1024'
      OnClick = FilterChange
    end
    object CheckBoxRSAGlobalKey: TCheckBox
      Left = 84
      Top = 14
      Width = 97
      Height = 17
      Caption = 'RSA Global Key'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = FilterChange
    end
    object EditRSAKeyExponent: TEdit
      Left = 199
      Top = 61
      Width = 34
      Height = 21
      TabOrder = 5
      Text = '3'
      OnClick = FilterChange
    end
    object EditPC1Key: TEdit
      Left = 84
      Top = 88
      Width = 149
      Height = 21
      TabOrder = 6
      Text = '16char clientkey'
      OnClick = FilterChange
    end
  end
  object EditRepeatCount: TEdit
    Left = 497
    Top = 256
    Width = 90
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 13
    Text = '1'
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'Datasnap'
    LoginPrompt = False
    Params.Strings = (
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=15.0.0.0,Culture=neutral,PublicKey' +
        'Token=a91a7c5705831a4f'
      'DriverUnit=DbxDataSnap'
      
        'Filters={"PC1":{"Key":"LiveStrongLance!"},"RSA":{"UseGlobalKey":' +
        '"true","KeyLength":"1024","KeyExponent":"3"}}')
    BeforeConnect = SQLConnection1BeforeConnect
    Left = 296
    Top = 136
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 144
    Top = 270
  end
end
