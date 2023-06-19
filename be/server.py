import uvicorn
import logging
import json

from fastapi import FastAPI, Request
from datetime import datetime

app = FastAPI()

@app.post("/")
async def root(request: Request):
    logging.info("Received a POST request on root route!")

    async with request.form() as form:
        contents = await form["reports"].read()
        contents = contents.decode("utf-8")

        with open(f"{fileprefix()}{timestamp()}.txt", "w") as f:
            f.write(contents)

        _deserialized = json.loads(contents)

        with open(f"{fileprefix()}{timestamp()}.json", "w") as f:
            json.dump(_deserialized, f, indent=4)

    return {"status": "ok"}

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    uvicorn.run("server:app", host="0.0.0.0", port=8001, reload=True)

def fileprefix() -> str:
    return "kscrash-"

def timestamp() -> str:
    return datetime.now().isoformat()