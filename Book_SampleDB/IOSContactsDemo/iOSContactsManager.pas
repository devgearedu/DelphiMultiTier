unit iOSContactsManager;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants
  {$IFDEF IOS},iOSapi.UIKit, Macapi.ObjectiveC, iOSapi.CocoaTypes, iOSapi.CoreGraphics,
  iOSapi.Foundation, iOSapi.CoreLocation, Macapi.CoreFoundation,
  iOSAddressBookWrap
  {$ENDIF};

Type
  TiOSContact = record
    FirstName : String;
    LastName : string;
    PhoneNumber : string;
    Email : String;
  end;
  PiOSContact = ^TiOSContact;

  TiOSContactsManager = class
    private
      fContactsList : TList;
      Procedure ClearList;          // Clear contacts list
      function GetiOSContactsCount : integer;  // Get contacts count
      function GetiOSContact(AIdx : Integer) : PiOSContact;   // Get contact record
    public
      constructor Create;
      destructor Destroy;override;
      procedure ExtractContacts;       // Extract all contacts

      property Contacts[AIdx : integer] : PiOSContact read GetiOSContact;
      property ContactsCount : Integer read GetiOSContactsCount;
  end;


implementation

{ TiOSContactsManager }


{-------------------------------------------------------------------------------
  Procedure: NSStrToStr   : Convert iOS string to delphi String;
  DateTime:  2014.01.03
  Arguments: const ASource: NSString
  Result:    string
-------------------------------------------------------------------------------}
function NSStrToStr( const ASource: NSString ): string;
begin
  Result := UTF8ToString( ASource.UTF8String );
end;


{-------------------------------------------------------------------------------
  Procedure: CFToDelphiString : Convert CFString to delphi string
  DateTime:  2014.01.03
  Arguments: const ACFStr: CFStringRef
  Result:    string
-------------------------------------------------------------------------------}
function CFToDelphiString(const ACFStr: CFStringRef): string;
var
  wRange: CFRange;
begin
  Result := '';
  if ACFStr <> nil then    //if contact peoperty is null, return nil string (for debug)
  begin
    wRange.location := 0;
    wRange.length := CFStringGetLength(ACFStr);
    SetLength(Result, wRange.length);
    if wRange.length = 0 then Exit;
    CFStringGetCharacters(ACFStr, wRange, PWideChar(Result));
  end;
end;


{-------------------------------------------------------------------------------
  Procedure: TiOSContactsManager.ClearList
  Author:    kelhedadi
  DateTime:  2014.01.03
  Arguments: None
  Result:    None
-------------------------------------------------------------------------------}
procedure TiOSContactsManager.ClearList;
var i : integer;
begin
  try
    for i := fContactsList.Count -1 downto 0 do
    begin
      Dispose(PiOSContact(fContactsList[i]));
      fContactsList.Delete(i);
    end;
    fContactsList.Clear;
  except
    On E:Exception do
      Raise Exception.create('[TiOSContactsManager.ClearList] : '+E.message);
  end;
end;


{-------------------------------------------------------------------------------
  Procedure: TiOSContactsManager.Create
  Author:    kelhedadi
  DateTime:  2014.01.03
  Arguments: None
  Result:    None
-------------------------------------------------------------------------------}
constructor TiOSContactsManager.Create;
begin
  fcontactsList := TList.Create;
end;


{-------------------------------------------------------------------------------
  Procedure: TiOSContactsManager.Destroy
  Author:    kelhedadi
  DateTime:  2014.01.03
  Arguments: None
  Result:    None
-------------------------------------------------------------------------------}
destructor TiOSContactsManager.Destroy;
begin
  ClearList;
  fcontactsList.Free;
  inherited;
end;


{-------------------------------------------------------------------------------
  Procedure: TiOSContactsManager.ExtractContacts
  Author:    ehkhalid
  DateTime:  2014.01.03
  Arguments: None
  Result:    None
-------------------------------------------------------------------------------}
procedure TiOSContactsManager.ExtractContacts;
 var
   wAddressBook : ABAddressBookRef;     // AddressBook reference
   wContactsList : CFArrayRef;          // contacts list array
   wcontactsCount : CFIndex;            //Contacts count
   wIosContactRef : ABRecordRef;        // Contact Reference
   wCFFirstName : CFStringRef;
   wCFLastName : CFStringRef;
   wCFEmailList : ABMultiValueRef;      //Emails List
   wCFEmail : CFStringRef;              //Email value (label and value)
   wEmailLabel : string;
   wStrEmail : string;                  // Concatened emails value as string
   wCFEPhoneList : CFStringRef;         //Phone numbers List
   wCFPhone : CFStringRef;              // Phone value and label
   wPhoneLabel : String;
   wStrPhone : string;                  //Phone value as string
   i,j : CFIndex;
   wNewContact : PiOSContact;           // Contact record
begin
  ClearList;

  wAddressBook := ABAddressBookCreate;        // create Addressebook interface
  try
    wContactsList := ABAddressBookCopyArrayOfAllPeople(wAddressBook);  // Retrieve all contacts
    wcontactsCount := ABAddressBookGetPersonCount(wAddressBook);       // get contacts count
    for i := 0 to wcontactsCount -1 do                                 // for each contact
    begin
      wIosContactRef := CFArrayGetValueAtIndex( wContactsList , i );    // get contact pointer

      New(wNewContact);
      wCFFirstName := ABRecordCopyValue(wIosContactRef,kABPersonFirstNameProperty);   // create a new contact record
      wNewContact.FirstName := CFToDelphiString(wCFFirstName);  // Extract first name
      wCFLastName := ABRecordCopyValue(wIosContactRef,kABPersonLastNameProperty);
      wNewContact.LastName := CFToDelphiString(wCFLastName);    // Extract last name

      // Emails
      wCFEmailList := ABRecordCopyValue(wIosContactRef, kABPersonEmailProperty);  //Extract emails list
      wStrEmail := '';
      for j := 0 to ABMultiValueGetCount(wCFEmailList) -1 do                      // for each email
      begin
        wEmailLabel := CFToDelphiString(ABMultiValueCopyLabelAtIndex(wCFEmailList, j));   // Get email label
        wCFEmail :=  ABMultiValueCopyValueAtIndex(wCFEmailList, j);
        if wCFEmail <> nil then
        begin
          if CompareText(wEmailLabel,kABPersonHomeEmailLabel) = 0 then           // return value only if email label is "Home"
            wStrEmail := CFToDelphiString(wCFEmail);
          CFRelease(wCFEmail);
          if Trim(wStrEmail) <> '' then
          begin
            wNewContact.Email := wStrEmail;
            Break;
          end;
        end;                                       // Release memory
      end;
      wNewContact.Email := wStrEmail;
      if wCFEmailList <> nil then                        // Release memory
        CFRelease(wCFEmailList);

      //Phones
      wCFEPhoneList := ABRecordCopyValue(wIosContactRef, kABPersonPhoneProperty);  //The same as email
      wStrPhone := '';
      for j := 0 to ABMultiValueGetCount(wCFEPhoneList) -1 do
      begin
        wPhoneLabel := CFToDelphiString(ABMultiValueCopyLabelAtIndex(wCFEPhoneList, j));  // get pone label
        wCFPhone :=  ABMultiValueCopyValueAtIndex(wCFEPhoneList, j);
        if wCFPhone <> nil then
        begin
          if CompareText(wPhoneLabel,kABPersonPhoneMobileLabel) = 0 then               // return value only if mobile number
            wStrPhone := CFToDelphiString(wCFPhone)
          else if CompareText(wPhoneLabel,kABPersonPhoneIPhoneLabel) = 0 then          // or Iphone number
            wStrPhone := CFToDelphiString(wCFPhone);
          CFRelease(wCFPhone);
          if Trim(wStrPhone) <> '' then
          begin
            wNewContact.PhoneNumber := wStrPhone;
            Break;
          end;
        end;
      end;

      if wCFEPhoneList <> nil then                            // Release memory
        CFRelease(wCFEPhoneList);

      fcontactsList.Add(wNewContact);   // Add contact to list
    end;
  finally
    wAddressBook := nil;
  end;
end;


{-------------------------------------------------------------------------------
  Procedure: TiOSContactsManager.GetiOSContact
  Author:    kelhedadi
  DateTime:  2014.01.03
  Arguments: AIdx: Integer
  Result:    PiOSContact
-------------------------------------------------------------------------------}
function TiOSContactsManager.GetiOSContact(AIdx: Integer): PiOSContact;
begin
  Result := fContactsList[Aidx];
end;


{-------------------------------------------------------------------------------
  Procedure: TiOSContactsManager.GetiOSContactsCount
  Author:    kelhedadi
  DateTime:  2014.01.03
  Arguments: None
  Result:    integer
-------------------------------------------------------------------------------}
function TiOSContactsManager.GetiOSContactsCount: integer;
begin
  Result := fContactsList.Count;
end;




end.
