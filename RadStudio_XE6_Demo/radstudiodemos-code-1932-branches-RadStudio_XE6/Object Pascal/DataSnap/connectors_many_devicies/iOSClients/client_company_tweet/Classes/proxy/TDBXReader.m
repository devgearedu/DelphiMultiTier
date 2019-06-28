
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TDBXReader.h"
#import "DBXJsonTools.h"


@implementation TDBXReader

@synthesize columns;
@synthesize internalDataStore;


-(id) initWithParams: (TParams * )params andJSONObject: (TJSONObject *)json{
	self = [self init];
	if (self) {
		self.columns = params;
		self.internalDataStore = json;
	}
	return self;
}

-(id) init{
	self = [super init];
	if (self) {
		currentPosition = -1;
	}
	return self;	
}
-(DBXWritableValue *) getValueByIndex: (int) index{
	return [[columns getParamByIndex:index]getValue ];
}
-(DBXWritableValue *) getValueByName: (NSString *) name{
	return [[columns getParamByName:name] getValue];

}
-(bool) next {
	currentPosition++;
	@try {
		return [TParams loadParametersValues:&columns withJSON:internalDataStore andOffSet:currentPosition];
	} @catch (NSException* ex) {
			@throw ex;
			}		
}
-(TJSONObject *) asJSONObject {
	return [DBXJsonTools  DBXReaderToJSONObject:self];
}
-(DBXWritableValue*) getValue:(int) position {
	return [[[self columns] getParamByIndex:position] getValue];
}
-(void) reset{
	currentPosition = -1;		
}
-(void) dealloc{
	[columns release];
	[internalDataStore release];
	[super dealloc];
}
@end


@implementation TDBXReader (TDBXReaderCreation)
+(id) DBXReaderWithJSON:(TJSONObject *) value {
	TParams * params = [TParams createParametersWithMetadata:[value getJSONArrayForKey:@"table" ]]  ;
	
	return [ TDBXReader DBXReaderWithParams:params andJSONObject: value];
}
+(id) DBXReaderWithParams: (TParams * )params andJSONObject: (TJSONObject *)json{
	return [[[TDBXReader alloc]initWithParams:params andJSONObject:json]autorelease];
}


@end
