object Form38: TForm38
  Left = 0
  Top = 0
  Caption = 'Form38'
  ClientHeight = 413
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    402
    413)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelControl: TLabel
    Left = 8
    Top = 183
    Width = 95
    Height = 13
    Caption = 'Source Component:'
  end
  object LabelSourceExpression: TLabel
    Left = 8
    Top = 237
    Width = 92
    Height = 13
    Caption = 'Source Expression:'
  end
  object LabelSource: TLabel
    Left = 8
    Top = 210
    Width = 97
    Height = 13
    Caption = 'Control Component:'
  end
  object LabelControlExpression: TLabel
    Left = 8
    Top = 265
    Width = 94
    Height = 13
    Caption = 'Control Expression:'
  end
  object Label1: TLabel
    Left = 24
    Top = 351
    Width = 28
    Height = 13
    Caption = 'Edit1:'
  end
  object Label2: TLabel
    Left = 216
    Top = 351
    Width = 28
    Height = 13
    Caption = 'Edit2:'
  end
  object LabelDirection: TLabel
    Left = 8
    Top = 291
    Width = 46
    Height = 13
    Caption = 'Direction:'
  end
  object EditSourceExpression: TEdit
    Left = 118
    Top = 234
    Width = 274
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = 'EditSourceExpression'
  end
  object EditControlExpression: TEdit
    Left = 119
    Top = 261
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    Text = 'EditSourceExpression'
  end
  object EditSourceComponent: TEdit
    Left = 118
    Top = 180
    Width = 121
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = 'EditSourceComponent'
  end
  object EditControlComponent: TEdit
    Left = 118
    Top = 207
    Width = 121
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = 'EditSourceComponent'
  end
  object ButtonEvaluate: TButton
    Left = 119
    Top = 319
    Width = 75
    Height = 25
    Caption = 'Evaluate'
    TabOrder = 6
    OnClick = ButtonEvaluateClick
  end
  object Edit1: TEdit
    Left = 24
    Top = 370
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 216
    Top = 370
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'Edit2'
  end
  object EditDirection: TEdit
    Left = 119
    Top = 288
    Width = 121
    Height = 21
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Text = 'EditDirection'
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 386
    Height = 159
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'This sample demonstrates how to use the OnEvalError '
      
        'event handler to intercept exceptions that occur while evaluatin' +
        'g a '
      
        'binding expression in the expression engine, and raise a more in' +
        'formative '
      'exception.'
      ''
      
        'To cause an exception, type in an invalid expression and click "' +
        'Evaluate".  '
      'Examples of invalid expressions:'
      ''
      'Missing closing quote:   "abc'
      'Method error:  Format("%d", "abc")'
      'Conversion error: "Text" + 1')
    ReadOnly = True
    TabOrder = 0
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    UseAppManager = True
    Left = 304
    Top = 303
    object BindExpression1: TBindExpression
      Category = 'Binding Expressions'
      ControlComponent = Edit1
      SourceComponent = Edit2
      SourceExpression = 'Text'
      ControlExpression = 'Text'
      AutoActivate = False
      NotifyOutputs = False
      Direction = dirSourceToControl
      OnEvalError = BindExpression1EvalError
    end
  end
end
