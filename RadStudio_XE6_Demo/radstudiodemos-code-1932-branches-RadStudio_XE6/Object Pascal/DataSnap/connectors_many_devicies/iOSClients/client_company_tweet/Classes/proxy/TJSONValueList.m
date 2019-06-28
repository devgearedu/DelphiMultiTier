
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TJSONValueList.h"


@implementation TJSONValueList
-(id) init{
	self = [super init];
	if (self) {
		internalArray = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}
-(void) dealloc{
	//[internalArray release];
	[super dealloc];
}
-(int) addValue:(TJSONValue* )value{
	[internalArray addObject:value ];
	return [internalArray count]-1;
}
-(void) removeValueByIndex:(int) value{
	[internalArray removeObjectAtIndex:value];
	
}


-(TJSONValue *) valueByIndex:(int) value{
	return (TJSONValue *)[internalArray objectAtIndex:value];
	
}

-(int)count{
	return [internalArray count];
}


@end
