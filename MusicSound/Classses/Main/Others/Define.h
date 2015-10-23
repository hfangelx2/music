
#if DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif

#define kScreenH     [[UIScreen mainScreen] bounds].size.height

#define kScreenW     [[UIScreen mainScreen] bounds].size.width

#define kMargin 5

#define kTextH 20

#define k2Margin 10

#define DayOrNight @"DayOrNight"

#define Night @"night"

#define Day @"day"

#define kRandomColor kColor(arc4random() % 256, arc4random() % 256, arc4random() % 256)

#define kColor(r, g, b) [UIColor colorWithRed:(r) / 256.0 green:(g) / 256.0 blue:(b) / 256.0 alpha:1]
