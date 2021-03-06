﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;
using Capstone.Models.DALs;
using Capstone.Models.View_Models;
using Capstone.Models.View_Models.API;
using Capstone.Providers.Auth;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class APIController : ControllerBase
    {
        private IDeckDAL decksSqlDAL;
        private ICardDAL cardSqlDAL;
        private ITagDAL tagSqlDAL;
        private IUsersDAL userSqlDAL;
        private IAuthProvider authProvider;

        public APIController(IDeckDAL decksSqlDAL, ICardDAL cardSqlDAL, ITagDAL tagSqlDAL, IUsersDAL userSqlDAL, IAuthProvider authProvider)
        {
            this.decksSqlDAL = decksSqlDAL;
            this.cardSqlDAL = cardSqlDAL;
            this.tagSqlDAL = tagSqlDAL;
            this.userSqlDAL = userSqlDAL;
            this.authProvider = authProvider;
        }

        // GET: API/Search
        [HttpGet]
        public SearchViewModel Search(string query)
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

            results.UserDecksSelectList = decksSqlDAL.GetUserDecksSelectList(authProvider.GetCurrentUser().Id);

            return results;
        }
        

        public List<Deck> GetUserDecks() //todo userId
        {
            Users currentUser = authProvider.GetCurrentUser();
            List<Deck> decks = decksSqlDAL.GetDecksbyUserId(currentUser.Id);
            return decks;
        }

        public List<Deck> LazyLoadDecks(int startId)
        {
            Users currentUser = authProvider.GetCurrentUser();
            List<Deck> decks = decksSqlDAL.LazyLoadDecks(currentUser.Id, startId);
            return decks;
        }

        public List<Deck> LazyLoadPublicDecks(int startId)
        {
            Users currentUser = authProvider.GetCurrentUser();
            List<Deck> decks = decksSqlDAL.LazyLoadPublicDecks(startId);
            return decks;
        }

        public List<Deck> LazyLoadPublicAdminDecks(int startId)
        {
            List<Deck> decks = decksSqlDAL.GetPublicAdminDecks(startId);
            return decks;
        }

        // GET: API/GetDeck?Id=
        public Deck GetDeck(int Id)
        {
            Deck deck = decksSqlDAL.GetDeckById(Id);
            return deck;
        }

        // POST: API/CreateDeck
        [HttpPost]
        public void CreateDeck(Deck newDeck)
        {
            int deckId = decksSqlDAL.CreateDeck(newDeck);
            if (deckId != 0)
            {
                newDeck.Cards = new List<Card>();
            }
        }

        [HttpPost]
        public IActionResult ToggleForReferral(int deckId)
        {
            int userId = authProvider.GetCurrentUser().Id;
            Deck deckToToggle = decksSqlDAL.GetDeckById(deckId);
            if (deckToToggle.UserId == userId || authProvider.IsAdmin())
            {
                bool value = deckToToggle.ForReview == true ? false : true;
                decksSqlDAL.SetDeckForReferral(deckId, value);
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost]
        public IActionResult MakePrivate(int deckId)
        {
            int userId = authProvider.GetCurrentUser().Id;
            Deck deckToToggle = decksSqlDAL.GetDeckById(deckId);
            if (deckToToggle.UserId == userId || authProvider.IsAdmin())
            {
                decksSqlDAL.MakePrivate(deckId);
                if (deckToToggle.ForReview)
                {
                    decksSqlDAL.SetDeckForReferral(deckId, false);
                }
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost]
        public IActionResult MakePublic(int deckId)
        {
            int userId = authProvider.GetCurrentUser().Id;
            Deck deckToToggle = decksSqlDAL.GetDeckById(deckId);
            if (deckToToggle.UserId == userId || authProvider.IsAdmin())
            {
                decksSqlDAL.MakePublic(deckId);
                bool value = deckToToggle.ForReview == true ? false : true;
                decksSqlDAL.SetDeckForReferral(deckId, value);
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost]
        public void AddTags(TagAPIViewModel newTags)
        {
            tagSqlDAL.AddTagList(newTags.Tags);
        }

        [HttpPost]
        public void AddCardsToDeck(List<Card> cards)
        {
            cardSqlDAL.AddCardListToDeck(cards);
        }
    }
}