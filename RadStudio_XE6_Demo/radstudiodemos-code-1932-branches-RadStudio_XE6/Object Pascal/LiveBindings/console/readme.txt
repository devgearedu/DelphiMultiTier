LiveBindings Console Samples

Project: SimpleExpressionConsole

Summary: Prompts for an expression string, evaluates the expression and displays the result.

Description: A TStringList is added to the expression scope, so expressions may reference methods and properties of TStringList.  Expression may also use operators (+, -, /), global methods (ToStr, Format).  This applications uses the following expression engine methods and types:  WrapObject(), TNestedScope, TBindingExpression and TBindings.CreateExpression().  

Sample Expressions:

(1 + 2) * 3 
'abc' + 'def'
ToStr(200)
Self.Count
Count
Add("abc")
Add('abc')
Strings[0]
Format('count: %d, capacity: %d, Count, Capacity)

Tips:
Methods require parenthesis
Default properties are not supported (For TStrings must use Self.Strings[0] rather than Self[0])





Project: SimpleUnmanagedBindingsConsole

Summary: Prompts for an input expression string and output expression string, creates an unmanaged bindings, evaluates the binding and displays the result.  

Description: The output expression is optional.  If it is blank then the input expression will be evaluated.  If the output expression is not blank then an unmanaged binding will be created and evaluated.  Abinding assigns the result of the input expression to the location defined by the output expression.  The input expressions may reference methods and properties of TStringList and also use operators and global methods.  Output expressions will typically reference properties of TStringList. This applications uses the following expression engine methods and types:  WrapObject(), TNestedScope,  TBindingExpression, TBindings.CreateExpression(), TBindings.CreateUnmanagedExpression(), and TBindingMethodsFactory.GetMethodScope.  

Sample Expressions:

input: (1 + 2) * 3   output: Capacity
input: "9"           output: Capacity
input: Add("abc")    output: <blank>
input: "xyz"         output: Strings[0]


Tips:
Output expression must evaluate to a writable value, such as a property.
There are built in converters to take care of many type mismatches (allowing a string can be assigned to an integer as long as the string can be converted into an integer).



Project: SimpleManagedBindingsConsole

Summary: Prompts for an input expression string and output expression string, creates managed bindings, evaluates the binding and displays the result.  Managed bindings stored by the expression engine and are automatically evaluated when the expression engine is notified of a change to a dependent object/property.

Description: TTestObject is added to the input and output scopes.  The declaration is shown belows.  TManagerObject is also added to the input scope.  It is associated with the name "Manager".  This object is used to display the list of managed bindings and notify the engine of property changes.  An event handler is used to monitor when the expression engine re-evaluates a managed expression.  This event handler displays information about the assignment.  The input expressions may This applications uses the following expression engine methods and types:  WrapObject(), TNestedScope,  TBindingExpression, TBindings.CreateExpression(), TBindings.CreateManagedExpression(), and TBindingMethodsFactory.GetMethodScope.  
TTestObject is decleared as follows:

  TTestObject = class
  private
    FStringProp: string;
    FIntegerProp: Integer;
    FDoubleProp: Double;
    FStrings: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    function IncInteger(I: Integer): Integer;
    property Strings: TStrings read FStrings;
    property StringProp: string read FStringProp write FStringProp;
    property IntegerProp: Integer read FIntegerProp write FIntegerProp;
    property DoubleProp: Double read FDoubleProp write FDoubleProp;
  end;

  TManagerObject = class
  private
    function GetCount: Integer;
  public
    procedure Display;
    procedure Clear;
    property Count: Integer read GetCount;
    procedure Notify(AObject: TObject; const APropName: string);
  end;


Sample Expressions:

input: IntegerProp                          output: StringProp
input: Manager.Display()                    output: <blank>
input: IncInteger(-5000)                    output: <blank>
input: Manager.Notify(Self, 'IntegerProp')  output: <blank>


Tips:
If the second parameter to Notify is an empty string then and binding expressions that depend on any properties of the object are re-evaluated


Project: UnManagedBindingsConsole

Summary: Enhanced version of SimpleUnmanagedBindingsConsole.    

Description: Compared to SimpleUnamangedBindingsConsole, this application displays more information and supports command line options.

Command line options:
nooptions - Disable all options
custommethods - Register custom methods
usemethods - Use global methods (default)
useconverters - Use output converters (default)
customconverters - Register custom output converters
alloptions - Enable all options
namedobject - When creating the scope, associate the test object with a name



Project: ManagedBindingsConsole

Summary: Enhanced version of ManagedBindingsConsole.    

Description: Compared to SimpleMangedBindingsConsole, this application displays more information and supports command line options.  The "Manager" object also has an additional method: NotifyAll()

Command line options:
nooptions - Disable all options
custommethods - Register custom methods
usemethods - Use global methods (default)
useconverters - Use output converters (default)
customconverters - Register custom output converters
alloptions - Enable all options
namedobject - When creating the scope, associate the test object with a name

