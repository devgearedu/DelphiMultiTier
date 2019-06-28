
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "DSRestParameter.h"


@implementation DSRestParameter

@synthesize name;
@synthesize direction;
@synthesize typeName;
@synthesize DBXType;

- (id) init{
	self = [super init]; 
	if (self) {
	  value = [[[DBXWritableValue alloc]init] autorelease];	
	  [value retain];
   }
	return self;
}
- (id) initWithParameter:(NSString *) aname  withDirection: (DSRESTParamDirection) adirection 
			withTypeName: (NSString *) aTypeName {
	self = [self init];
	if (self) {
		name = [NSString stringWithString:aname];
		direction = adirection;
		typeName = [NSString stringWithString:aTypeName];
		
	}
	return self;
	
}

-(void) dealloc {
//	[name release];
//	[typeName release];
	[value release];
	[super dealloc];
	
}
-(DBXValue*) getValue {
	return value  ;
}


@end
