--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO sarmad;

--
-- Name: child_usage_reports; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.child_usage_reports (
    id integer NOT NULL,
    child_id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL,
    used_bytes bigint NOT NULL,
    note text
);


ALTER TABLE public.child_usage_reports OWNER TO sarmad;

--
-- Name: child_usage_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.child_usage_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.child_usage_reports_id_seq OWNER TO sarmad;

--
-- Name: child_usage_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.child_usage_reports_id_seq OWNED BY public.child_usage_reports.id;


--
-- Name: children; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.children (
    id integer NOT NULL,
    parent_id integer NOT NULL,
    child_user_id bigint NOT NULL,
    alias character varying(50),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.children OWNER TO sarmad;

--
-- Name: children_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.children_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.children_id_seq OWNER TO sarmad;

--
-- Name: children_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.children_id_seq OWNED BY public.children.id;


--
-- Name: config_cisco; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_cisco (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    group_name character varying,
    group_password character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_cisco OWNER TO sarmad;

--
-- Name: config_cisco_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_cisco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_cisco_id_seq OWNER TO sarmad;

--
-- Name: config_cisco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_cisco_id_seq OWNED BY public.config_cisco.id;


--
-- Name: config_ikev2; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_ikev2 (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    certificate character varying,
    private_key character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_ikev2 OWNER TO sarmad;

--
-- Name: config_ikev2_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_ikev2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_ikev2_id_seq OWNER TO sarmad;

--
-- Name: config_ikev2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_ikev2_id_seq OWNED BY public.config_ikev2.id;


--
-- Name: config_ipsec; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_ipsec (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    ike_version character varying,
    username character varying,
    password character varying,
    psk character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_ipsec OWNER TO sarmad;

--
-- Name: config_ipsec_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_ipsec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_ipsec_id_seq OWNER TO sarmad;

--
-- Name: config_ipsec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_ipsec_id_seq OWNED BY public.config_ipsec.id;


--
-- Name: config_l2tp; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_l2tp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    shared_secret character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_l2tp OWNER TO sarmad;

--
-- Name: config_l2tp_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_l2tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_l2tp_id_seq OWNER TO sarmad;

--
-- Name: config_l2tp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_l2tp_id_seq OWNED BY public.config_l2tp.id;


--
-- Name: config_openvpn; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_openvpn (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    ca_cert character varying,
    client_cert character varying,
    client_key character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_openvpn OWNER TO sarmad;

--
-- Name: config_openvpn_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_openvpn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_openvpn_id_seq OWNER TO sarmad;

--
-- Name: config_openvpn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_openvpn_id_seq OWNED BY public.config_openvpn.id;


--
-- Name: config_pptp; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_pptp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    mppe_enabled character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_pptp OWNER TO sarmad;

--
-- Name: config_pptp_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_pptp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_pptp_id_seq OWNER TO sarmad;

--
-- Name: config_pptp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_pptp_id_seq OWNED BY public.config_pptp.id;


--
-- Name: config_shadowsocks; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_shadowsocks (
    id integer NOT NULL,
    config_id integer,
    address character varying NOT NULL,
    port integer NOT NULL,
    encryption character varying NOT NULL,
    password character varying NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.config_shadowsocks OWNER TO sarmad;

--
-- Name: config_shadowsocks_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_shadowsocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_shadowsocks_id_seq OWNER TO sarmad;

--
-- Name: config_shadowsocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_shadowsocks_id_seq OWNED BY public.config_shadowsocks.id;


--
-- Name: config_sstp; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_sstp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    cert character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_sstp OWNER TO sarmad;

--
-- Name: config_sstp_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_sstp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_sstp_id_seq OWNER TO sarmad;

--
-- Name: config_sstp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_sstp_id_seq OWNED BY public.config_sstp.id;


--
-- Name: config_v2ray; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_v2ray (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    server character varying,
    port integer,
    uuid character varying,
    encryption character varying,
    password character varying,
    alter_id integer,
    security character varying,
    network character varying,
    path character varying,
    host character varying,
    sni character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    address character varying NOT NULL
);


ALTER TABLE public.config_v2ray OWNER TO sarmad;

--
-- Name: config_v2ray_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_v2ray_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_v2ray_id_seq OWNER TO sarmad;

--
-- Name: config_v2ray_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_v2ray_id_seq OWNED BY public.config_v2ray.id;


--
-- Name: config_wireguard; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.config_wireguard (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    private_key character varying,
    public_key character varying,
    preshared_key character varying,
    endpoint character varying,
    allowed_ips character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.config_wireguard OWNER TO sarmad;

--
-- Name: config_wireguard_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.config_wireguard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_wireguard_id_seq OWNER TO sarmad;

--
-- Name: config_wireguard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.config_wireguard_id_seq OWNED BY public.config_wireguard.id;


--
-- Name: configs; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.configs (
    id bigint NOT NULL,
    user_id bigint,
    protocol character varying NOT NULL,
    name character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    expiration_date timestamp without time zone,
    config_name character varying,
    domain character varying,
    port integer,
    uuid character varying,
    active boolean,
    transfer_enable bigint,
    feedback_requested boolean DEFAULT false NOT NULL,
    used_bytes bigint NOT NULL
);


ALTER TABLE public.configs OWNER TO sarmad;

--
-- Name: COLUMN configs.transfer_enable; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.transfer_enable IS 'حجم کل به بایت';


--
-- Name: COLUMN configs.feedback_requested; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.feedback_requested IS 'آیا برای این کانفیگ فیدبک درخواست شده؟';


--
-- Name: COLUMN configs.used_bytes; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.used_bytes IS 'مقدار ترافیک مصرف‌شده از این کانفیگ';


--
-- Name: configs_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.configs_id_seq OWNER TO sarmad;

--
-- Name: configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;


--
-- Name: email_tokens; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.email_tokens (
    id character varying NOT NULL,
    user_id bigint NOT NULL,
    token character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    used boolean DEFAULT false NOT NULL
);


ALTER TABLE public.email_tokens OWNER TO sarmad;

--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    config_id integer NOT NULL,
    is_satisfied boolean NOT NULL,
    feedback_text character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.feedbacks OWNER TO sarmad;

--
-- Name: COLUMN feedbacks.is_satisfied; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.feedbacks.is_satisfied IS 'آیا کاربر راضی بود؟';


--
-- Name: COLUMN feedbacks.feedback_text; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.feedbacks.feedback_text IS 'متن بازخورد کاربر';


--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedbacks_id_seq OWNER TO sarmad;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: inbounds; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.inbounds (
    id integer NOT NULL,
    server character varying NOT NULL,
    port integer NOT NULL,
    protocol character varying NOT NULL,
    encryption character varying,
    password character varying,
    network character varying,
    path character varying,
    host character varying,
    sni character varying
);


ALTER TABLE public.inbounds OWNER TO sarmad;

--
-- Name: inbounds_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.inbounds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inbounds_id_seq OWNER TO sarmad;

--
-- Name: inbounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.inbounds_id_seq OWNED BY public.inbounds.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    status character varying,
    is_manual boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    description character varying,
    deposit_amount integer,
    trial_days integer,
    trial_volume integer
);


ALTER TABLE public.orders OWNER TO sarmad;

--
-- Name: COLUMN orders.deposit_amount; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.orders.deposit_amount IS 'مبلغ ودیعه/پیش‌پرداخت (تومان/دلار)';


--
-- Name: COLUMN orders.trial_days; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.orders.trial_days IS 'مدت تریال (روز)';


--
-- Name: COLUMN orders.trial_volume; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.orders.trial_volume IS 'حجم تریال (بایت)';


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO sarmad;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: parental_controls; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.parental_controls (
    id integer NOT NULL,
    parent_id bigint NOT NULL,
    child_id bigint NOT NULL,
    control_type character varying(50) NOT NULL,
    settings jsonb DEFAULT '{}'::jsonb NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.parental_controls OWNER TO sarmad;

--
-- Name: parental_controls_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.parental_controls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parental_controls_id_seq OWNER TO sarmad;

--
-- Name: parental_controls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.parental_controls_id_seq OWNED BY public.parental_controls.id;


--
-- Name: parents; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.parents (
    id integer NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.parents OWNER TO sarmad;

--
-- Name: parents_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.parents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parents_id_seq OWNER TO sarmad;

--
-- Name: parents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.parents_id_seq OWNED BY public.parents.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.plans (
    id integer NOT NULL,
    name character varying NOT NULL,
    duration_days integer NOT NULL,
    volume_gb integer,
    price integer NOT NULL,
    description character varying,
    is_active boolean,
    created_at timestamp without time zone,
    type character varying DEFAULT 'monthly'::character varying NOT NULL
);


ALTER TABLE public.plans OWNER TO sarmad;

--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plans_id_seq OWNER TO sarmad;

--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.servers (
    id integer NOT NULL,
    name character varying NOT NULL,
    ip character varying NOT NULL,
    port integer NOT NULL,
    protocol character varying NOT NULL,
    panel_path character varying,
    domain character varying,
    is_active boolean,
    current_clients integer,
    max_clients integer,
    panel_username character varying,
    panel_password character varying
);


ALTER TABLE public.servers OWNER TO sarmad;

--
-- Name: servers_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servers_id_seq OWNER TO sarmad;

--
-- Name: servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;


--
-- Name: support_agents; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.support_agents (
    id integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    last_assigned_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.support_agents OWNER TO sarmad;

--
-- Name: support_agents_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.support_agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_agents_id_seq OWNER TO sarmad;

--
-- Name: support_agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.support_agents_id_seq OWNED BY public.support_agents.id;


--
-- Name: support_messages; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.support_messages (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    from_user character varying(5) NOT NULL,
    content text NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    sender_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.support_messages OWNER TO sarmad;

--
-- Name: support_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.support_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_messages_id_seq OWNER TO sarmad;

--
-- Name: support_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.support_messages_id_seq OWNED BY public.support_messages.id;


--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.support_tickets (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    status character varying(20) DEFAULT 'open'::character varying NOT NULL,
    first_message text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    agent_id integer,
    username character varying,
    sender_id bigint
);


ALTER TABLE public.support_tickets OWNER TO sarmad;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.support_tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_tickets_id_seq OWNER TO sarmad;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.support_tickets_id_seq OWNED BY public.support_tickets.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    user_id bigint NOT NULL,
    message character varying NOT NULL,
    response character varying,
    status character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    answered_at timestamp with time zone
);


ALTER TABLE public.tickets OWNER TO sarmad;

--
-- Name: tickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_ticket_id_seq OWNER TO sarmad;

--
-- Name: tickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;


--
-- Name: traffic_records; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.traffic_records (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    category character varying NOT NULL,
    bytes_used bigint DEFAULT '0'::bigint NOT NULL,
    recorded_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.traffic_records OWNER TO sarmad;

--
-- Name: traffic_records_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.traffic_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traffic_records_id_seq OWNER TO sarmad;

--
-- Name: traffic_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.traffic_records_id_seq OWNED BY public.traffic_records.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    amount integer NOT NULL,
    currency character varying,
    status character varying,
    gateway character varying NOT NULL,
    reference character varying,
    type character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO sarmad;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO sarmad;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying,
    phone character varying,
    balance integer,
    lang character varying,
    role character varying,
    full_name character varying,
    language_code character varying,
    is_admin boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    referrer_id bigint,
    total_referral_bonus integer,
    email character varying,
    email_verified_at timestamp with time zone,
    trial_used boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO sarmad;

--
-- Name: COLUMN users.balance; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.users.balance IS 'موجودی کیف‌پول کاربر (تومان/دلار)';


--
-- Name: COLUMN users.referrer_id; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.users.referrer_id IS 'کاربری که این فرد را دعوت کرده';


--
-- Name: COLUMN users.total_referral_bonus; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.users.total_referral_bonus IS 'مجموع بونوس‌های دریافتی از زیرمجموعه‌ها';


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: sarmad
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO sarmad;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarmad
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: child_usage_reports id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.child_usage_reports ALTER COLUMN id SET DEFAULT nextval('public.child_usage_reports_id_seq'::regclass);


--
-- Name: children id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.children ALTER COLUMN id SET DEFAULT nextval('public.children_id_seq'::regclass);


--
-- Name: config_cisco id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_cisco ALTER COLUMN id SET DEFAULT nextval('public.config_cisco_id_seq'::regclass);


--
-- Name: config_ikev2 id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_ikev2 ALTER COLUMN id SET DEFAULT nextval('public.config_ikev2_id_seq'::regclass);


--
-- Name: config_ipsec id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_ipsec ALTER COLUMN id SET DEFAULT nextval('public.config_ipsec_id_seq'::regclass);


--
-- Name: config_l2tp id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_l2tp ALTER COLUMN id SET DEFAULT nextval('public.config_l2tp_id_seq'::regclass);


--
-- Name: config_openvpn id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_openvpn ALTER COLUMN id SET DEFAULT nextval('public.config_openvpn_id_seq'::regclass);


--
-- Name: config_pptp id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_pptp ALTER COLUMN id SET DEFAULT nextval('public.config_pptp_id_seq'::regclass);


--
-- Name: config_shadowsocks id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_shadowsocks ALTER COLUMN id SET DEFAULT nextval('public.config_shadowsocks_id_seq'::regclass);


--
-- Name: config_sstp id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_sstp ALTER COLUMN id SET DEFAULT nextval('public.config_sstp_id_seq'::regclass);


--
-- Name: config_v2ray id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_v2ray ALTER COLUMN id SET DEFAULT nextval('public.config_v2ray_id_seq'::regclass);


--
-- Name: config_wireguard id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_wireguard ALTER COLUMN id SET DEFAULT nextval('public.config_wireguard_id_seq'::regclass);


--
-- Name: configs id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: inbounds id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.inbounds ALTER COLUMN id SET DEFAULT nextval('public.inbounds_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: parental_controls id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.parental_controls ALTER COLUMN id SET DEFAULT nextval('public.parental_controls_id_seq'::regclass);


--
-- Name: parents id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.parents ALTER COLUMN id SET DEFAULT nextval('public.parents_id_seq'::regclass);


--
-- Name: plans id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);


--
-- Name: servers id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);


--
-- Name: support_agents id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_agents ALTER COLUMN id SET DEFAULT nextval('public.support_agents_id_seq'::regclass);


--
-- Name: support_messages id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_messages ALTER COLUMN id SET DEFAULT nextval('public.support_messages_id_seq'::regclass);


--
-- Name: support_tickets id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_tickets ALTER COLUMN id SET DEFAULT nextval('public.support_tickets_id_seq'::regclass);


--
-- Name: tickets ticket_id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);


--
-- Name: traffic_records id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.traffic_records ALTER COLUMN id SET DEFAULT nextval('public.traffic_records_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.alembic_version (version_num) FROM stdin;
5be85e104710
\.


--
-- Data for Name: child_usage_reports; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.child_usage_reports (id, child_id, "timestamp", used_bytes, note) FROM stdin;
\.


--
-- Data for Name: children; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.children (id, parent_id, child_user_id, alias, created_at) FROM stdin;
\.


--
-- Data for Name: config_cisco; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_cisco (id, config_id, username, password, group_name, group_password, created_at) FROM stdin;
\.


--
-- Data for Name: config_ikev2; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_ikev2 (id, config_id, username, password, certificate, private_key, created_at) FROM stdin;
\.


--
-- Data for Name: config_ipsec; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_ipsec (id, config_id, ike_version, username, password, psk, created_at) FROM stdin;
\.


--
-- Data for Name: config_l2tp; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_l2tp (id, config_id, username, password, shared_secret, created_at) FROM stdin;
\.


--
-- Data for Name: config_openvpn; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_openvpn (id, config_id, username, password, ca_cert, client_cert, client_key, created_at) FROM stdin;
\.


--
-- Data for Name: config_pptp; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_pptp (id, config_id, username, password, mppe_enabled, created_at) FROM stdin;
\.


--
-- Data for Name: config_shadowsocks; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_shadowsocks (id, config_id, address, port, encryption, password, created_at) FROM stdin;
\.


--
-- Data for Name: config_sstp; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_sstp (id, config_id, username, password, cert, created_at) FROM stdin;
\.


--
-- Data for Name: config_v2ray; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_v2ray (id, config_id, server, port, uuid, encryption, password, alter_id, security, network, path, host, sni, created_at, address) FROM stdin;
\.


--
-- Data for Name: config_wireguard; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.config_wireguard (id, config_id, private_key, public_key, preshared_key, endpoint, allowed_ips, created_at) FROM stdin;
\.


--
-- Data for Name: configs; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.configs (id, user_id, protocol, name, created_at, expiration_date, config_name, domain, port, uuid, active, transfer_enable, feedback_requested, used_bytes) FROM stdin;
\.


--
-- Data for Name: email_tokens; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.email_tokens (id, user_id, token, created_at, used) FROM stdin;
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.feedbacks (id, user_id, config_id, is_satisfied, feedback_text, created_at) FROM stdin;
\.


--
-- Data for Name: inbounds; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.inbounds (id, server, port, protocol, encryption, password, network, path, host, sni) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description, deposit_amount, trial_days, trial_volume) FROM stdin;
\.


--
-- Data for Name: parental_controls; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.parental_controls (id, parent_id, child_id, control_type, settings, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: parents; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.parents (id, user_id) FROM stdin;
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at, type) FROM stdin;
\.


--
-- Data for Name: servers; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.servers (id, name, ip, port, protocol, panel_path, domain, is_active, current_clients, max_clients, panel_username, panel_password) FROM stdin;
\.


--
-- Data for Name: support_agents; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.support_agents (id, is_active, last_assigned_at) FROM stdin;
\.


--
-- Data for Name: support_messages; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.support_messages (id, ticket_id, from_user, content, "timestamp", sender_id, user_id) FROM stdin;
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.support_tickets (id, user_id, status, first_message, created_at, updated_at, agent_id, username, sender_id) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.tickets (ticket_id, user_id, message, response, status, created_at, answered_at) FROM stdin;
\.


--
-- Data for Name: traffic_records; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.traffic_records (id, user_id, category, bytes_used, recorded_at) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.transactions (id, user_id, plan_id, amount, currency, status, gateway, reference, type, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.users (user_id, username, phone, balance, lang, role, full_name, language_code, is_admin, created_at, referrer_id, total_referral_bonus, email, email_verified_at, trial_used) FROM stdin;
\.


--
-- Name: child_usage_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.child_usage_reports_id_seq', 1, false);


--
-- Name: children_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.children_id_seq', 1, false);


--
-- Name: config_cisco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_cisco_id_seq', 1, false);


--
-- Name: config_ikev2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_ikev2_id_seq', 1, false);


--
-- Name: config_ipsec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_ipsec_id_seq', 1, false);


--
-- Name: config_l2tp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_l2tp_id_seq', 1, false);


--
-- Name: config_openvpn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_openvpn_id_seq', 1, false);


--
-- Name: config_pptp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_pptp_id_seq', 1, false);


--
-- Name: config_shadowsocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_shadowsocks_id_seq', 1, false);


--
-- Name: config_sstp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_sstp_id_seq', 1, false);


--
-- Name: config_v2ray_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_v2ray_id_seq', 1, false);


--
-- Name: config_wireguard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);


--
-- Name: configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.configs_id_seq', 1, false);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 1, false);


--
-- Name: inbounds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.inbounds_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: parental_controls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.parental_controls_id_seq', 1, false);


--
-- Name: parents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.parents_id_seq', 1, false);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.plans_id_seq', 1, false);


--
-- Name: servers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.servers_id_seq', 1, false);


--
-- Name: support_agents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.support_agents_id_seq', 1, false);


--
-- Name: support_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.support_messages_id_seq', 1, false);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 1, false);


--
-- Name: tickets_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);


--
-- Name: traffic_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.traffic_records_id_seq', 1, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: child_usage_reports child_usage_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.child_usage_reports
    ADD CONSTRAINT child_usage_reports_pkey PRIMARY KEY (id);


--
-- Name: children children_child_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.children
    ADD CONSTRAINT children_child_user_id_key UNIQUE (child_user_id);


--
-- Name: children children_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.children
    ADD CONSTRAINT children_pkey PRIMARY KEY (id);


--
-- Name: config_cisco config_cisco_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_pkey PRIMARY KEY (id);


--
-- Name: config_ikev2 config_ikev2_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_pkey PRIMARY KEY (id);


--
-- Name: config_ipsec config_ipsec_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_pkey PRIMARY KEY (id);


--
-- Name: config_l2tp config_l2tp_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_pkey PRIMARY KEY (id);


--
-- Name: config_openvpn config_openvpn_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_pkey PRIMARY KEY (id);


--
-- Name: config_pptp config_pptp_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_pkey PRIMARY KEY (id);


--
-- Name: config_shadowsocks config_shadowsocks_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_pkey PRIMARY KEY (id);


--
-- Name: config_sstp config_sstp_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_pkey PRIMARY KEY (id);


--
-- Name: config_v2ray config_v2ray_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_pkey PRIMARY KEY (id);


--
-- Name: config_wireguard config_wireguard_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_pkey PRIMARY KEY (id);


--
-- Name: configs configs_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);


--
-- Name: email_tokens email_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: inbounds inbounds_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.inbounds
    ADD CONSTRAINT inbounds_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: parental_controls parental_controls_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.parental_controls
    ADD CONSTRAINT parental_controls_pkey PRIMARY KEY (id);


--
-- Name: parents parents_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.parents
    ADD CONSTRAINT parents_pkey PRIMARY KEY (id);


--
-- Name: parents parents_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.parents
    ADD CONSTRAINT parents_user_id_key UNIQUE (user_id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: servers servers_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: support_agents support_agents_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_agents
    ADD CONSTRAINT support_agents_pkey PRIMARY KEY (id);


--
-- Name: support_messages support_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);


--
-- Name: traffic_records traffic_records_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.traffic_records
    ADD CONSTRAINT traffic_records_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: ix_email_tokens_token; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE UNIQUE INDEX ix_email_tokens_token ON public.email_tokens USING btree (token);


--
-- Name: ix_email_tokens_user_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_email_tokens_user_id ON public.email_tokens USING btree (user_id);


--
-- Name: ix_feedbacks_config_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_feedbacks_config_id ON public.feedbacks USING btree (config_id);


--
-- Name: ix_feedbacks_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_feedbacks_id ON public.feedbacks USING btree (id);


--
-- Name: ix_feedbacks_user_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_feedbacks_user_id ON public.feedbacks USING btree (user_id);


--
-- Name: ix_order_user_plan; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_order_user_plan ON public.orders USING btree (user_id, plan_id);


--
-- Name: ix_orders_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_orders_id ON public.orders USING btree (id);


--
-- Name: ix_orders_plan_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_orders_plan_id ON public.orders USING btree (plan_id);


--
-- Name: ix_orders_user_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_orders_user_id ON public.orders USING btree (user_id);


--
-- Name: ix_parental_controls_child_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_parental_controls_child_id ON public.parental_controls USING btree (child_id);


--
-- Name: ix_parental_controls_parent_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_parental_controls_parent_id ON public.parental_controls USING btree (parent_id);


--
-- Name: ix_plans_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_plans_id ON public.plans USING btree (id);


--
-- Name: ix_servers_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_servers_id ON public.servers USING btree (id);


--
-- Name: ix_support_messages_ticket_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_support_messages_ticket_id ON public.support_messages USING btree (ticket_id);


--
-- Name: ix_support_tickets_user_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_support_tickets_user_id ON public.support_tickets USING btree (user_id);


--
-- Name: ix_ticket_user_status; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_ticket_user_status ON public.tickets USING btree (user_id, status);


--
-- Name: ix_tickets_ticket_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_tickets_ticket_id ON public.tickets USING btree (ticket_id);


--
-- Name: ix_traffic_records_user_category; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_traffic_records_user_category ON public.traffic_records USING btree (user_id, category);


--
-- Name: ix_transaction_user_status; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_transaction_user_status ON public.transactions USING btree (user_id, status);


--
-- Name: ix_transactions_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);


--
-- Name: ix_user_username_phone; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_user_username_phone ON public.users USING btree (username, phone);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_lang; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_users_lang ON public.users USING btree (lang);


--
-- Name: ix_users_referrer_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_users_referrer_id ON public.users USING btree (referrer_id);


--
-- Name: ix_users_role; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_users_role ON public.users USING btree (role);


--
-- Name: child_usage_reports child_usage_reports_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.child_usage_reports
    ADD CONSTRAINT child_usage_reports_child_id_fkey FOREIGN KEY (child_id) REFERENCES public.children(id) ON DELETE CASCADE;


--
-- Name: children children_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.children
    ADD CONSTRAINT children_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.parents(id) ON DELETE CASCADE;


--
-- Name: config_cisco config_cisco_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_ikev2 config_ikev2_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_ipsec config_ipsec_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_l2tp config_l2tp_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_openvpn config_openvpn_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_pptp config_pptp_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_shadowsocks config_shadowsocks_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);


--
-- Name: config_sstp config_sstp_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_v2ray config_v2ray_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: config_wireguard config_wireguard_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;


--
-- Name: configs configs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: email_tokens email_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: feedbacks feedbacks_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);


--
-- Name: feedbacks feedbacks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: support_tickets fk_support_tickets_sender_id_users; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT fk_support_tickets_sender_id_users FOREIGN KEY (sender_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: orders orders_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: support_messages support_messages_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.support_tickets(id) ON DELETE CASCADE;


--
-- Name: support_tickets support_tickets_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.support_agents(id);


--
-- Name: tickets tickets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: transactions transactions_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: users users_referrer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_referrer_id_fkey FOREIGN KEY (referrer_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

