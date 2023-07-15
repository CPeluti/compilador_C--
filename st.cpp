#include "st.h"
#include<string>
#include<algorithm>
bool ST::exist_symbol(std::string symbol){
    return(std::find(symbol_table.begin(), symbol_table.end(), symbol) != symbol_table.end());
};
void ST::insert_symbol(std::string symbol){
    symbol_table.push_back(symbol);
};