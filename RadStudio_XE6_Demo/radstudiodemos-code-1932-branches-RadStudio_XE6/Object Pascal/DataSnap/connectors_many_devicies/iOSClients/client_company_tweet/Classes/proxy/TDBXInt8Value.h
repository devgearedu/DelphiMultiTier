
#import <Foundation/Foundation.h>
#import "DBXValue.h"
/**
 * 
 *@brief Wraps the Double type and allows it to be null
 *
 */
@interface TDBXInt8Value : DBXValue {
@protected bool ValueNull;
@private  int DBXInternalValue;
}



@end
