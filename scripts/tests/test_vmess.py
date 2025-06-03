import base64
import json

link = "vmess://ewogICJ2IjogIjIiLAogICJwcyI6ICJjdXlzd3R4eCIsCiAgImFkZCI6ICJibHVlaHViMS52YXJ6ZXNobmV3czI0Lm9ubGluZSIsCiAgInBvcnQiOiA4MDgwLAogICJpZCI6ICI1ZWNlN2VhOS1lM2E2LTRjNDYtOTkxZS02MzlhZTU3MGNjYjkiLAogICJzY3kiOiAiYXV0byIsCiAgIm5ldCI6ICJ0Y3AiLAogICJ0eXBlIjogIm5vbmUiLAogICJ0bHMiOiAibm9uZSIKfQ=="

decoded = base64.urlsafe_b64decode(link.replace("vmess://", "")).decode()
print(json.dumps(json.loads(decoded), indent=2))
