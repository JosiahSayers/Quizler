﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Tag
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public int CardId { get; set; }
    }
}
