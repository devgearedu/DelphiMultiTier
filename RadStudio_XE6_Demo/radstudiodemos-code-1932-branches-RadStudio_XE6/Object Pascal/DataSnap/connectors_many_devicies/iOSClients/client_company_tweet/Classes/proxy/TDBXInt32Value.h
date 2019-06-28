

/**
 * 
 * @brief Wraps the Int8 type and allows it to be null
 *
 */
#import <Foundation/Foundation.h>
#import "DBXValue.h"



@interface TDBXInt32Value : DBXValue {
@protected bool ValueNull;
@private long DBXInternalValue;
}


@end
