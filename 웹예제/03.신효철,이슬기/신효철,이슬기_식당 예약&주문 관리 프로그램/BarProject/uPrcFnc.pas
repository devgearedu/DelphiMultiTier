unit uPrcFnc;

interface

type
  RoomArray = Array[0..19, 0..1] of Integer;
var
  RoomInfo: RoomArray;
  i, j: integer;{for���� �ӽú���}

procedure OrderListOutput(Sender: TObject; iSlipNum:Integer; DM:TDM);

implementation



initialization

begin
  for i := 0 to 9 do
  begin
    RoomInfo[i][0] := 0; // RoomInfo[i][j] -> i�� ���� ������ �����ϱ�����. i:=0�̸� �Ķ�, i:=1�̸� ����
    RoomInfo[i][1] := 0; // RoomInfo[i][j] -> j�� �ش���� ��ǥ��ȣ�� �ӽ�����.
  end;
end;




end.
