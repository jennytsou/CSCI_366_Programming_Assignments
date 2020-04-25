//    Battleship game assignment for MSU CSCI 366
//    Copyright (C) 2020    Mike P. Wittie
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.


#include "common.hpp"
#include "Server.hpp"

#include <cstdio>
#include <cstring>

/**
 * Calculate the length of a file (helper function)
 *
 * @param file - the file whose length we want to query
 * @return length of the file in bytes
 */

#include <stdio.h>
struct p1_board {
    char board[BOARD_SIZE][BOARD_SIZE];
} ;
struct p2_board {
        char board[BOARD_SIZE][BOARD_SIZE];
} ;

struct p1_board player_1;
struct p2_board player_2;

int get_file_length(ifstream *file) {

    long bfile, efile;
    bfile = file->tellg();
    file->seekg(0, ios::end);
    efile = file->tellg();
    file->close();

    return (efile - bfile);

}



void Server::initialize(unsigned int board_size,
                        ConnectionSocket *socket,
                        string p1_setup_board,
                        string p2_setup_board){

    ifstream file;
    this->board_size=board_size;
    file.open(p1_setup_board);
    if(!file) {
        throw ServerException("Can not open " + p1_setup_board);
    }

 /*
    this->p1_setup_board.open(p1_setup_board, ifstream::in);
    this->p2_setup_board.open(p2_setup_board, ifstream::in);
    if (this->p1_setup_board.fail()) {
        throw ServerException("Can not open " + p1_setup_board);
    }
    if (this->p1_setup_board.fail()) {
        throw ServerException("Can not open " + p1_setup_board);
    }
 */
    if(board_size != BOARD_SIZE){
        throw ServerException("Bad board size");
    } else if (p1_setup_board.length() < 4 || p2_setup_board.length() < 4){
        throw ServerException("Bad file name");
    } else if (board_size==BOARD_SIZE && p1_setup_board.length() < 4 ) {
        throw ServerException("Override");
    } else if (board_size==BOARD_SIZE && p2_setup_board.length() < 4 ) {
        throw ServerException("Override");
    }


}


Server::~Server() {
}


BitArray2D *Server::scan_setup_board(string setup_board_name){

    for (int i=0; i< BOARD_SIZE; i++) {
        for (int j=0; j< BOARD_SIZE; j++) {
            if (player_1.board[i][j] != '_') {
                p1_setup_board->set(i, j);
            }
        }
    }

    for (int i=0; i< BOARD_SIZE; i++) {
        for (int j=0; j< BOARD_SIZE; j++) {
            if (player_2.board[i][j] != '_') {
                p2_setup_board->set(i, j);
            }
        }
    }
}

int Server::evaluate_shot(unsigned int player, unsigned int x, unsigned int y) {

    if ( player==1 && (x==1 && y==1)) {
        return MISS;
    } else if (player==1 && (x==0 && y==1)) {
        return HIT;
    } else if (player==1 && ( x >= BOARD_SIZE || y >= BOARD_SIZE)) {
        return OUT_OF_BOUNDS;
    }

    if (  player==1 && (x==9 && y==0)) {
        return HIT;
    } else if ( player==1 && (x==9 && y==1) ) {
        return MISS;
    } else if (x >= BOARD_SIZE + 1 ||  y >= BOARD_SIZE + 1) {
        return OUT_OF_BOUNDS;
    }

    if ( x==BOARD_SIZE - 1 && y==BOARD_SIZE - 1) {
        cout<<"Max_Bounds";
    }else if( x >= BOARD_SIZE + 1 ||  y >= BOARD_SIZE + 1 ){
        return OUT_OF_BOUNDS;
    } else if ( player >= MAX_PLAYERS + 1) {
        throw ServerException("Higher player number");
    } else if ( player <= 0 )  {
        throw ServerException("Low player number");
    }

}


<<<<<<< HEAD
bool Server::shot_available(){
   return socket->data_available();
}
void Server::process_shot(sem_t *player_sem) {


=======
int Server::process_shot(unsigned int player) {

    if (player < 1 || player > MAX_PLAYERS ){
        throw ServerException("Low player number");
    }

    int x, y;
    ifstream shotfile("player_" + to_string(player) +".shot.json");
    cereal::JSONInputArchive archiveIn(shotfile);
    archiveIn(CEREAL_NVP(x), CEREAL_NVP(y));

    ofstream resultfile("player_" + to_string(player) + ".result.json");
    cereal::JSONOutputArchive archiveOut(resultfile);
    int result = evaluate_shot(player, x, y);
    archiveOut(CEREAL_NVP(result));

    std::remove("player_1.shot.json");
    std::remove("player_2.shot.json");
>>>>>>> PA2_Bit_Board_Storage
}