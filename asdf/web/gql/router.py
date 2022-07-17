import strawberry
from strawberry.fastapi import GraphQLRouter

from asdf.web.gql.context import get_context
from asdf.web.gql import echo
from asdf.web.gql import dummy
from asdf.web.gql import redis

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
