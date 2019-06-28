
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "TDataSet.h"


@implementation TDataSet

@end

@implementation TDataSet (TDatasetCreation)

+(id) DataSetWithJSON:(TJSONObject *) value {
	TParams * params = [TParams createParametersWithMetadata:[value getJSONArrayForKey:@"table" ]] ;
	
	return [ TDBXReader DBXReaderWithParams:params andJSONObject: value];
}
+(id) DataSetWithParams: (TParams * )params andJSONObject: (TJSONObject *)json{
	return [[TDataSet alloc]initWithParams:params andJSONObject:json];
}
@end
