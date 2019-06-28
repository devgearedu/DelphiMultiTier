// 
// Created by the DataSnap proxy generator.
// 11/04/2011 16.01.49
// 

#import <Foundation/Foundation.h>
#import "DSAdmin.h"
#import "DSRESTParameterMetaData.h"
#import "DBException.h"
#import "TParams.h"
#import "TDBXReader.h"
#import "TDataSet.h"
#import "TJSONNull.h"
#import "TJSONValue.h"
#import "TJSONObject.h"
#import "TJSONArray.h"
#import "DBXProtocols.h"

@interface TCompanyTweet:DSAdmin{
  NSArray *TCompanyTweet_Logout;
  NSArray *TCompanyTweet_LoginUser;
  NSArray *TCompanyTweet_UsersList;
  NSArray *TCompanyTweet_ConnectedUsers;
  NSArray *TCompanyTweet_SetUsersToFollow;
  NSArray *TCompanyTweet_SendTweet;
}
@end
@interface TCompanyTweet (CompanyTweetSingleton) 
+(id) getProxyinstance;
+(void) releaseProxyinstance;
+(DSRESTConnection*) getConnectioninstance;
+(void) releaseConnectioninstance;

@end


@implementation TCompanyTweet
  -(id) init {
    self = [super init];
    if (self) {
        TCompanyTweet_Logout = [NSArray arrayWithObjects:
        nil];
        TCompanyTweet_LoginUser = [NSArray arrayWithObjects:
          [DSRESTParameterMetaData parameterWithName: @"UserName" withDirection:Input withDBXType:WideStringType withTypeName:@"string"],
          [DSRESTParameterMetaData parameterWithName: @"ReturnMessage" withDirection:Output withDBXType:WideStringType withTypeName:@"string"],
          [DSRESTParameterMetaData parameterWithName: @"" withDirection:ReturnValue withDBXType:BooleanType withTypeName:@"Boolean"],
        nil];
		[TCompanyTweet_LoginUser retain];
        TCompanyTweet_UsersList = [NSArray arrayWithObjects:
          [DSRESTParameterMetaData parameterWithName: @"" withDirection:ReturnValue withDBXType:JsonValueType withTypeName:@"TJSONArray"],
        nil];
		[TCompanyTweet_UsersList retain];
        TCompanyTweet_ConnectedUsers = [NSArray arrayWithObjects:
          [DSRESTParameterMetaData parameterWithName: @"" withDirection:ReturnValue withDBXType:JsonValueType withTypeName:@"TJSONArray"],
        nil];
        TCompanyTweet_SetUsersToFollow = [NSArray arrayWithObjects:
          [DSRESTParameterMetaData parameterWithName: @"Users" withDirection:Input withDBXType:JsonValueType withTypeName:@"TJSONArray"],
        nil];
		[TCompanyTweet_SetUsersToFollow retain];
        TCompanyTweet_SendTweet = [NSArray arrayWithObjects:
          [DSRESTParameterMetaData parameterWithName: @"Tweet" withDirection:Input withDBXType:WideStringType withTypeName:@"string"],
        nil];
		[TCompanyTweet_SendTweet retain];
      }
    	return self;
  }
-(void) dealloc{
	[super dealloc];
}
  -(void) Logout{
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.Logout";
    [cmd  prepare:TCompanyTweet_Logout];
    
    
    [Connection execute: cmd];
  }

/**
 * @param UserName [in] - Type on server: string
 * @param ReturnMessage [out] - Type on server: string
 * @return result - Type on server: Boolean
 */
  -(bool) LoginUser: (NSString *) username  withReturnMessage: (out NSString **) returnmessage{
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.LoginUser";
    [cmd  prepare:TCompanyTweet_LoginUser];
    
    [[[cmd.parameters objectAtIndex:0]getValue]SetAsString:username];
    
    [Connection execute: cmd];
    *returnmessage =   [[[cmd.parameters objectAtIndex:1]getValue]GetAsString];
    
    return [[[cmd.parameters objectAtIndex:2]getValue]GetAsBoolean];
	  
  }

/**
 * @return result - Type on server: TJSONArray
 */
  -(TJSONArray *) UsersList{
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.UsersList";
    [cmd  prepare:TCompanyTweet_UsersList];
    
    
    [Connection execute: cmd];
    
    return (TJSONArray*)[[[cmd.parameters objectAtIndex:0]getValue]GetAsJSONValue];
  }

/**
 * @return result - Type on server: TJSONArray
 */
  -(TJSONArray *) ConnectedUsers{
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.ConnectedUsers";
    [cmd  prepare:TCompanyTweet_ConnectedUsers];
    
    
    [Connection execute: cmd];
    
    return (TJSONArray*)[[[cmd.parameters objectAtIndex:0]getValue]GetAsJSONValue];
  }

/**
 * @param Users [in] - Type on server: TJSONArray
 */
  -(void) SetUsersToFollow: (TJSONArray *) users {
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  POST;
    cmd.text= @"TCompanyTweet.SetUsersToFollow";
    [cmd  prepare:TCompanyTweet_SetUsersToFollow];
    
    [[[cmd.parameters objectAtIndex:0]getValue]SetAsJSONValue:users];
    
    [Connection execute: cmd];
  }

/**
 * @param Tweet [in] - Type on server: string
 */
  -(void) SendTweet: (NSString *) tweet {
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.SendTweet";
    [cmd  prepare:TCompanyTweet_SendTweet];
    
    [[[cmd.parameters objectAtIndex:0]getValue]SetAsString:tweet];
    
    [Connection execute: cmd];
  }
@end
@implementation TCompanyTweet (CompanyTweetSingleton) 

static TCompanyTweet *instanceProxy = NULL;
static DSRESTConnection *instanceConnetion = NULL;

+(id) getProxyinstance{
	if (!instanceProxy) {
		instanceProxy = [[TCompanyTweet alloc]initWithConnection:[TCompanyTweet getConnectioninstance]];
	}
	return instanceProxy;
}

+(void) releaseProxyinstance{
	if (instanceProxy) {
		[instanceProxy release];
		instanceProxy = nil;
		
	}
}

+(DSRESTConnection*) getConnectioninstance{
	if (!instanceConnetion) {
		instanceConnetion =[[DSRESTConnection alloc]init];
	}
	return instanceConnetion;
}

+(void) releaseConnectioninstance{
	if (instanceConnetion) 
	{
		[instanceConnetion release];
		instanceConnetion = nil;
		
		
		}
}
@end	
