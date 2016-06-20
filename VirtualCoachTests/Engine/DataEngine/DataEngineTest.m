//
//  DataEngineTest.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 16/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatabaseService.h"
#import "CoachDataEngine.h"
#import "CoachDO.h"
#import "CheckDatabaseDAO.h"

@interface DataEngineTest : XCTestCase

@property (nonatomic) NSString * databasePath;
@property (nonatomic) CoachDataEngine *coachDE;
@property (nonatomic) CoachDO *coachDO;
@property (nonatomic) CheckDatabaseDAO *checkDB;
@property (nonatomic) NSString * sqlPath;

@end

@implementation DataEngineTest

- (void)setUp {
    [super setUp];
    NSLog(@"\n\n\n\n\n\n\n\n");
    NSLog(@"TEST SETUP");
    NSLog(@"\n\n\n\n\n\n\n\n");
    _databasePath  = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/DatabaseTest.db"];
    NSLog(@"\n\n\n\n\n");
    NSLog(@"databasePath: %@", _databasePath);
    NSLog(@"\n\n\n\n\n");
    [DatabaseService initWithFile:_databasePath];
    
    _sqlPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/CreationTablesTest.sql"];
    NSLog(@"\n\n\n\n\n");
    NSLog(@"sqlPath: %@", _sqlPath);
    NSLog(@"\n\n\n\n\n");
    
    _coachDE = [[CoachDataEngine alloc] init];
    _coachDO = [[CoachDO alloc]init];
    _checkDB = [[CheckDatabaseDAO alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCoachDataEngine {
    /**************************************************DROP TABLES*****************************************************/
    int rep = [DatabaseService sqlFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/DropTables.sql"]];
    
    NSLog(@"REP:%d", rep);
    
    XCTAssertEqual(rep, 0);
    /***********************test checking database and/or creating tables**************/
    int check = [_checkDB CheckingDatabase: _databasePath andScriptCreationPath: _sqlPath];
    
    NSLog(@"CHECK: %d", check);
    
    /********************************************INSERT*************************************************************/
    _coachDO = [[CoachDO alloc] initWithCoachId:nil andName:@"Adrien" andFirstName:@"LESUR" andLogin:@"lesura" andPassword:@"adidi" andLeftHanded:YES andPlayers:NULL andReferenceVideos:NULL];
    
    NSNumber *insertCoachDE = (NSNumber *)[_coachDE insertCoach:_coachDO];
    
    NSLog(@"testDE insert\n\n\n\n\n");
    NSLog(@"%@",insertCoachDE);
    NSLog(@"\n\n\n\n\n");
    
    XCTAssertEqual([insertCoachDE boolValue],YES );
    
    /********************************************SELECT*************************************************************/
    NSMutableArray *selectCoachDE = [_coachDE selectAllCoaches];
     NSLog(@"testDE select\n\n\n\n\n");
    //int countDE= [selectCoachDE count];
    
    // NSLog(@"NB ELMT DANS NSMUTARR: %i",countDE);
    int i;
    
    for (i = 0 ; i < [selectCoachDE count] ; i++) {
        id objet = [selectCoachDE objectAtIndex:i];
         NSLog(@"BOUCLE NSMUTALBEARRAY: %@",objet);
    }
    
    CoachDO *coach = [selectCoachDE objectAtIndex:1];
    NSLog(@"testDE select\n\n\n\n\n");
    NSLog(@"%@",coach.name);
    NSLog(@"\n\n\n\n\n");
    XCTAssertEqualObjects(@"Adrien", coach.name);
    
    /********************************************DELETE*************************************************************/
    NSNumber *delete = (NSNumber *) [_coachDE deleteCoachById:coach.coachId];
    
    XCTAssertEqual([delete boolValue],YES );
}

@end
