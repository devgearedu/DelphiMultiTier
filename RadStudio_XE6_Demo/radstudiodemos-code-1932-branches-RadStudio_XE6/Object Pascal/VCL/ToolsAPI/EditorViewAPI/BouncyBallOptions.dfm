object BouncyBallOptionsFrame: TBouncyBallOptionsFrame
  Left = 0
  Top = 0
  Width = 398
  Height = 153
  TabOrder = 0
  DesignSize = (
    398
    153)
  object lbColor: TLabel
    Left = 16
    Top = 16
    Width = 29
    Height = 13
    Caption = 'C&olor:'
    FocusControl = BallColorBox
  end
  object lbHStep: TLabel
    Left = 16
    Top = 74
    Width = 77
    Height = 13
    Caption = '&Horizontal Step:'
    FocusControl = HStepEdit
  end
  object lbVStep: TLabel
    Left = 15
    Top = 101
    Width = 64
    Height = 13
    Caption = '&Vertical Step:'
    FocusControl = VStepEdit
  end
  object BallColorBox: TColorBox
    Left = 51
    Top = 13
    Width = 319
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = BallColorBoxChange
    ExplicitWidth = 241
  end
  object CycleColorsCB: TCheckBox
    Left = 51
    Top = 41
    Width = 97
    Height = 17
    Caption = '&Cycle Colors'
    TabOrder = 1
  end
  object HStepEdit: TEdit
    Left = 99
    Top = 71
    Width = 252
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = '0'
    ExplicitWidth = 174
  end
  object VStepEdit: TEdit
    Left = 99
    Top = 98
    Width = 252
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = '0'
    ExplicitWidth = 174
  end
  object HStepUpDown: TUpDown
    Left = 351
    Top = 71
    Width = 16
    Height = 21
    Anchors = [akTop, akRight]
    Associate = HStepEdit
    Max = 20
    TabOrder = 4
    ExplicitLeft = 273
  end
  object VStepUpDown: TUpDown
    Left = 351
    Top = 98
    Width = 16
    Height = 21
    Anchors = [akTop, akRight]
    Associate = VStepEdit
    Max = 20
    TabOrder = 5
    ExplicitLeft = 273
  end
  object UseExistingCB: TCheckBox
    Left = 16
    Top = 128
    Width = 351
    Height = 17
    Caption = 
      '&Use existing view (if available) when creating a Bouncy Ball vi' +
      'ew'
    TabOrder = 6
  end
end
