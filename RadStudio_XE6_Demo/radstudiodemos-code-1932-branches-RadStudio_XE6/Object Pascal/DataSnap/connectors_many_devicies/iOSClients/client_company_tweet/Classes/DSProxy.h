// 
// Created by the DataSnap proxy generator.
// 03/06/2011 17:53:12
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
#import "TJSONTrue.h"
#import "TJSONFalse.h"
#import "DBXProtocols.h"
#import "TDBXAnsiStringValue.h"
#import "TDBXAnsiCharsValue.h"
#import "TDBXBooleanValue.h"
#import "TDBXDoubleValue.h"
#import "TDBXUInt8Value.h"
#import "TDBXInt8Value.h"
#import "TDBXUInt16Value.h"
#import "TDBXInt16Value.h"
#import "TDBXInt32Value.h"
#import "TDBXInt64Value.h"
#import "TDBXSingleValue.h"
#import "TDBXStringValue.h"
#import "TDBXTimeValue.h"
#import "TDBXTimeStampValue.h"
#import "TDBXWideStringValue.h"
#import "TDBXDateValue.h"
#import "TDBXReaderValue.h"
#import "TDBXStreamValue.h"
#import "TDBXBcdValue.h"

@interface TCompanyTweet:DSAdmin{
}

  -(void) Logout;

/**
 * @param UserName [in] - Type on server: string
 * @param ReturnMessage [out] - Type on server: string
 * @return result - Type on server: Boolean
 */
  -(bool) LoginUser: (NSString *) username  withReturnMessage: (out NSString **) returnmessage;

/**
 * @return result - Type on server: TJSONArray
 */
  -(TJSONArray *) UsersList;

/**
 * @return result - Type on server: TJSONArray
 */
  -(TJSONArray *) ConnectedUsers;

/**
 * @param Users [in] - Type on server: TJSONArray
 */
  -(void) SetUsersToFollow: (TJSONArray *) users ;

/**
 * @param Tweet [in] - Type on server: string
 */
  -(void) SendTweet: (NSString *) tweet ;
@end

