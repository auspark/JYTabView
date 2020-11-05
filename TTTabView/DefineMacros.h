#define NSLogRect(rect) NSLog(@"Rect x:%f,y:%f,width:%f,height:%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)

#define NSLogPoint(point) NSLog(@"Point x:%f,y%f",point.x,point.y)

#define NSLogSize(size) NSLog(@"Size width:%f,height%f",size.width,size.height)

#define NSLogObj(obj) NSLog(@"%@",obj)

#define NSLogBool(obj) NSLog(@"%@",obj?@"YES":@"NO")

#define NSLogArray(array) for(id obj in array){NSLog(@"%@",obj);}

#define NSLogDictionary(dict){\
    for(id key in dict.allKeys){\
        NSLog(@"key:%@ value:%@",key,[dict objectForKey:key]);\
    }\
}

#define ResourcesPath  [[NSBundle mainBundle] resourcePath]

#define isFileExists(filePath) [[NSFileManager defaultManager]fileExistsAtPath:filePath]

#define ResourcesFilePath(fileName) [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:fileName]

#define ResourcesFilePath2(fileName) isFileExists(ResourcesFilePath(fileName))?ResourcesFilePath(fileName):nil
