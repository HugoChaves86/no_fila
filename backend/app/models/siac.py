from pydantic import BaseModel


class SiacAuth(BaseModel):
    cpf: str
    senha: str


class SiacLesson(BaseModel):
    day_of_week: str
    start: str
    end: str
    location: str
    teacher: str

class SiacGroup(BaseModel):
    code: str
    number: str

class SiacSubject(BaseModel):
    code: str
    name: str
    workload: int
    group: SiacGroup
    lessons: list[SiacLesson]

class SiacProofOfRegistration(BaseModel):
    subjects: list[SiacSubject]
    registration: str
    current_semester: str
    course: str
    score: float
    student: str
