
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SampleCollection;

interface

uses
  Classes, DBXJSonReflect;

type
  TSampleCollectionItem = class(TCollectionItem)
  private
    FProduct: string;
    FQty: Integer;
  public
    property Product: string read FProduct write FProduct;
    property Qty: Integer read FQty write FQty;
  end;

  TSampleCollectionItems = class(TCollection)
  public
    function Add: TSampleCollectionItem;
  end;

  TSampleCollectionFieldInterceptor = class(TJSONInterceptor)
  public
    procedure ObjectsReverter(Data: TObject; Field: String;
      Args: TListOfObjects); override;
    function ObjectsConverter(Data: TObject; Field: String): TListOfObjects; override;
  end;

  TSampleCollectionField = class(TObject)
  private
    FPOCustomer: string;
    FPONumber: string;
    [JSONReflect(ctObjects, rtObjects, TSampleCollectionFieldInterceptor,nil,true)]
    [JSONOwned(false)] // Prevent unmarshal from freeing FSampleCollectionItems after construction
    FSampleCollectionItems: TSampleCollectionItems;
  public
    constructor Create;
    destructor Destroy; override;
    property POCustomer: string read FPOCustomer write FPOCustomer;
    property PONumber: string read FPONumber write FPONumber;
    property PurchaseOrderItems: TSampleCollectionItems read FSampleCollectionItems
        write FSampleCollectionItems;
  end;

  TSampleCollectionField_Register = class(TObject)
  private
    FPOCustomer: string;
    FPONumber: string;
    [JSONOwned(false)] // Prevent unmarshal from freeing FSampleCollectionItems after construction
    FSampleCollectionItems: TSampleCollectionItems;
  public
    constructor Create;
    destructor Destroy; override;
    property POCustomer: string read FPOCustomer write FPOCustomer;
    property PONumber: string read FPONumber write FPONumber;
    property PurchaseOrderItems: TSampleCollectionItems read FSampleCollectionItems
        write FSampleCollectionItems;
  end;

  // Used to marshal a collection item
  [JSONReflect(true)]  // Marshalling system frees this
  TSampleCollectionItemMarshal = class
  private
    FProduct: string;
    FQty: Integer;
  public
    constructor Create; overload;  // Constructor for unmarshalling
    constructor Create(AItem: TSampleCollectionItem); overload;
  end;

  procedure LoadSampleCollectionField(AValue: TSampleCollectionField); overload;
  procedure ValidateSampleCollectionField(AValue: TSampleCollectionField); overload;
  procedure LoadSampleCollectionField(AValue: TSampleCollectionField_Register); overload;
  procedure ValidateSampleCollectionField(AValue: TSampleCollectionField_Register); overload;

implementation

uses
  DateUtils, SysUtils, Rtti;

procedure LoadSampleCollectionField(AValue: TSampleCollectionField);
var
  I: Integer;
  LItem: TSampleCollectionItem;
begin
  AValue.PONumber        := 'PONumberValue';
  AValue.POCustomer      := 'POCustomerValue';

  AValue.PurchaseOrderItems.Clear;
  for I := 0 to 2 do
  begin
    LItem         := AValue.FSampleCollectionItems.Add;
    LItem.Product := 'Product' + IntToStr(I);
    LItem.Qty     := I;
  end;
end;

procedure ValidateSampleCollectionField(AValue: TSampleCollectionField);
var
  I: Integer;
  LItem: TSampleCollectionItem;
begin
  Assert(AValue.PONumber = 'PONumberValue');
  Assert(AValue.POCustomer = 'POCustomerValue');
  Assert(AValue.PurchaseOrderItems.Count = 3);
  for I := 0 to 2 do
  begin
    LItem         := TSampleCollectionItem(AValue.FSampleCollectionItems.Items[I]);
    Assert(LItem.Product = 'Product' + IntToStr(I));
    Assert(LItem.Qty = I);
  end;
end;

procedure LoadSampleCollectionField(AValue: TSampleCollectionField_Register);
var
  I: Integer;
  LItem: TSampleCollectionItem;
begin
  AValue.PONumber        := 'PONumberValue';
  AValue.POCustomer      := 'POCustomerValue';

  AValue.PurchaseOrderItems.Clear;
  for I := 0 to 2 do
  begin
    LItem         := AValue.FSampleCollectionItems.Add;
    LItem.Product := 'Product' + IntToStr(I);
    LItem.Qty     := I;
  end;
end;

procedure ValidateSampleCollectionField(AValue: TSampleCollectionField_Register);
var
  I: Integer;
  LItem: TSampleCollectionItem;
begin
  Assert(AValue.PONumber = 'PONumberValue');
  Assert(AValue.POCustomer = 'POCustomerValue');
  Assert(AValue.PurchaseOrderItems.Count = 3);
  for I := 0 to 2 do
  begin
    LItem         := TSampleCollectionItem(AValue.FSampleCollectionItems.Items[I]);
    Assert(LItem.Product = 'Product' + IntToStr(I));
    Assert(LItem.Qty = I);
  end;
end;

{ TSampleCollectionField }

constructor TSampleCollectionField.Create;
begin
  inherited Create;
  FSampleCollectionItems := TSampleCollectionItems.Create(TSampleCollectionItem);
end;

destructor TSampleCollectionField.Destroy;
begin
  inherited Destroy;
  FSampleCollectionItems.Free;
end;

function TSampleCollectionItems.Add: TSampleCollectionItem;
begin
  Result := TSampleCollectionItem(Inherited Add);
end;

{ TSampleCollectionField_Register }

constructor TSampleCollectionField_Register.Create;
begin
  inherited Create;
  FSampleCollectionItems := TSampleCollectionItems.Create(TSampleCollectionItem);
end;

destructor TSampleCollectionField_Register.Destroy;
begin
  inherited Destroy;
  FSampleCollectionItems.Free;
end;

{ TSampleCollectionFieldInterceptor }

constructor TSampleCollectionItemMarshal.Create;
begin
end;

constructor TSampleCollectionItemMarshal.Create(AItem: TSampleCollectionItem);
begin
  FProduct := AItem.FProduct;
  FQty := AItem.FQty;
end;

function TSampleCollectionFieldInterceptor.ObjectsConverter(Data: TObject;
  Field: String): TListOfObjects;
var
  LRttiContext: TRttiContext;
  LValue: TSampleCollectionItems;
  I: Integer;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TSampleCollectionItems>;
  SetLength(Result, LValue.Count);
  for I := 0 to LValue.Count - 1 do
  begin
    Result[I] := TSampleCollectionItemMarshal.Create(
      TSampleCollectionItem(LValue.Items[I]));
  end;
end;

procedure TSampleCollectionFieldInterceptor.ObjectsReverter(Data: TObject; Field: String;
  Args: TListOfObjects);
var
  LRttiContext: TRttiContext;
  LValue: TSampleCollectionItems;
  LItem: TObject;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TSampleCollectionItems>;
  for LItem in Args do
  begin
    Assert(LItem is TSampleCollectionItemMarshal);
    with LValue.Add do
    begin
      FProduct := TSampleCollectionItemMarshal(LItem).FProduct;
      FQty := TSampleCollectionItemMarshal(LItem).FQty;
    end;
    LItem.Free;
  end;
end;

procedure RegisterReverterConverters;
var
  LReverter: TReverterEvent;
  LConverter: TConverterEvent;
begin
  // Equivalent [JSONReflect(ctObjects, rtObjects, TSampleCollectionFieldInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TSampleCollectionField_Register, 'FSampleCollectionItems');
  LReverter.ObjectsReverter :=
    procedure(Data: TObject; Field: string;
  Args: TListOfObjects)
    begin
      with TSampleCollectionFieldInterceptor.Create do
      try
        ObjectsReverter(Data, Field, Args);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TSampleCollectionField_Register, 'FSampleCollectionItems');
  LConverter.ObjectsConverter :=
    function(Data: TObject; Field: string): TListOfObjects
    begin
      with TSampleCollectionFieldInterceptor.Create do
      try
        Result := ObjectsConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);

end;

initialization
  RegisterReverterConverters;
end.



