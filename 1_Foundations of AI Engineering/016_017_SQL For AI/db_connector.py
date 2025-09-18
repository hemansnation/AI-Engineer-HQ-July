import pandas as pd
from sqlalchemy import create_engine
import os

DB_USER = "him"
DB_PASSWORD = ""
DB_NAME = "ai_store"
DB_HOST = "localhost"
DB_PORT = "5432"

engine = create_engine(f"postgresql://{DB_USER}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

query = """
SELECT p.product_name, p.category, r.rating, u.username
FROM reviews AS r
JOIN products AS p ON r.product_id = p.product_id
JOIN users AS u ON r.user_id = u.user_id;
"""

print("Executing SQL query to fetch AI training data")

training_df = pd.read_sql(query, engine)

print("\n Successfully loaded data into a pandas dataframe")

print(training_df)

print("\n Dataframe Info:")
training_df.info()

