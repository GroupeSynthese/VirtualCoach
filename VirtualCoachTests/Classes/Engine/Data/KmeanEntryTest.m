//
//  KmeanEntryTest.m
//  VirtualCoach
//
//  Created by Bi ZORO on 04/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KmeanEntry.h"

@interface KmeanEntryTest : XCTestCase

@property (nonatomic) KmeanEntry * entry;

@end

@implementation KmeanEntryTest

- (void)setUp {
    [super setUp];
    _entry = [[KmeanEntry alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 Test the method which update the properties maxAngle and meanAcceleration of object KmeanEntry.
 We run the test on two set of speed which generate a meanAcceleration of 150 and maxAngle of 180.
 */
- (void)testgenerateDataEntryForKmeanFromSpeedVectors {
    
    rect_t interval;
    uint16_t width= 100;
    interval.start.x = 30;
    interval.start.y = 30;
    interval.end.x = 90;
    interval.end.y = 90;
    vect2darray_t * speedVectors0 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors1 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    
    speedVectors0->length=10000;
    speedVectors0->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors1->length=10000;
    speedVectors1->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    int i =0;
    for (i=0; i<10000; i++) {
        speedVectors0->data[i].x =0;
        speedVectors0->data[i].y =0;
        speedVectors1->data[i].x =0;
        speedVectors1->data[i].y =0;
    }
    int j=0;
    for (i=interval.start.y; i<interval.end.y; i++) {
        for (j=interval.start.x; j<interval.end.x; j++) {
            speedVectors0->data[PXL_IDX(width, i, j)].x =0;
            speedVectors0->data[PXL_IDX(width, i, j)].y =50;
            speedVectors1->data[PXL_IDX(width, i, j)].x =-200;
            speedVectors1->data[PXL_IDX(width, i, j)].y =0;
        }
    }
    [_entry generateDataEntryForKmeanFromFirstSpeedVectorsTab:speedVectors0 andSecondSpeedVectorsTab:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    
    XCTAssertEqual((int)_entry.time, 0);
    XCTAssertEqual((int)_entry.maxAngle, 180);
    XCTAssertEqual((double)_entry.meanAcceleration, 150);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
