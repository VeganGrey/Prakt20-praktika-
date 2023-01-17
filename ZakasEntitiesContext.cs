using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prakt20_praktika_
{
    internal class ZakasEntitiesContext : ZakazEntities
    {
        private static ZakasEntitiesContext context;

        public static ZakasEntitiesContext GetContext()
        {
            if (context == null)
                context = new ZakasEntitiesContext();
            return context;
        }
    }
}
