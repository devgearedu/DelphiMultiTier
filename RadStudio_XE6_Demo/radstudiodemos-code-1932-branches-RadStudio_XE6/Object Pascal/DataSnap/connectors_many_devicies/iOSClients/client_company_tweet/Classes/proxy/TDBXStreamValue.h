

#import <Foundation/Foundation.h>
#import "DBXValue.h"

/**
 * 
 * @brief Wraps the {@link TStream} type and allows it to be null
 *
 */
@interface TDBXStreamValue : DBXValue {
	BOOL ValueNull;
}

@end
