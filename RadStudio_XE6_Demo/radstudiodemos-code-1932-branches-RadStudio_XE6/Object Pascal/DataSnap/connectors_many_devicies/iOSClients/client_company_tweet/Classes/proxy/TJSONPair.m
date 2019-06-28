
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TJSONPair.h"



@implementation TJSONPair
@synthesize name,value;

-(id) initWithName:(NSString* )aName andValue:(TJSONValue*)aValue{
	self = [self init];
	if (self) {
		self.name = aName;
		self.value = aValue;
	}
	return self;

}
-(void) dealloc{
	[name release];
	[value release];
	[super dealloc];
}



@end


@implementation TJSONPair(JSONPairCreation)
+(id) JSONPairWithName:(NSString* )aName andValue:(TJSONValue*)aValue{
	return [[[TJSONPair alloc]initWithName:aName andValue:aValue]autorelease];

}
@end