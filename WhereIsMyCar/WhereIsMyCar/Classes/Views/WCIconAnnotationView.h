//
//  WCCarAnnotationView.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/4/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

extern NSString *const WCIconAnnotationViewReuseIdentifier;

@interface WCIconAnnotationView : MKAnnotationView

- (id)initWithAnnotation:(id)annotation reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setAnnotation:(id)annotation;

@end
