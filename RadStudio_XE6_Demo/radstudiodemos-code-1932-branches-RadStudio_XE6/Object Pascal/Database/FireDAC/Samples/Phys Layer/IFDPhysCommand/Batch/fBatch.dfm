inherited frmMain: TfrmMain
  Left = 314
  Top = 197
  Width = 528
  Height = 470
  Caption = 'Batch'
  Font.Name = 'MS Sans Serif'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTitle: TPanel
    Width = 520
    inherited bvlTitle: TBevel
      Width = 462
    end
    inherited imgAnyDAC: TImage
      Left = 462
    end
    inherited lblTitle: TLabel
      Width = 60
      Caption = 'Batch'
    end
  end
  inherited pnlMain: TPanel
    Width = 520
    Height = 327
    inherited pnlConnection: TPanel
      Width = 520
      inherited lblUseConnectionDef: TLabel
        Width = 126
      end
      object Label1: TLabel [1]
        Left = 164
        Top = 22
        Width = 80
        Height = 13
        Caption = 'Records to insert'
      end
      inherited cbDB: TComboBox
        TabOrder = 1
      end
      object chbBlobs: TCheckBox
        Left = 327
        Top = 21
        Width = 97
        Height = 17
        Caption = 'Insert blobs'
        TabOrder = 0
      end
      object edtRecordsToInsert: TEdit
        Left = 250
        Top = 19
        Width = 65
        Height = 21
        TabOrder = 2
        Text = '10000'
      end
    end
    inherited Console: TMemo
      Width = 509
      Height = 274
    end
  end
  inherited pnlButtons: TPanel
    Top = 380
    Width = 520
    inherited bvlButtons: TBevel
      Width = 520
    end
    inherited btnClose: TButton
      Left = 441
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 417
    Width = 520
    Height = 19
    Panels = <
      item
        Width = 270
      end
      item
        Width = 270
      end>
  end
end
