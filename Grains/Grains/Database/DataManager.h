// DataManager.h
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+CWCoreData.h"
#import "DatabaseImports.h"


extern NSString * const DataManagerDidSaveNotification;
extern NSString * const DataManagerDidSaveFailedNotification;

@interface DataManager : NSObject {
    NSOperationQueue *operationQueue;
}

@property (nonatomic,retain) NSOperationQueue *operationQueue;
@property (nonatomic, readonly, retain) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, retain) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, readonly, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager*)sharedInstance;
- (BOOL)save;
- (NSManagedObjectContext*)managedObjectContext;
- (id) createUniqueObj:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
- (void) deleteObject:(id)obj;
- (void) deleteEntity:(NSString*)entity;
- (NSArray*) getSideMenuItems;
- (NSArray*) getAllNews;
- (NSArray*) getAllPoliceStations;
- (NSArray*) getCallUsContent;
- (NSArray*) getAllDepartment;
- (NSArray*) getDepartmentById:(int)departmentId;
- (NSArray*) getAllVideos;
- (NSArray*) getLatestVideos;
- (NSArray*) getAllPharmacies:(int) dayType;
- (NSArray*) getAllEvents;
- (NSArray*) getMastersByURL:(NSString*) url;
- (NSArray*) getParentId:(NSNumber *)parentId;
- (NSArray*) getMasterObject:(int )masterId;
- (NSArray*) getAllMastersForListingByParentID:(NSNumber*)parentId;
- (NSArray*) getDepartmentDetails:(id) department;
- (SplashImage*)getSplashImage;
- (NSArray*) getAllMasterItems;
- (int) getEventsCount:(int)year month:(int)month;
- (Master*) getMastersByEVoiceKeyword:(NSString*) voiceKey;

-(NSArray*) getAllMasters;
-(NSArray *)getEventsByDate:(int)year month:(int)month;
- (NSArray*) getAllNotifications;

@end
