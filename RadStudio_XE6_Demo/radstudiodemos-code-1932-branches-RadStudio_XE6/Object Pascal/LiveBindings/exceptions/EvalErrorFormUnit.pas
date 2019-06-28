
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit EvalErrorFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Data.Bind.Components, Vcl.StdCtrls,
  Vcl.Bind.Editors;

type
  TForm38 = class(TForm)
    LabelControl: TLabel;
    LabelSourceExpression: TLabel;
    EditSourceExpression: TEdit;
    BindingsList1: TBindingsList;
    BindExpression1: TBindExpression;
    LabelSource: TLabel;
    EditControlExpression: TEdit;
    LabelControlExpression: TLabel;
    EditSourceComponent: TEdit;
    EditControlComponent: TEdit;
    ButtonEvaluate: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelDirection: TLabel;
    EditDirection: TEdit;
    Memo1: TMemo;
    procedure BindExpression1EvalError(Sender: TObject; AException: Exception);
    procedure FormCreate(Sender: TObject);
    procedure ButtonEvaluateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form38: TForm38;

implementation

{$R *.dfm}

procedure TForm38.BindExpression1EvalError(Sender: TObject;
  AException: Exception);
begin
  // raise a new exception with more information
  raise TBindCompException.CreateFmt(
    'Evaluation Exception'#13#10 +
    'Component Name: %s'#13#10 +
    'Exception Class: %s'#13#10 +
    'Exception Message: %s',
    [TComponent(Sender).Name, AException.ClassName, AException.Message]);

end;

procedure TForm38.ButtonEvaluateClick(Sender: TObject);
begin
  BindExpression1.Active := False;
  // Update component with expressions typed by the user
  BindExpression1.SourceExpression := EditSourceExpression.Text;
  BindExpression1.ControlExpression := EditControlExpression.Text;
  BindExpression1.Active := True;
end;

procedure TForm38.FormCreate(Sender: TObject);
begin
  EditSourceComponent.Text :=
    Format('%s: %s', [BindExpression1.SourceComponent.Name, BindExpression1.SourceComponent.ClassName]);
  EditControlComponent.Text :=
    Format('%s: %s', [BindExpression1.ControlComponent.Name, BindExpression1.ControlComponent.ClassName]);
  EditSourceExpression.Text := BindExpression1.SourceExpression;
  EditControlExpression.Text := BindExpression1.ControlExpression;
  case BindExpression1.Direction of
    dirSourceToControl:
      EditDirection.Text := 'SourceToControl';
    dirControlToSource:
      EditDirection.Text := 'ControlToSource';
    dirBidirectional:
      EditDirection.Text := 'Bidirectional';
  end;
end;

end.
