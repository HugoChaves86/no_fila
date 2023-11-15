from fastapi import FastAPI
from services.siac import proof_of_registration
from models.siac import SiacAuth, SiacProofOfRegistration

app = FastAPI()


@app.post("/siac_proof_of_registration", tags=["Siac"])
async def siac_proof_of_registration(siac_auth: SiacAuth) -> SiacProofOfRegistration:
    return await proof_of_registration(siac_auth=siac_auth)
