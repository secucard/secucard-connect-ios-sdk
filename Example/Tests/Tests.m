//
//  SecucardConnectClientLibTests.m
//  SecucardConnectClientLibTests
//
//  Created by Jörn Schmidt on 04/25/2015.
//  Copyright (c) 2014 Jörn Schmidt. All rights reserved.
//

SpecBegin(InitialSpecs)

describe(@"these will fail", ^{

    it(@"can do maths", ^{
        expect(1).to.equal(2);
    });

    it(@"can read", ^{
        expect(@"number").to.equal(@"string");
    });
    
    it(@"will wait for 10 seconds and fail", ^{
        waitUntil(^(DoneCallback done) {
        
        });
    });
});

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
<<<<<<< HEAD
    it(@"will wait and succeed", ^AsyncBlock {
        waitUntil(^(DoneCallback done) {
            done();
        });
    });
=======
//    it(@"will wait and succeed", ^AsyncBlock {
//        waitUntil(^(DoneCallback done) {
//            done();
//        });
//    });
>>>>>>> 7808b388d351e4168bd08b487b74e45734c03a78
});

SpecEnd
