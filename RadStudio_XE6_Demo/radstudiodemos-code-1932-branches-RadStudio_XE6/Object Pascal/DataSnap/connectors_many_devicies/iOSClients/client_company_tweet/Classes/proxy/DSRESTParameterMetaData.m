
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "DSRESTParameterMetaData.h"


@implementation DSRESTParameterMetaData

@synthesize Name;
@synthesize Direction;
@synthesize DBXType;
@synthesize TypeName;

-(void) dealloc {
	//[Name release];
	//[TypeName release];
	[super dealloc];
}

+(id) parameterWithName: (NSString *) aname withDirection:(DSRESTParamDirection)adirection 
			withDBXType: (DBXDataTypes) aDBXType withTypeName:(NSString *) aTypeName{

	return [[[DSRESTParameterMetaData alloc] initWithMetadata:aname withDirection:adirection
												 withDBXType:aDBXType withTypeName:aTypeName] autorelease];
}
-(id) initWithMetadata:(NSString*)aname withDirection:(DSRESTParamDirection)adirection 
		  withDBXType: (DBXDataTypes) aDBXType withTypeName:(NSString *)aTypeName{
	self = [super init];
	if (self) {
		Name = aname;
		Direction = adirection;
		DBXType = aDBXType; 
		TypeName = aTypeName;
	}
	return self;

}





@end
