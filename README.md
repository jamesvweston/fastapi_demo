# fastapi demo

- This project was generated using fastapi_template. It serves as a proof of concept and a demo of what the Olea services architecture could use.
- It was created using this templating tool: https://github.com/s3rius/FastAPI-template
- Openapi docs, graphql, sqlalchemy, redis, postgres, and even DB migrations are supported

## Poetry

This project uses poetry. It's a modern dependency management
tool.

You can read more about poetry here: https://python-poetry.org/

## OpenApi
- You can find swagger documentation at `/asdf/web/api/docs`.
- While running the local server view them at http://0.0.0.0:8000/api/docs
## Docker
-   Make sure you copy .env.example to .env
-   You can start the project with docker using this command:

```bash
make docker-build
make docker-run
```
