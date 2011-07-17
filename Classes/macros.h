#define fmt(f, ...) [NSString stringWithFormat: f, ##__VA_ARGS__]
#define appFmt(val, str, ...) [val appendFormat:str, ##__VA_ARGS__]

#define forAllDays for (int day = 0; day < 7; ++day)
