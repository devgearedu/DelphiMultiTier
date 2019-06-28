
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TJSONNumber.h"


@implementation TJSONNumber

-(id) init{
	self = [super init];
	if (self) {
	//	value = [[NSNumber alloc ]init ];
		value = nil;
	}
	return self;
}
-(void) dealloc {
	[value release];
	[super dealloc];
}
-(id) initWithNumber:(NSNumber*)aValue{
	self =[self init];
	if (self) {
		[value release];
		value = [aValue retain];
	}
	return self;
	

}
-(id) initWithString:(NSString *) aValue {
	self =[self init];
	if (self) {
		[value release];		
		NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
		[f setNumberStyle:NSNumberFormatterDecimalStyle];
		value = [[f numberFromString:aValue]retain];
		[f release];
		
	}
	return self;
}

-(id) initWithDouble:(double) aValue {
	self =[self init];
	if (self) {
		[value release];
		value = [[NSNumber numberWithDouble:aValue]retain];
	}
	return self;
}

-(id) initWithLong:(long) aValue {
	self =[self init];
	if (self) {
		[value release];
		value = [[NSNumber numberWithLong:aValue] retain];
	}
	return self;
}
-(id) initWithInt:(int) aValue {
	self =[self init];
	if (self) {
		[value release];
		value = [[NSNumber numberWithInt:aValue] retain];
	}
	return self;
}

-(id) getInternalObject{
	return value;
}

-(NSString *) toString{
	if (value) {
		return [value stringValue];
	}

    return [self nullString];	
}
-(JSONValueType) getJSONValueType{
	return JSONNumber;
}
-(NSNumber *) getValue{
	return value;
}

@end
@implementation TJSONNumber(jsonnumberCreation)
+ (id) jsonNumberWithNumber:(NSNumber *) value{
	return [[[TJSONNumber alloc]initWithNumber:value]autorelease];
}
@end
