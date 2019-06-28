object FrmTriggerDemo: TFrmTriggerDemo
  Left = 144
  Top = 75
  Hint = 'Explore the EmployeeTable to see the trigger sources'
  ActiveControl = Panel1
  Caption = 'Salary Change Auditing'
  ClientHeight = 304
  ClientWidth = 375
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
    Width = 375
    Height = 41
    Align = alTop
    TabOrder = 0
    object DBNavigator: TDBNavigator
      Left = 8
      Top = 8
      Width = 232
      Height = 25
      DataSource = DmEmployee.EmployeeSource
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 315
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
    Width = 375
    Height = 137
    Align = alTop
    BevelInner = bvLowered
    BorderWidth = 4
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 6
      Top = 6
      Width = 363
      Height = 125
      Hint = 'Changing a salary initiates a trigger'
      Align = alClient
      BorderStyle = bsNone
      DataSource = DmEmployee.EmployeeSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'FULL_NAME'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALARY'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'JOB_GRADE'
          ReadOnly = True
          Width = 64
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 178
    Width = 375
    Height = 126
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 4
    Caption = 'Panel3'
    TabOrder = 2
    object DBGrid2: TDBGrid
      Left = 6
      Top = 6
      Width = 363
      Height = 114
      Hint = 'Salary history is maintained by a trigger on salary change'
      Align = alClient
      BorderStyle = bsNone
      DataSource = DmEmployee.SalaryHistorySource
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'EMPLOYEE'
          Width = 123
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHANGE_DATE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OLD_SALARY'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NEW_SALARY'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PERCENT_CHANGE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UPDATER_ID'
          Visible = True
        end>
    end
  end
end
