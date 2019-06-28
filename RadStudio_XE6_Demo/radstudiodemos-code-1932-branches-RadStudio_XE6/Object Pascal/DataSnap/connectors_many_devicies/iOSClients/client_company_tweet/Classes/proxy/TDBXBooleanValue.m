
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TDBXBooleanValue.h"


@implementation TDBXBooleanValue
-(id)init{
	self = [super init];
	if (self) {
		[self setDBXType:BooleanType];
	}
	return self;
}
-(void) dealloc{
	[super dealloc];
}
-(void) SetNull {
	ValueNull = YES;
	DBXBoolValue = NO;
}

-(bool) isNull {
	return ValueNull;
}

-(void) SetAsBoolean:(bool) value{
	ValueNull = NO;
	DBXBoolValue = value;
}

-(bool) GetAsBoolean {
	return DBXBoolValue;
}

@end
