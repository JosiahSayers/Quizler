﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Providers.Auth;

namespace Capstone.Models
{
    public class Deck
    {
        public int Id { get; set; }

        [Display(Name = "Deck Name")]
        [Required(ErrorMessage = "Please enter a deck name")]
        public string Name { get; set; }

        [Display(Name = "Date Created")]
        public DateTime DateCreated { get; set; }

        public bool PublicDeck { get; set; }

        public int UserId { get; set; }

        public bool ForReview { get; set; }

        [Display(Name = "Deck Description")]
        [Required(ErrorMessage = "Please enter a description for the deck")]
        public string Description { get; set; }

        public List<Card> Cards { get; set; }

        public bool isAdminDeck { get; set; }

        public string DeckColor { get; set; }

        public string TextColor { get; set; }
    }
}
