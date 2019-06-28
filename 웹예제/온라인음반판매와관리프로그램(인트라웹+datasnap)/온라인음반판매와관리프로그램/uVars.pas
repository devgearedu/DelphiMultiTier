unit uVars;

interface

var
  LogInState: Boolean;    // �α��� ���� üũ, �α����̸� True
  UserID: String;         // �α��� ���� ��� ID ����

  miLeft, miTop, miTerm: Integer; // ��ǰ ����Ʈ ��� ��ǥ, ����
  RecordPointer: Integer; // ��ǰ ����Ʈ ������ "���ڵ� ������'
  ItemViewCount: Integer; // �� ���� ����� ������ ����

  ClickedNumber: Integer; // ����(���� ��� ����) ������ ��ȣ

implementation

initialization
  // �α��� ���� üũ, �α����̸� True
  LogInState := False;
  // �� ���� ����� ������ ����
  ItemViewCount := 5;

  // ��ǰ ����Ʈ ������ "���ڵ� ������'
  RecordPointer := 0;

  // ��ǰ ����Ʈ ��� ��ǥ, ����
  miLeft := 50;
  miTop := 70;
  miTerm := 120;

  // ����(���� ��� ����) ������ ��ȣ
  ClickedNumber := 1;

end.
