﻿using Capstone.Models;
using Capstone.Models.DALs;
using Capstone.Models.View_Models;
using Capstone.Providers.Auth;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;

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
            return View();
        }

        public IActionResult CommunityDecks()
        {
            return View();
        }

        [HttpGet]
        public IActionResult CreateDeck()
        {
            if (authProvider.IsLoggedIn)
            {
            Deck deck = new Deck() {
                DeckColor = "#ecf0f1",
                TextColor = "#000000"
            };
            deck.UserId = authProvider.GetCurrentUser().Id;
            return View(deck);
            }
            else
            {
                return RedirectToAction("login", "account");
            }
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
            if (authProvider.GetCurrentUser() == null)
            {
                if (IsDeckPublic(deckId))
                {
                    return View("AnonViewDeck", deck);
                }
                else
                {
                    return NotFound();
                }
                
            }
            int userId = authProvider.GetCurrentUser().Id;
            if (IsCurrentUserTheOwner(deckId))
            {
                return View(deck);
            }
            else if (IsDeckPublic(deckId))
            {
                OtherUsersDeckViewModel oudvm = new OtherUsersDeckViewModel()
                {
                    Deck = deck
                };
                oudvm.DeckOwnerName = decksSqlDAL.GetUserNameFromDeckId(deck.Id);
                oudvm.UserDecksSelectList = decksSqlDAL.GetUserDecksSelectList(userId);
                return View("NotOwnersDeck", oudvm);

            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet]
        public IActionResult AddCard(int deckID)
        {
            if (authProvider.IsLoggedIn && IsCurrentUserTheOwner(deckID))
            {
                Card card = new Card();
                card.DeckId = deckID;
                card.CardOrder = decksSqlDAL.GetNextCardOrder(deckID);
                return View(card);
            }
            else
            {
                return NotFound();
            }
            
        }

        [HttpPost]
        public IActionResult AddCard(Card newCard)
        {
            if (authProvider.IsLoggedIn && IsCurrentUserTheOwner(newCard.DeckId))
            {
                if (String.IsNullOrEmpty(newCard.Front) && !String.IsNullOrEmpty(newCard.ImageURL))
                {
                    newCard.Front = "";
                }
                cardSqlDAL.AddCardToDeck(newCard);
                return RedirectToAction("ViewDeck", new { deckId = newCard.DeckId });
            }
            else
            {
                return NotFound();
            }
            
        }

        public IActionResult AddCardFromSearch(SearchViewModel svm)
        {
            Card cardToAdd = cardSqlDAL.GetCardById(svm.Card.Id);
            cardToAdd.DeckId = svm.Card.DeckId;
            cardToAdd.CardOrder = decksSqlDAL.GetNextCardOrder(cardToAdd.DeckId);
            cardToAdd = cardSqlDAL.AddCardToDeck(cardToAdd);
            return RedirectToAction("ViewDeck", new { deckId = cardToAdd.DeckId });
        }


        public IActionResult AddCardFromOtherUsersDeck(OtherUsersDeckViewModel oudvm)
        {
            if (authProvider.IsLoggedIn)
            {
                Card cardToAdd = cardSqlDAL.GetCardById(oudvm.Card.Id);
                cardToAdd.DeckId = oudvm.Card.DeckId;
                cardToAdd.CardOrder = decksSqlDAL.GetNextCardOrder(cardToAdd.DeckId);
                cardToAdd = cardSqlDAL.AddCardToDeck(cardToAdd);
                return RedirectToAction("ViewDeck", new { deckId = cardToAdd.DeckId });
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet]
        public IActionResult UpdateCard(int cardId)
        {
            Card card = cardSqlDAL.GetCardById(cardId);
            return View(card);
        }

        [HttpPost]
        public IActionResult UpdateCard(Card updatedCard)
        {
            Card card = cardSqlDAL.GetCardById(updatedCard.Id);

            // Check if new Card Order is within range of valid options
            if (updatedCard.CardOrder > cardSqlDAL.GetCardsByDeckId(updatedCard.DeckId).Count || updatedCard.CardOrder < 1)
            {
                return View("Error");
            }

            if (cardSqlDAL.UpdateCard(updatedCard) == null)
            {
                if (updatedCard.Front == card.Front
                    && updatedCard.Back == card.Back
                    && updatedCard.ImageURL == card.ImageURL
                    && updatedCard.CardOrder == card.CardOrder)
                {
                    return RedirectToAction("ViewDeck", new { deckId = updatedCard.DeckId });
                }
                else
                {
                    return View("Error");
                }
            }
            else
            {
                return RedirectToAction("ViewDeck", new { deckId = updatedCard.DeckId });
            }
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
            TagViewModel tag = new TagViewModel();
            Card card = cardSqlDAL.GetCardById(cardId);
            tag.CardId = cardId;
            tag.DeckId = card.DeckId;
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
            int userId = authProvider.GetCurrentUser().Id;

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

            results.UserDecksSelectList = decksSqlDAL.GetUserDecksSelectList(userId);

            return View("SearchResults", results);
        }

        public bool IsCurrentUserTheOwner(int deckId)
        {
            Users currentUser = authProvider.GetCurrentUser();
            if (currentUser == null)
            {
                return false;
            }
            int userId = currentUser.Id;
            Deck deck = decksSqlDAL.GetDeckById(deckId);
            if (userId != deck.UserId)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public bool IsDeckPublic(int deckId)
        {
            Deck deck = decksSqlDAL.GetDeckById(deckId);
            return deck.PublicDeck ? true : false;
        }
    }
}