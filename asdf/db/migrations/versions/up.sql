CREATE SCHEMA IF NOT EXISTS global;
CREATE TABLE IF NOT EXISTS global.aaaaa
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    olea_id    character varying,
    domain_key character varying        NOT NULL,
    type_key   character varying        NOT NULL,
    latitude   double precision,
    longitude  double precision,
    elevation  double precision,
    fulcrum_id character varying,
    site_id    uuid,
    primary key ("id")
) ;
CREATE TABLE IF NOT EXISTS global.asset
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    olea_id    character varying,
    domain_key character varying        NOT NULL,
    type_key   character varying        NOT NULL,
    latitude   double precision,
    longitude  double precision,
    elevation  double precision,
    fulcrum_id character varying,
    site_id    uuid
);

CREATE TABLE IF NOT EXISTS global.asset_device_history
(
    id          uuid                     NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    olea_id     character varying        NOT NULL,
    action_key  character varying        NOT NULL,
    interval    tstzrange                NOT NULL,
    description character varying
);
CREATE TABLE IF NOT EXISTS global.asset_site_order
(
    asset_id uuid    NOT NULL,
    "order"  integer NOT NULL
);
CREATE TABLE IF NOT EXISTS global.domain
(
    unid   uuid              NOT NULL,
    sid    character varying NOT NULL,
    itst   timestamp with time zone,
    utst   timestamp with time zone,
    name   character varying NOT NULL,
    descr  character varying,
    clat   double precision,
    clon   double precision,
    zoom   integer,
    uri_fu character varying
);
CREATE TABLE IF NOT EXISTS global.asset_condition
(
    id             uuid                     NOT NULL,
    created_at     timestamp with time zone NOT NULL,
    updated_at     timestamp with time zone NOT NULL,
    subcategory_id uuid                     NOT NULL,
    name           text                     NOT NULL,
    "order"        integer
);
CREATE TABLE IF NOT EXISTS global.asset_condition_category
(
    id            uuid                     NOT NULL,
    created_at    timestamp with time zone NOT NULL,
    updated_at    timestamp with time zone NOT NULL,
    name          text                     NOT NULL,
    asset_type_id integer,
    "order"       integer,
    icon          text
);
CREATE TABLE IF NOT EXISTS global.asset_condition_option
(
    id           uuid                     NOT NULL,
    created_at   timestamp with time zone NOT NULL,
    updated_at   timestamp with time zone NOT NULL,
    condition_id uuid                     NOT NULL,
    description  text                     NOT NULL,
    value_id     uuid                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.asset_condition_subcategory
(
    id          uuid                     NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    updated_at  timestamp with time zone NOT NULL,
    category_id uuid                     NOT NULL,
    name        text                     NOT NULL,
    "order"     integer
);
CREATE TABLE IF NOT EXISTS global.asset_status
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    key        text                     NOT NULL,
    name       text                     NOT NULL,
    "order"    integer
);
CREATE TABLE IF NOT EXISTS global.asset_type
(
    id    integer                  NOT NULL,
    itst  timestamp with time zone NOT NULL,
    utst  timestamp with time zone NOT NULL,
    sid   character varying(64)    NOT NULL,
    iname character varying(16)    NOT NULL,
    hname character varying(32)    NOT NULL,
    lname character varying(256)   NOT NULL,
    descr character varying(2048)
);
CREATE TABLE IF NOT EXISTS global.asset_type_device_type
(
    id             uuid                     NOT NULL,
    created_at     timestamp with time zone NOT NULL,
    updated_at     timestamp with time zone NOT NULL,
    asset_type_id  integer                  NOT NULL,
    device_type_id integer                  NOT NULL
);
CREATE TABLE IF NOT EXISTS global.site
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    latitude   double precision,
    longitude  double precision,
    elevation  double precision,
    premise_id uuid
);
CREATE TABLE IF NOT EXISTS global.site_state
(
    id             uuid                     NOT NULL,
    created_at     timestamp with time zone NOT NULL,
    updated_at     timestamp with time zone NOT NULL,
    name           text                     NOT NULL,
    subcategory_id uuid                     NOT NULL,
    "order"        integer
);
CREATE TABLE IF NOT EXISTS global.site_state_category
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name       text                     NOT NULL,
    "order"    integer
);
CREATE TABLE IF NOT EXISTS global.site_state_history
(
    id                uuid                     NOT NULL,
    created_at        timestamp with time zone NOT NULL,
    updated_at        timestamp with time zone NOT NULL,
    site_id           uuid                     NOT NULL,
    state_option_id   uuid                     NOT NULL,
    "timestamp"       timestamp with time zone NOT NULL,
    override_value_id uuid
);
CREATE TABLE IF NOT EXISTS global.site_state_option
(
    id          uuid                     NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    updated_at  timestamp with time zone NOT NULL,
    state_id    uuid                     NOT NULL,
    description text                     NOT NULL,
    value_id    uuid                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.site_state_subcategory
(
    id          uuid                     NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    updated_at  timestamp with time zone NOT NULL,
    name        text                     NOT NULL,
    category_id uuid                     NOT NULL,
    "order"     integer
);
CREATE TABLE IF NOT EXISTS global.value
(
    id          uuid                     NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    updated_at  timestamp with time zone NOT NULL,
    key         text                     NOT NULL,
    name        text                     NOT NULL,
    description text,
    "order"     integer
);
CREATE TABLE IF NOT EXISTS global.water_meter_head_type
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    key        text                     NOT NULL,
    name       text                     NOT NULL,
    "order"    integer
);
CREATE TABLE IF NOT EXISTS global.water_meter_measuring_element
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name       text                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.water_meter_register_unit
(
    id           uuid                     NOT NULL,
    created_at   timestamp with time zone NOT NULL,
    updated_at   timestamp with time zone NOT NULL,
    name         text                     NOT NULL,
    abbreviation text                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.water_meter_register_type
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    key        text                     NOT NULL,
    type       text                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.water_meter_model
(
    id                        uuid                     NOT NULL,
    created_at                timestamp with time zone NOT NULL,
    updated_at                timestamp with time zone NOT NULL,
    name                      text                     NOT NULL,
    model                     text,
    series                    text,
    submodel                  text,
    subseries                 text,
    min_low_flow              real,
    min_operational_flow      real,
    crossover_point           real,
    max_operational_flow      real,
    max_continuous_flow       real,
    max_intermittent_flow     real,
    pipe_diameter             real,
    low_pipe_diameter         real,
    high_pipe_diameter        real,
    low_measuring_element_id  uuid,
    high_measuring_element_id uuid,
    manufacturer_id           uuid
);
CREATE TABLE IF NOT EXISTS global.water_meter_model_manufacturer
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name       text                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.domain_source
(
    id          uuid                     NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    updated_at  timestamp with time zone NOT NULL,
    key         text                     NOT NULL,
    description text                     NOT NULL
);
CREATE TABLE IF NOT EXISTS global.analysis_batch
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name       text                     NOT NULL,
    "order"    integer
);
CREATE TABLE IF NOT EXISTS global.analysis_section
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name       text                     NOT NULL,
    "order"    integer
);
CREATE TABLE IF NOT EXISTS global.report_status
(
    id         uuid                     NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name       text                     NOT NULL,
    "order"    integer
);
