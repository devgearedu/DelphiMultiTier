
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TDBXReaderValue.h"



@implementation TDBXReaderValue
-(id) init {
	self = [super init];
	if (self) {
		[self setDBXType:TableType];
		ValueNull =  NO;
	}
	return self;
}
-(void) SetNull {
	ValueNull = YES;
	objectValue = nil;
}

-(bool) isNull {
	return ValueNull;
}


-(void) SetAsTable:(id<TableType>)value{
	[objectValue release];
	objectValue = [value retain];
	[self setDBXType:TableType];}


-(id<TableType>) GetAsTable{
	[self checkCurrentDBXType:TableType];
	return objectValue ;
}

-(TDBXReader *) GetAsDBXReader {
	return (TDBXReader *) objectValue;
}

-(void) SetAsDBXReader:(id<TableType>) value {
	[self SetAsTable:value];
}
-(void) dealloc{
	[super dealloc];
}

@end
