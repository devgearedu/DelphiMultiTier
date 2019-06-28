object UpdateForm: TUpdateForm
  Left = 0
  Top = 0
  Caption = #51312#51064#46108#53244#47532#50629#45936#51060#53944
  ClientHeight = 502
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 516
    Height = 42
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates, nbCancelUpdates]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 223
    Width = 516
    Height = 42
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 280
    Width = 57
    Height = 25
    Caption = #52992#49772
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object DBNavigator2: TDBNavigator
    Left = 88
    Top = 279
    Width = 420
    Height = 25
    DataSource = DM.DeptSource
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates, nbCancelUpdates]
    TabOrder = 3
  end
  object Button2: TButton
    Left = 8
    Top = 465
    Width = 75
    Height = 29
    Caption = 'CancelUpdates'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 469
    Width = 75
    Height = 25
    Caption = 'revertrecord'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 216
    Top = 469
    Width = 75
    Height = 25
    Caption = 'applyupdates'
    TabOrder = 6
    OnClick = Button4Click
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 424
    Width = 121
    Height = 21
    DataField = 'CODE'
    DataSource = DM.DeptSource
    TabOrder = 7
  end
  object DBEdit2: TDBEdit
    Left = 152
    Top = 424
    Width = 121
    Height = 21
    DataField = 'DEPT'
    DataSource = DM.DeptSource
    TabOrder = 8
  end
  object DBEdit3: TDBEdit
    Left = 304
    Top = 424
    Width = 121
    Height = 21
    DataField = 'SECTION'
    DataSource = DM.DeptSource
    TabOrder = 9
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 513
    Height = 161
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 16
    Top = 312
    Width = 492
    Height = 106
    DataSource = DM.DeptSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button5: TButton
    Left = 320
    Top = 467
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 12
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 416
    Top = 469
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 13
    OnClick = Button6Click
  end
  object FDQuery1: TFDQuery
    Active = True
    CachedUpdates = True
    Connection = DM.FDConnection1
    UpdateObject = FDUpdateSQL1
    SQL.Strings = (
      'select * from dept, insa'
      'where code = dept_code')
    Left = 352
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 400
    Top = 160
  end
  object FDUpdateSQL1: TFDUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO DEPT'
      '(CODE, DEPT, SECTION)'
      'VALUES (:NEW_CODE, :NEW_DEPT, :NEW_SECTION)')
    ModifySQL.Strings = (
      'UPDATE DEPT'
      'SET CODE = :NEW_CODE, DEPT = :NEW_DEPT, SECTION = :NEW_SECTION'
      'WHERE CODE = :OLD_CODE')
    DeleteSQL.Strings = (
      'DELETE FROM DEPT'
      'WHERE CODE = :OLD_CODE')
    FetchRowSQL.Strings = (
      'SELECT CODE, DEPT, SECTION'
      'FROM DEPT'
      'WHERE CODE = :OLD_CODE')
    Left = 464
    Top = 448
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 360
    Top = 336
  end
end
