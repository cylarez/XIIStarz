//
//  Entry.h
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-04-02.
//  Copyright (c) 2011 XIIStarz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSData * image;

@end
