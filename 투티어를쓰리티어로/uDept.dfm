object DeptForm: TDeptForm
  Left = 0
  Top = 0
  Caption = #48512#49436#44288#47532
  ClientHeight = 415
  ClientWidth = 478
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    478
    415)
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 410
    Height = 49
    DataSource = DM.DeptSource
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 72
    Width = 456
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    DataSource = DM.DeptSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 200
    Width = 462
    Height = 207
    ActivePage = TabSheet4
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #49345#49464#51312#54924
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 454
        Height = 179
        Align = alClient
        DataSource = DM.InsaQuerySource
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object TabSheet2: TTabSheet
      Caption = #51064#50896#49688
      ImageIndex = 1
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 454
        Height = 179
        Align = alClient
        ColCount = 3
        DrawingStyle = gdsClassic
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
      end
    end
    object TabSheet3: TTabSheet
      Caption = #46321#47197'('#51200#51109#54532#47196#49884#51200')'
      ImageIndex = 2
      object Label1: TLabel
        Left = 64
        Top = 32
        Width = 44
        Height = 13
        Caption = #48512#49436#53076#46300
      end
      object Label2: TLabel
        Left = 64
        Top = 64
        Width = 33
        Height = 13
        Caption = #48512#49436#47749
      end
      object Label3: TLabel
        Left = 64
        Top = 104
        Width = 22
        Height = 13
        Caption = #54016#47749
      end
      object Edit1: TEdit
        Left = 136
        Top = 24
        Width = 121
        Height = 21
        MaxLength = 4
        TabOrder = 0
        OnChange = Edit1Change
      end
      object Edit2: TEdit
        Left = 136
        Top = 59
        Width = 121
        Height = 21
        MaxLength = 6
        TabOrder = 1
        OnChange = Edit1Change
      end
      object Edit3: TEdit
        Left = 136
        Top = 96
        Width = 121
        Height = 21
        MaxLength = 8
        TabOrder = 2
        OnChange = Edit1Change
      end
      object Button1: TButton
        Left = 272
        Top = 72
        Width = 153
        Height = 49
        Caption = #46321#47197
        TabOrder = 3
        OnClick = Button1Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = #49828#53944#47553#44536#47532#46300'('#52404#53356#48149#49828')'
      ImageIndex = 3
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 454
        Height = 179
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object Button2: TButton
    Left = 424
    Top = 8
    Width = 46
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = #50641#49472#47196
    TabOrder = 3
    OnClick = Button2Click
  end
end
