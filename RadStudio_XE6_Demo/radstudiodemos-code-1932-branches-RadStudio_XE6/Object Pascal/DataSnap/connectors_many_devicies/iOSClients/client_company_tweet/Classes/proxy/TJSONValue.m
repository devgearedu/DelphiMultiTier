
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TJSONValue.h"


@implementation TJSONValue


- (NSString *) nullString{
	 return @"null";
}

-(id) getInternalObject{
	return nil;	
}

-(NSArray*) asJSONArray{
	return nil;
}

-(NSString *) asJSONString{
	return nil;
}
-(NSDictionary *) asJSONObject{
	return nil;
}
-(NSString *) toString{
	return [self nullString];

}
-(JSONValueType) getJSONValueType{
	return JSONNull;
}
@end
