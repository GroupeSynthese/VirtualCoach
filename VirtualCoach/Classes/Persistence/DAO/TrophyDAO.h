//
//  TrophyDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface TrophyDAO : NSObject

//INSERT
-(id)insertIntoTrophy:(NSString *) name description:(NSString *) desc;
//SELECT
-(NSArray *) allTrophy;

@end
