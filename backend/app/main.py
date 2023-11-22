from fastapi import FastAPI
from models.siac import SiacAuth, SiacProofOfRegistration
from services.siac import proof_of_registration
from starlette.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
)


@app.post("/siac_proof_of_registration", tags=["Siac"])
async def siac_proof_of_registration(
    siac_auth: SiacAuth,
) -> SiacProofOfRegistration:
    return await proof_of_registration(siac_auth=siac_auth)
