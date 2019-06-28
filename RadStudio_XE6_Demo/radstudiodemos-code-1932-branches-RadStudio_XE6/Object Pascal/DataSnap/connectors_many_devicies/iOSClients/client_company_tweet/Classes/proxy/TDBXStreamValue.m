
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TDBXStreamValue.h"


@implementation TDBXStreamValue
-(id) init {
	self = [super init];
	if (self) {
		[self setDBXType:BinaryBlobType];
		ValueNull =  NO;
	}
	return self;
}
-(void) SetNull {
	ValueNull = YES;
	streamValue = nil;
}

-(bool) isNull {
	return ValueNull;
}
-(NSData*) GetAsStream{
	[self checkCurrentDBXType:BinaryBlobType];
	return streamValue;
}
-(void) SetAsStream:(NSData *) value{
	[streamValue release];
	streamValue = [value retain];
	[self setDBXType:BinaryBlobType];
}




@end
