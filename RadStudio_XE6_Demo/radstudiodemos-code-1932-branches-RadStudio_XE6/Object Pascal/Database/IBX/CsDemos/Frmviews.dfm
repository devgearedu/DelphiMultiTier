object FrmViewDemo: TFrmViewDemo
  Left = 145
  Top = 99
  ActiveControl = Panel1
  Caption = 'Table/View Switcher'
  ClientHeight = 298
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 390
    Height = 41
    Align = alTop
    TabOrder = 0
    object BtnShowEmployee: TSpeedButton
      Left = 258
      Top = 8
      Width = 25
      Height = 25
      Hint = 'Show Employee Table'
      GroupIndex = 1
      Down = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777777777777777777778877778877778877FF7777FF7777FF700887700887
        7007787FF77887F7788777008800808800777787FF8878FF8877777000077000
        07777778788778888777778700877800877877F788F77F88F77F707800870700
        8707787F88F78788F7877708008088008087778F88F87F88F8F7770000008800
        0077778888887F88887777700007700007777778888778888777777700887700
        8877777788FF7788FF7777700008700008777778888F78888F77777000077000
        0777777888877888877777770077770077777777887777887777777777777777
        7777777777777777777777777777777777777777777777777777}
      NumGlyphs = 2
      OnClick = BtnShowEmployeeClick
    end
    object BtnShowPhoneList: TSpeedButton
      Left = 282
      Top = 8
      Width = 25
      Height = 25
      Hint = 'Show Phone List View'
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00707007007700
        7077707007FF77007F77770770070077070777077007F07707F7007007000770
        0007FF7FF7F0077FF0F7F07F07F0770000000F70F70F7F00007F777777777064
        440077777777F077770F0070070006666400FF7FF7FF0777770FF07F07F06640
        74070F70F7F0777FF707777777066400407777777F077F00F077007000664070
        0777FF7FF077F0700777F07F0664077777770F7F077F07777777777066407777
        7777777077F0777777770006640007777777FF0F7707F7777777F00760000777
        77770F0F7770F77777777707644077777777770F7770777777777707C6077777
        77777707FF077777777777700077777777777770007777777777}
      NumGlyphs = 2
      OnClick = BtnShowPhoneListClick
    end
    object DBNavigator: TDBNavigator
      Left = 8
      Top = 8
      Width = 240
      Height = 25
      DataSource = VaryingTableSource
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 320
      Top = 8
      Width = 60
      Height = 25
      Hint = 'Exit and close this form'
      Caption = 'E&xit'
      Kind = bkClose
      NumGlyphs = 2
      Style = bsNew
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 390
    Height = 257
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 4
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 6
      Top = 6
      Width = 378
      Height = 245
      Align = alClient
      BorderStyle = bsNone
      DataSource = VaryingTableSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object VaryingTableSource: TDataSource
    DataSet = VaryingTable
    Left = 44
    Top = 127
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\EMPLOYEE.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 240
    Top = 56
  end
  object IBTransaction1: TIBTransaction
    Left = 312
    Top = 56
  end
  object VaryingTable: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from EMPLOYEE')
    ParamCheck = True
    UniDirectional = False
    Left = 184
    Top = 64
  end
end
