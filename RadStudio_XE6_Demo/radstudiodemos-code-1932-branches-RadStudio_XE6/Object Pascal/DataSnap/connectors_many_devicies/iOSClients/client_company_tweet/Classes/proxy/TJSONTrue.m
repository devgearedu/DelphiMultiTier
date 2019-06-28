
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TJSONTrue.h"


@implementation TJSONTrue
-(NSString *) asJSONString{
 return @"true";
}
-(id) getInternalObject {
	return [NSNumber numberWithBool:YES];
}
-(NSString *) toString{
	return [self asJSONString];
}
-(JSONValueType) getJSONValueType{
	return JSONTrue;
}

@end
