#include<string>
#include<vector>
class ST 
{
    public:
        std::vector<std::string> symbol_table;
        bool exist_symbol(std::string symbol);
        void insert_symbol(std::string symbol);
};