﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Capstone.Models;
using Capstone.Models.DALs;

namespace Capstone.Controllers
{
    public class DecksController : Controller
    {
        private IDeckDAL decksSqlDAL;
        private ICardDAL cardSqlDAL;

        public DecksController(IDeckDAL decksSqlDAL, ICardDAL cardSqlDAL)
        {
            this.decksSqlDAL = decksSqlDAL;
            this.cardSqlDAL = cardSqlDAL;
        }

        public IActionResult Index(int userId = 1)
        {
            List<Deck> decks = decksSqlDAL.GetDecksbyUserId(userId);
            return View(decks);
        }

        [HttpGet]
        public IActionResult CreateDeck()
        {
            Deck deck = new Deck();
            return View(deck);
        }

        [HttpPost]
        public IActionResult CreateDeck(Deck newDeck)
        {
            int deckId = decksSqlDAL.CreateDeck(newDeck);
            if (deckId != 0)
            {
                newDeck.Cards = new List<Card>();
                return RedirectToAction("ViewDeck", new { deckId = newDeck.Id });
            }
            else
            {
                return NotFound();
            }
        }

        public IActionResult ViewDeck(int deckId)
        {
            Deck deck = decksSqlDAL.GetDeckById(deckId);
            return View(deck);
        }

        [HttpPost]
        public IActionResult AddCard(Card newCard)
        {
            cardSqlDAL.AddCardToDeck(newCard);
            return RedirectToAction("ViewDeck", new { deckId = newCard.DeckId });
        }

        [HttpGet]
        public IActionResult AddCard(int deckID)
        {
            Card card = new Card();
            card.DeckId = deckID;
            return View(card);
        }

        [HttpPost]
        public IActionResult UpdateCard(Card updatedCard)
        {
            cardSqlDAL.UpdateCard(updatedCard);
            return RedirectToAction("ViewDeck", new { deckId = updatedCard.DeckId });
        }

        [HttpGet]
        public IActionResult UpdateCard(int cardId)
        {
            Card card = cardSqlDAL.GetCardById(cardId);
            return View(card);
        }


        [HttpGet]
        public IActionResult DeleteCard(int cardId)
        {
            Card card = cardSqlDAL.GetCardById(cardId);
            return View(card);
        }

        [HttpPost]
        public IActionResult DeleteCard(int cardId, int DeckId )
        {
            bool result = cardSqlDAL.DeleteCard(cardId);

            if (result)
            {
                return RedirectToAction("ViewDeck", new { deckId = DeckId});
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet]
        public IActionResult EditDeck(int deckId)
        {
            Deck deck = decksSqlDAL.GetDeckById(deckId);
            return View(deck);
        }

        [HttpPost]
        public IActionResult EditDeck(Deck updatedDeck)
        {
            decksSqlDAL.UpdateDeck(updatedDeck);
            return RedirectToAction("ViewDeck", new { deckId = updatedDeck.Id });
        }
    }
}