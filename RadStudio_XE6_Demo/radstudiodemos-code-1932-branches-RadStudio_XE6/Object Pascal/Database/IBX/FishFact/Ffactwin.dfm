object Form1: TForm1
  Left = 127
  Top = 92
  ActiveControl = DBImage1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FISH FACTS'
  ClientHeight = 533
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 33
    Width = 259
    Height = 263
    Hint = 'Scroll grid below to see other fish'
    Align = alLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object DBLabel1: TDBText
      Left = 4
      Top = 183
      Width = 249
      Height = 24
      DataField = 'Common_Name'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'MS Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object DBImage1: TDBImage
      Left = 1
      Top = 1
      Width = 248
      Height = 261
      Hint = 'Scroll grid below to see other fish'
      Align = alLeft
      DataField = 'Graphic'
      DataSource = DataSource1
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 265
    Top = 39
    Width = 271
    Height = 22
    TabOrder = 1
    object Label1: TLabel
      Left = 5
      Top = 4
      Width = 56
      Height = 13
      Caption = 'About the'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBLabel2: TDBText
      Left = 67
      Top = 4
      Width = 99
      Height = 13
      AutoSize = True
      DataField = 'Common_Name'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel3: TPanel
    Left = 265
    Top = 85
    Width = 336
    Height = 193
    BevelOuter = bvLowered
    TabOrder = 2
    object DBMemo1: TDBMemo
      Left = 1
      Top = 1
      Width = 334
      Height = 191
      Align = alClient
      BorderStyle = bsNone
      Color = clSilver
      Ctl3D = False
      DataField = 'Notes'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 296
    Width = 631
    Height = 237
    Align = alBottom
    BevelInner = bvRaised
    BorderStyle = bsSingle
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 623
      Height = 229
      Hint = 'Scroll up/down to see other fish!'
      Align = alClient
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CATEGORY'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPECIES_NAME'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LENGTH__CM_'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LENGTH_IN'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMMON_NAME'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTES'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'GRAPHIC'
          Visible = False
        end>
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 33
    Align = alTop
    TabOrder = 4
    object lbStyle: TLabel
      Left = 8
      Top = 10
      Width = 63
      Height = 13
      Caption = 'Change Style'
    end
    object cbStyles: TComboBox
      Left = 77
      Top = 7
      Width = 156
      Height = 21
      TabOrder = 0
      Text = 'cbStyles'
      OnClick = cbStylesClick
    end
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 187
    Top = 137
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\dbdemos.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 48
    Top = 64
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Left = 112
    Top = 64
  end
  object IBDataSet1: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from BIOLIFE'
      'where'
      '  SPECIES_NO = :OLD_SPECIES_NO')
    InsertSQL.Strings = (
      'insert into BIOLIFE'
      
        '  (CATEGORY, COMMON_NAME, GRAPHIC, LENGTH__CM_, LENGTH_IN, NOTES' +
        ', SPECIES_NAME, '
      '   SPECIES_NO)'
      'values'
      
        '  (:CATEGORY, :COMMON_NAME, :GRAPHIC, :LENGTH__CM_, :LENGTH_IN, ' +
        ':NOTES, '
      '   :SPECIES_NAME, :SPECIES_NO)')
    RefreshSQL.Strings = (
      'Select '
      '  SPECIES_NO,'
      '  CATEGORY,'
      '  COMMON_NAME,'
      '  SPECIES_NAME,'
      '  LENGTH__CM_,'
      '  LENGTH_IN,'
      '  NOTES,'
      '  GRAPHIC'
      'from BIOLIFE '
      'where'
      '  SPECIES_NO = :SPECIES_NO')
    SelectSQL.Strings = (
      'select * from BIOLIFE')
    ModifySQL.Strings = (
      'update BIOLIFE'
      'set'
      '  CATEGORY = :CATEGORY,'
      '  COMMON_NAME = :COMMON_NAME,'
      '  GRAPHIC = :GRAPHIC,'
      '  LENGTH__CM_ = :LENGTH__CM_,'
      '  LENGTH_IN = :LENGTH_IN,'
      '  NOTES = :NOTES,'
      '  SPECIES_NAME = :SPECIES_NAME,'
      '  SPECIES_NO = :SPECIES_NO'
      'where'
      '  SPECIES_NO = :OLD_SPECIES_NO')
    ParamCheck = True
    UniDirectional = False
    Active = True
    Left = 48
    Top = 129
  end
end
