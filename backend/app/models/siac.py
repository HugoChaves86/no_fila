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


class SiacSubject(BaseModel):
    subject_code: str
    subject: str
    workload: int
    class_code: str
    class_number: str
    lessons: list[SiacLesson]


class SiacProofOfRegistration(BaseModel):
    subjects: list[SiacSubject]
    registration: str
    current_semester: str
    course: str
    score: float
