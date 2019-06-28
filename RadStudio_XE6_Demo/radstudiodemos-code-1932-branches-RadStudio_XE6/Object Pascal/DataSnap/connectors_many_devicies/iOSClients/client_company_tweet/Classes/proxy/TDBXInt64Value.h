
#import <Foundation/Foundation.h>
#import "DBXValue.h"


/**
 * 
 * @brief Wraps the Int64 type and allows it to be null
 *
 */
@interface TDBXInt64Value : DBXValue {
@protected bool ValueNull;
@private long long DBXInternalValue;
}



@end

