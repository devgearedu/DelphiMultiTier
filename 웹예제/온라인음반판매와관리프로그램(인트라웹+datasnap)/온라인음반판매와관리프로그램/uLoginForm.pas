unit uLoginForm;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  IWCompEdit, Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, DBXDataSnap, DBXCommon, DB, DBClient, DSConnect,
  SqlExpr, uVars, IWCompRectangle, jpeg, IWExtCtrls, Graphics;

type
  TLoginForm = class(TIWAppForm)
    SQLConnection: TSQLConnection;
    DSProvider: TDSProviderConnection;
    MemberQuery: TClientDataSet;
    Rectangle: TIWRectangle;
    IDLabel: TIWLabel;
    PWLabel: TIWLabel;
    IdEdit: TIWEdit;
    PWEdit: TIWEdit;
    LoginButton: TIWButton;
    TitleLabel: TIWLabel;
    TitleImage: TIWImage;
    procedure LoginButtonClick(Sender: TObject);
  end;

implementation

uses uHomeForm;

{$R *.dfm}

procedure TLoginForm.LoginButtonClick(Sender: TObject);
begin
  with MemberQuery do begin
    Close;
    Params[0].AsString := IdEdit.Text;
    Open;

    // �Է��� ID�� ���� ����� ������ ���� ���
    if IsEmpty then begin
      WebApplication.ShowMessage('���� ���̵��Դϴ�.');
      IdEdit.Text := '';
      PWEdit.Text := '';
      IdEdit.SetFocus;
      Exit;
    end;

    // �н����尡 ��ġ���� ���� ���
    if FieldByName('password').AsString <> PWEdit.Text then begin
      WebApplication.ShowMessage('�н����尡 Ʋ�Ƚ��ϴ�.');
      PWEdit.Text := '';
      PWEdit.SetFocus;
      Exit;
    end;

    // �α��� ����
    LogInState := True;
    UserID := IdEdit.Text;
    Release;
    THomeForm.Create(WebApplication).Show;
  end;
end;

end.
