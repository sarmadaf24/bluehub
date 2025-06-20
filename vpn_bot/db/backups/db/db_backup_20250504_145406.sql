PGDMP      6                }            vpn_bot #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16390    vpn_bot    DATABASE     s   CREATE DATABASE vpn_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE vpn_bot;
                sarmad    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sarmad    false            �           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   sarmad    false    5            �           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   sarmad    false    5            �            1259    16392    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    sarmad    false    5                       1259    17044 
   audit_logs    TABLE     �   CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    user_id bigint,
    action character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.audit_logs;
       public         heap    sarmad    false    5            �           0    0    COLUMN audit_logs.user_id    COMMENT     [   COMMENT ON COLUMN public.audit_logs.user_id IS 'شناسه کاربری (اختیاری)';
          public          sarmad    false    264            �           0    0    COLUMN audit_logs.action    COMMENT     U   COMMENT ON COLUMN public.audit_logs.action IS 'عنوان یا نوع عملیات';
          public          sarmad    false    264            �           0    0    COLUMN audit_logs.metadata    COMMENT     T   COMMENT ON COLUMN public.audit_logs.metadata IS 'اطلاعات جانبی (JSON)';
          public          sarmad    false    264            �           0    0    COLUMN audit_logs.created_at    COMMENT     I   COMMENT ON COLUMN public.audit_logs.created_at IS 'زمان رخداد';
          public          sarmad    false    264                       1259    17043    audit_logs_id_seq    SEQUENCE     z   CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.audit_logs_id_seq;
       public          sarmad    false    5    264            �           0    0    audit_logs_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;
          public          sarmad    false    263            �            1259    16395    config_cisco    TABLE     *  CREATE TABLE public.config_cisco (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    group_name character varying,
    group_password character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.config_cisco;
       public         heap    sarmad    false    5            �            1259    16401    config_cisco_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_cisco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_cisco_id_seq;
       public          sarmad    false    5    216            �           0    0    config_cisco_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_cisco_id_seq OWNED BY public.config_cisco.id;
          public          sarmad    false    217            �            1259    16402    config_ikev2    TABLE     (  CREATE TABLE public.config_ikev2 (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    certificate character varying,
    private_key character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.config_ikev2;
       public         heap    sarmad    false    5            �            1259    16408    config_ikev2_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_ikev2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_ikev2_id_seq;
       public          sarmad    false    5    218            �           0    0    config_ikev2_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ikev2_id_seq OWNED BY public.config_ikev2.id;
          public          sarmad    false    219            �            1259    16409    config_ipsec    TABLE        CREATE TABLE public.config_ipsec (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    ike_version character varying,
    username character varying,
    password character varying,
    psk character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.config_ipsec;
       public         heap    sarmad    false    5            �            1259    16415    config_ipsec_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_ipsec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_ipsec_id_seq;
       public          sarmad    false    220    5            �           0    0    config_ipsec_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ipsec_id_seq OWNED BY public.config_ipsec.id;
          public          sarmad    false    221            �            1259    16416    config_l2tp    TABLE       CREATE TABLE public.config_l2tp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    shared_secret character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.config_l2tp;
       public         heap    sarmad    false    5            �            1259    16422    config_l2tp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_l2tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_l2tp_id_seq;
       public          sarmad    false    222    5            �           0    0    config_l2tp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_l2tp_id_seq OWNED BY public.config_l2tp.id;
          public          sarmad    false    223            �            1259    16423    config_openvpn    TABLE     H  CREATE TABLE public.config_openvpn (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    ca_cert character varying,
    client_cert character varying,
    client_key character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.config_openvpn;
       public         heap    sarmad    false    5            �            1259    16429    config_openvpn_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.config_openvpn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.config_openvpn_id_seq;
       public          sarmad    false    224    5            �           0    0    config_openvpn_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.config_openvpn_id_seq OWNED BY public.config_openvpn.id;
          public          sarmad    false    225            �            1259    16430    config_pptp    TABLE       CREATE TABLE public.config_pptp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    mppe_enabled character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.config_pptp;
       public         heap    sarmad    false    5            �            1259    16436    config_pptp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_pptp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_pptp_id_seq;
       public          sarmad    false    5    226            �           0    0    config_pptp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_pptp_id_seq OWNED BY public.config_pptp.id;
          public          sarmad    false    227            �            1259    16437    config_shadowsocks    TABLE       CREATE TABLE public.config_shadowsocks (
    id integer NOT NULL,
    config_id integer,
    address character varying NOT NULL,
    port integer NOT NULL,
    encryption character varying NOT NULL,
    password character varying NOT NULL,
    created_at timestamp without time zone
);
 &   DROP TABLE public.config_shadowsocks;
       public         heap    sarmad    false    5            �            1259    16442    config_shadowsocks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_shadowsocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.config_shadowsocks_id_seq;
       public          sarmad    false    228    5            �           0    0    config_shadowsocks_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.config_shadowsocks_id_seq OWNED BY public.config_shadowsocks.id;
          public          sarmad    false    229            �            1259    16443    config_sstp    TABLE     �   CREATE TABLE public.config_sstp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    cert character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.config_sstp;
       public         heap    sarmad    false    5            �            1259    16449    config_sstp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_sstp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_sstp_id_seq;
       public          sarmad    false    230    5            �           0    0    config_sstp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_sstp_id_seq OWNED BY public.config_sstp.id;
          public          sarmad    false    231            �            1259    16450    config_v2ray    TABLE        CREATE TABLE public.config_v2ray (
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
     DROP TABLE public.config_v2ray;
       public         heap    sarmad    false    5            �            1259    16456    config_v2ray_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_v2ray_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_v2ray_id_seq;
       public          sarmad    false    5    232            �           0    0    config_v2ray_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_v2ray_id_seq OWNED BY public.config_v2ray.id;
          public          sarmad    false    233            �            1259    16457    config_wireguard    TABLE     S  CREATE TABLE public.config_wireguard (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    private_key character varying,
    public_key character varying,
    preshared_key character varying,
    endpoint character varying,
    allowed_ips character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 $   DROP TABLE public.config_wireguard;
       public         heap    sarmad    false    5            �            1259    16463    config_wireguard_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_wireguard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.config_wireguard_id_seq;
       public          sarmad    false    5    234            �           0    0    config_wireguard_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.config_wireguard_id_seq OWNED BY public.config_wireguard.id;
          public          sarmad    false    235            �            1259    16464    configs    TABLE     �  CREATE TABLE public.configs (
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
    used_bytes bigint DEFAULT '0'::bigint,
    reset_period interval,
    last_reset_at timestamp without time zone,
    plan_type character varying DEFAULT 'monthly'::character varying NOT NULL,
    is_trial boolean DEFAULT false,
    extra_metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);
    DROP TABLE public.configs;
       public         heap    sarmad    false    5            �           0    0    COLUMN configs.transfer_enable    COMMENT     f   COMMENT ON COLUMN public.configs.transfer_enable IS 'حجم کل مجاز (بایت); None=infinite';
          public          sarmad    false    236            �           0    0 !   COLUMN configs.feedback_requested    COMMENT     �   COMMENT ON COLUMN public.configs.feedback_requested IS 'آیا برای این کانفیگ فیدبک درخواست شده؟';
          public          sarmad    false    236            �           0    0    COLUMN configs.used_bytes    COMMENT     X   COMMENT ON COLUMN public.configs.used_bytes IS 'حجم مصرف‌شده تاکنون';
          public          sarmad    false    236            �           0    0    COLUMN configs.reset_period    COMMENT     �   COMMENT ON COLUMN public.configs.reset_period IS 'فاصله دوره‌ای ری‌ست ترافیک (مثلاً ماهانه)';
          public          sarmad    false    236            �           0    0    COLUMN configs.last_reset_at    COMMENT     U   COMMENT ON COLUMN public.configs.last_reset_at IS 'آخرین زمان ری‌ست';
          public          sarmad    false    236            �           0    0    COLUMN configs.plan_type    COMMENT     I   COMMENT ON COLUMN public.configs.plan_type IS 'monthly/unlimited/trial';
          public          sarmad    false    236            �           0    0    COLUMN configs.extra_metadata    COMMENT     p   COMMENT ON COLUMN public.configs.extra_metadata IS 'ابر‌داده برای توسعه‌های آینده';
          public          sarmad    false    236            �            1259    16470    configs_id_seq    SEQUENCE     w   CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.configs_id_seq;
       public          sarmad    false    5    236            �           0    0    configs_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;
          public          sarmad    false    237                       1259    17028    currency_rates    TABLE     �  CREATE TABLE public.currency_rates (
    id bigint NOT NULL,
    currency character varying NOT NULL,
    base_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    rate double precision NOT NULL,
    provider character varying DEFAULT 'exchangerate-api'::character varying NOT NULL,
    fetched_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    raw_response jsonb DEFAULT '{}'::jsonb NOT NULL
);
 "   DROP TABLE public.currency_rates;
       public         heap    sarmad    false    5                       1259    17027    currency_rates_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.currency_rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.currency_rates_id_seq;
       public          sarmad    false    262    5            �           0    0    currency_rates_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.currency_rates_id_seq OWNED BY public.currency_rates.id;
          public          sarmad    false    261            �            1259    16834    email_tokens    TABLE        CREATE TABLE public.email_tokens (
    id character varying NOT NULL,
    user_id bigint NOT NULL,
    token character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    used boolean DEFAULT false NOT NULL
);
     DROP TABLE public.email_tokens;
       public         heap    sarmad    false    5            �           0    0    COLUMN email_tokens.id    COMMENT     C   COMMENT ON COLUMN public.email_tokens.id IS 'UUID for this token';
          public          sarmad    false    252            �           0    0    COLUMN email_tokens.user_id    COMMENT     O   COMMENT ON COLUMN public.email_tokens.user_id IS 'Reference to users.user_id';
          public          sarmad    false    252            �           0    0    COLUMN email_tokens.token    COMMENT     ?   COMMENT ON COLUMN public.email_tokens.token IS 'Signed token';
          public          sarmad    false    252            �            1259    16721 	   feedbacks    TABLE       CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    config_id integer NOT NULL,
    is_satisfied boolean NOT NULL,
    feedback_text character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.feedbacks;
       public         heap    sarmad    false    5            �           0    0    COLUMN feedbacks.is_satisfied    COMMENT     Z   COMMENT ON COLUMN public.feedbacks.is_satisfied IS 'آیا کاربر راضی بود؟';
          public          sarmad    false    251            �           0    0    COLUMN feedbacks.feedback_text    COMMENT     X   COMMENT ON COLUMN public.feedbacks.feedback_text IS 'متن بازخورد کاربر';
          public          sarmad    false    251            �            1259    16720    feedbacks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.feedbacks_id_seq;
       public          sarmad    false    5    251            �           0    0    feedbacks_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;
          public          sarmad    false    250            �            1259    16471    inbounds    TABLE     Y  CREATE TABLE public.inbounds (
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
    DROP TABLE public.inbounds;
       public         heap    sarmad    false    5            �            1259    16476    inbounds_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inbounds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.inbounds_id_seq;
       public          sarmad    false    5    238            �           0    0    inbounds_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.inbounds_id_seq OWNED BY public.inbounds.id;
          public          sarmad    false    239            �            1259    16477    orders    TABLE     \  CREATE TABLE public.orders (
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
    DROP TABLE public.orders;
       public         heap    sarmad    false    5            �           0    0    COLUMN orders.deposit_amount    COMMENT     u   COMMENT ON COLUMN public.orders.deposit_amount IS 'مبلغ ودیعه/پیش‌پرداخت (تومان/دلار)';
          public          sarmad    false    240            �           0    0    COLUMN orders.trial_days    COMMENT     L   COMMENT ON COLUMN public.orders.trial_days IS 'مدت تریال (روز)';
          public          sarmad    false    240            �           0    0    COLUMN orders.trial_volume    COMMENT     P   COMMENT ON COLUMN public.orders.trial_volume IS 'حجم تریال (بایت)';
          public          sarmad    false    240            �            1259    16483    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          sarmad    false    5    240            �           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          sarmad    false    241            
           1259    17055    payment_requests    TABLE     �  CREATE TABLE public.payment_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    amount integer NOT NULL,
    currency character varying NOT NULL,
    gateway character varying NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 $   DROP TABLE public.payment_requests;
       public         heap    sarmad    false    5            �           0    0    COLUMN payment_requests.gateway    COMMENT     O   COMMENT ON COLUMN public.payment_requests.gateway IS 'zarinpal/paypal/crypto';
          public          sarmad    false    266            �           0    0    COLUMN payment_requests.status    COMMENT     K   COMMENT ON COLUMN public.payment_requests.status IS 'pending/paid/failed';
          public          sarmad    false    266            	           1259    17054    payment_requests_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payment_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.payment_requests_id_seq;
       public          sarmad    false    266    5            �           0    0    payment_requests_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.payment_requests_id_seq OWNED BY public.payment_requests.id;
          public          sarmad    false    265            �            1259    16484    plans    TABLE     r  CREATE TABLE public.plans (
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
    DROP TABLE public.plans;
       public         heap    sarmad    false    5            �           0    0    COLUMN plans.name    COMMENT     8   COMMENT ON COLUMN public.plans.name IS 'نام پلن';
          public          sarmad    false    242            �           0    0    COLUMN plans.duration_days    COMMENT     O   COMMENT ON COLUMN public.plans.duration_days IS 'مدت زمان به روز';
          public          sarmad    false    242            �           0    0    COLUMN plans.volume_gb    COMMENT     c   COMMENT ON COLUMN public.plans.volume_gb IS 'حجم به گیگابایت; None = نامحدود';
          public          sarmad    false    242            �           0    0    COLUMN plans.price    COMMENT     F   COMMENT ON COLUMN public.plans.price IS 'قیمت (به تومان)';
          public          sarmad    false    242            �           0    0    COLUMN plans.description    COMMENT     O   COMMENT ON COLUMN public.plans.description IS 'توضیحات اختیاری';
          public          sarmad    false    242            �           0    0    COLUMN plans.is_active    COMMENT     O   COMMENT ON COLUMN public.plans.is_active IS 'آیا پلن فعال است؟';
          public          sarmad    false    242            �           0    0    COLUMN plans.type    COMMENT     Q   COMMENT ON COLUMN public.plans.type IS 'نوع پلن: monthly/unlimited/trial';
          public          sarmad    false    242            �            1259    16489    plans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.plans_id_seq;
       public          sarmad    false    242    5            �           0    0    plans_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;
          public          sarmad    false    243            �            1259    16947    support_agents    TABLE     �   CREATE TABLE public.support_agents (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    is_active boolean NOT NULL,
    last_assigned_at timestamp without time zone DEFAULT now() NOT NULL
);
 "   DROP TABLE public.support_agents;
       public         heap    sarmad    false    5            �            1259    16946    support_agents_id_seq    SEQUENCE     �   CREATE SEQUENCE public.support_agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.support_agents_id_seq;
       public          sarmad    false    254    5            �           0    0    support_agents_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.support_agents_id_seq OWNED BY public.support_agents.id;
          public          sarmad    false    253                       1259    16973    support_messages    TABLE     �   CREATE TABLE public.support_messages (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    from_user character varying(5) NOT NULL,
    content text NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);
 $   DROP TABLE public.support_messages;
       public         heap    sarmad    false    5                       1259    16972    support_messages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.support_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.support_messages_id_seq;
       public          sarmad    false    5    258            �           0    0    support_messages_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.support_messages_id_seq OWNED BY public.support_messages.id;
          public          sarmad    false    257                        1259    16957    support_tickets    TABLE       CREATE TABLE public.support_tickets (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    agent_id integer,
    question text DEFAULT ''::text NOT NULL
);
 #   DROP TABLE public.support_tickets;
       public         heap    sarmad    false    5            �            1259    16956    support_tickets_id_seq    SEQUENCE     �   CREATE SEQUENCE public.support_tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.support_tickets_id_seq;
       public          sarmad    false    256    5            �           0    0    support_tickets_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.support_tickets_id_seq OWNED BY public.support_tickets.id;
          public          sarmad    false    255            �            1259    16496    tickets    TABLE     0  CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    user_id bigint NOT NULL,
    message character varying NOT NULL,
    response character varying,
    status character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    answered_at timestamp with time zone
);
    DROP TABLE public.tickets;
       public         heap    sarmad    false    5            �            1259    16502    tickets_ticket_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tickets_ticket_id_seq;
       public          sarmad    false    5    244            �           0    0    tickets_ticket_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;
          public          sarmad    false    245                       1259    16994    traffic_records    TABLE     J  CREATE TABLE public.traffic_records (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    config_id bigint NOT NULL,
    category character varying NOT NULL,
    bytes_used bigint NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    extra_metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);
 #   DROP TABLE public.traffic_records;
       public         heap    sarmad    false    5            �           0    0    COLUMN traffic_records.category    COMMENT     M   COMMENT ON COLUMN public.traffic_records.category IS 'social/youtube/other';
          public          sarmad    false    260                       1259    16993    traffic_records_id_seq    SEQUENCE     �   CREATE SEQUENCE public.traffic_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.traffic_records_id_seq;
       public          sarmad    false    5    260            �           0    0    traffic_records_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.traffic_records_id_seq OWNED BY public.traffic_records.id;
          public          sarmad    false    259            �            1259    16503    transactions    TABLE     |  CREATE TABLE public.transactions (
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
     DROP TABLE public.transactions;
       public         heap    sarmad    false    5            �            1259    16509    transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.transactions_id_seq;
       public          sarmad    false    5    246            �           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public          sarmad    false    247            �            1259    16510    users    TABLE       CREATE TABLE public.users (
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
    DROP TABLE public.users;
       public         heap    sarmad    false    5            �           0    0    COLUMN users.balance    COMMENT     k   COMMENT ON COLUMN public.users.balance IS 'موجودی کیف‌پول کاربر (تومان/دلار)';
          public          sarmad    false    248            �           0    0    COLUMN users.referrer_id    COMMENT     h   COMMENT ON COLUMN public.users.referrer_id IS 'کاربری که این فرد را دعوت کرده';
          public          sarmad    false    248            �           0    0 !   COLUMN users.total_referral_bonus    COMMENT     �   COMMENT ON COLUMN public.users.total_referral_bonus IS 'مجموع بونوس‌های دریافتی از زیرمجموعه‌ها';
          public          sarmad    false    248            �           0    0    COLUMN users.trial_used    COMMENT     w   COMMENT ON COLUMN public.users.trial_used IS 'آیا کاربر تریال را قبلاً استفاده کرده؟';
          public          sarmad    false    248            �            1259    16516    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          sarmad    false    5    248            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          sarmad    false    249            k           2604    17047    audit_logs id    DEFAULT     n   ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);
 <   ALTER TABLE public.audit_logs ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    264    263    264            2           2604    16517    config_cisco id    DEFAULT     r   ALTER TABLE ONLY public.config_cisco ALTER COLUMN id SET DEFAULT nextval('public.config_cisco_id_seq'::regclass);
 >   ALTER TABLE public.config_cisco ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    217    216            4           2604    16518    config_ikev2 id    DEFAULT     r   ALTER TABLE ONLY public.config_ikev2 ALTER COLUMN id SET DEFAULT nextval('public.config_ikev2_id_seq'::regclass);
 >   ALTER TABLE public.config_ikev2 ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    219    218            6           2604    16519    config_ipsec id    DEFAULT     r   ALTER TABLE ONLY public.config_ipsec ALTER COLUMN id SET DEFAULT nextval('public.config_ipsec_id_seq'::regclass);
 >   ALTER TABLE public.config_ipsec ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    221    220            8           2604    16520    config_l2tp id    DEFAULT     p   ALTER TABLE ONLY public.config_l2tp ALTER COLUMN id SET DEFAULT nextval('public.config_l2tp_id_seq'::regclass);
 =   ALTER TABLE public.config_l2tp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    223    222            :           2604    16521    config_openvpn id    DEFAULT     v   ALTER TABLE ONLY public.config_openvpn ALTER COLUMN id SET DEFAULT nextval('public.config_openvpn_id_seq'::regclass);
 @   ALTER TABLE public.config_openvpn ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    225    224            <           2604    16522    config_pptp id    DEFAULT     p   ALTER TABLE ONLY public.config_pptp ALTER COLUMN id SET DEFAULT nextval('public.config_pptp_id_seq'::regclass);
 =   ALTER TABLE public.config_pptp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    227    226            >           2604    16523    config_shadowsocks id    DEFAULT     ~   ALTER TABLE ONLY public.config_shadowsocks ALTER COLUMN id SET DEFAULT nextval('public.config_shadowsocks_id_seq'::regclass);
 D   ALTER TABLE public.config_shadowsocks ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    229    228            ?           2604    16524    config_sstp id    DEFAULT     p   ALTER TABLE ONLY public.config_sstp ALTER COLUMN id SET DEFAULT nextval('public.config_sstp_id_seq'::regclass);
 =   ALTER TABLE public.config_sstp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    231    230            A           2604    16525    config_v2ray id    DEFAULT     r   ALTER TABLE ONLY public.config_v2ray ALTER COLUMN id SET DEFAULT nextval('public.config_v2ray_id_seq'::regclass);
 >   ALTER TABLE public.config_v2ray ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    233    232            C           2604    16526    config_wireguard id    DEFAULT     z   ALTER TABLE ONLY public.config_wireguard ALTER COLUMN id SET DEFAULT nextval('public.config_wireguard_id_seq'::regclass);
 B   ALTER TABLE public.config_wireguard ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    235    234            E           2604    16527 
   configs id    DEFAULT     h   ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);
 9   ALTER TABLE public.configs ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    237    236            f           2604    17031    currency_rates id    DEFAULT     v   ALTER TABLE ONLY public.currency_rates ALTER COLUMN id SET DEFAULT nextval('public.currency_rates_id_seq'::regclass);
 @   ALTER TABLE public.currency_rates ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    261    262    262            X           2604    16724    feedbacks id    DEFAULT     l   ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);
 ;   ALTER TABLE public.feedbacks ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    250    251    251            L           2604    16528    inbounds id    DEFAULT     j   ALTER TABLE ONLY public.inbounds ALTER COLUMN id SET DEFAULT nextval('public.inbounds_id_seq'::regclass);
 :   ALTER TABLE public.inbounds ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    239    238            M           2604    16529 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    241    240            n           2604    17058    payment_requests id    DEFAULT     z   ALTER TABLE ONLY public.payment_requests ALTER COLUMN id SET DEFAULT nextval('public.payment_requests_id_seq'::regclass);
 B   ALTER TABLE public.payment_requests ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    265    266    266            O           2604    16530    plans id    DEFAULT     d   ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);
 7   ALTER TABLE public.plans ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    243    242            \           2604    16950    support_agents id    DEFAULT     v   ALTER TABLE ONLY public.support_agents ALTER COLUMN id SET DEFAULT nextval('public.support_agents_id_seq'::regclass);
 @   ALTER TABLE public.support_agents ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    254    253    254            a           2604    16976    support_messages id    DEFAULT     z   ALTER TABLE ONLY public.support_messages ALTER COLUMN id SET DEFAULT nextval('public.support_messages_id_seq'::regclass);
 B   ALTER TABLE public.support_messages ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    257    258    258            ^           2604    16960    support_tickets id    DEFAULT     x   ALTER TABLE ONLY public.support_tickets ALTER COLUMN id SET DEFAULT nextval('public.support_tickets_id_seq'::regclass);
 A   ALTER TABLE public.support_tickets ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    255    256    256            Q           2604    16532    tickets ticket_id    DEFAULT     v   ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);
 @   ALTER TABLE public.tickets ALTER COLUMN ticket_id DROP DEFAULT;
       public          sarmad    false    245    244            c           2604    16997    traffic_records id    DEFAULT     x   ALTER TABLE ONLY public.traffic_records ALTER COLUMN id SET DEFAULT nextval('public.traffic_records_id_seq'::regclass);
 A   ALTER TABLE public.traffic_records ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    260    259    260            S           2604    16533    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    247    246            U           2604    16534    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          sarmad    false    249    248            h          0    16392    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          sarmad    false    215   +D      �          0    17044 
   audit_logs 
   TABLE DATA           O   COPY public.audit_logs (id, user_id, action, metadata, created_at) FROM stdin;
    public          sarmad    false    264   UD      i          0    16395    config_cisco 
   TABLE DATA           q   COPY public.config_cisco (id, config_id, username, password, group_name, group_password, created_at) FROM stdin;
    public          sarmad    false    216   rD      k          0    16402    config_ikev2 
   TABLE DATA           o   COPY public.config_ikev2 (id, config_id, username, password, certificate, private_key, created_at) FROM stdin;
    public          sarmad    false    218   �D      m          0    16409    config_ipsec 
   TABLE DATA           g   COPY public.config_ipsec (id, config_id, ike_version, username, password, psk, created_at) FROM stdin;
    public          sarmad    false    220   �D      o          0    16416    config_l2tp 
   TABLE DATA           c   COPY public.config_l2tp (id, config_id, username, password, shared_secret, created_at) FROM stdin;
    public          sarmad    false    222   �D      q          0    16423    config_openvpn 
   TABLE DATA           y   COPY public.config_openvpn (id, config_id, username, password, ca_cert, client_cert, client_key, created_at) FROM stdin;
    public          sarmad    false    224   �D      s          0    16430    config_pptp 
   TABLE DATA           b   COPY public.config_pptp (id, config_id, username, password, mppe_enabled, created_at) FROM stdin;
    public          sarmad    false    226   E      u          0    16437    config_shadowsocks 
   TABLE DATA           l   COPY public.config_shadowsocks (id, config_id, address, port, encryption, password, created_at) FROM stdin;
    public          sarmad    false    228    E      w          0    16443    config_sstp 
   TABLE DATA           Z   COPY public.config_sstp (id, config_id, username, password, cert, created_at) FROM stdin;
    public          sarmad    false    230   =E      y          0    16450    config_v2ray 
   TABLE DATA           �   COPY public.config_v2ray (id, config_id, server, port, uuid, encryption, password, alter_id, security, network, path, host, sni, created_at, address) FROM stdin;
    public          sarmad    false    232   ZE      {          0    16457    config_wireguard 
   TABLE DATA           �   COPY public.config_wireguard (id, config_id, private_key, public_key, preshared_key, endpoint, allowed_ips, created_at) FROM stdin;
    public          sarmad    false    234   wE      }          0    16464    configs 
   TABLE DATA           �   COPY public.configs (id, user_id, protocol, name, created_at, expiration_date, config_name, domain, port, uuid, active, transfer_enable, feedback_requested, used_bytes, reset_period, last_reset_at, plan_type, is_trial, extra_metadata) FROM stdin;
    public          sarmad    false    236   �E      �          0    17028    currency_rates 
   TABLE DATA           {   COPY public.currency_rates (id, currency, base_currency, rate, provider, fetched_at, expires_at, raw_response) FROM stdin;
    public          sarmad    false    262   K      �          0    16834    email_tokens 
   TABLE DATA           L   COPY public.email_tokens (id, user_id, token, created_at, used) FROM stdin;
    public          sarmad    false    252   $K      �          0    16721 	   feedbacks 
   TABLE DATA           d   COPY public.feedbacks (id, user_id, config_id, is_satisfied, feedback_text, created_at) FROM stdin;
    public          sarmad    false    251   �K                0    16471    inbounds 
   TABLE DATA           n   COPY public.inbounds (id, server, port, protocol, encryption, password, network, path, host, sni) FROM stdin;
    public          sarmad    false    238   �K      �          0    16477    orders 
   TABLE DATA           �   COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description, deposit_amount, trial_days, trial_volume) FROM stdin;
    public          sarmad    false    240   AL      �          0    17055    payment_requests 
   TABLE DATA           o   COPY public.payment_requests (id, user_id, plan_id, amount, currency, gateway, status, created_at) FROM stdin;
    public          sarmad    false    266   ^L      �          0    16484    plans 
   TABLE DATA           t   COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at, type) FROM stdin;
    public          sarmad    false    242   {L      �          0    16947    support_agents 
   TABLE DATA           R   COPY public.support_agents (id, user_id, is_active, last_assigned_at) FROM stdin;
    public          sarmad    false    254   \M      �          0    16973    support_messages 
   TABLE DATA           Z   COPY public.support_messages (id, ticket_id, from_user, content, "timestamp") FROM stdin;
    public          sarmad    false    258   yM      �          0    16957    support_tickets 
   TABLE DATA           ^   COPY public.support_tickets (id, user_id, status, created_at, agent_id, question) FROM stdin;
    public          sarmad    false    256   �M      �          0    16496    tickets 
   TABLE DATA           i   COPY public.tickets (ticket_id, user_id, message, response, status, created_at, answered_at) FROM stdin;
    public          sarmad    false    244   �M      �          0    16994    traffic_records 
   TABLE DATA           t   COPY public.traffic_records (id, user_id, config_id, category, bytes_used, "timestamp", extra_metadata) FROM stdin;
    public          sarmad    false    260   �M      �          0    16503    transactions 
   TABLE DATA           |   COPY public.transactions (id, user_id, plan_id, amount, currency, status, gateway, reference, type, created_at) FROM stdin;
    public          sarmad    false    246   �M      �          0    16510    users 
   TABLE DATA           �   COPY public.users (user_id, username, phone, balance, lang, role, full_name, language_code, is_admin, created_at, referrer_id, total_referral_bonus, email, email_verified_at, trial_used) FROM stdin;
    public          sarmad    false    248   
N      �           0    0    audit_logs_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.audit_logs_id_seq', 1, false);
          public          sarmad    false    263            �           0    0    config_cisco_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_cisco_id_seq', 1, false);
          public          sarmad    false    217            �           0    0    config_ikev2_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ikev2_id_seq', 1, false);
          public          sarmad    false    219            �           0    0    config_ipsec_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ipsec_id_seq', 1, false);
          public          sarmad    false    221            �           0    0    config_l2tp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_l2tp_id_seq', 1, false);
          public          sarmad    false    223            �           0    0    config_openvpn_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.config_openvpn_id_seq', 1, false);
          public          sarmad    false    225            �           0    0    config_pptp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_pptp_id_seq', 1, false);
          public          sarmad    false    227            �           0    0    config_shadowsocks_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.config_shadowsocks_id_seq', 1, false);
          public          sarmad    false    229            �           0    0    config_sstp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_sstp_id_seq', 1, false);
          public          sarmad    false    231            �           0    0    config_v2ray_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_v2ray_id_seq', 4, true);
          public          sarmad    false    233            �           0    0    config_wireguard_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);
          public          sarmad    false    235            �           0    0    configs_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.configs_id_seq', 177, true);
          public          sarmad    false    237            �           0    0    currency_rates_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.currency_rates_id_seq', 1, false);
          public          sarmad    false    261            �           0    0    feedbacks_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.feedbacks_id_seq', 1, false);
          public          sarmad    false    250            �           0    0    inbounds_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.inbounds_id_seq', 4, true);
          public          sarmad    false    239            �           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public          sarmad    false    241            �           0    0    payment_requests_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.payment_requests_id_seq', 1, false);
          public          sarmad    false    265            �           0    0    plans_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.plans_id_seq', 10, true);
          public          sarmad    false    243            �           0    0    support_agents_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.support_agents_id_seq', 1, false);
          public          sarmad    false    253            �           0    0    support_messages_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.support_messages_id_seq', 1, false);
          public          sarmad    false    257            �           0    0    support_tickets_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.support_tickets_id_seq', 1, false);
          public          sarmad    false    255            �           0    0    tickets_ticket_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);
          public          sarmad    false    245            �           0    0    traffic_records_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.traffic_records_id_seq', 1, false);
          public          sarmad    false    259            �           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);
          public          sarmad    false    247            �           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          sarmad    false    249            r           2606    16536 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            sarmad    false    215            �           2606    17053    audit_logs audit_logs_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.audit_logs DROP CONSTRAINT audit_logs_pkey;
       public            sarmad    false    264            t           2606    16538    config_cisco config_cisco_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_pkey;
       public            sarmad    false    216            v           2606    16540    config_ikev2 config_ikev2_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_pkey;
       public            sarmad    false    218            x           2606    16542    config_ipsec config_ipsec_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_pkey;
       public            sarmad    false    220            z           2606    16544    config_l2tp config_l2tp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_pkey;
       public            sarmad    false    222            |           2606    16546 "   config_openvpn config_openvpn_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_pkey;
       public            sarmad    false    224            ~           2606    16548    config_pptp config_pptp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_pkey;
       public            sarmad    false    226            �           2606    16550 *   config_shadowsocks config_shadowsocks_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_pkey;
       public            sarmad    false    228            �           2606    16552    config_sstp config_sstp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_pkey;
       public            sarmad    false    230            �           2606    16554    config_v2ray config_v2ray_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_pkey;
       public            sarmad    false    232            �           2606    16556 &   config_wireguard config_wireguard_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_pkey;
       public            sarmad    false    234            �           2606    16558    configs configs_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_pkey;
       public            sarmad    false    236            �           2606    17041 *   currency_rates currency_rates_currency_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_currency_key UNIQUE (currency);
 T   ALTER TABLE ONLY public.currency_rates DROP CONSTRAINT currency_rates_currency_key;
       public            sarmad    false    262            �           2606    17039 "   currency_rates currency_rates_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.currency_rates DROP CONSTRAINT currency_rates_pkey;
       public            sarmad    false    262            �           2606    16842    email_tokens email_tokens_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.email_tokens DROP CONSTRAINT email_tokens_pkey;
       public            sarmad    false    252            �           2606    16896 #   email_tokens email_tokens_token_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_token_key UNIQUE (token);
 M   ALTER TABLE ONLY public.email_tokens DROP CONSTRAINT email_tokens_token_key;
       public            sarmad    false    252            �           2606    16729    feedbacks feedbacks_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_pkey;
       public            sarmad    false    251            �           2606    16560    inbounds inbounds_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.inbounds
    ADD CONSTRAINT inbounds_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.inbounds DROP CONSTRAINT inbounds_pkey;
       public            sarmad    false    238            �           2606    16562    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            sarmad    false    240            �           2606    17064 &   payment_requests payment_requests_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.payment_requests
    ADD CONSTRAINT payment_requests_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.payment_requests DROP CONSTRAINT payment_requests_pkey;
       public            sarmad    false    266            �           2606    16564    plans plans_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_pkey;
       public            sarmad    false    242            �           2606    16953 "   support_agents support_agents_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.support_agents
    ADD CONSTRAINT support_agents_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.support_agents DROP CONSTRAINT support_agents_pkey;
       public            sarmad    false    254            �           2606    16955 )   support_agents support_agents_user_id_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.support_agents
    ADD CONSTRAINT support_agents_user_id_key UNIQUE (user_id);
 S   ALTER TABLE ONLY public.support_agents DROP CONSTRAINT support_agents_user_id_key;
       public            sarmad    false    254            �           2606    16981 &   support_messages support_messages_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.support_messages DROP CONSTRAINT support_messages_pkey;
       public            sarmad    false    258            �           2606    16966 $   support_tickets support_tickets_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.support_tickets DROP CONSTRAINT support_tickets_pkey;
       public            sarmad    false    256            �           2606    16568    tickets tickets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public            sarmad    false    244            �           2606    17003 $   traffic_records traffic_records_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.traffic_records
    ADD CONSTRAINT traffic_records_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.traffic_records DROP CONSTRAINT traffic_records_pkey;
       public            sarmad    false    260            �           2606    16570    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            sarmad    false    246            �           2606    16572    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sarmad    false    248            �           1259    16849    ix_email_tokens_user_id    INDEX     S   CREATE INDEX ix_email_tokens_user_id ON public.email_tokens USING btree (user_id);
 +   DROP INDEX public.ix_email_tokens_user_id;
       public            sarmad    false    252            �           1259    16740    ix_feedbacks_config_id    INDEX     Q   CREATE INDEX ix_feedbacks_config_id ON public.feedbacks USING btree (config_id);
 *   DROP INDEX public.ix_feedbacks_config_id;
       public            sarmad    false    251            �           1259    16741    ix_feedbacks_id    INDEX     C   CREATE INDEX ix_feedbacks_id ON public.feedbacks USING btree (id);
 #   DROP INDEX public.ix_feedbacks_id;
       public            sarmad    false    251            �           1259    16742    ix_feedbacks_user_id    INDEX     M   CREATE INDEX ix_feedbacks_user_id ON public.feedbacks USING btree (user_id);
 (   DROP INDEX public.ix_feedbacks_user_id;
       public            sarmad    false    251            �           1259    16573    ix_order_user_plan    INDEX     Q   CREATE INDEX ix_order_user_plan ON public.orders USING btree (user_id, plan_id);
 &   DROP INDEX public.ix_order_user_plan;
       public            sarmad    false    240    240            �           1259    16574    ix_orders_id    INDEX     =   CREATE INDEX ix_orders_id ON public.orders USING btree (id);
     DROP INDEX public.ix_orders_id;
       public            sarmad    false    240            �           1259    16575    ix_orders_plan_id    INDEX     G   CREATE INDEX ix_orders_plan_id ON public.orders USING btree (plan_id);
 %   DROP INDEX public.ix_orders_plan_id;
       public            sarmad    false    240            �           1259    16576    ix_orders_user_id    INDEX     G   CREATE INDEX ix_orders_user_id ON public.orders USING btree (user_id);
 %   DROP INDEX public.ix_orders_user_id;
       public            sarmad    false    240            �           1259    17042    ix_plans_id    INDEX     ;   CREATE INDEX ix_plans_id ON public.plans USING btree (id);
    DROP INDEX public.ix_plans_id;
       public            sarmad    false    242            �           1259    16578    ix_ticket_user_status    INDEX     T   CREATE INDEX ix_ticket_user_status ON public.tickets USING btree (user_id, status);
 )   DROP INDEX public.ix_ticket_user_status;
       public            sarmad    false    244    244            �           1259    16579    ix_tickets_ticket_id    INDEX     M   CREATE INDEX ix_tickets_ticket_id ON public.tickets USING btree (ticket_id);
 (   DROP INDEX public.ix_tickets_ticket_id;
       public            sarmad    false    244            �           1259    16580    ix_transaction_user_status    INDEX     ^   CREATE INDEX ix_transaction_user_status ON public.transactions USING btree (user_id, status);
 .   DROP INDEX public.ix_transaction_user_status;
       public            sarmad    false    246    246            �           1259    16581    ix_transactions_id    INDEX     I   CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);
 &   DROP INDEX public.ix_transactions_id;
       public            sarmad    false    246            �           1259    16582    ix_user_username_phone    INDEX     S   CREATE INDEX ix_user_username_phone ON public.users USING btree (username, phone);
 *   DROP INDEX public.ix_user_username_phone;
       public            sarmad    false    248    248            �           1259    16851    ix_users_email    INDEX     H   CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);
 "   DROP INDEX public.ix_users_email;
       public            sarmad    false    248            �           1259    16583    ix_users_lang    INDEX     ?   CREATE INDEX ix_users_lang ON public.users USING btree (lang);
 !   DROP INDEX public.ix_users_lang;
       public            sarmad    false    248            �           1259    16691    ix_users_referrer_id    INDEX     M   CREATE INDEX ix_users_referrer_id ON public.users USING btree (referrer_id);
 (   DROP INDEX public.ix_users_referrer_id;
       public            sarmad    false    248            �           1259    16584    ix_users_role    INDEX     ?   CREATE INDEX ix_users_role ON public.users USING btree (role);
 !   DROP INDEX public.ix_users_role;
       public            sarmad    false    248            �           2606    16585 (   config_cisco config_cisco_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_config_id_fkey;
       public          sarmad    false    216    236    3464            �           2606    16590 (   config_ikev2 config_ikev2_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_config_id_fkey;
       public          sarmad    false    3464    218    236            �           2606    16595 (   config_ipsec config_ipsec_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_config_id_fkey;
       public          sarmad    false    236    3464    220            �           2606    16600 &   config_l2tp config_l2tp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_config_id_fkey;
       public          sarmad    false    236    3464    222            �           2606    16605 ,   config_openvpn config_openvpn_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_config_id_fkey;
       public          sarmad    false    224    3464    236            �           2606    16610 &   config_pptp config_pptp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_config_id_fkey;
       public          sarmad    false    226    236    3464            �           2606    16615 4   config_shadowsocks config_shadowsocks_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 ^   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_config_id_fkey;
       public          sarmad    false    228    236    3464            �           2606    16620 &   config_sstp config_sstp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_config_id_fkey;
       public          sarmad    false    3464    230    236            �           2606    16625 (   config_v2ray config_v2ray_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_config_id_fkey;
       public          sarmad    false    236    3464    232            �           2606    16630 0   config_wireguard config_wireguard_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_config_id_fkey;
       public          sarmad    false    3464    234    236            �           2606    16635    configs configs_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_user_id_fkey;
       public          sarmad    false    248    3490    236            �           2606    16843 &   email_tokens email_tokens_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.email_tokens DROP CONSTRAINT email_tokens_user_id_fkey;
       public          sarmad    false    3490    248    252            �           2606    16730 "   feedbacks feedbacks_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 L   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_config_id_fkey;
       public          sarmad    false    3464    251    236            �           2606    16735     feedbacks feedbacks_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_user_id_fkey;
       public          sarmad    false    3490    251    248            �           2606    16640    orders orders_plan_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_plan_id_fkey;
       public          sarmad    false    240    242    3475            �           2606    16645    orders orders_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          sarmad    false    3490    248    240            �           2606    17070 .   payment_requests payment_requests_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_requests
    ADD CONSTRAINT payment_requests_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 X   ALTER TABLE ONLY public.payment_requests DROP CONSTRAINT payment_requests_plan_id_fkey;
       public          sarmad    false    242    3475    266            �           2606    17065 .   payment_requests payment_requests_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_requests
    ADD CONSTRAINT payment_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 X   ALTER TABLE ONLY public.payment_requests DROP CONSTRAINT payment_requests_user_id_fkey;
       public          sarmad    false    266    3490    248            �           2606    16982 0   support_messages support_messages_ticket_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.support_tickets(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.support_messages DROP CONSTRAINT support_messages_ticket_id_fkey;
       public          sarmad    false    256    3506    258            �           2606    16967 -   support_tickets support_tickets_agent_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.support_agents(id);
 W   ALTER TABLE ONLY public.support_tickets DROP CONSTRAINT support_tickets_agent_id_fkey;
       public          sarmad    false    256    254    3502            �           2606    16650    tickets tickets_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_user_id_fkey;
       public          sarmad    false    3490    244    248            �           2606    17009 .   traffic_records traffic_records_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.traffic_records
    ADD CONSTRAINT traffic_records_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 X   ALTER TABLE ONLY public.traffic_records DROP CONSTRAINT traffic_records_config_id_fkey;
       public          sarmad    false    260    236    3464            �           2606    17004 ,   traffic_records traffic_records_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.traffic_records
    ADD CONSTRAINT traffic_records_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 V   ALTER TABLE ONLY public.traffic_records DROP CONSTRAINT traffic_records_user_id_fkey;
       public          sarmad    false    3490    260    248            �           2606    16655 &   transactions transactions_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_plan_id_fkey;
       public          sarmad    false    242    3475    246            �           2606    16660 &   transactions transactions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_user_id_fkey;
       public          sarmad    false    248    3490    246            �           2606    16692    users users_referrer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_referrer_id_fkey FOREIGN KEY (referrer_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.users DROP CONSTRAINT users_referrer_id_fkey;
       public          sarmad    false    248    3490    248            v           826    16391    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     [   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO sarmad;
          public          postgres    false    5            h      x�36175445M5HK����� &-�      �      x������ � �      i      x������ � �      k      x������ � �      m      x������ � �      o      x������ � �      q      x������ � �      s      x������ � �      u      x������ � �      w      x������ � �      y      x������ � �      {      x������ � �      }   c  x��WmoG��E�~�����+R�:@𹾣z�|����*8�����&ܙ�(�	��cw��}f,�mhk�2��6��4X/��ecxu�鏇��oC��&��`������[�-�MaA;�3�G��(b��y����r�z�v�p��聇�,b��-�,�܌���8��V܇�`?ݭc�0�wn��v�)e$�,������z���2K92&eҤ��L�s/2˳<����7r��rʷl�Ƨh�,>�&�-���υ��� ��1C -JU�cu��JP��~T�3��O�"�y�7ď�w�U<�&ɐ?wO����&e���KQ��>LZkX�i�0K�`d�H�����5~�1?_��r�X�5M�'81�ΉPM����L�!����L�ޱ�޻4$��h
t\3��"�s�R]҇2S�T; �4��O�8l�:�0m� p�
����Bt�[���-�Z�6���05�hC��A8�I�T�yɤ+�T��ʴ�X�.�vժ�	�tE�
�]Z\�0M÷��0H�j��D�����`���I!fPpIm
CB��yi5s�R�*�����m{	HI��@��ܶjP����?'1������H��|N�m���>��[1!;��[Βi�~��,%2'L�$W�y�g,��	�@{�ϵ#�+*/v*�×�h�\Ue�`�E�$	8ȯ*�PG�9s`��"��^C0{�f���}9ͮ�iz9,6"���x,���$���D�̺2lK��6�<���y;�A;�a�nL�w�b~��z�tB�p3�n�qwu>,�C���ތ�i4��G�D��:�L��g����?�s�g�W�u2ܝy��A�gN�d�{��c>�,����.��������3μ�y
>�_H%R��󚥐R���c�`�*��wWV�������z��p�T��J��H�A׽�=�=ƕ��2�E��%�rL��@��\��=�1|�I���e�ҔtSQ�9ƣ�c�q�?���&!^D�d�x(f�,��чy2�V�Nr��Ō��"^0ǐt._���gE�Uʲ�Ԋ�0��e�K�U� ����+"��L���bZ
� /E>�~����A�3�g2U%K�B3�Ԕ��ʸsD��vzm���l��7��=�`
y*I��CzDfi�cܺ�4d���9ƨ紱(*��b���%n�;�q�:扁w=e��~�o��`M�z���Ð	���f4�����2Hz�3�mF�@�ڝ�yi�'�bJ�Tx��|v�9{�#V�V=MR�ny�T��ӥ���I���TSoJ��x����~N��=�i� ���e����K�=Y����1c�#$���S����}��9���yqq�/׊`1      �      x������ � �      �   �   x�½
�0 �9y
wI��r͵�-�m[P$?%��������[0s
��G�ʹ*�Ī΄���b���yD�����a�Ͱ�k?��m6�hw���՞���.���ޙ��q,)�w��&d����i)��C#      �      x������ � �         Y   x�3�445�3�0�31�321�4205�,)��J���CC\&��-8�3S�ˋ󓳋��0B�abb�Y��Z�M�!��@�r������� �+�      �      x������ � �      �      x������ � �      �   �   x���1�0��=;Je;q�����HTj�҅�㒀҉D�=9�������v=��+0�t���ԋ�)�D.x{�'�sYӫ�DH&�� bI�D�LD���P.��X 4 �
�JE���.���oC�&��V�+���_F��b�dbb����m� 5�����h_��M���2���oK�JW*C�4�%��      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x���M�@��3���tf�F�51]t`����j�O4!|���ҩ%7��|�Ƌ����6�:mNKUWI�bl2�,0)��`=zF�����e#W�C�	��2�����$ !�.�}����I� b����"#�\j0e��4��ඵesQE�A%E[�2�>x�o�2QO     