
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
#import "DSProxy.h"


@implementation TCompanyTweet
  -(id) getTCompanyTweet_Logout {
    return  [NSArray arrayWithObjects:
    nil];
  }
  -(id) getTCompanyTweet_LoginUser {
    return  [NSArray arrayWithObjects:
      [DSRESTParameterMetaData parameterWithName: @"UserName" withDirection:Input withDBXType:WideStringType withTypeName:@"string"],
      [DSRESTParameterMetaData parameterWithName: @"ReturnMessage" withDirection:Output withDBXType:WideStringType withTypeName:@"string"],
      [DSRESTParameterMetaData parameterWithName: @"" withDirection:ReturnValue withDBXType:BooleanType withTypeName:@"Boolean"],
    nil];
  }
  -(id) getTCompanyTweet_UsersList {
    return  [NSArray arrayWithObjects:
      [DSRESTParameterMetaData parameterWithName: @"" withDirection:ReturnValue withDBXType:JsonValueType withTypeName:@"TJSONArray"],
    nil];
  }
  -(id) getTCompanyTweet_ConnectedUsers {
    return  [NSArray arrayWithObjects:
      [DSRESTParameterMetaData parameterWithName: @"" withDirection:ReturnValue withDBXType:JsonValueType withTypeName:@"TJSONArray"],
    nil];
  }
  -(id) getTCompanyTweet_SetUsersToFollow {
    return  [NSArray arrayWithObjects:
      [DSRESTParameterMetaData parameterWithName: @"Users" withDirection:Input withDBXType:JsonValueType withTypeName:@"TJSONArray"],
    nil];
  }
  -(id) getTCompanyTweet_SendTweet {
    return  [NSArray arrayWithObjects:
      [DSRESTParameterMetaData parameterWithName: @"Tweet" withDirection:Input withDBXType:WideStringType withTypeName:@"string"],
    nil];
  }
  -(void) dealloc {
    [super dealloc];
  }

  -(void) Logout{
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.Logout";
    [cmd  prepare:[self getTCompanyTweet_Logout]];
    
    
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
    [cmd  prepare:[self getTCompanyTweet_LoginUser]];
    
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
    [cmd  prepare:[self getTCompanyTweet_UsersList]];
    
    
    [Connection execute: cmd];
    
    return (TJSONArray *)[[[cmd.parameters objectAtIndex:0]getValue]GetAsJSONValue];
  }

/**
 * @return result - Type on server: TJSONArray
 */
  -(TJSONArray *) ConnectedUsers{
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  GET;
    cmd.text= @"TCompanyTweet.ConnectedUsers";
    [cmd  prepare:[self getTCompanyTweet_ConnectedUsers]];
    
    
    [Connection execute: cmd];
    
    return (TJSONArray *)[[[cmd.parameters objectAtIndex:0]getValue]GetAsJSONValue];
  }

/**
 * @param Users [in] - Type on server: TJSONArray
 */
  -(void) SetUsersToFollow: (TJSONArray *) users {
    
    DSRESTCommand * cmd = [[self Connection ] CreateCommand];
    cmd.RequestType =  POST;
    cmd.text= @"TCompanyTweet.SetUsersToFollow";
    [cmd  prepare:[self getTCompanyTweet_SetUsersToFollow]];
    
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
    [cmd  prepare:[self getTCompanyTweet_SendTweet]];
    
    [[[cmd.parameters objectAtIndex:0]getValue]SetAsString:tweet];
    
    [Connection execute: cmd];
  }
@end
