


#import <Foundation/Foundation.h>
#import "DBXValue.h"
/**
 * 
 *@brief Wraps the UInt8 type and allows it to be null
 *
 */
@interface TDBXUInt8Value : DBXValue {
@protected bool ValueNull;
@private  unsigned int DBXInternalValue;
}



@end
