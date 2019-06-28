
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TDBXTimeStampValue.h"


@implementation TDBXTimeStampValue
-(id)init{
	self = [super init];
	if (self) {
		[self setDBXType:TimeStampType];
	}
	return self;
}
-(void) dealloc{
	[DBXInternalValue release];
	[super dealloc];
}
-(void) SetNull {
	ValueNull = YES;
	[DBXInternalValue release];
	DBXInternalValue = nil;
}

-(bool) isNull {
	return ValueNull;
}

-(void) SetAsTimeStamp:(NSDate*) value{
	ValueNull = NO;
	[DBXInternalValue release];
	DBXInternalValue = [value retain];
}

-(NSDate*) GetAsTimeStamp {
	return DBXInternalValue;
}

@end
