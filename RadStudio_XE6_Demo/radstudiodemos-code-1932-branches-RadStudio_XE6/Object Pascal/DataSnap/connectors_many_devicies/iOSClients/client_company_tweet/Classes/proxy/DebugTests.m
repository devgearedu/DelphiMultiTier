
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "DebugTests.h"
#import"DSProxy.h"
#import "DBXDefaultFormatter.h"



@implementation DebugTests
+(bool) similarDouble:(double) value1 withOther: (double) value2{
	return	abs(value1-value2) <= 0.0001;
}
+(bool) similarFloat:(float) value1 withOther: (float) value2{
	return	abs(value1-value2) <= 0.0001;
}
+(NSDictionary *) CreateJSONObject {
	
	
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithInt: 1],@"prop1", 
			[NSString  stringWithString:@"2"],@"prop2",
			[NSNumber numberWithBool:true],@"prop3", 
			[NSNumber numberWithBool:false],@"prop4", 
			[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil],@"prop5",
			[[[NSNull alloc]init]autorelease],@"prop6",
			[NSNumber numberWithDouble:1234.5678],@"prop7",
			nil ];
	
	
}

+(void) ExecuteTests{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
   	
	DSRESTConnection * connection = [[DSRESTConnection alloc]init];
	connection.Host = @"datasnap.embarcadero.com";
	connection.Port = 8086;
	//connection.UrlPath = @"cgi-bin/ISAPITestServer.dll";
	connection.protocol = @"http";
	NSLog(@"connection created!");
	
	
    TTestSimpleTypes * SimpleTypes =[[TTestSimpleTypes alloc]initWithConnection:connection];
	TTestComplexParameterTypes * complexTypes =[[TTestComplexParameterTypes alloc]initWithConnection:connection];
	TTestJSONValueTypes * jsonTypes =[[TTestJSONValueTypes alloc]initWithConnection:connection];	
	TTestSession * sessions =[[TTestSession alloc]initWithConnection:connection];
	TTestSimpleValueTypes *SimpleValues =[[TTestSimpleValueTypes alloc]initWithConnection:connection];
	//[SimpleTypes TestInteger:-1000];
/*	NSArray *dates = [NSArray arrayWithObjects: @"0001-01-01", @"0033-01-29",
					  @"2011-02-18", @"2100-01-01", @"1969-12-31", @"1970-01-02",
					  @"1958-02-02", @"1900-01-09",  
					  @"1400-04-04", @"1256-12-25", @"1101-01-12", @"1800-02-07",
					  @"1700-02-12", @"1600-08-09", @"1530-04-24", @"1500-04-11",nil];	
	long value1;
	NSString * s2;
	for (NSString *s in dates){

	value1 = [[DBXDefaultFormatter getInstance] StringToDBXDate:s];
	s2 = [[DBXDefaultFormatter getInstance] TDBXDateToString:value1];
	NSLog(@"%@ %@",s,s2);
	}*/
/*	
    NSDate * value_1 = [NSDate date];
	NSDate * value_2;

	
	NSDate ** value1 = &value_1;
	NSDate ** value2 = &value_2;
		
		DSRESTCommand * cmd = [connection CreateCommand];
		cmd.RequestType =  GET;
		cmd.text= @"TTestSimpleTypes.TestTDBXDate_060_";
	    [cmd  prepare];
		[[[cmd.parameters objectAtIndex:0]getValue]SetAsDateTime:*value1];
		
		[connection execute: cmd];
		*value1 =   [[[cmd.parameters objectAtIndex:0]getValue]GetAsDateTime];
		*value2 =   [[[cmd.parameters objectAtIndex:1]getValue]GetAsDateTime];	
	NSDateComponents *components = [[[NSDateComponents alloc] 
									 init] autorelease];
	[components setDay:14];
	[components setMonth:12];
	[components setYear:2010];
	[components setHour:10];
	[components setMinute:20];
	[components setSecond:30];
	
	// create a calendar
	NSCalendar *gregorian = [[DBXDefaultFormatter getInstance]calendar];	
	
	NSDate *dt = [gregorian dateFromComponents:components];
	NSLog(@"%@",[dt description]);
	NSTimeInterval time = [dt timeIntervalSince1970];
	time = time +0.50;
	dt = [NSDate dateWithTimeIntervalSince1970:time];
	NSLog(@"%@",[dt description]);
/*	NSString * managerid = [ NSString stringWithFormat:@"%i" ,arc4random()%100000];
	DSCallbackChannelManager * mng = [[DSCallbackChannelManager alloc] initWithChannel:@"memotest" withProtocol:@"http"
															  withTimeCommunicationOut:@"" withConnectionTimeOut:@""
																withHostName:@"datasnap.embarcadero.com" withPath:@"" withPort:@"8086" withManagerID:managerid];
	
	
	DBXCallback * cb = [[ MyCallBack alloc]init];
	[ mng registerCallback:@"pluto" WithDBXCallBack:cb];
//	[ mng unregisterCallback:@"pluto"];
//	[ mng closeClientChannel];
	[cb release];
	[mng release];*/
		NSLog(@"fine");
	[jsonTypes release];
	[sessions release];
	[connection release];
    [complexTypes release];
	[SimpleTypes release];
    [SimpleValues release];
	
    [pool drain];
	
}

@end
@implementation MyCallBack
@synthesize textView;
-(void) updateview:(NSString *) mesg{
textView.text =mesg;
}
-(id) execute:(NSArray *)params{
		NSLog(@"consume [MyCallback.execute] %@",[params description]);
	[self performSelectorOnMainThread:@selector(updateview:) withObject:[params description] waitUntilDone:YES];
	return [ NSArray arrayWithObjects:@"{\"Hello\":\"World\"}",nil];
}


@end

