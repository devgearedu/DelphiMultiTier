unit iOSAddressBookWrap;

interface

uses
  System.Classes,
  System.SysUtils,
  System.TypInfo,
  System.Math,
{$IFDEF IOS}
  iOSapi.UIKit, Macapi.ObjectiveC, iOSapi.CocoaTypes,iOSapi.CoreGraphics,
  iOSapi.Foundation,  iOSapi.CoreLocation,  Macapi.CoreFoundation
{$ENDIF};

{$IFDEF IOS}
const
  libAddressBook   = '/System/Library/Frameworks/AddressBook.framework/AddressBook';
  kABPersonFirstNameProperty          = 0;
  kABPersonLastNameProperty           = 1;
  kABPersonEmailProperty              = 4;
  kABPersonPhoneProperty              = 3;
  kABPersonPhoneMobileLabel : string  = '_$!<Mobile>!$_';
  kABPersonPhoneIPhoneLabel : string  = 'IPhone';
  kABPersonHomeEmailLabel : string  = '_$!<Home>!$_';

type
{$M+}
  ABAddressBookRef  = CFTypeRef;
  ABRecordRef       = CFTypeRef;
  ABMultiValueRef   = CFTypeRef;
  ABPropertyID                = UINT32;
  ABRecordID                  = UINT32;
  ABMultiValueIdentifier      = UINT32;
  ABPersonSortOrdering        = UINT32;
  ABRecordType                = UINT32;
  ABPropertyType              = NSInteger;
  ABPersonImageFormat         = NSInteger;
  ABPersonCompositeNameFormat = NSInteger;
  ABAuthorizationStatus       = NSInteger;

function ABAddressBookCreate( ): ABAddressBookRef; cdecl; external libAddressBook name _PU + 'ABAddressBookCreate';
function ABAddressBookCopyArrayOfAllPeople( addressBook: ABAddressBookRef ): CFArrayRef; cdecl; external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllPeople';
function ABAddressBookGetPersonCount( addressBook: ABAddressBookRef ): CFIndex; cdecl; external libAddressBook name _PU + 'ABAddressBookGetPersonCount';
function ABRecordCopyValue( &record: ABRecordRef; &property: ABPropertyID ): CFTypeRef; cdecl; external libAddressBook name _PU + 'ABRecordCopyValue';
function ABMultiValueGetCount( multiValue: ABMultiValueRef ): CFIndex; cdecl; external libAddressBook name _PU + 'ABMultiValueGetCount';
function ABMultiValueCopyValueAtIndex( multiValue: ABMultiValueRef; index: CFIndex ): CFTypeRef; cdecl; external libAddressBook name _PU + 'ABMultiValueCopyValueAtIndex';
function ABMultiValueCopyLabelAtIndex( multiValue: ABMultiValueRef; index: CFIndex ): CFStringRef; cdecl; external libAddressBook name _PU + 'ABMultiValueCopyLabelAtIndex';

{$ENDIF}

implementation

{$IFDEF IOS}
{$IF Not defined(CPUARM)}

uses Posix.Dlfcn;

var
  iAddressBookUIModule: THandle;
  iAddressBookModule  : THandle;
{$ENDIF}
{$IFDEF IOS}
{$IF defined(CPUARM)}
procedure LibAddressBookLoader; cdecl; external libAddressBook;
{$ELSE}

initialization

iAddressBookModule   := dlopen( MarshaledAString( libAddressBook ), RTLD_LAZY );

finalization

dlclose( iAddressBookModule );
{$ENDIF}
{$ENDIF}
{$ENDIF}


end.
