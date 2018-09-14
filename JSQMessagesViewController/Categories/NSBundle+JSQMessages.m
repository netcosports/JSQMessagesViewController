//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "NSBundle+JSQMessages.h"

#import "JSQMessagesViewController.h"

typedef enum JSQLanguageValue {
    JSQLanguageValueEnglish = 0,
    JSQLanguageValueFrench = 1
} JSQLanguageValue;

@interface JSQLanguage : NSObject
@property (nonatomic, assign) JSQLanguageValue languageType;
@end

@implementation JSQLanguage : NSObject

- (instancetype)initWithLanguageType:(JSQLanguageValue)languageType
{
    self = [super init];
    if (self) {
        self.languageType = languageType;
    }
    return self;
}

- (NSString *)code
{
    if (self.languageType == JSQLanguageValueEnglish) {
        return @"en";
    } else if (self.languageType == JSQLanguageValueFrench) {
        return @"fr";
    } else {
        return @"en";
    }
}

@end


static NSString * const JSQLanguageManagerSavedLanguageKey = @"savedLanguage";

@implementation JSQLanguageManager : NSObject

+ (JSQLanguage *)language
{
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    JSQLanguage *userLanguage = [self defaultLanguage];
    
    NSString *savedLanguageCode = [defaults objectForKey:JSQLanguageManagerSavedLanguageKey];
    if (savedLanguageCode != nil && savedLanguageCode.length > 0) {
        for (JSQLanguage* languageObject in [self avaibleLanguages]) {
            if ([[languageObject code] isEqualToString:savedLanguageCode]) {
                userLanguage = languageObject;
                break;
            }
        }
    }
    return userLanguage;
}

+ (NSArray *)avaibleLanguages
{
    JSQLanguage *frenchLanguage = [[JSQLanguage alloc] initWithLanguageType:JSQLanguageValueFrench];
    JSQLanguage *englishLanguage = [[JSQLanguage alloc] initWithLanguageType:JSQLanguageValueEnglish];
    return @[englishLanguage, frenchLanguage];
}

+ (JSQLanguage *)defaultLanguage
{
    JSQLanguage *englishLanguage = [[JSQLanguage alloc] initWithLanguageType:JSQLanguageValueEnglish];
    return englishLanguage;
}

+ (NSBundle *)bundle
{
    NSBundle *defaultBundle = NSBundle.mainBundle;
    NSString *bundleCode = [[self language] code];
    NSString *bundleResourcePath = [[NSBundle mainBundle] pathForResource:bundleCode ofType:@"lproj"];
    if (bundleResourcePath == nil) {
        return defaultBundle;
    }
    
    return [[NSBundle alloc] initWithPath:bundleResourcePath];
}

@end


@implementation NSBundle (JSQMessages)

+ (NSBundle *)jsq_messagesBundle
{
    return [NSBundle bundleForClass:[JSQMessagesViewController class]];
}

+ (NSBundle *)jsq_messagesAssetBundle
{
    NSString *bundleResourcePath = [NSBundle jsq_messagesBundle].resourcePath;
 
    NSString *bundleCode = [[JSQLanguageManager language] code];
    
    NSString *assetPath = [bundleResourcePath stringByAppendingPathComponent:@"JSQMessagesAssets.bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:assetPath];
    
    NSString *bundleResourcePath = [bundle pathForResource:bundleCode ofType:@"lproj"];
    
    return [[NSBundle alloc] initWithPath:bundleResourcePath];
}

+ (NSString *)jsq_localizedStringForKey:(NSString *)key
{
    NSBundle *bundle = [NSBundle jsq_messagesAssetBundle];
    NSString *format = NSLocalizedStringFromTableInBundle(key, @"JSQMessages", bundle, nil);
    NSString *string = [[NSString alloc] initWithFormat:format locale:NSLocale.currentLocale];
    NSLog(@"localized: %@", string);
    return string;
}

@end
