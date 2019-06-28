
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TJSONString.h"


@implementation TJSONString
-(id) init {
	self = [super init];
	if (self) {
		value =nil;
	}
	return self;
}
-(void)dealloc {
	[value release];
	[super dealloc];
}
-(id) initWithString:(NSString *) aValue{
	self = [self init];
	if (self) {
		[value release];
		value = [aValue retain];
	}
	return self;
}
-(id) getInternalObject{
	return value;
}

-(NSString *) toString{
  	if (value)
		return [NSString stringWithFormat:@"\"%@\"",value];
	return [self nullString];

}

-(JSONValueType) getJSONValueType{
	return JSONString;
}

-(NSString *) getValue {
	return value;
}

@end
@implementation TJSONString(jsonstringCreation)
+(id) JSONStringWithString:(NSString *) aValue{
	return [[[TJSONString alloc]initWithString:aValue]autorelease];
}

@end