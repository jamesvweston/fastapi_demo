create table if not exists addresses
(
    id         bigint
    primary key,
    name       varchar(255) not null,
    street1    varchar(255) not null,
    street2    varchar(255) null,
    city       varchar(255) not null,
    state      varchar(255) not null,
    zip        varchar(255) not null,
    country    varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null
    );

create table if not exists addressables
(
    address_id       bigint    not null,
    addressable_id   bigint    not null,
    addressable_type smallint  not null,
    is_default       bool        not null,
    constraint addressables_address_id_foreign
    foreign key (address_id) references addresses (id)
    );

create table if not exists failed_jobs
(
    id         bigint
    primary key,
    uuid       varchar(255)                          not null,
    connection text                                  not null,
    queue      text                                  not null,
    payload    text                              not null,
    exception  text                              not null,
    failed_at  timestamp  not null,
    constraint failed_jobs_uuid_unique
    unique (uuid)
    );

create table if not exists migrations
(
    id        int
    primary key,
    migration varchar(255) not null,
    batch     int          not null
    );

create table if not exists password_resets
(
    email      varchar(255) not null,
    token      varchar(255) not null,
    created_at timestamp    null
    );

create index if not exists password_resets_email_index
    on password_resets (email);

create table if not exists permissions
(
    id         bigint
    primary key,
    name       varchar(255) not null,
    guard_name varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null,
    constraint permissions_name_guard_name_unique
    unique (name, guard_name)
    );

create table if not exists model_has_permissions
(
    permission_id bigint    not null,
    model_type    smallint  not null,
    model_id      bigint    not null,
    primary key (permission_id, model_id, model_type),
    constraint model_has_permissions_permission_id_foreign
    foreign key (permission_id) references permissions (id)
    on delete cascade
    );

create index if not exists model_has_permissions_model_id_model_type_index
    on model_has_permissions (model_id, model_type);

create table if not exists personal_access_tokens
(
    id             bigint
    primary key,
    tokenable_type varchar(255)    not null,
    tokenable_id   bigint  not null,
    name           varchar(255)    not null,
    token          varchar(64)     not null,
    abilities      text            null,
    last_used_at   timestamp       null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    constraint personal_access_tokens_token_unique
    unique (token)
    );

create index if not exists personal_access_tokens_tokenable_type_tokenable_id_index
    on personal_access_tokens (tokenable_type, tokenable_id);

create table if not exists roles
(
    id         bigint
    primary key,
    name       varchar(255) not null,
    guard_name varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null,
    constraint roles_name_guard_name_unique
    unique (name, guard_name)
    );

create table if not exists model_has_roles
(
    role_id    bigint    not null,
    model_type smallint  not null,
    model_id   bigint    not null,
    primary key (role_id, model_id, model_type),
    constraint model_has_roles_role_id_foreign
    foreign key (role_id) references roles (id)
    on delete cascade
    );

create index if not exists model_has_roles_model_id_model_type_index
    on model_has_roles (model_id, model_type);

create table if not exists role_has_permissions
(
    permission_id bigint  not null,
    role_id       bigint  not null,
    primary key (permission_id, role_id),
    constraint role_has_permissions_permission_id_foreign
    foreign key (permission_id) references permissions (id)
    on delete cascade,
    constraint role_has_permissions_role_id_foreign
    foreign key (role_id) references roles (id)
    on delete cascade
    );

create table if not exists telescope_entries
(
    sequence                bigint
    primary key,
    uuid                    char(36)             not null,
    batch_id                char(36)             not null,
    family_hash             varchar(255)         null,
    should_display_on_index bool default 1 not null,
    type                    varchar(20)          not null,
    content                 text             not null,
    created_at              timestamp             null,
    constraint telescope_entries_uuid_unique
    unique (uuid)
    );

create index if not exists telescope_entries_batch_id_index
    on telescope_entries (batch_id);

create index if not exists telescope_entries_created_at_index
    on telescope_entries (created_at);

create index if not exists telescope_entries_family_hash_index
    on telescope_entries (family_hash);

create index if not exists telescope_entries_type_should_display_on_index_index
    on telescope_entries (type, should_display_on_index);

create table if not exists telescope_entries_tags
(
    entry_uuid char(36)     not null,
    tag        varchar(255) not null,
    constraint telescope_entries_tags_entry_uuid_foreign
    foreign key (entry_uuid) references telescope_entries (uuid)
    on delete cascade
    );

create index if not exists telescope_entries_tags_entry_uuid_tag_index
    on telescope_entries_tags (entry_uuid, tag);

create index if not exists telescope_entries_tags_tag_index
    on telescope_entries_tags (tag);

create table if not exists telescope_monitoring
(
    tag varchar(255) not null
    );

create table if not exists users
(
    id                bigint
    primary key,
    first_name        varchar(255) not null,
    last_name         varchar(255) not null,
    email             varchar(255) not null,
    payments_id       varchar(255) null,
    email_verified_at timestamp    null,
    password          varchar(255) not null,
    remember_token    varchar(100) null,
    created_at        timestamp    null,
    updated_at        timestamp    null,
    deleted_at        timestamp    null,
    constraint users_email_unique
    unique (email)
    );

create index if not exists users_first_name_index
    on users (first_name);

create index if not exists users_last_name_index
    on users (last_name);

create table if not exists websockets_statistics_entries
(
    id                      int
    primary key,
    app_id                  varchar(255) not null,
    peak_connection_count   int          not null,
    websocket_message_count int          not null,
    api_message_count       int          not null,
    created_at              timestamp    null,
    updated_at              timestamp    null
    );

