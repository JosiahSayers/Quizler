﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models.DALs
{
    public class CardSqlDAL : ICardDAL
    {
        public string ConnectionString { get; }
        private const string SQL_AddCardToDeck = "INSERT INTO cards (front, back, img, card_order, deck_id) VALUES (@front, @back, @img, @card_order, @deck_id); SELECT CAST(SCOPE_IDENTITY() AS INT);";
        private const string sql_GetCardsByDeckId = @"Select * FROM cards WHERE deck_id = @deckId ORDER BY card_order;";
        private const string SQL_UpdateCard = "UPDATE cards SET front = @front, back = @back, img = @img, card_order = @order WHERE id = @id;";
        private const string SQL_GetCardById = "SELECT * FROM cards WHERE id = @id;";
        private const string SQL_DeleteCard = "DELETE FROM cards WHERE id = @id";

        public CardSqlDAL(string connectionString)
        {
            ConnectionString = connectionString;
        }

        public Card AddCardToDeck(Card card)
        {
            Card output = card;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(SQL_AddCardToDeck, conn);
                cmd.Parameters.AddWithValue("@front", card.Front);
                cmd.Parameters.AddWithValue("@back", card.Back);
                cmd.Parameters.AddWithValue("@img", card.ImageURL);
                cmd.Parameters.AddWithValue("@card_order", card.CardOrder);
                cmd.Parameters.AddWithValue("@deck_id", card.DeckId);

                try
                {
                    card.Id = (int)cmd.ExecuteScalar();
                }
                catch (Exception e)
                {
                    output = new Card();
                }
            }
            return output;
        }

        public List<Card> GetCardsByDeckId(int deckId)
        {
            List<Card> result = new List<Card>();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql_GetCardsByDeckId, conn);
                    cmd.Parameters.AddWithValue("@deckId", deckId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Card card = new Card
                        {
                            Id = Convert.ToInt32(reader["id"]),
                            Front = Convert.ToString(reader["front"]),
                            Back = Convert.ToString(reader["back"]),
                            ImageURL = Convert.ToString(reader["img"]),
                            DeckId = Convert.ToInt32(reader["deck_id"]),
                            CardOrder = Convert.ToInt32(reader["card_order"])
                        };

                        result.Add(card);
                    }
                }
            }
            catch (SqlException ex)
            {
                result = new List<Card>();
            }

            return result;

        }

        public Card UpdateCard(Card updatedCard)
        {
            Card output;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand(SQL_UpdateCard, conn);
                    cmd.Parameters.AddWithValue("@front", updatedCard.Front);
                    cmd.Parameters.AddWithValue("@back", updatedCard.Back);
                    cmd.Parameters.AddWithValue("@img", updatedCard.ImageURL);
                    cmd.Parameters.AddWithValue("@id", updatedCard.Id);
                    cmd.Parameters.AddWithValue("@order", updatedCard.CardOrder);

                    int numRowsChanged = cmd.ExecuteNonQuery();
                    if (numRowsChanged > 0)
                    {
                        output = updatedCard;
                    }
                    else
                    {
                        output = null;
                    }
                }
                catch
                {
                    output = null;
                }
            }

            return output;
        }

        public bool DeleteCard(int cardId)
        {
            bool output = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_DeleteCard, conn);
                    cmd.Parameters.AddWithValue("@id", cardId);

                    int numRowsChanged = cmd.ExecuteNonQuery();
                    if (numRowsChanged > 0)
                    {
                        output = true;
                    }
                    else
                    {
                        output = false;
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }

            return output;
        }

        public Card GetCardById(int cardId)
        {
            Card output = new Card();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GetCardById, conn);
                    cmd.Parameters.AddWithValue("@id", cardId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        output.Id = Convert.ToInt32(reader["id"]);
                        output.Front = Convert.ToString(reader["front"]);
                        output.Back = Convert.ToString(reader["back"]);
                        output.ImageURL = Convert.ToString(reader["img"]);
                        output.DeckId = Convert.ToInt32(reader["deck_id"]);
                        output.CardOrder = Convert.ToInt32(reader["card_order"]);
                    }
                }
            }
            catch
            {
                output = new Card();
            }
            return output;
        }
    }
}
