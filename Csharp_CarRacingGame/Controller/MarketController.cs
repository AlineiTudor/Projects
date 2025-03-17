using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project_ii_v3.Controller
{
     class MarketController
    {
        public static bool buyCar(string carName, string userN)
        {
            bool canBuy = false;
            int money = DatabaseController.getMoney(userN);
            int price = DatabaseController.getItemPrice(carName);
            if(money > price)
            {
                canBuy = true;
                DatabaseController.buyItem(userN, carName);
            }

            return canBuy;
        }

    }
}
