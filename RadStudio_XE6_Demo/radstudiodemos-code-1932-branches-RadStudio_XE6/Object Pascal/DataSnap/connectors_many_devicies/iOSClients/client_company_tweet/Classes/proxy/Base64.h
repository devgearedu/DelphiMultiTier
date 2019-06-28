#import <Foundation/Foundation.h>
/**
 * @brief  NSString extension for string and stream base64 conversion. Extension to NSString object to encode  a string using base64 encoding
 */ 

@interface NSString (NSStringBase64) 
/**
 * Encode a string using base64 encoding
 * @param strData is the string to be encoded
 * @return retunr the base64 string encoding for the string parameter.  
 */

+ (NSString *)encodeBase64WithString:(NSString *)strData;
/**
 * Encode an NSdata using base64 encoding
 * @param objData is the NSData to be encoded
 * @return retunr the base64 string encoding for the  parameter.  
 */

+ (NSString *)encodeBase64WithData:(NSData *)objData; 

@end

