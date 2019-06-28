
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TDBXBcdValue.h"


@implementation TDBXBcdValue
-(id)init {
	self =  [super init];
	if (self) {
		[self setDBXType:BcdType];
	}
	return self;
}
-(bool) isNull{
	return valueNull;
}
-(void) SetNull{
	valueNull = YES;
	bcdValue = 0;
}
-(void) SetAsBcd:(double)value{
	bcdValue = value;
}

-(double) GetAsBcd{
	return bcdValue;
}

@end
