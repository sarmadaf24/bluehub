"""Train ticket predictor model."""
import joblib
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.ensemble import RandomForestClassifier
import pandas as pd
from .data_cleaning import clean_dataframe

MODEL_PATH = 'ticket_predictor.pkl'

def train(path: str):
    df = pd.read_csv(path)
    df = clean_dataframe(df)
    pipeline = Pipeline([
        ('tfidf', TfidfVectorizer()),
        ('rf', RandomForestClassifier()),
    ])
    pipeline.fit(df['message'], df['label'])
    joblib.dump(pipeline, MODEL_PATH)
