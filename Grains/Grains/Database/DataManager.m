 // DataManager.m
#import "DataManager.h"


NSString * const DataManagerDidSaveNotification = @"DIBDataManagerDidSaveNotification";
NSString * const DataManagerDidSaveFailedNotification = @"DIBDataManagerDidSaveFailedNotification";

@interface DataManager ()

- (NSString*)sharedDocumentsPath;

@end

@implementation DataManager


@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainObjectContext = _mainObjectContext;
@synthesize objectModel = _objectModel;
@synthesize operationQueue;

NSString * const kDataManagerModelName = @"DPModel";
NSString * const kDataManagerSQLiteName = @"DPModel.sqlite";

+ (DataManager*)sharedInstance {
	static dispatch_once_t pred;
	static DataManager *sharedInstance = nil;

	dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init]; 
    });
	return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        operationQueue = [[NSOperationQueue alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextDidSaveNotification object:nil];
    }
    return self;
}

- (NSManagedObjectModel*)objectModel {

    if (_objectModel != nil)
    {
        return _objectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kDataManagerModelName withExtension:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _objectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    
	if (_persistentStoreCoordinator)
		return _persistentStoreCoordinator;
    
    
    NSString *defaultStorePath = [[NSBundle bundleForClass:[self class]] pathForResource:kDataManagerModelName ofType:@"sqlite"];
    NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDataManagerSQLiteName];
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath])
        //if (![[NSFileManager defaultManager] fileExistsAtPath:storePath])
    {
//        if ([[NSFileManager defaultManager] copyItemAtPath:defaultStorePath toPath:storePath error:&error])
//            NSLog(@"Copied starting data to %@", storePath);
//        else
//            NSLog(@"Error copying default DB to %@ (%@)", storePath, error);
    }
    
	// Get the paths to the SQLite file
	//NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDataManagerSQLiteName];
	NSURL *storeURL = [NSURL fileURLWithPath:storePath];

	// Define the Core Data version migration options
//	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//				 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//				 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
//				 nil];

    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES,
                              NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}
                              };
    
	// Attempt to load the persistent store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self objectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
						       configuration:nil
								 URL:storeURL
							     options:options
							       error:&error]) {
		NSLog(@"Fatal error while creating persistent store: %@", error);
		abort();
	}


	return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_mainObjectContext != nil)
    {
        return _mainObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _mainObjectContext = [[NSManagedObjectContext alloc] init];
        [_mainObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _mainObjectContext;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)save {
	if (![[self managedObjectContext] hasChanges])
		return YES;

	NSError *error = nil;
	if (![[self managedObjectContext] save:&error]) {
		NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
		[[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveFailedNotification
								    object:error];
		return NO;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveNotification object:nil];
	return YES;
}


- (void)contextChanged:(NSNotification*)notification
{
    if ([notification object] == [self managedObjectContext]) return;
    
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(contextChanged:) withObject:notification waitUntilDone:YES];
        return;
    }
    NSManagedObjectContext *context = (NSManagedObjectContext *)notification.object;
    if( context.persistentStoreCoordinator == self.persistentStoreCoordinator ) {
        [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    }
}

#pragma -
#pragma ActionMethods

- (NSString*)sharedDocumentsPath {
	static NSString *SharedDocumentsPath = nil;
	if (SharedDocumentsPath)
		return SharedDocumentsPath;

	// Compose a path to the <Library>/Database directory
	NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	SharedDocumentsPath = [libraryPath stringByAppendingPathComponent:@"Database"] ;

	// Ensure the database directory exists
	NSFileManager *manager = [NSFileManager defaultManager];
	BOOL isDirectory;
	if (![manager fileExistsAtPath:SharedDocumentsPath isDirectory:&isDirectory] || !isDirectory) {
		NSError *error = nil;
		NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
								 forKey:NSFileProtectionKey];
		[manager createDirectoryAtPath:SharedDocumentsPath
		   withIntermediateDirectories:YES
				    attributes:attr
					 error:&error];
		if (error)
			NSLog(@"Error creating directory path: %@", [error localizedDescription]);
	}

	return SharedDocumentsPath;
}


#pragma -
#pragma public Methods

- (id) createUniqueObj:(NSString*)entityName withPredicate:(NSPredicate*)predicate {
    id  obj = [[self managedObjectContext] insertNewUniqueObjectForEntityForName:entityName withPredicate:predicate];
    return obj;
}
//
//- (User*)getUser {
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_USER inManagedObjectContext:context];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDesc];
//    NSError *error = nil;
//    NSArray *objects = [context executeFetchRequest:request error:&error];
//    //[request release];
//    User *user;
//    if (objects.count > 0) {
//        user = [objects objectAtIndex:0];
//    }
//    //    else {
//    //        user = [self createUniqueObj:DB_TABLE_USER withPredicate:nil];
//    //    }
//    
//    return user;
//}
//
- (NSArray*) getSideMenuItems {

    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_MASTER inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate * isSideMenu = [NSPredicate predicateWithFormat:@"isSideMenu = '1'"];
    NSPredicate * isActive = [NSPredicate predicateWithFormat:@"isActive = '1'"];
    NSPredicate *compountPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[isSideMenu, isActive]];
    [request setPredicate:compountPredicate];
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"isSideMenuOrder" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];

    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getAllMasterItems {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_MASTER inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
//    NSPredicate * isSideMenu = [NSPredicate predicateWithFormat:@"isSideMenu = '1'"];
    NSPredicate * isActive = [NSPredicate predicateWithFormat:@"isActive = '1'"];
//    NSPredicate *compountPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[isSideMenu, isActive]];
    [request setPredicate:isActive];
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"isSideMenuOrder" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getAllNews {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_NEWS inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    NSString *imagePathLocalised = [AppSettings getLocalizedField:@"imagePath"];
    NSString *titleLocalised = [AppSettings getLocalizedField:@"title"];
    NSPredicate * isSideMenu = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ != ''",imagePathLocalised]];
    NSPredicate * title = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ != ' '",titleLocalised]];
    NSPredicate *compountPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[isSideMenu, title]];
    [request setPredicate:compountPredicate];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"articleDate" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getAllMastersForListingByParentID:(NSNumber*) parentId {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_MASTER inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSPredicate * newParentId = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"parentId = '%@'",parentId]];
    NSPredicate * newMasterType = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type CONTAINS[c] '2' OR type CONTAINS[c] '3'"]];
    NSPredicate *compountPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[newParentId, newMasterType]];
    [request setPredicate:compountPredicate];
    
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"isSideMenuOrder" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];

    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getMasterObject:(int )masterId{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_MASTER inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate * idPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"masterID = '%d'",masterId]];
    [request setPredicate:idPredicate];

    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;

}

- (NSArray*) getCallUsContent {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_CALLUS inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getMastersByURL:(NSString *)url {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_MASTER inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    NSString *urlLocalised = [AppSettings getLocalizedField:@"url"];
    NSPredicate * urlPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ CONTAINS[c] '%@'",urlLocalised, url]];
    [request setPredicate:urlPredicate];
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getParentId:(NSNumber *)parentId {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_MASTER inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSPredicate * parentIdPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"masterID == '%@'",parentId]];
    [request setPredicate:parentIdPredicate];
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

- (NSArray*) getAllPharmacies:(int)dayType {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_PHARMACY inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSPredicate * day = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"dayType == '%d'",dayType]];
    [request setPredicate:day];
    
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"articleDate" ascending:NO];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
//    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}


- (NSArray*) getAllDepartment {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_GENERAL_DEPARTMENT inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSPredicate * isPoliceStation = [NSPredicate predicateWithFormat:@"policeStation == '1' and isActive = 1"];
    [request setPredicate:isPoliceStation];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    return objects;
}

- (NSArray*) getDepartmentById:(int)departmentId {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_GENERAL_DEPARTMENT inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSPredicate * isPoliceStation = [NSPredicate predicateWithFormat:@"policeStation == '1' and isActive = 1 and departmentID == %d ", departmentId];
    [request setPredicate:isPoliceStation];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    return objects;
}

- (NSArray*) getDepartmentDetails:(id) department {
    
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_GENERAL_DEPARTMENT_DETAIL inManagedObjectContext:context];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDesc];
//    [request setReturnsObjectsAsFaults:NO];
//    
//    NSPredicate * isPoliceStation = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"isActive = 1 and department = %@",department]];
//    [request setPredicate:isPoliceStation];
//    
//    NSError *error = nil;
//    NSArray *objects = [context executeFetchRequest:request error:&error];
//    return objects;
    return nil;
}



- (NSArray*) getAllVideos {
    return [[DataManager sharedInstance] getLatestVideosWithCount:-1];
}

- (NSArray*) getLatestVideos {
    return [[DataManager sharedInstance] getLatestVideosWithCount:2];
}


- (NSArray*) getLatestVideosWithCount:(int)count {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_VIDEO inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"uploaded" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];

    
    if(count >0){
        [request setFetchLimit:count];
    }
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    return objects;
}

#pragma mark -
#pragma Notifications FUNCTIONS

- (NSArray*) getAllNotifications {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_NOTIFICATIONS inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    return objects;
}

//todo
//delete notification by notification id


#pragma mark -
#pragma Events FUNCTIONS



- (NSArray*) getAllEvents{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_EVENTS inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortByOrder = [[NSSortDescriptor alloc] initWithKey:@"articleDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByOrder]];

    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    return objects;
}


-(int)getEventsCount:(int)year month:(int)month{
    
    NSArray *array = [self getEventsByDate:year month:month];
    return  array.count;
}

-(NSArray *)getEventsByDate:(int)year month:(int)month{
    
    month++;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:DB_TABLE_EVENTS inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];
    
    NSString *strMonth = [NSString stringWithFormat:@"%d" , month];
    if([strMonth  length]==1)strMonth = [NSString stringWithFormat:@"0%@" , strMonth];
    
//    NSLog(@"year : %d , month : %@" , year , strMonth);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone: [NSTimeZone systemTimeZone]];
    
    // Specify the date components manually (year, month, day, hour, minutes, etc.)
    NSDateComponents *timeZoneComps=[[NSDateComponents alloc] init];
    [timeZoneComps setTimeZone:[NSTimeZone  systemTimeZone]];
    [timeZoneComps setYear:year];
    [timeZoneComps setMonth:month];
    [timeZoneComps setDay:1];
    [timeZoneComps setHour:4];
    
    // transform the date compoments into a date, based on current calendar settings
    NSDate *dateStart = [calendar dateFromComponents:timeZoneComps];
    //    NSLog(@"start date with calendar : %@" , dateStart);
    
    int endDay =[Utility getLastDateMonth:year month:month];
    [timeZoneComps setDay:endDay];
    NSDate *dateEnd = [calendar dateFromComponents:timeZoneComps];
    //    NSLog(@"dateEnd with calendar : %@" , dateEnd);
    
//    NSLog(@"(articleDate >= %@) AND (articleDate <= %@)", dateStart, dateEnd);
    NSPredicate *compountPredicate = [NSPredicate predicateWithFormat:@"(articleDate >= %@) AND (articleDate <= %@)", dateStart, dateEnd];
    [request setPredicate:compountPredicate];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
//    NSLog(@"year : %d , month : %d , objects.count : %d" , year , month , objects.count);
    return objects;
}



-(NSArray*) getAllMasters {
    return [[self mainObjectContext]objectsForEntityName:DB_TABLE_MASTER withPredicate:nil sortDescriptors:nil];
}

- (Master*) getMastersByEVoiceKeyword:(NSString*) voiceKey {
    Master *master = nil;
    NSString *coloumn ;
    if (AppLanguage == ARABIC) {
        coloumn = db_master_VCKeywordAR;
    }
    else {
        coloumn = db_master_VCKeywordEN;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = [c]'%@'",coloumn,voiceKey]];
    NSArray *objects =   [[self mainObjectContext]objectsForEntityName:DB_TABLE_MASTER withPredicate:predicate sortDescriptors:nil];
    if ([objects count] == 0) {
        master = [self getMastersByVoiceKeywordLike:voiceKey];
    }
    else {
        master = [objects objectAtIndex:0];
    }
    return master;
}

-(Master*) getMastersByVoiceKeywordLike:(NSString*) voiceKey {
    
    Master *master = nil;
    NSString *coloumn ;
    if (AppLanguage == ARABIC) {
        coloumn = db_master_VCKeywordAR;
    }
    else {
        coloumn = db_master_VCKeywordEN;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ CONTAINS[c]'%@'",coloumn,voiceKey]];
    NSArray *objects =   [[self mainObjectContext]objectsForEntityName:DB_TABLE_MASTER withPredicate:predicate sortDescriptors:nil];
    if ([objects count] > 0)
        master = [objects objectAtIndex:0];
    return master;
    
}

- (SplashImage*)getSplashImage {
    NSManagedObjectContext *mainObject = [self managedObjectContext];
    NSArray *objects =   [mainObject objectsForEntityName:DB_TABLE_SPLASH withPredicate:nil sortDescriptors:nil];
    if ([objects count] > 0) {
        return [objects objectAtIndex:0];
    }
    return nil;
}

#pragma mark -
#pragma DB MANAGER FUNCTIONS



- (void) deleteObject:(id)obj {
    if (!obj) {
        return;
    }
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:obj];
    obj = nil;
    [self save];
}

- (void) deleteEntity:(NSString*)entity {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setEntity:entityDesc];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *managedObject in objects) {
        [context deleteObject:managedObject];
    }
    if (![context save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entity,error);
    }
}



@end
