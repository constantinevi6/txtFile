//
//  txtFile.cpp
//  txtFile
//
//  Created by Constantine VI on 2021/11/9.
//

#include <iostream>
#include "txtFile.hpp"
#include "txtFilePriv.hpp"

void txtFile::HelloWorld(const char * s)
{
    txtFilePriv *theObj = new txtFilePriv;
    theObj->HelloWorldPriv(s);
    delete theObj;
};

void txtFilePriv::HelloWorldPriv(const char * s) 
{
    std::cout << s << std::endl;
};

