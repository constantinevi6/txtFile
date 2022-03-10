//
//  readtxt.cpp
//  ASPS
//
//  Created by Constantine VI on 2020/12/16.
//  Copyright © 2020 CSRSR. All rights reserved.
//

#include "txtFile.hpp"
#include <iostream>
#include <fstream>
#include <algorithm>

txtFile::txtFile() {

}

txtFile::txtFile(std::filesystem::path InputFilePath) {
    pathFile = InputFilePath;
}

txtFile::~txtFile() {
    TXTContent.clear();
}

int txtFile::read() {
    std::string Line = "";
    try {
        if (std::filesystem::exists(pathFile)) {
            std::fstream fsInput(pathFile.string(), std::ifstream::in);
            while (getline(fsInput, Line)) {
                if (Line.find('\r') != Line.npos) {
                    Line.erase(std::remove(Line.begin(), Line.end(), '\r'), Line.end());
                }
                TXTContent.push_back(Line);
            }
            fsInput.close();
        }
        else {
            std::string error = "Error: " + pathFile.string() + ", No such file or directory.";
            throw error.c_str();
        }
    }
    catch (const char* message) {
        std::cout << message << std::endl;
        return 1;
    }
    return 0;
}

int txtFile::write() {
    std::ofstream filestr;
    filestr.open(pathFile.string());
    for (auto& it : TXTContent)
    {
        filestr << it;
        filestr << std::endl;
    }
    filestr.close();
    return 0;
}

int txtFile::write(std::filesystem::path pathOutputFile) {
    std::ofstream filestr;
    filestr.open(pathOutputFile.string());
    for (auto& it : TXTContent)
    {
        filestr << it;
        filestr << std::endl;
    }
    filestr.close();
    return 0;
}

int txtFile::append(std::string Inputstr) {
    if (TXTContent.size() == 0) {
        TXTContent.push_back(std::string());
    }
    TXTContent.rbegin()->append(Inputstr);
    return 0;
}

int txtFile::appendLine(std::string Inputstr) {
    TXTContent.push_back(Inputstr);
    return 0;
}

int txtFile::appendLine(std::string Inputstr, unsigned long NoLine) {
    if (TXTContent.size() < NoLine) {
        TXTContent.resize(NoLine);
    }
    TXTContent.insert(TXTContent.begin() + NoLine, Inputstr);
    return 0;
}

int txtFile::print() {
    for (auto itLine : TXTContent) {
        std::cout << itLine << std::endl;
    }
    return 0;
}

unsigned long txtFile::getNLine() {
    return TXTContent.size();
}

std::string txtFile::getLineContent(unsigned long NoLine) {
    return TXTContent.at(NoLine - 1);
}

std::string txtFile::getLineContent(std::string InputKeyword) {
    for (auto itLine : TXTContent) {
        if (itLine.find(InputKeyword) != itLine.npos) {
            return itLine;
        }
    }
    return std::string();
}
