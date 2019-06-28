object FmAboutBox: TFmAboutBox
  Left = 274
  Top = 158
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 403
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 402
    Height = 73
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
      Width = 65
      Height = 57
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        0000200000000100040000000000000200000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00000000000000000000000000000000000EE8787878EEEEEEE03F30878EEE
        EEE00EE8787878EEEEEEE03F30878EEEEEE00EE8787878EEEEEEE03F30878EEE
        EEE00EE8787878EEEEEEE03F30878EEEEEE00887787877788888803F3088787E
        EEE00788787878878887803F3088887EEEE00788887888878887803F3088887E
        EEE00877888887788888703F308887EEEEE00888777778888888037883088888
        8EE007777777777777703787883087777EE00888888888888803787FF8830888
        888008888888888880378777778830888880077777777788037873F3F3F87808
        88E00888888888803787FFFFFFFF8830EEE00887777778800001111111111100
        EEE00888888888888899B999B99999EEEEE00888888888888899B9B99BB9B9EE
        EEE0088888888888899BB9BB99BB99EEEEE0078888888888899B999B999999EE
        EEE0087788888778899B9B9BB9BB99EEEEE00888778778888E9B9B9BB9999EEE
        EEE0088888788888EE9B99B9BB9BEEEEEEE00EE8888888EEEEE999B9999EEEEE
        EEE00EEEE888EEEEEEEE99BB999EEEEEEEE00EEEEE8EEEEEEEEEE999B9EEEEEE
        EEE00EEEEE8EEEEEEEEEEEE999EEEEEEEEE00EEEEE8EEEEEEEEEEEEE99EEEEEE
        EEE00EEEEE8EEEEEEEEEEEEE9EEEEEEEEEE00EEEEE8EEEEEEEEEEEEEEEEEEEEE
        EEE00EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE00000000000000000000000000000
        0000}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 88
      Top = 16
      Width = 119
      Height = 13
      Caption = 'Database Errors Example'
      IsControl = True
    end
    object Version: TLabel
      Left = 88
      Top = 40
      Width = 53
      Height = 13
      Caption = 'Version 1.5'
      IsControl = True
    end
  end
  object Panel2: TPanel
    Left = 9
    Top = 88
    Width = 401
    Height = 73
    TabOrder = 1
    object Label2: TLabel
      Left = 22
      Top = 8
      Width = 194
      Height = 13
      Caption = 'Data Model  - Referential Integrity'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 169
    Width = 401
    Height = 193
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'This example demonstrates'
      ''
      '  - The use of Data Modules to centralize coding'
      '  - A one-to-many-to-many form'
      '  - Trapping and Controlling Database Errors'
      ''
      '* Creation Order'
      ''
      'The proper functioning of any form with a one-to-many '
      'relationship depends on the creation order of data components '
      'like '
      'TDatasources at runtime. In this example, the MasterSource '
      'property of the Orders table point to CustomerSource. For the '
      'one-to-many link to properly synch up, the Customer table must '
      'be active. The creation order is determined at design'
      'time by right-clicking on the form and choosing Creation Order.'
      ''
      '* Database Error Trapping'
      ''
      'Delphi displays errors that raise from user interaction with '
      'database tables as application level exceptions. '
      ''
      
        'To trigger these errors, run this application, and try to modify' +
        ','
      'add, or delete records. '
      ''
      'You may encounter several different database '
      'errors: key violations, missing  required fields, referential'
      'integrity errors, incorrect foreign keys, '
      'and so on. '
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    WantReturns = False
  end
  object Button1: TButton
    Left = 173
    Top = 368
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 2
    TabOrder = 3
  end
end
