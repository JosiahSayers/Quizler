﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Capstone.Models;
using Capstone.Models.DALs;
using Capstone.Models.View_Models;
using Capstone.Providers.Auth;

namespace Capstone.Controllers
{
    public class DecksController : Controller
    {
        private IDeckDAL decksSqlDAL;
        private ICardDAL cardSqlDAL;
        private ITagDAL tagSqlDAL;
        private IUsersDAL userSqlDAL;
        private IAuthProvider authProvider;

        public DecksController(IDeckDAL decksSqlDAL, ICardDAL cardSqlDAL, ITagDAL tagSqlDAL, IUsersDAL userSqlDAL, IAuthProvider authProvider)
        {
            this.decksSqlDAL = decksSqlDAL;
            this.cardSqlDAL = cardSqlDAL;
            this.tagSqlDAL = tagSqlDAL;
            this.userSqlDAL = userSqlDAL;
            this.authProvider = authProvider;
        }

        public IActionResult MyDecks(int userId)
        {

            Users currentUser = authProvider.GetCurrentUser();
            if (currentUser == null)
            {
                return RedirectToAction("login", "account");
            }
            userId = currentUser.Id;
            //List<Deck> decks = decksSqlDAL.GetDecksbyUserId(userId);
            return View();
        }

        [HttpGet]
        public IActionResult CreateDeck()
        {
            Deck deck = new Deck();
            deck.UserId = authProvider.GetCurrentUser().Id;
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

        [HttpGet]
        public IActionResult AddCard(int deckID)
        {
            Card card = new Card();
            card.DeckId = deckID;
            card.CardOrder = decksSqlDAL.GetNextCardOrder(deckID);
            return View(card);
        }

        [HttpPost]
        public IActionResult AddCard(Card newCard)
        {
            cardSqlDAL.AddCardToDeck(newCard);
            return RedirectToAction("ViewDeck", new { deckId = newCard.DeckId });
        }

        public IActionResult AddCardFromSearch(SearchViewModel svm)
        {
            Card cardToAdd = cardSqlDAL.GetCardById(svm.Card.Id);
            cardToAdd.DeckId = svm.Card.DeckId;
            cardToAdd = cardSqlDAL.AddCardToDeck(cardToAdd);
            return RedirectToAction("ViewDeck", new { deckId = cardToAdd.DeckId });
        }

        [HttpPost]
        public IActionResult UpdateCard(Card updatedCard)
        {
            if (cardSqlDAL.UpdateCard(updatedCard) == null)
            {
                return View("Error");
            }
            else
            {
                return RedirectToAction("ViewDeck", new { deckId = updatedCard.DeckId });
            }
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
        public IActionResult DeleteCard(int cardId, int DeckId)
        {
            //todo: when deleting card, also delete tags. 
            bool result = cardSqlDAL.DeleteCard(cardId);

            if (result)
            {
                return RedirectToAction("ViewDeck", new { deckId = DeckId });
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
            if (decksSqlDAL.UpdateDeck(updatedDeck) == null)
            {
                return View("Error");
            }
            else
            {
                return RedirectToAction("ViewDeck", new { deckId = updatedDeck.Id });
            }
        }

        [HttpGet]
        public IActionResult DeleteDeck(int deckId)
        {
            Deck deck = decksSqlDAL.GetDeckById(deckId);
            return View(deck);
        }

        [HttpPost]
        public IActionResult DeleteDeck(int deckId, int routedUserId) //todo userId
        {
            if (decksSqlDAL.DeleteDeck(deckId) == false)
            {
                return View("Error");
            }
            else
            {
                return RedirectToAction("MyDecks", new { userId = routedUserId });
            }
        }

        [HttpGet]
        public IActionResult AddTag(int cardId)
        {
            Tag tag = new Tag();
            tag.CardId = cardId;
            return View(tag);
        }

        [HttpPost]
        public IActionResult AddTag(Tag newTag)
        {
            newTag = tagSqlDAL.AddTag(newTag);
            Card card = cardSqlDAL.GetCardById(newTag.CardId);
            return RedirectToAction("ViewDeck", new { deckId = card.DeckId });
        }

        [HttpGet]
        public IActionResult Search(string query)
        {
            SearchViewModel results = new SearchViewModel();
            results.Card = new Card();
            string[] tags = query.Split(' ', ',', '+');

            foreach (string tag in tags)
            {
                results.SearchTerms.Add(new Tag() { Name = tag.ToLower() });
            }

            HashSet<int> uniqueCardIds = new HashSet<int>();

            foreach (Tag tag in results.SearchTerms)
            {
                uniqueCardIds = cardSqlDAL.SearchForCard(tag);
            }

            foreach (int id in uniqueCardIds)
            {
                results.SearchResults.Add(cardSqlDAL.GetCardById(id));
            }

            results.UserDecksSelectList = decksSqlDAL.GetUserDecksSelectList(1); //TODO: Fix so it pulls actual userID

            return View("SearchResults", results);
        }
    }
}