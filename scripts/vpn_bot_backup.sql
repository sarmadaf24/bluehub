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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: sarmad
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO sarmad;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: sarmad
--

COMMENT ON SCHEMA public IS '';


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
    reset_period interval,
    last_reset_at timestamp without time zone,
    plan_type character varying DEFAULT 'monthly'::character varying NOT NULL,
    is_trial boolean DEFAULT false,
    extra_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    used_bytes bigint NOT NULL
);


ALTER TABLE public.configs OWNER TO sarmad;

--
-- Name: COLUMN configs.transfer_enable; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.transfer_enable IS 'حجم کل مجاز (بایت); None=infinite';


--
-- Name: COLUMN configs.feedback_requested; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.feedback_requested IS 'آیا برای این کانفیگ فیدبک درخواست شده؟';


--
-- Name: COLUMN configs.reset_period; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.reset_period IS 'فاصله دوره‌ای ری‌ست ترافیک (مثلاً ماهانه)';


--
-- Name: COLUMN configs.last_reset_at; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.last_reset_at IS 'آخرین زمان ری‌ست';


--
-- Name: COLUMN configs.plan_type; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.plan_type IS 'monthly/unlimited/trial';


--
-- Name: COLUMN configs.extra_metadata; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.configs.extra_metadata IS 'ابر‌داده برای توسعه‌های آینده';


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
-- Name: COLUMN email_tokens.id; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.email_tokens.id IS 'UUID for this token';


--
-- Name: COLUMN email_tokens.user_id; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.email_tokens.user_id IS 'Reference to users.user_id';


--
-- Name: COLUMN email_tokens.token; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.email_tokens.token IS 'Signed token';


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
-- Name: plans; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.plans (
    id integer NOT NULL,
    name character varying NOT NULL,
    duration_days integer NOT NULL,
    volume_gb integer,
    price integer NOT NULL,
    description character varying,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    type character varying DEFAULT 'monthly'::character varying NOT NULL
);


ALTER TABLE public.plans OWNER TO sarmad;

--
-- Name: COLUMN plans.name; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.plans.name IS 'نام پلن';


--
-- Name: COLUMN plans.duration_days; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.plans.duration_days IS 'مدت زمان به روز';


--
-- Name: COLUMN plans.volume_gb; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.plans.volume_gb IS 'حجم به گیگابایت؛ None = نامحدود';


--
-- Name: COLUMN plans.price; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.plans.price IS 'قیمت (به تومان)';


--
-- Name: COLUMN plans.description; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.plans.description IS 'توضیحات اختیاری';


--
-- Name: COLUMN plans.is_active; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.plans.is_active IS 'آیا پلن فعال است؟';


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
-- Name: support_agents; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.support_agents (
    id integer NOT NULL,
    is_active boolean NOT NULL,
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
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: sarmad
--

CREATE TABLE public.support_tickets (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    agent_id integer,
    question text DEFAULT ''::text NOT NULL,
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
-- Name: COLUMN users.trial_used; Type: COMMENT; Schema: public; Owner: sarmad
--

COMMENT ON COLUMN public.users.trial_used IS 'آیا کاربر تریال را قبلاً استفاده کرده؟';


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
-- Name: plans id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);


--
-- Name: support_agents id; Type: DEFAULT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_agents ALTER COLUMN id SET DEFAULT nextval('public.support_agents_id_seq'::regclass);


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

COPY public.configs (id, user_id, protocol, name, created_at, expiration_date, config_name, domain, port, uuid, active, transfer_enable, feedback_requested, reset_period, last_reset_at, plan_type, is_trial, extra_metadata, used_bytes) FROM stdin;
158	6875573318	shadowsocks	SHADOWSOCKS-6875573318-1746289410	2025-05-03 16:23:30.182695+00	2026-05-03 16:23:30.182633	Plan-9	ss://Tm9uZTo0M2ZmY2EwMy01MjdhLTQ3YTQtOWM0Ny1kMGIxYzgwY2RhODU@157.180.44.242:80#BlueHub	80	43ffca03-527a-47a4-9c47-d0b1c80cda85	t	805306368000	f	\N	\N	monthly	f	{}	0
163	6875573318	shadowsocks	SHADOWSOCKS-6875573318-1746312155	2025-05-03 22:42:35.97786+00	2026-05-03 22:42:35.97784	Plan-8	ss://Tm9uZTo5ODlhMzZmNS1lYmMxLTQ4ODctYTNhZS0zY2EzNTU3Y2ExYTc@157.180.44.242:80#BlueHub	80	989a36f5-ebc1-4887-a3ae-3ca3557ca1a7	t	644245094400	f	\N	\N	monthly	f	{}	0
166	6875573318	vless	trial-6875573318-1746312795	2025-05-03 22:53:15.164643+00	2025-05-05 22:53:15.164643	2d-1GB-trial	\N	443	a37e3906-46b5-47d1-a6f1-a5743a3c5c27	t	1073741824	f	\N	\N	trial	t	{}	0
167	6727220793	vless	trial-6727220793-1746353398	2025-05-04 10:09:58.680517+00	2025-05-05 10:09:58.680517	1d-0GB-trial	\N	443	986ebc43-d0df-49e1-b636-cdafb3ea9dc5	t	629145600	f	\N	\N	trial	t	{}	0
168	2005217637	vless	trial-2005217637-1746353469	2025-05-04 10:11:09.232546+00	2025-05-06 10:11:09.232546	2d-1GB-trial	\N	443	93c2e046-07e7-47f4-b486-9e01c34f135e	t	1073741824	f	\N	\N	trial	t	{}	0
169	2005217637	shadowsocks	SHADOWSOCKS-2005217637-1746353542	2025-05-04 10:12:22.32371+00	2026-05-04 10:12:22.323685	Plan-9	ss://Tm9uZTphY2FlMDExMy05MTdlLTQwNTctYjVkYy1hMGI5MTU5MjZiOTY@157.180.44.242:80#BlueHub	80	acae0113-917e-4057-b5dc-a0b915926b96	t	805306368000	f	\N	\N	monthly	f	{}	0
170	2005217637	vmess	VMESS-2005217637-1746365999	2025-05-04 13:39:59.374024+00	2025-10-31 13:39:59.373997	Plan-7	vmess://eyJ2IjogIjIiLCAicHMiOiAiQmx1ZUh1YiIsICJhZGQiOiAiMTU3LjE4MC40NC4yNDIiLCAicG9ydCI6ICI4MDgwIiwgImlkIjogIjJmZDM1OWI2LWEyYWEtNDRmOS05MDEyLTNiNTJlNWQ2NDEwNSIsICJhaWQiOiAiMCIsICJuZXQiOiAid3MiLCAidHlwZSI6ICJub25lIiwgImhvc3QiOiBudWxsLCAicGF0aCI6IG51bGwsICJ0bHMiOiAidGxzIn0=	8080	2fd359b6-a2aa-44f9-9012-3b52e5d64105	t	429496729600	f	\N	\N	monthly	f	{}	0
171	6727220793	vless	trial-6727220793-1746366255	2025-05-04 13:44:15.436326+00	2025-05-05 13:44:15.436326	1d-0GB-trial	\N	443	79f53478-961f-488f-bc59-5ab4f96ce006	t	629145600	f	\N	\N	trial	t	{}	0
172	6727220793	shadowsocks	SHADOWSOCKS-6727220793-1746367004	2025-05-04 13:56:44.524526+00	2025-06-03 13:56:44.524503	Plan-1	ss://Tm9uZTo2YmNlZWI1YS1jZjI3LTRlZjctODZkZC1jMjZmYmQ3NWY2ZDA@157.180.44.242:80#BlueHub	80	6bceeb5a-cf27-4ef7-86dd-c26fbd75f6d0	t	32212254720	f	\N	\N	monthly	f	{}	0
173	2005217637	vless	trial-2005217637-1746367072	2025-05-04 13:57:52.521282+00	2025-05-05 13:57:52.521282	1d-0GB-trial	\N	443	982362cd-bd20-4a5f-aee6-69556deb3579	t	629145600	f	\N	\N	trial	t	{}	0
174	6875573318	vless	trial-6875573318-1746367113	2025-05-04 13:58:33.050773+00	2025-05-06 13:58:33.050773	2d-1GB-trial	\N	443	e21da45a-665a-4b33-8a85-089ff79179b3	t	1073741824	f	\N	\N	trial	t	{}	0
175	6875573318	shadowsocks	SHADOWSOCKS-6875573318-1746367831	2025-05-04 14:10:31.882372+00	2026-05-04 14:10:31.882346	Plan-9	ss://Tm9uZTowNzc3NGQyOC0xODIwLTRkZjgtYjJmZC01NjlhMWJiNTc2ZGU@157.180.44.242:80#BlueHub	80	07774d28-1820-4df8-b2fd-569a1bb576de	t	805306368000	f	\N	\N	monthly	f	{}	0
176	6875573318	vless	trial-6875573318-1746367871	2025-05-04 14:11:11.418793+00	2025-05-05 14:11:11.418793	1d-0GB-trial	\N	443	9948bb94-0e31-4610-a92f-7b0df28e5b70	t	629145600	f	\N	\N	trial	t	{}	0
177	6727220793	vless	trial-6727220793-1746368324	2025-05-04 14:18:44.567447+00	2025-05-06 14:18:44.567447	2d-1GB-trial	\N	443	c6c3433c-d9f8-43ec-9c07-5bfd255be513	t	1073741824	f	\N	\N	trial	t	{}	0
178	6727220793	shadowsocks	SHADOWSOCKS-6727220793-1746380335	2025-05-04 17:38:55.065662+00	2026-05-04 17:38:55.06564	Plan-9	ss://Tm9uZTo3ZmNhNWZiYS0zYzFmLTQ5ZDYtODhkNi1hNWViYjY3YzZmNmM@157.180.44.242:80#BlueHub	80	7fca5fba-3c1f-49d6-88d6-a5ebb67c6f6c	t	805306368000	f	\N	\N	monthly	f	{}	0
179	2005217637	vless	trial-2005217637-1746380506	2025-05-04 17:41:46.187913+00	2025-05-05 17:41:46.187913	1d-0GB-trial	\N	443	585f3426-be3e-4508-9f5b-a53e0da60f23	t	629145600	f	\N	\N	trial	t	{}	0
180	6727220793	vless	trial-6727220793-1746380568	2025-05-04 17:42:48.033847+00	2025-05-06 17:42:48.033847	2d-1GB-trial	\N	443	7135422e-478b-494c-9967-c97e313ce1f8	t	1073741824	f	\N	\N	trial	t	{}	0
181	8048396187	vless	trial-8048396187-1746385769	2025-05-04 19:09:29.7043+00	2025-05-06 19:09:29.7043	2d-1GB-trial	\N	443	a473d6d4-7bd9-4aaf-bedb-2759defa69f7	t	1073741824	f	\N	\N	trial	t	{}	0
182	8048396187	trojan	TROJAN-8048396187-1746386355	2025-05-04 19:19:15.671415+00	2025-06-03 19:19:15.671388	Plan-2	trojan://41d1b161-4770-45a8-ba54-06fa5ba6207b@157.180.44.242:2052?security=tls#BlueHub	2052	41d1b161-4770-45a8-ba54-06fa5ba6207b	t	53687091200	f	\N	\N	monthly	f	{}	0
183	6727220793	vless	trial-6727220793-1746472573	2025-05-05 19:16:13.66337+00	2025-05-07 19:16:13.66337	2d-1GB-trial	\N	443	438b3b42-fc4e-4b8d-8aa9-5591ee91c7e9	t	1073741824	f	\N	\N	trial	t	{}	0
184	6875573318	shadowsocks	SHADOWSOCKS-6875573318-1746601992	2025-05-07 07:13:12.750167+00	2026-05-07 07:13:12.750142	Plan-9	ss://Tm9uZToxYmQ3MDVkMS02MjI0LTRiZjgtYmQyZS05Yjc4NDNkOTExMDM@157.180.44.242:80#BlueHub	80	1bd705d1-6224-4bf8-bd2e-9b7843d91103	t	805306368000	f	\N	\N	monthly	f	{}	0
185	6875573318	vless	trial-6875573318-1746602139	2025-05-07 07:15:39.702192+00	2025-05-08 07:15:39.702192	1d-0GB-trial	\N	443	0009870c-4ee5-4349-9162-8809e42c253b	t	629145600	f	\N	\N	trial	t	{}	0
186	6727220793	vless	trial-6727220793-1746610585	2025-05-07 09:36:25.184378+00	2025-05-08 09:36:25.184378	1d-0GB-trial	\N	443	06d5b1a3-7e43-4487-a15e-57dd7e886b19	t	629145600	f	\N	\N	trial	t	{}	0
187	482463905	vless	trial-482463905-1746610706	2025-05-07 09:38:26.595261+00	2025-05-09 09:38:26.595261	2d-1GB-trial	\N	443	15c8101d-af6a-441f-bb99-dd03079c3d51	t	1073741824	f	\N	\N	trial	t	{}	0
188	6875573318	shadowsocks	SHADOWSOCKS-6875573318-1746631998	2025-05-07 15:33:18.521713+00	2025-11-03 15:33:18.521689	Plan-7	ss://Tm9uZTo4NTdlNDg3Yy01NWJlLTQ5ODUtOTdhZS01NjM3MDlmM2JkMjE@157.180.44.242:80#BlueHub	80	857e487c-55be-4985-97ae-563709f3bd21	t	429496729600	f	\N	\N	monthly	f	{}	0
189	6875573318	vless	trial-6875573318-1746632022	2025-05-07 15:33:42.496104+00	2025-05-09 15:33:42.496104	2d-1GB-trial	\N	443	ff481141-00bd-4022-9c90-eaa527ad1d5c	t	1073741824	f	\N	\N	trial	t	{}	0
190	6727220793	vmess	VMESS-6727220793-1746641631	2025-05-07 18:13:51.894768+00	2025-08-05 18:13:51.894743	Plan-5	vmess://eyJ2IjogIjIiLCAicHMiOiAiQmx1ZUh1YiIsICJhZGQiOiAiMTU3LjE4MC40NC4yNDIiLCAicG9ydCI6ICI4MDgwIiwgImlkIjogIjk5NjJlYzZkLTlkNmYtNDkzZC04ZjA0LWYyNWVhOGMyM2NkMiIsICJhaWQiOiAiMCIsICJuZXQiOiAid3MiLCAidHlwZSI6ICJub25lIiwgImhvc3QiOiBudWxsLCAicGF0aCI6IG51bGwsICJ0bHMiOiAidGxzIn0=	8080	9962ec6d-9d6f-493d-8f04-f25ea8c23cd2	t	236223201280	f	\N	\N	monthly	f	{}	0
191	6875573318	shadowsocks	SHADOWSOCKS-6875573318-1746648555	2025-05-07 20:09:15.105511+00	2026-05-07 20:09:15.105487	Plan-9	ss://Tm9uZTpiOGJlODUwNy0yMjNhLTQzM2ItOTk0MS0yMzZkMzAyZDEwMWM@157.180.44.242:80#BlueHub	80	b8be8507-223a-433b-9941-236d302d101c	t	805306368000	f	\N	\N	monthly	f	{}	0
192	2005217637	shadowsocks	SHADOWSOCKS-2005217637-1746651527	2025-05-07 20:58:47.749849+00	2026-05-07 20:58:47.749827	Plan-8	ss://Tm9uZTpmZTJkZTNkMy1hODllLTQwNjEtODkwZC1hYWY3NTUzMzBkZTE@157.180.44.242:80#BlueHub	80	fe2de3d3-a89e-4061-890d-aaf755330de1	t	644245094400	f	\N	\N	monthly	f	{}	0
193	2005217637	vmess	VMESS-2005217637-1746652069	2025-05-07 21:07:49.767314+00	2026-05-07 21:07:49.76729	Plan-9	vmess://eyJ2IjogIjIiLCAicHMiOiAiQmx1ZUh1YiIsICJhZGQiOiAiMTU3LjE4MC40NC4yNDIiLCAicG9ydCI6ICI4MDgwIiwgImlkIjogIjlkYjY1ZmY1LTQwYTgtNGRiNi04NDZlLWZiNzNiYWIyYTRjNiIsICJhaWQiOiAiMCIsICJuZXQiOiAid3MiLCAidHlwZSI6ICJub25lIiwgImhvc3QiOiBudWxsLCAicGF0aCI6IG51bGwsICJ0bHMiOiAidGxzIn0=	8080	9db65ff5-40a8-4db6-846e-fb73bab2a4c6	t	805306368000	f	\N	\N	monthly	f	{}	0
194	6727220793	vmess	VMESS-6727220793-1746702976	2025-05-08 11:16:16.137067+00	2026-05-08 11:16:16.137044	Plan-9	vmess://eyJ2IjogIjIiLCAicHMiOiAiQmx1ZUh1YiIsICJhZGQiOiAiMTU3LjE4MC40NC4yNDIiLCAicG9ydCI6ICI4MDgwIiwgImlkIjogIjUxOTE0MjE3LTRlZDktNDNmNC04Yzk4LWYzMjQ5NzdmOTZkYiIsICJhaWQiOiAiMCIsICJuZXQiOiAid3MiLCAidHlwZSI6ICJub25lIiwgImhvc3QiOiBudWxsLCAicGF0aCI6IG51bGwsICJ0bHMiOiAidGxzIn0=	8080	51914217-4ed9-43f4-8c98-f324977f96db	t	805306368000	f	\N	\N	monthly	f	{}	0
195	2005217637	vless	trial-2005217637-1746725739	2025-05-08 17:35:39.865883+00	2025-05-09 17:35:39.865883	1d-0GB-trial	\N	443	6a3ed254-4747-46d7-879b-b53615158b7a	t	629145600	f	\N	\N	trial	t	{}	0
196	6875573318	vless	trial-6875573318-1746726283	2025-05-08 17:44:43.065166+00	2025-05-10 17:44:43.065166	2d-1GB-trial	\N	443	ac3fb560-95ca-481a-b2b4-b42ffa19c107	t	1073741824	f	\N	\N	trial	t	{}	0
197	6875573318	trojan	TROJAN-6875573318-1746733724	2025-05-08 19:48:44.566721+00	2025-06-07 19:48:44.566696	Plan-1	trojan://56f63150-ddf3-42c2-97fc-5077a6732ac0@157.180.44.242:2052?security=tls#BlueHub	2052	56f63150-ddf3-42c2-97fc-5077a6732ac0	t	32212254720	f	\N	\N	monthly	f	{}	0
\.


--
-- Data for Name: email_tokens; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.email_tokens (id, user_id, token, created_at, used) FROM stdin;
e29c0a75-4ae7-43a8-8a52-f1c4146c3503	2005217637	IjIwMDUyMTc2Mzci.aBzrUg.AyKDQsVGFbX2LukWoQW4E5hiQcs	2025-05-08 17:35:14.466455+00	t
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
3	157.180.44.242	2052	trojan	\N	\N	\N	\N	\N	\N
4	157.180.44.242	80	shadowsocks	\N	\N	\N	\N	\N	\N
2	157.180.44.242	443	vless	\N	\N	\N	\N	\N	\N
1	157.180.44.242	8080	vmess	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description, deposit_amount, trial_days, trial_volume) FROM stdin;
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at, type) FROM stdin;
1	Plan-30-1	30	30	60000	\N	t	2025-04-21 21:53:17.114763+00	monthly
2	Plan-50-1	30	50	90000	\N	t	2025-04-21 21:53:17.114768+00	monthly
3	Plan-80-1	30	80	130000	\N	t	2025-04-21 21:53:17.11477+00	monthly
4	Plan-140-3	90	140	180000	\N	t	2025-04-21 21:53:17.114771+00	monthly
5	Plan-220-3	90	220	260000	\N	t	2025-04-21 21:53:17.114772+00	monthly
6	Plan-250-6	180	250	290000	\N	t	2025-04-21 21:53:17.114774+00	monthly
7	Plan-400-6	180	400	430000	\N	t	2025-04-21 21:53:17.114775+00	monthly
8	Plan-600-12	365	600	590000	\N	t	2025-04-21 21:53:17.114777+00	monthly
9	Plan-750-12	365	750	690000	\N	t	2025-04-21 21:53:17.114778+00	monthly
10	Plan-Unlimited	365	\N	0	\N	t	2025-04-21 21:53:17.114779+00	monthly
\.


--
-- Data for Name: support_agents; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.support_agents (id, is_active, last_assigned_at) FROM stdin;
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: sarmad
--

COPY public.support_tickets (id, user_id, status, created_at, agent_id, question, sender_id) FROM stdin;
1	6727220793	open	2025-05-07 15:43:54.341795	\N	توضیحات کامل	\N
2	6727220793	open	2025-05-07 16:13:09.143445	\N	تیکت	\N
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
123456789	testuser	\N	0	\N	user	Test User	fa	f	2025-04-13 20:49:57.197418+00	\N	\N	\N	\N	f
8048396187	\N	\N	0	fa	user	\N	fa	f	2025-05-04 19:07:31.848303+00	\N	0	\N	\N	f
6875573318	\N	\N	0	fa	user	\N	fa	f	2025-04-19 19:24:44.790884+00	\N	\N	\N	\N	f
482463905	r2o2y6a8	\N	0	fa	user	\N	fa	f	2025-05-07 08:35:18.381942+00	\N	0	\N	\N	f
6727220793	S_afaf	\N	0	fa	user	\N	fa	f	2025-04-13 08:58:13.441817+00	\N	\N	\N	\N	f
2005217637	\N	\N	0	fa	user	\N	fa	f	2025-04-13 14:20:22.558079+00	\N	\N	\N	2025-05-08 17:35:39.189057+00	t
\.


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

SELECT pg_catalog.setval('public.config_v2ray_id_seq', 4, true);


--
-- Name: config_wireguard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);


--
-- Name: configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.configs_id_seq', 197, true);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 1, false);


--
-- Name: inbounds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.inbounds_id_seq', 4, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.plans_id_seq', 10, true);


--
-- Name: support_agents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.support_agents_id_seq', 1, false);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarmad
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 2, true);


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
-- Name: email_tokens email_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_token_key UNIQUE (token);


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
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: support_agents support_agents_pkey; Type: CONSTRAINT; Schema: public; Owner: sarmad
--

ALTER TABLE ONLY public.support_agents
    ADD CONSTRAINT support_agents_pkey PRIMARY KEY (id);


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
-- Name: ix_plans_id; Type: INDEX; Schema: public; Owner: sarmad
--

CREATE INDEX ix_plans_id ON public.plans USING btree (id);


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
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: sarmad
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO sarmad;


--
-- PostgreSQL database dump complete
--

