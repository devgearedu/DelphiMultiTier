
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "TStream.h"
#import "DBXTools.h"
@implementation TStream
+(id) streamWithJsonArray:(TJSONArray*) json{
	NSArray * jarr = [json asJSONArray];
	Byte* b =	[DBXTools arrayToByteArray:jarr];
	NSData *  str =	 [TStream streamWithBytes:b length: [jarr count]];
	free(b);
	return str;
}

+(id) streamWithBytes:(Byte *) barray length:(NSUInteger) len{

	return [NSData dataWithBytes:barray length:len];


}
+(TJSONArray *) StreamToJson:(NSData *)str{
	Byte * b = [DBXTools streamToByteArray: str];
	NSMutableArray * a=[NSMutableArray arrayWithCapacity:sizeof(b)]; 
	for (int i = 0; i < [str length]; i++){
		NSNumber * n = [NSNumber numberWithInt:b[i]];
		[a addObject:n];
		
		//NSMutableArray * arr  = [NSMutableArray arrayWithCapacity:0];
	}
	free(b);
	return [[[TJSONArray alloc] initWithJSONArray:a] autorelease];
}

@end
