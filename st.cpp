#include "st.h"
#include<string>
bool ST::exist_symbol(std::string symbol){
    return(symbol_table.find(symbol) != symbol_table.end());
};
void ST::insert_symbol(std::string symbol){
    symbol_table[symbol] = 0;
};