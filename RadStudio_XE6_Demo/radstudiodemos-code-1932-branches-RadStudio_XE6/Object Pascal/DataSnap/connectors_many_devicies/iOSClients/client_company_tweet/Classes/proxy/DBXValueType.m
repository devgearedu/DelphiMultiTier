
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "DBXValueType.h"
#import "DBException.h"


@implementation DBXValueType

@synthesize name;
@synthesize caption;
@synthesize ordinal;
@synthesize subType;
@synthesize size;
@synthesize precision;
@synthesize scale;
@synthesize childPosition;
@synthesize nullable;
@synthesize parameterDirection;
@synthesize hidden;
@synthesize valueParameter;
@synthesize literal;

-(void) setDataType:(int) dataType{
	@throw [DBXException exceptionWithName:@"AbstractMethdo" 
									reason:@"Must be overridden in the descendant classes" userInfo:nil]; 
	
}
-(int) DataType;{
	@throw [DBXException exceptionWithName:@"AbstractMethdo" 
									reason:@"Must be overridden in the descendant classes" userInfo:nil]; 
}
-(void) dealloc {
	[name release];
	[caption release];
	[super dealloc];
}

@end