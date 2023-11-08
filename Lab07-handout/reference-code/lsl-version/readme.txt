物体flag：在蚂蚁到达食物时释放，用于被Food检测，包含脚本Die_Listen，在听到“die”时消失。
物体Phe：信息素，包含脚本Die，在所设定的时间后消失，目前为200秒。
物体Food：包含脚本Food，用于检测flag，并减小自身体积，目前体积为4，在脚本变量food_number中修改。
物体ant：包含物体flag和Phe，脚本Search_Silent和脚本Ant_Die_Listen。听到“antdie”后消失。
物体Home：包含物体ant，脚本Touch_Rez，每Touch一次释放一只ant。

Food放置在Home的X轴正方向，距离15-30左右。
ant每次搜索食物的半径为10，搜索信息素的半径为8。
