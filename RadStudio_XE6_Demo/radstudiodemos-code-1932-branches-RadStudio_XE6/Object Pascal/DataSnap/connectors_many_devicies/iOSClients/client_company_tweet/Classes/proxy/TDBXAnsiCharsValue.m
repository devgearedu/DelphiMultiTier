
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TDBXAnsiCharsValue.h"


@implementation TDBXAnsiCharsValue
-(id)init{
	self = [super init];
	if (self) {
		[self setDBXType:WideStringType];
	}
	return self;
}
-(void) dealloc{
	[DBXStringValue release];
	[super dealloc];
}
-(void) SetNull {
	ValueNull = YES;
	[DBXStringValue release];
	DBXStringValue = @"";
	[DBXStringValue retain];
}

-(bool) isNull {
	return ValueNull;
}

-(void) SetAsString:(NSString*) value{
	ValueNull = NO;
	[DBXStringValue release];
	DBXStringValue = [value retain];
}

-(NSString*) GetAsString {
	return DBXStringValue;
}
@end
