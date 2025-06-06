"""Utilities for cleaning chat data for ML."""
import pandas as pd

def clean_dataframe(df: pd.DataFrame) -> pd.DataFrame:
    df = df.dropna(subset=['message'])
    df['message'] = df['message'].str.lower()
    return df
