

#import <Foundation/Foundation.h>
#import "DBXValue.h"


/**
 * 
 * @brief Wraps the TimeStamp type and allows it to be null
 *
 */

@interface TDBXTimeStampValue : DBXValue {
@protected bool ValueNull;
@private NSDate* DBXInternalValue;
}


@end

