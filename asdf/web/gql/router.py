import strawberry
from strawberry.fastapi import GraphQLRouter

from asdf.web.gql import dummy, echo, redis
from asdf.web.gql.context import get_context


@strawberry.type
class Query(
    echo.Query,
    dummy.Query,
    redis.Query,
):
    """Main query."""


@strawberry.type
class Mutation(
    echo.Mutation,
    dummy.Mutation,
    redis.Mutation,
):
    """Main mutation."""


schema = strawberry.Schema(
    Query,
    Mutation,
)

gql_router = GraphQLRouter(
    schema,
    graphiql=True,
    context_getter=get_context,
)
