//
//  LanguageModel.m
//  VoiceCommand
//
//  Created by Faizan Ali on 9/11/13.
//  Copyright (c) 2013 Faizan Ali. All rights reserved.
//

#import "LanguageModel.h"

@implementation LanguageModel

- (NSError *) generateLanguageModelFromArray:(NSArray *)languageModelArray withFilesNamed:(NSString *)fileName {
    NSError *error = [super generateLanguageModelFromArray:languageModelArray withFilesNamed:fileName];
    
	if([error code] != noErr) {
        return error;
	} else {
        NSDictionary *resultDictionary = [error userInfo];
        NSMutableDictionary *mDictionary = [NSMutableDictionary dictionaryWithDictionary:resultDictionary];
        NSString *path = [self generateJsgfFromArray:languageModelArray withName:fileName];
        [mDictionary setObject:path forKey:@"JsgfPath"];
        error = [NSError errorWithDomain:error.domain code:error.code userInfo:mDictionary];
    }
    return error;
}

- (NSString *) generateJsgfFromArray:(NSArray*)languageArray withName:(NSString*)fileName {

    NSMutableString *grammer = [NSMutableString string];
    [grammer appendString:@"#JSGF V1.0;\n"];
    [grammer appendString:@"grammar samplegrammar;\n"];
    [grammer appendString:@"public <mygrammar1> = "];
    
    for (int i=0; i<[languageArray count]; i++) {
        NSString *phrase = [languageArray objectAtIndex:i];
        [grammer appendString:[phrase uppercaseString]];
        if (i == [languageArray count]-1) {
            [grammer appendString:@" ;"];
        }
        else {
            [grammer appendString:@" | \n"];
        }
    }
    
    return [self saveGrammer:grammer withFileName:fileName];

}

//Method writes a string to a text file
- (NSString *) saveGrammer:(NSString*)grammer withFileName:(NSString*)name {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.gram",documentsDirectory,name];
    //create content - four lines of text
    //save content to the documents directory
    [grammer writeToFile:filePath
              atomically:NO
                encoding:NSUTF8StringEncoding
                   error:nil];
    
    return filePath;
}

@end
