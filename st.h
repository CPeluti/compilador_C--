#include<string>
#include<map>
class ST 
{
    public:
        std::map<std::string, int> symbol_table;
        bool exist_symbol(std::string symbol);
        void insert_symbol(std::string symbol);
};