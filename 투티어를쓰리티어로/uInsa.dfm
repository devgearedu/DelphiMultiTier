object InsaForm: TInsaForm
  Left = 0
  Top = 0
  Caption = #49324#50896#44288#47532
  ClientHeight = 399
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    611
    399)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 417
    Top = 17
    Width = 23
    Height = 22
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333FF3333333333333003333333333333F77F33333333333009033
      333333333F7737F333333333009990333333333F773337FFFFFF330099999000
      00003F773333377777770099999999999990773FF33333FFFFF7330099999000
      000033773FF33777777733330099903333333333773FF7F33333333333009033
      33333333337737F3333333333333003333333333333377333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 438
    Top = 16
    Width = 23
    Height = 22
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
      3333333333777F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
      3333333777737777F333333099999990333333373F3333373333333309999903
      333333337F33337F33333333099999033333333373F333733333333330999033
      3333333337F337F3333333333099903333333333373F37333333333333090333
      33333333337F7F33333333333309033333333333337373333333333333303333
      333333333337F333333333333330333333333333333733333333}
    NumGlyphs = 2
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 459
    Top = 17
    Width = 23
    Height = 22
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333337F33333333333333033333333333333373F333333333333090333
      33333333337F7F33333333333309033333333333337373F33333333330999033
      3333333337F337F33333333330999033333333333733373F3333333309999903
      333333337F33337F33333333099999033333333373333373F333333099999990
      33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333300033333333333337773333333}
    NumGlyphs = 2
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 479
    Top = 16
    Width = 23
    Height = 22
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333FF3333333333333003333
      3333333333773FF3333333333309003333333333337F773FF333333333099900
      33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
      99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
      33333333337F3F77333333333309003333333333337F77333333333333003333
      3333333333773333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    OnClick = SpeedButton4Click
  end
  object Label1: TLabel
    Left = 10
    Top = 18
    Width = 42
    Height = 19
    Caption = #44160#49353#49692
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 219
    Top = 16
    Width = 56
    Height = 19
    Caption = #44160#49353#51060#47492
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 56
    Width = 581
    Height = 335
    ActivePage = tabsheet3
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnDragDrop = PageControl1DragDrop
    OnDragOver = PageControl1DragOver
    OnMouseDown = PageControl1MouseDown
    OnMouseMove = PageControl1MouseMove
    OnMouseUp = PageControl1MouseUp
    OnStartDrag = PageControl1StartDrag
    object tabsheet1: TTabSheet
      Caption = #51312#54924
      ExplicitWidth = 583
      object TabControl1: TTabControl
        Left = 0
        Top = 0
        Width = 573
        Height = 307
        Align = alClient
        TabOrder = 0
        Tabs.Strings = (
          #51204#52404
          #49324#50896
          #45824#47532
          #44284#51109
          #48512#51109
          #52264#51109
          #51060#49324
          #51204#47924
          #49324#51109
          #51452#51076
          #52293#51076
          #49440#51076
          #44256#47928
          #44053#49324)
        TabIndex = 0
        OnChange = TabControl1Change
        ExplicitWidth = 583
        object DBGrid1: TDBGrid
          Left = 4
          Top = 24
          Width = 565
          Height = 279
          Align = alClient
          DataSource = DM.InsaSource
          Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
    end
    object tabsheet2: TTabSheet
      Caption = #54200#51665
      ImageIndex = 1
      ExplicitWidth = 583
      object 사번: TLabel
        Left = 32
        Top = 19
        Width = 22
        Height = 16
        Caption = #49324#48264
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 32
        Top = 48
        Width = 22
        Height = 16
        Caption = #51060#47492
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 32
        Top = 75
        Width = 22
        Height = 16
        Caption = #45208#51060
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 32
        Top = 104
        Width = 22
        Height = 16
        Caption = #51649#44553
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 32
        Top = 136
        Width = 22
        Height = 16
        Caption = #48512#49436
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 32
        Top = 165
        Width = 44
        Height = 16
        Caption = #51077#49324#51068#51088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 32
        Top = 187
        Width = 22
        Height = 16
        Caption = #44553#50668
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 241
        Top = 19
        Width = 22
        Height = 16
        Caption = #49324#51652
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = Label9Click
      end
      object DBEdit1: TDBEdit
        Left = 88
        Top = 18
        Width = 121
        Height = 21
        DataField = 'ID'
        DataSource = DM.InsaSource
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 88
        Top = 45
        Width = 121
        Height = 21
        DataField = 'NAME'
        DataSource = DM.InsaSource
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 88
        Top = 72
        Width = 121
        Height = 21
        DataField = 'AGE'
        DataSource = DM.InsaSource
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 88
        Top = 162
        Width = 121
        Height = 21
        DataField = 'IPSA_DATE'
        DataSource = DM.InsaSource
        MaxLength = 10
        TabOrder = 6
      end
      object DBEdit5: TDBEdit
        Left = 88
        Top = 189
        Width = 121
        Height = 21
        DataField = 'SALARY'
        DataSource = DM.InsaSource
        TabOrder = 7
      end
      object DBComboBox1: TDBComboBox
        Left = 88
        Top = 106
        Width = 121
        Height = 21
        DataField = 'CLASS'
        DataSource = DM.InsaSource
        Items.Strings = (
          #49324#50896
          #45824#47532
          #44284#51109
          #48512#51109
          #52264#51109
          #51204#47924
          #51060#49324)
        TabOrder = 3
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 88
        Top = 133
        Width = 121
        Height = 21
        DataField = 'DEPT_CODE'
        DataSource = DM.InsaSource
        KeyField = 'CODE'
        ListField = 'SECTION'
        ListSource = DM.DeptSource
        TabOrder = 5
      end
      object DBImage1: TDBImage
        Left = 278
        Top = 19
        Width = 105
        Height = 105
        DataField = 'PHOTO'
        DataSource = DM.InsaSource
        TabOrder = 8
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 405
        Top = 18
        Width = 164
        Height = 105
        Caption = #50628#47924#45733#47141
        DataField = 'GRADE'
        DataSource = DM.InsaSource
        Items.Strings = (
          #47588#50864#51339#51020
          #51339#51020
          #48372#53685
          #44536#51200#44536#47100)
        TabOrder = 4
        Values.Strings = (
          '1'
          '2'
          '3'
          '4')
      end
      object Button1: TButton
        Left = 280
        Top = 144
        Width = 103
        Height = 25
        Caption = 'Insert'
        TabOrder = 9
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 405
        Top = 144
        Width = 103
        Height = 25
        Caption = 'Delete'
        TabOrder = 10
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 280
        Top = 175
        Width = 103
        Height = 25
        Caption = 'Cancel'
        TabOrder = 11
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 405
        Top = 175
        Width = 103
        Height = 25
        Caption = 'Post'
        TabOrder = 12
        OnClick = Button4Click
      end
    end
    object tabsheet3: TTabSheet
      Caption = #52264#53944
      ImageIndex = 2
      ExplicitWidth = 583
      inline TFrame11: TFrame1
        Left = -8
        Top = -63
        Width = 469
        Height = 349
        TabOrder = 0
        ExplicitLeft = -8
        ExplicitTop = -63
        inherited DBChart1: TDBChart
          Left = 21
          Top = 77
          Width = 452
          Height = 211
          ExplicitLeft = 21
          ExplicitTop = 77
          ExplicitWidth = 452
          ExplicitHeight = 211
          PrintMargins = (
            15
            20
            15
            20)
          inherited Series1: TBarSeries
            DataSource = DM.insa
            XLabelsSource = 'NAME'
            YValues.ValueSource = 'SALARY'
          end
        end
        inherited Button1: TButton
          Left = 21
          Top = 294
          ExplicitLeft = 21
          ExplicitTop = 294
        end
        inherited Button2: TButton
          Left = 102
          Top = 294
          ExplicitLeft = 102
          ExplicitTop = 294
        end
        inherited Button3: TButton
          Left = 21
          Top = 325
          ExplicitLeft = 21
          ExplicitTop = 325
        end
        inherited Button4: TButton
          Left = 102
          Top = 325
          ExplicitLeft = 102
          ExplicitTop = 325
        end
        inherited ColorGrid1: TColorGrid
          Left = 183
          Top = 294
          ExplicitLeft = 183
          ExplicitTop = 294
        end
        inherited CheckBox1: TCheckBox
          Left = 286
          Top = 294
          ExplicitLeft = 286
          ExplicitTop = 294
        end
        inherited ComboBox1: TComboBox
          Left = 277
          Top = 325
          ExplicitLeft = 277
          ExplicitTop = 325
        end
      end
    end
  end
  object ComboBox1: TComboBox
    Left = 64
    Top = 17
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = #48264#54840
    OnChange = ComboBox1Change
    Items.Strings = (
      #48264#54840
      #51060#47492
      #48512#49436)
  end
  object Edit1: TEdit
    Left = 290
    Top = 17
    Width = 121
    Height = 21
    TabOrder = 2
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object RadioGroup1: TRadioGroup
    Left = 508
    Top = 8
    Width = 92
    Height = 66
    Caption = #44540#47924#44592#44036
    Items.Strings = (
      #51204#52404
      '1'#45380#48120#47564
      '1'#45380'~5'#45380
      '5'#45380'~10'#45380
      '10'#45380#51060#49345)
    TabOrder = 3
    OnClick = RadioGroup1Click
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 472
    Top = 40
  end
end
