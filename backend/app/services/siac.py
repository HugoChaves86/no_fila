import aiohttp
from models.siac import SiacAuth, SiacProofOfRegistration, SiacSubject, SiacLesson, SiacGroup
from io import StringIO
from http.cookies import SimpleCookie
import pandas as pd
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_400_BAD_REQUEST


async def auth_cookies(cpf: str, senha: str) -> SimpleCookie:
    login_url = "https://siac.ufba.br/SiacWWW/LogonSubmit.do"
    data = {"cpf": cpf, "senha": senha}
    headers = {"Content-Type": "application/x-www-form-urlencoded"}

    async with aiohttp.ClientSession() as session:
        async with session.post(login_url, data=data, headers=headers) as response:
            response_text = await response.text()
            
            if "O CPF informado não é válido." in response_text:
                raise HTTPException(
                    status_code=HTTP_400_BAD_REQUEST, 
                    detail="Invalid CPF."
                )
            if "For input string: " in response_text:
                raise HTTPException(
                    status_code=HTTP_400_BAD_REQUEST, 
                    detail="Invalid CPF."
                )
            if "A senha informada para o usuário de CPF" in response_text:
                raise HTTPException(
                    status_code=HTTP_400_BAD_REQUEST, 
                    detail="Invalid Password."
                )
            return response.cookies

def parse_proof_of_registration(html: StringIO) -> SiacProofOfRegistration:
    dfs = pd.read_html(html)
    df = dfs[6]
    df.columns = [  # type: ignore
        "subject_code",
        "subject",
        "workload",
        "group_code",
        "group",
        "day_of_week",
        "schedule",
        "location",
        "teacher",
    ]
    df = df[:-1]
    df = df.ffill()
    df = df.astype(
        {
            "subject_code": "string",
            "subject": "string",
            "workload": "int32",
            "group_code": "int32",
            "group": "string",
            "day_of_week": "string",
            "schedule": "string",
            "location": "string",
            "teacher": "string",
        }
    ).astype({"group_code": "string"})

    df["group_code"] = df["group_code"].str.zfill(6)

    subjects = []
    for subject_code in df.subject_code.unique():
        subject = (
            df.where(df.subject_code == subject_code).dropna().to_dict(orient="records")
        )
        subjects.append(
            SiacSubject(
                code=subject_code,
                name=subject[0]["subject"],
                workload=subject[0]["workload"],
                group=SiacGroup(code=subject[0]["group_code"], number=subject[0]["group"]),
                lessons=[
                    SiacLesson(
                        day_of_week=subject[lesson]["day_of_week"],
                        start=subject[lesson]["schedule"].split("/")[0]
                        if subject[lesson]["schedule"] != "A Combinar"
                        else "A Combinar",
                        end=subject[lesson]["schedule"].split("/")[1]
                        if subject[lesson]["schedule"] != "A Combinar"
                        else "A Combinar",
                        location=subject[lesson]["location"],
                        teacher=subject[lesson]["teacher"],
                    )
                    for lesson in range(len(subject))
                ],
            )
        )

    registration = dfs[4][0][1].split("\xa0")[1]
    current_semester = dfs[4][1][2].split("\xa0")[1]
    course = dfs[4][0][2].split("\xa0")[1]
    score = float(dfs[4][2][2].split("\xa0")[1])
    student = dfs[4][1][1].split("\xa0")[1]

    return SiacProofOfRegistration(
        course=course,
        registration=registration,
        score=score,
        student=student,
        subjects=subjects,
        current_semester=current_semester,
    )

async def proof_of_registration(siac_auth: SiacAuth) -> SiacProofOfRegistration:
    cookies = await auth_cookies(siac_auth.cpf, siac_auth.senha)
    comprovante_url = "https://siac.ufba.br/SiacWWW/ConsultarComprovanteMatricula.do"

    async with aiohttp.ClientSession(cookies=cookies) as session:
        async with session.get(comprovante_url) as response:
            return parse_proof_of_registration(StringIO(await response.text()))
