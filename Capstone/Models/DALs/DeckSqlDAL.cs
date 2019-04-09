﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models.DALs
{
    public class DeckSqlDAL : IDeckDAL
    {
        private string connectionString;
        private ICardDAL cardSqlDAL;

        private const string sql_CreateDeck = @"insert into decks (name, users_id, description) values (@name, @user, @description); SELECT CAST(SCOPE_IDENTITY() as int);";
        private const string sql_GetDeckById = @"SELECT * FROM decks WHERE id = @id";
        //private const string sql_GetRandomDeck = "";
        private const string sql_GetDecksbyUserId = @"SELECT * FROM decks WHERE users_id = @userId";
        private const string sql_UpdateDeck = @"UPDATE decks SET name = @name, description = @description WHERE id = @id";


        public DeckSqlDAL(string connectionString)
        {
            this.connectionString = connectionString;
            cardSqlDAL = new CardSqlDAL(connectionString);
        }

        //bool CreateDeck();
        public int CreateDeck(Deck newDeck)
        {
            int result = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql_CreateDeck, conn);

                    cmd.Parameters.AddWithValue("@name", newDeck.Name);
                    cmd.Parameters.AddWithValue("@user", newDeck.UserId);
                    cmd.Parameters.AddWithValue("@description", newDeck.Description);

                    newDeck.Id = (int)cmd.ExecuteScalar();

                    if (newDeck.Id > 0)
                    {
                        result = newDeck.Id;
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return result;
        }

        //Deck GetDeckById();
        public Deck GetDeckById(int deckId)
        {
            Deck result = new Deck();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql_GetDeckById, conn);
                    cmd.Parameters.AddWithValue("@id", deckId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Deck deck = new Deck
                        {
                            Id = Convert.ToInt32(reader["id"]),
                            Name = Convert.ToString(reader["name"]),
                            DateCreated = Convert.ToDateTime(reader["date_created"]),
                            PublicDeck = Convert.ToBoolean(reader["is_public"]),
                            UserId = Convert.ToInt32(reader["users_id"]),
                            ForReview = Convert.ToBoolean(reader["for_review"]),
                            Description = Convert.ToString(reader["description"])                            
                        };

                        result = deck;
                    }
                }
                result.Cards = cardSqlDAL.GetCardsByDeckId(result.Id);
            }
            catch (SqlException ex)
            {
                //Deck deck = new Deck();
            }
            return result;
        }

        //List<Deck> GetDecksbyUserId();
        public List<Deck> GetDecksbyUserId(int userId)
        {
            List<Deck> result = new List<Deck>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql_GetDecksbyUserId, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Deck deck = new Deck
                        {
                            Id = Convert.ToInt32(reader["id"]),
                            Name = Convert.ToString(reader["name"]),
                            DateCreated = Convert.ToDateTime(reader["date_created"]),
                            PublicDeck = Convert.ToBoolean(reader["is_public"]),
                            UserId = Convert.ToInt32(reader["users_id"]),
                            ForReview = Convert.ToBoolean(reader["for_review"]),
                            Description = Convert.ToString(reader["description"])
                        };

                        result.Add(deck);
                    }
                }
            }
            catch (SqlException ex)
            {
                List<Deck> deck = new List<Deck>();
            }
            return result;
        }

        //Modify an existing deck
        public Deck UpdateDeck(Deck updatedDeck)
        {
            Deck output;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql_UpdateDeck, conn);
                    cmd.Parameters.AddWithValue("@id", updatedDeck.Id);
                    cmd.Parameters.AddWithValue("@name", updatedDeck.Name);
                    cmd.Parameters.AddWithValue("@description", updatedDeck.Description);

                    int numRowsChanged = cmd.ExecuteNonQuery();
                    if (numRowsChanged > 0)
                    {
                        output = updatedDeck;
                    }
                    else
                    {
                        output = new Deck();
                    }
                }
            }
            catch (Exception e)
            {
                throw;
            }
            return output;
        }

        //Deck GetRandomDeck();
    }
}
