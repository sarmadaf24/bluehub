PGDMP                       }            vpn_bot #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) �    D           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            E           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            F           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            G           1262    16390    vpn_bot    DATABASE     s   CREATE DATABASE vpn_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE vpn_bot;
                sarmad    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sarmad    false            H           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   sarmad    false    5            I           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   sarmad    false    5            �            1259    16392    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    sarmad    false    5            �            1259    16395    config_cisco    TABLE     *  CREATE TABLE public.config_cisco (
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
       public          sarmad    false    5    216            J           0    0    config_cisco_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_cisco_id_seq OWNED BY public.config_cisco.id;
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
       public          sarmad    false    218    5            K           0    0    config_ikev2_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ikev2_id_seq OWNED BY public.config_ikev2.id;
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
       public          sarmad    false    5    220            L           0    0    config_ipsec_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ipsec_id_seq OWNED BY public.config_ipsec.id;
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
       public          sarmad    false    5    222            M           0    0    config_l2tp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_l2tp_id_seq OWNED BY public.config_l2tp.id;
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
       public          sarmad    false    5    224            N           0    0    config_openvpn_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.config_openvpn_id_seq OWNED BY public.config_openvpn.id;
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
       public          sarmad    false    5    226            O           0    0    config_pptp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_pptp_id_seq OWNED BY public.config_pptp.id;
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
       public          sarmad    false    228    5            P           0    0    config_shadowsocks_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.config_shadowsocks_id_seq OWNED BY public.config_shadowsocks.id;
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
       public          sarmad    false    230    5            Q           0    0    config_sstp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_sstp_id_seq OWNED BY public.config_sstp.id;
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
       public          sarmad    false    5    232            R           0    0    config_v2ray_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_v2ray_id_seq OWNED BY public.config_v2ray.id;
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
       public          sarmad    false    5    234            S           0    0    config_wireguard_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.config_wireguard_id_seq OWNED BY public.config_wireguard.id;
          public          sarmad    false    235            �            1259    16464    configs    TABLE     �  CREATE TABLE public.configs (
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
    feedback_requested boolean DEFAULT false NOT NULL
);
    DROP TABLE public.configs;
       public         heap    sarmad    false    5            T           0    0    COLUMN configs.transfer_enable    COMMENT     Q   COMMENT ON COLUMN public.configs.transfer_enable IS 'حجم کل به بایت';
          public          sarmad    false    236            U           0    0 !   COLUMN configs.feedback_requested    COMMENT     �   COMMENT ON COLUMN public.configs.feedback_requested IS 'آیا برای این کانفیگ فیدبک درخواست شده؟';
          public          sarmad    false    236            �            1259    16470    configs_id_seq    SEQUENCE     w   CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.configs_id_seq;
       public          sarmad    false    236    5            V           0    0    configs_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;
          public          sarmad    false    237            �            1259    16834    email_tokens    TABLE        CREATE TABLE public.email_tokens (
    id character varying NOT NULL,
    user_id bigint NOT NULL,
    token character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    used boolean DEFAULT false NOT NULL
);
     DROP TABLE public.email_tokens;
       public         heap    sarmad    false    5            �            1259    16721 	   feedbacks    TABLE       CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    config_id integer NOT NULL,
    is_satisfied boolean NOT NULL,
    feedback_text character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.feedbacks;
       public         heap    sarmad    false    5            W           0    0    COLUMN feedbacks.is_satisfied    COMMENT     Z   COMMENT ON COLUMN public.feedbacks.is_satisfied IS 'آیا کاربر راضی بود؟';
          public          sarmad    false    253            X           0    0    COLUMN feedbacks.feedback_text    COMMENT     X   COMMENT ON COLUMN public.feedbacks.feedback_text IS 'متن بازخورد کاربر';
          public          sarmad    false    253            �            1259    16720    feedbacks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.feedbacks_id_seq;
       public          sarmad    false    253    5            Y           0    0    feedbacks_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;
          public          sarmad    false    252            �            1259    16471    inbounds    TABLE     Y  CREATE TABLE public.inbounds (
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
       public          sarmad    false    5    238            Z           0    0    inbounds_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.inbounds_id_seq OWNED BY public.inbounds.id;
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
       public         heap    sarmad    false    5            [           0    0    COLUMN orders.deposit_amount    COMMENT     u   COMMENT ON COLUMN public.orders.deposit_amount IS 'مبلغ ودیعه/پیش‌پرداخت (تومان/دلار)';
          public          sarmad    false    240            \           0    0    COLUMN orders.trial_days    COMMENT     L   COMMENT ON COLUMN public.orders.trial_days IS 'مدت تریال (روز)';
          public          sarmad    false    240            ]           0    0    COLUMN orders.trial_volume    COMMENT     P   COMMENT ON COLUMN public.orders.trial_volume IS 'حجم تریال (بایت)';
          public          sarmad    false    240            �            1259    16483    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          sarmad    false    5    240            ^           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          sarmad    false    241            �            1259    16484    plans    TABLE       CREATE TABLE public.plans (
    id integer NOT NULL,
    name character varying NOT NULL,
    duration_days integer NOT NULL,
    volume_gb integer,
    price integer NOT NULL,
    description character varying,
    is_active boolean,
    created_at timestamp without time zone
);
    DROP TABLE public.plans;
       public         heap    sarmad    false    5            �            1259    16489    plans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.plans_id_seq;
       public          sarmad    false    5    242            _           0    0    plans_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;
          public          sarmad    false    243            �            1259    16490    servers    TABLE     �  CREATE TABLE public.servers (
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
    DROP TABLE public.servers;
       public         heap    sarmad    false    5            �            1259    16495    servers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.servers_id_seq;
       public          sarmad    false    244    5            `           0    0    servers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;
          public          sarmad    false    245            �            1259    16496    tickets    TABLE     0  CREATE TABLE public.tickets (
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
       public          sarmad    false    246    5            a           0    0    tickets_ticket_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;
          public          sarmad    false    247            �            1259    16503    transactions    TABLE     |  CREATE TABLE public.transactions (
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
       public          sarmad    false    5    248            b           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public          sarmad    false    249            �            1259    16510    users    TABLE       CREATE TABLE public.users (
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
       public         heap    sarmad    false    5            c           0    0    COLUMN users.balance    COMMENT     k   COMMENT ON COLUMN public.users.balance IS 'موجودی کیف‌پول کاربر (تومان/دلار)';
          public          sarmad    false    250            d           0    0    COLUMN users.referrer_id    COMMENT     h   COMMENT ON COLUMN public.users.referrer_id IS 'کاربری که این فرد را دعوت کرده';
          public          sarmad    false    250            e           0    0 !   COLUMN users.total_referral_bonus    COMMENT     �   COMMENT ON COLUMN public.users.total_referral_bonus IS 'مجموع بونوس‌های دریافتی از زیرمجموعه‌ها';
          public          sarmad    false    250            �            1259    16516    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          sarmad    false    5    250            f           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          sarmad    false    251                       2604    16517    config_cisco id    DEFAULT     r   ALTER TABLE ONLY public.config_cisco ALTER COLUMN id SET DEFAULT nextval('public.config_cisco_id_seq'::regclass);
 >   ALTER TABLE public.config_cisco ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    217    216                       2604    16518    config_ikev2 id    DEFAULT     r   ALTER TABLE ONLY public.config_ikev2 ALTER COLUMN id SET DEFAULT nextval('public.config_ikev2_id_seq'::regclass);
 >   ALTER TABLE public.config_ikev2 ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    219    218                       2604    16519    config_ipsec id    DEFAULT     r   ALTER TABLE ONLY public.config_ipsec ALTER COLUMN id SET DEFAULT nextval('public.config_ipsec_id_seq'::regclass);
 >   ALTER TABLE public.config_ipsec ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    221    220                       2604    16520    config_l2tp id    DEFAULT     p   ALTER TABLE ONLY public.config_l2tp ALTER COLUMN id SET DEFAULT nextval('public.config_l2tp_id_seq'::regclass);
 =   ALTER TABLE public.config_l2tp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    223    222                       2604    16521    config_openvpn id    DEFAULT     v   ALTER TABLE ONLY public.config_openvpn ALTER COLUMN id SET DEFAULT nextval('public.config_openvpn_id_seq'::regclass);
 @   ALTER TABLE public.config_openvpn ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    225    224                       2604    16522    config_pptp id    DEFAULT     p   ALTER TABLE ONLY public.config_pptp ALTER COLUMN id SET DEFAULT nextval('public.config_pptp_id_seq'::regclass);
 =   ALTER TABLE public.config_pptp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    227    226                        2604    16523    config_shadowsocks id    DEFAULT     ~   ALTER TABLE ONLY public.config_shadowsocks ALTER COLUMN id SET DEFAULT nextval('public.config_shadowsocks_id_seq'::regclass);
 D   ALTER TABLE public.config_shadowsocks ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    229    228            !           2604    16524    config_sstp id    DEFAULT     p   ALTER TABLE ONLY public.config_sstp ALTER COLUMN id SET DEFAULT nextval('public.config_sstp_id_seq'::regclass);
 =   ALTER TABLE public.config_sstp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    231    230            #           2604    16525    config_v2ray id    DEFAULT     r   ALTER TABLE ONLY public.config_v2ray ALTER COLUMN id SET DEFAULT nextval('public.config_v2ray_id_seq'::regclass);
 >   ALTER TABLE public.config_v2ray ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    233    232            %           2604    16526    config_wireguard id    DEFAULT     z   ALTER TABLE ONLY public.config_wireguard ALTER COLUMN id SET DEFAULT nextval('public.config_wireguard_id_seq'::regclass);
 B   ALTER TABLE public.config_wireguard ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    235    234            '           2604    16527 
   configs id    DEFAULT     h   ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);
 9   ALTER TABLE public.configs ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    237    236            6           2604    16724    feedbacks id    DEFAULT     l   ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);
 ;   ALTER TABLE public.feedbacks ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    252    253    253            *           2604    16528    inbounds id    DEFAULT     j   ALTER TABLE ONLY public.inbounds ALTER COLUMN id SET DEFAULT nextval('public.inbounds_id_seq'::regclass);
 :   ALTER TABLE public.inbounds ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    239    238            +           2604    16529 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    241    240            -           2604    16530    plans id    DEFAULT     d   ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);
 7   ALTER TABLE public.plans ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    243    242            .           2604    16531 
   servers id    DEFAULT     h   ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);
 9   ALTER TABLE public.servers ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    245    244            /           2604    16532    tickets ticket_id    DEFAULT     v   ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);
 @   ALTER TABLE public.tickets ALTER COLUMN ticket_id DROP DEFAULT;
       public          sarmad    false    247    246            1           2604    16533    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    249    248            3           2604    16534    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          sarmad    false    251    250                      0    16392    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          sarmad    false    215   ��                 0    16395    config_cisco 
   TABLE DATA           q   COPY public.config_cisco (id, config_id, username, password, group_name, group_password, created_at) FROM stdin;
    public          sarmad    false    216   ��                 0    16402    config_ikev2 
   TABLE DATA           o   COPY public.config_ikev2 (id, config_id, username, password, certificate, private_key, created_at) FROM stdin;
    public          sarmad    false    218   ��                 0    16409    config_ipsec 
   TABLE DATA           g   COPY public.config_ipsec (id, config_id, ike_version, username, password, psk, created_at) FROM stdin;
    public          sarmad    false    220   ��       !          0    16416    config_l2tp 
   TABLE DATA           c   COPY public.config_l2tp (id, config_id, username, password, shared_secret, created_at) FROM stdin;
    public          sarmad    false    222   �       #          0    16423    config_openvpn 
   TABLE DATA           y   COPY public.config_openvpn (id, config_id, username, password, ca_cert, client_cert, client_key, created_at) FROM stdin;
    public          sarmad    false    224   /�       %          0    16430    config_pptp 
   TABLE DATA           b   COPY public.config_pptp (id, config_id, username, password, mppe_enabled, created_at) FROM stdin;
    public          sarmad    false    226   L�       '          0    16437    config_shadowsocks 
   TABLE DATA           l   COPY public.config_shadowsocks (id, config_id, address, port, encryption, password, created_at) FROM stdin;
    public          sarmad    false    228   i�       )          0    16443    config_sstp 
   TABLE DATA           Z   COPY public.config_sstp (id, config_id, username, password, cert, created_at) FROM stdin;
    public          sarmad    false    230   ��       +          0    16450    config_v2ray 
   TABLE DATA           �   COPY public.config_v2ray (id, config_id, server, port, uuid, encryption, password, alter_id, security, network, path, host, sni, created_at, address) FROM stdin;
    public          sarmad    false    232   ��       -          0    16457    config_wireguard 
   TABLE DATA           �   COPY public.config_wireguard (id, config_id, private_key, public_key, preshared_key, endpoint, allowed_ips, created_at) FROM stdin;
    public          sarmad    false    234   ��       /          0    16464    configs 
   TABLE DATA           �   COPY public.configs (id, user_id, protocol, name, created_at, expiration_date, config_name, domain, port, uuid, active, transfer_enable, feedback_requested) FROM stdin;
    public          sarmad    false    236   ��       A          0    16834    email_tokens 
   TABLE DATA           L   COPY public.email_tokens (id, user_id, token, created_at, used) FROM stdin;
    public          sarmad    false    254         @          0    16721 	   feedbacks 
   TABLE DATA           d   COPY public.feedbacks (id, user_id, config_id, is_satisfied, feedback_text, created_at) FROM stdin;
    public          sarmad    false    253   y      1          0    16471    inbounds 
   TABLE DATA           n   COPY public.inbounds (id, server, port, protocol, encryption, password, network, path, host, sni) FROM stdin;
    public          sarmad    false    238   �      3          0    16477    orders 
   TABLE DATA           �   COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description, deposit_amount, trial_days, trial_volume) FROM stdin;
    public          sarmad    false    240   �      5          0    16484    plans 
   TABLE DATA           n   COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at) FROM stdin;
    public          sarmad    false    242         7          0    16490    servers 
   TABLE DATA           �   COPY public.servers (id, name, ip, port, protocol, panel_path, domain, is_active, current_clients, max_clients, panel_username, panel_password) FROM stdin;
    public          sarmad    false    244   �      9          0    16496    tickets 
   TABLE DATA           i   COPY public.tickets (ticket_id, user_id, message, response, status, created_at, answered_at) FROM stdin;
    public          sarmad    false    246   2      ;          0    16503    transactions 
   TABLE DATA           |   COPY public.transactions (id, user_id, plan_id, amount, currency, status, gateway, reference, type, created_at) FROM stdin;
    public          sarmad    false    248   O      =          0    16510    users 
   TABLE DATA           �   COPY public.users (user_id, username, phone, balance, lang, role, full_name, language_code, is_admin, created_at, referrer_id, total_referral_bonus, email, email_verified_at, trial_used) FROM stdin;
    public          sarmad    false    250   l      g           0    0    config_cisco_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_cisco_id_seq', 1, false);
          public          sarmad    false    217            h           0    0    config_ikev2_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ikev2_id_seq', 1, false);
          public          sarmad    false    219            i           0    0    config_ipsec_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ipsec_id_seq', 1, false);
          public          sarmad    false    221            j           0    0    config_l2tp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_l2tp_id_seq', 1, false);
          public          sarmad    false    223            k           0    0    config_openvpn_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.config_openvpn_id_seq', 1, false);
          public          sarmad    false    225            l           0    0    config_pptp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_pptp_id_seq', 1, false);
          public          sarmad    false    227            m           0    0    config_shadowsocks_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.config_shadowsocks_id_seq', 1, false);
          public          sarmad    false    229            n           0    0    config_sstp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_sstp_id_seq', 1, false);
          public          sarmad    false    231            o           0    0    config_v2ray_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_v2ray_id_seq', 4, true);
          public          sarmad    false    233            p           0    0    config_wireguard_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);
          public          sarmad    false    235            q           0    0    configs_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.configs_id_seq', 119, true);
          public          sarmad    false    237            r           0    0    feedbacks_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.feedbacks_id_seq', 1, false);
          public          sarmad    false    252            s           0    0    inbounds_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.inbounds_id_seq', 4, true);
          public          sarmad    false    239            t           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public          sarmad    false    241            u           0    0    plans_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.plans_id_seq', 10, true);
          public          sarmad    false    243            v           0    0    servers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.servers_id_seq', 8, true);
          public          sarmad    false    245            w           0    0    tickets_ticket_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);
          public          sarmad    false    247            x           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);
          public          sarmad    false    249            y           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          sarmad    false    251            ;           2606    16536 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            sarmad    false    215            =           2606    16538    config_cisco config_cisco_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_pkey;
       public            sarmad    false    216            ?           2606    16540    config_ikev2 config_ikev2_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_pkey;
       public            sarmad    false    218            A           2606    16542    config_ipsec config_ipsec_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_pkey;
       public            sarmad    false    220            C           2606    16544    config_l2tp config_l2tp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_pkey;
       public            sarmad    false    222            E           2606    16546 "   config_openvpn config_openvpn_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_pkey;
       public            sarmad    false    224            G           2606    16548    config_pptp config_pptp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_pkey;
       public            sarmad    false    226            I           2606    16550 *   config_shadowsocks config_shadowsocks_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_pkey;
       public            sarmad    false    228            K           2606    16552    config_sstp config_sstp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_pkey;
       public            sarmad    false    230            M           2606    16554    config_v2ray config_v2ray_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_pkey;
       public            sarmad    false    232            O           2606    16556 &   config_wireguard config_wireguard_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_pkey;
       public            sarmad    false    234            Q           2606    16558    configs configs_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_pkey;
       public            sarmad    false    236            t           2606    16842    email_tokens email_tokens_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.email_tokens DROP CONSTRAINT email_tokens_pkey;
       public            sarmad    false    254            o           2606    16729    feedbacks feedbacks_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_pkey;
       public            sarmad    false    253            S           2606    16560    inbounds inbounds_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.inbounds
    ADD CONSTRAINT inbounds_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.inbounds DROP CONSTRAINT inbounds_pkey;
       public            sarmad    false    238            Y           2606    16562    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            sarmad    false    240            [           2606    16564    plans plans_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_pkey;
       public            sarmad    false    242            ^           2606    16566    servers servers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_pkey;
       public            sarmad    false    244            b           2606    16568    tickets tickets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public            sarmad    false    246            f           2606    16570    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            sarmad    false    248            m           2606    16572    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sarmad    false    250            u           1259    16848    ix_email_tokens_token    INDEX     V   CREATE UNIQUE INDEX ix_email_tokens_token ON public.email_tokens USING btree (token);
 )   DROP INDEX public.ix_email_tokens_token;
       public            sarmad    false    254            v           1259    16849    ix_email_tokens_user_id    INDEX     S   CREATE INDEX ix_email_tokens_user_id ON public.email_tokens USING btree (user_id);
 +   DROP INDEX public.ix_email_tokens_user_id;
       public            sarmad    false    254            p           1259    16740    ix_feedbacks_config_id    INDEX     Q   CREATE INDEX ix_feedbacks_config_id ON public.feedbacks USING btree (config_id);
 *   DROP INDEX public.ix_feedbacks_config_id;
       public            sarmad    false    253            q           1259    16741    ix_feedbacks_id    INDEX     C   CREATE INDEX ix_feedbacks_id ON public.feedbacks USING btree (id);
 #   DROP INDEX public.ix_feedbacks_id;
       public            sarmad    false    253            r           1259    16742    ix_feedbacks_user_id    INDEX     M   CREATE INDEX ix_feedbacks_user_id ON public.feedbacks USING btree (user_id);
 (   DROP INDEX public.ix_feedbacks_user_id;
       public            sarmad    false    253            T           1259    16573    ix_order_user_plan    INDEX     Q   CREATE INDEX ix_order_user_plan ON public.orders USING btree (user_id, plan_id);
 &   DROP INDEX public.ix_order_user_plan;
       public            sarmad    false    240    240            U           1259    16574    ix_orders_id    INDEX     =   CREATE INDEX ix_orders_id ON public.orders USING btree (id);
     DROP INDEX public.ix_orders_id;
       public            sarmad    false    240            V           1259    16575    ix_orders_plan_id    INDEX     G   CREATE INDEX ix_orders_plan_id ON public.orders USING btree (plan_id);
 %   DROP INDEX public.ix_orders_plan_id;
       public            sarmad    false    240            W           1259    16576    ix_orders_user_id    INDEX     G   CREATE INDEX ix_orders_user_id ON public.orders USING btree (user_id);
 %   DROP INDEX public.ix_orders_user_id;
       public            sarmad    false    240            \           1259    16577    ix_servers_id    INDEX     ?   CREATE INDEX ix_servers_id ON public.servers USING btree (id);
 !   DROP INDEX public.ix_servers_id;
       public            sarmad    false    244            _           1259    16578    ix_ticket_user_status    INDEX     T   CREATE INDEX ix_ticket_user_status ON public.tickets USING btree (user_id, status);
 )   DROP INDEX public.ix_ticket_user_status;
       public            sarmad    false    246    246            `           1259    16579    ix_tickets_ticket_id    INDEX     M   CREATE INDEX ix_tickets_ticket_id ON public.tickets USING btree (ticket_id);
 (   DROP INDEX public.ix_tickets_ticket_id;
       public            sarmad    false    246            c           1259    16580    ix_transaction_user_status    INDEX     ^   CREATE INDEX ix_transaction_user_status ON public.transactions USING btree (user_id, status);
 .   DROP INDEX public.ix_transaction_user_status;
       public            sarmad    false    248    248            d           1259    16581    ix_transactions_id    INDEX     I   CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);
 &   DROP INDEX public.ix_transactions_id;
       public            sarmad    false    248            g           1259    16582    ix_user_username_phone    INDEX     S   CREATE INDEX ix_user_username_phone ON public.users USING btree (username, phone);
 *   DROP INDEX public.ix_user_username_phone;
       public            sarmad    false    250    250            h           1259    16851    ix_users_email    INDEX     H   CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);
 "   DROP INDEX public.ix_users_email;
       public            sarmad    false    250            i           1259    16583    ix_users_lang    INDEX     ?   CREATE INDEX ix_users_lang ON public.users USING btree (lang);
 !   DROP INDEX public.ix_users_lang;
       public            sarmad    false    250            j           1259    16691    ix_users_referrer_id    INDEX     M   CREATE INDEX ix_users_referrer_id ON public.users USING btree (referrer_id);
 (   DROP INDEX public.ix_users_referrer_id;
       public            sarmad    false    250            k           1259    16584    ix_users_role    INDEX     ?   CREATE INDEX ix_users_role ON public.users USING btree (role);
 !   DROP INDEX public.ix_users_role;
       public            sarmad    false    250            w           2606    16585 (   config_cisco config_cisco_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_config_id_fkey;
       public          sarmad    false    3409    216    236            x           2606    16590 (   config_ikev2 config_ikev2_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_config_id_fkey;
       public          sarmad    false    3409    236    218            y           2606    16595 (   config_ipsec config_ipsec_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_config_id_fkey;
       public          sarmad    false    3409    236    220            z           2606    16600 &   config_l2tp config_l2tp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_config_id_fkey;
       public          sarmad    false    3409    236    222            {           2606    16605 ,   config_openvpn config_openvpn_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_config_id_fkey;
       public          sarmad    false    3409    224    236            |           2606    16610 &   config_pptp config_pptp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_config_id_fkey;
       public          sarmad    false    3409    226    236            }           2606    16615 4   config_shadowsocks config_shadowsocks_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 ^   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_config_id_fkey;
       public          sarmad    false    236    3409    228            ~           2606    16620 &   config_sstp config_sstp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_config_id_fkey;
       public          sarmad    false    236    230    3409                       2606    16625 (   config_v2ray config_v2ray_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_config_id_fkey;
       public          sarmad    false    232    236    3409            �           2606    16630 0   config_wireguard config_wireguard_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_config_id_fkey;
       public          sarmad    false    236    3409    234            �           2606    16635    configs configs_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_user_id_fkey;
       public          sarmad    false    3437    250    236            �           2606    16843 &   email_tokens email_tokens_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.email_tokens
    ADD CONSTRAINT email_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.email_tokens DROP CONSTRAINT email_tokens_user_id_fkey;
       public          sarmad    false    254    250    3437            �           2606    16730 "   feedbacks feedbacks_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 L   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_config_id_fkey;
       public          sarmad    false    3409    253    236            �           2606    16735     feedbacks feedbacks_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_user_id_fkey;
       public          sarmad    false    253    3437    250            �           2606    16640    orders orders_plan_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_plan_id_fkey;
       public          sarmad    false    240    242    3419            �           2606    16645    orders orders_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          sarmad    false    3437    240    250            �           2606    16650    tickets tickets_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_user_id_fkey;
       public          sarmad    false    3437    250    246            �           2606    16655 &   transactions transactions_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_plan_id_fkey;
       public          sarmad    false    242    248    3419            �           2606    16660 &   transactions transactions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_user_id_fkey;
       public          sarmad    false    248    3437    250            �           2606    16692    users users_referrer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_referrer_id_fkey FOREIGN KEY (referrer_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.users DROP CONSTRAINT users_referrer_id_fkey;
       public          sarmad    false    3437    250    250            X           826    16391    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     [   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO sarmad;
          public          postgres    false    5                  x�KN12N54�HMJ3����� /p>            x������ � �            x������ � �            x������ � �      !      x������ � �      #      x������ � �      %      x������ � �      '      x������ � �      )      x������ � �      +   �   x��бq1И�� �� m��!�³�?�&��y���>C��89Ax��=���[�M�Y/���Z�C��|,�_� �rE���|�v���k�
\-�SIY�A~�1�������p�s��CC��k�O�S8Yk���+P�|��a�J�l8WJ���O��k�A����tfK9����+/�aU5��k��B�ݤ�
�ը����k�n�[*�^�����8~ ��c�      -      x������ � �      /      x��}koɒ�g�_���e��|?\�ʦ�+����)q�0_����g�1����{��O��e� ۰VUFFd�9��I��:��.��3������_�ߘpZm��$��q̈́�M�N��`�C���g�ْ)���+����C��}�Y+���O�;Ѣ�U���o%uA�`��l�������߷^��y��'�u��������Z*��Z|��Rp����C����	fM�7V�V�1!�R������!�R����aQ}{��[��I�H~b�	'�bg"�R�����|�}��/��v����c���U�*;���<���)t����ii$+�w��}QU���i�a��w�ٗ/l��v��7�0��:BI��֐7�2���N�ߙ|z�ɿ�{=����o_/Ǘ�ϟNG�_ɨ7:]�E~;�����OW���z�yҿU��g:��y�I�����]�y���^~��I��������l:Y>{v>Id:������R�����;y�}�|���Ǚ��"O�闧w��w~Z�����=��R��տ��z��_�4ӧw�'*����>��4�#ʋz/���.����F�RQ�XF��ך��+U�24�Em�P����w��?4��Xc��~�L+��ηf�>�I5�U�U�r���YQ��\-�vM(�+�bIGx�Ѻ#�<�Z�G�{�����o����o����g���������?��~�G�χ?��G���*?�>��E��WπrO�Gi'�g�Y�����v��̨B�P����,X�[p�K�Kf�%/jg@�~�����
��<IU��<̀jg�#�H_V�(10]0�]`V#�(SD�_2/yQ;������;�n��Ը`�%X�ϧ��f�.�ǟ���3
V"�a�����*��M���$��{��+X����,�RJQY��(��·f��{��wu���P�D���	အ�����P���䫅��8�
�����hYi|]ɪ�k�w}Ur#�c�9[�$ɇ�<�Uw�lf�͌}@q��H��D���X�[kt[ʥ5�(�t��,������~"��p��$F����s��1[�����و�D^�ym��ׇT^�΃��2�t�GJ2 "4/YPeTU����U۾����.;�#���I��ӫp���V��B��,�cp��.Y�cc����y��_��VY�&#�r�8\+��^I�w�Iq�ec�\�=&��!���A� ?��ظ��5���Lt"oUڏ?�q��C+�I����+K&�.zU;�Z���Ԗ�D��V�̽�
��Im����d�<$����_B�a6�����l�{�:�.�n5A���ڕT\��`��tQT,D��k/jU�J��Vx�ڊ/SR;����T���!k��E��`�����GX[�g���l���,Yćlq��3���ُ�����!L��&d��x��j!��oS@uG?���yXP��q6��t�-��0�ա��������~H��覽��<]d?V;�A[��h�U�n��:b��R:۪-ަ���%��VP�Y
¶�[[>��n&��Z�y2���7���>��?�"�ŬLH�t����ZK���+��E�0�,fT�0+�围�뷣�z_�P�I+l'�lLv<}H�p���x&�����Q�_���V��S��O�$-� �b��
.#p�o�����/y��z���krb,��k-��T[an��'�����К#~�g�|$���f�<G'jz$����Aiϰ�=�Z�;U�D�2X�l�<P��.n~�Ŝ��2�v��k��+���f�k2�A����g����1�s��K|v7ͻ�a�MT�[��w#�`5���^��J8ʶ`;u���w�n�d0�@&�Y����;f�'��I��v�LOR vnVѧ%���\y �&�4޲"(*��e�y��kH�^�΀ݜ�mL��9p�� <ށ9x�Z���-�,eY	�n�c	PP��F���։���x%�|�#[uݦ�ߋF�U\(Z��{�;�+)��3e[�H%2���
i�����h���3f�"��|o�8�F�b"�(~��j��a�[&�P����.�)An�:�����;�"r��R�P��c�B4>C�*���Bm��)�f:��y*�Q6&�q|�0� ��~�Ueʹk$T�������5a��)�B�N�?��í�e�m�Rڭ,��V/�Yҝ�lq�>��C�=E�B�E�C�O���"���E���{Ea��#X��
��f�4U	Z�p�\�y�P0%��{�9�7�B ���t*7H	�=��!�y�����0����H��w:#L ���X�%/����JաM>J���C!N��H$��]I�j/���(5SM �Ԟ�Z�r�l(D��m^��V�7�_RM�e��v7�r�k�ml�q:�5��q��s3��	"Х 6@,�D�X��/��@��:h)-�k,����T�<����ހ~��RdO�仁wC������d<Y <7.���
� ���2���q6��=xI/�*d�`�:X��.X#�X�<��B�7���ɝ�F��ڵ�Bq���;+:����yBś�Ҭ�U�u�D
�/�q�8�GW������L�a
Vc����j*��+�uI(f��������J����c�w�'��ݘTL��!����=T�����)~g�3 �#N�T�
&BOa�V��	Ueue�p�Meߠ����5��joi�R��=���1U�� �8h��@.�s1�]�S�)X�n��~�ڥ���T����ђ�
�<�����][�To�PB1�iG�z��.�^K�Q6rr�:M�ʗ��g�}2��
��Y=����%��H͊�Z4���B/58S���7�2��B+��M1R	X������R�����ÉQ�s7�b`�3
��3���fc�%/jg �z�!�l����V���v�E}4 �Z8YX�U��UmY���ue��%��|��V�_�7���V'2t������V*�
V���y]��
vWx�+
�]�ֺҗ���L�K^�N�
��
�N4�e�[R�W�ꝥ�h���tFU-�S�\����������<YT�tq����#K?c�����G{O��J���z�Q��A1)�II����E�!�-��
� ���*��A�n�T�N�=���ϧ��j
 7LG}|�+g�'��+�^��(Q��V�0m��o q��O0��H��7�R���1�f	���c����	!�t<�9!����V�;�OO�G!\SFAy��Z#�Ed�B�)��%��5��o�p�}��ȭ�Pf-`v�І�Jw�|v9O�p��O	���U���txP�nM�;���8�S�lJ)�� 0���
�8�xgj���L����Sw�p�ګᮥ�9�-l�ʻԑɈc��������]G�|7�g7�|L(��s�������z�u�E��h��-M�[U��ԇ�rY/[�,8�6MْJ��m�:~�i?1Iw7>�Үc��z��F���tp3�/��%x=�7��ب��.��:�? ث�s`�voB�t5�I�p�U�k��;���T�C��H�0�� �)X��������-��-`�t�\,we~�5Z����+do�ؤ��ڈPrڔi���b�R/�8t��3���*y����O�9fT��=,K�3�jX��Y>��Ӵ�O@b�1qn�U�ߦ�T-Xiˤl�����D��z�z��O��'��Ӻ�Z+�!���4�8%�K��@H9m�.�>�����g�����L^�d|��8����ДP� w9aq�+/b��R��tmm���'
�:�\|-]v9�qd�d��j�x���\���R��A�ӽ��8\M�R���m	Q!��Z�p�k�q�EY^���?��o�nKױ�jv�ސ0�Cj�dq����+oF���>�]R��Z(L�u
ښ̎�q�d�c]3�$�4�	+Kp*��9�-��(�$���^��M��e�D��{j�R�4z8���԰���R6��=��� ��������z�Ԗ�'0��kʪ�r.��7���K��vm�7n�U��������w�    P�Y*�k-�������oMޟ,>��F�z����~28S������"3ٻ��5@T��b��T4���p�JQ�vUZ�d���v
��3�95o�{�bC�ͺ:���n��E|+0<�) �1`] ���+�/yd��y�WJjV�x�h��}�:�ư���WR�W��o��53$���?���dޣH.o���|�~^�x�T=f�,�
MᲪ���U˦h�^�ʮ�'SH��H��W>K�^!��+yY7�<	���F��İ�?��)](�+��%�l�u��J}�iW�p�6�R;�>^�ՀN�H�Yr�v�*?	���yp7I�f����d�^^�(�2%ddZ+jTp�Օs��M�M�Ȍ�3�QA��M[Rx���fg`��|�Li��8���,AJ��?{ *��&ɻ5��(��%��R�� �et̀SpSȺ�[.�@�i��J�wʹ��R9���Y*�i��W�Т�֩�d��2Dw�X��Ѐ�Hk�/)���E���'�:��1je��ܳԁ�ؽ]�:z�JS�k�=6�p�0�\�c�t�M�/yd��x�6��4����}�WR�W;��u1�q�I����Q.���칚$s���Y?��8L�GzW� ��X&���T�wV��)d�5��j��G��r�
'���?쨺�r-�~�s@�&��TS������Gb����ϴ%>��QU"Y ˼[?��=�MU�5��}Ɇ�& ��	*�hڝ)�ӕ�'��e��2Z풢�����9�&�n:�Qi�b�E����W�t�N~>M�w��e��1�,+���4I]�^q�Kx(ע��i*�n�����$��i����.�ݐZs���||7D�Hd:�]?�O�d�ܜ�$�
��wLǆ�����e����vi`l�jV)@<۔��6�X��e�>e;�6�vs�Z
��.˯rO#�)��jJ��I�
�18(�PJ�������'���^�Y�ewAGP��6�ߔr�?����<�W#��Y*3��oA��#����=$�L��<=�fbkY�R 5��-H�&2@w�h�
���n_�ɴ��H�څ�R�����wS:n��� ��rA�2�R����g��f���;�ݏ��;Anjj��*h� QŚ��Eŋ��ֺ�"#2��D�QV�]��!�n�LfY�(������	����cŵ3�x-0z�#[m���043H.�){ ����m���VH�"WS:��to����i���1���⫠cL��|ȏ���
A��ё�+�P�+ڱ�
��-4��&��_n�x0��g%Eғ����=�%�g"Qy��R�׿�G>��P�`bf���"'�:���*@JCő{TЬ��b6DUVRǸn�t���G��{�t-Tn��h׬ǖu�`�Ro }*-Y�m�ިF�kX�^��/^���؉k*
#wMlJu�|/��hA�8uF䆈�� aL�X�Fp�L�%3��3 _ݞ��C�C��i�ڔ"�����h��������Bz�ƥ+�c�W{ex{�#[u��C���J��s�sRsC��מ�o������ɢ�.wM�������w/���$��.z�#] �cuP zJYjUi�͢f�����FhOP�����7���	q#v����}*y���a��AE��-NKh=#h��Z��uq��!g��4�h���LD���9���Ψ�9<�\�m^�ܤ��^��~�L�%���V!�un�� ����<�q�� c*S������<�U׾.��:˻\��K�(�$�ί�؈禉������RJ�v��F��.ʊ�=]2�Q;���?��1YQ�!�~�갺���͐z:M�}��V�K@�K�����R:{�>¼���Y:z��6���%e\s3B���W���l���i��2���⇜�Y�Bhw�܎0��2�Ofɲc'YP5�����8�L�! ���/ 0���k���@!�e�tT�Pk��� s������ l#��~�zx��vS��.�J*�'�o&�.��L�˺�8{��x{ݏ��X�є�@���-ծ��!�~���l��m����Amq"�	!D�9w-�Aq��H<_��ٜ�N���C�f�ԩt3�T�^BN�]ɱn���\�����:
V��<��,�j+���K�K�����4^�}�WRΕZť�.���iڽ!X���RH�]��ϩ	5_>�(c:3t�ɡu�5��.�RXY���"@p(y#yl���t�
�K���JD�]�[���Q)�S�_�T�S�C"�ղqLwa\@������>���LJюA���U� ,�7� �1f�^�����co�Dz@G�����R��AkO���H�ݰ��T���=jB�Ô�to]�E�9;z� v���mM���7�ӅFp��9���[����kD�*���+!�`�v�v��#a�9����xy���-��-mj��)��<�K-K[G�\@k�kVJ,m��h 9[\�͛�V��x�-mI�G��@N���5��4�\�S�܌{�8�=�e��p�8z��qMi+]��R7^��F���i1!˾ו��Mj �;��^ o��Zw�ǿi�� ȟ�15T]��K�?o�8�%���j�Ϯ�ő:-�k���S7,�iP�53.֕��J���ׂJ��yx�U��V���|���g�c�T���"%���S/��g��7��ےn�߯N[馩+�JUQ?�TH<@?�V�)+�p��Z��4t�����=��J92�9�k6���D"ʎ�$�8{\^�@G��/b�-�	��c2�?�,k[*:�[U]�PEV4ƀY�|����`�Pi��yrP��s}Kh��܄���7HGٜE/��t���_����t� t!\`�#k�V6�22���e���.T��
���
o����D�����{�h-��z�Gԍ*馳��mwB��t������G�.�p�IǷ��X(
�s\5�����G潧�&�4E�F�6��`J*�SF52�=l�ZS6�d�+���	��4�]j�$��Z�36��i��!�7��C�`��g��=�BAk�"Dm�2b}��[ ��oa �ޯ^����C�V)����V���,ӭ�~���1��f9P5"'8��l�D~�>J�]{����j��)��j�-��RV[�^���V� 8á��aY �SNWa��Kb�"���<�e��G �yҝ��4����Q�¬��6t��0^���z7X���埻���;8wUm��C�V�t�wu͸�_W�0U`��R� ��5����E��^z�tǺW;׌oIH��ۍ845%���0����%2YB�xr?�WtX��ďݢX�t�*�%h*���煉e�ۮ��x��b,dA���OR�Y�Ն�h�2��(�T��'t��EN'tM*3������#m �U""�c��t;�d�i<0��B_�2�:�fN���k��.7�v��m���V�d�1�BYj�K��V*p)7�9����^��i#��*P!�.o\��\���}H��r��s?�3�H�"�	�A4�by�Z��z�ٚk_��N���W��X���֕k�+8���o��t�W�5[vڔ"���iw����f�^,�c���c��wCj)L��DUUN�d�A�5��u!���PZ�6�OCDE����`�+�Н"�Tyw���h8�f��ْJr"���L��tٓy3��Z�Mz�&�U]��4 ��3)��{�&�Pưn�\��8E��"O�IڒZ��9��><V{݌��F*�G�g&��W������Y2��TԆ/�w#4M7�f�tQ�5,p�o�ц:(����ѷ�-Ԏ���KRh��������d��4ಊ���2sC��U4t�@���CXvX�%�B/��_<t����\�+K'����Rn~4t�\c�"2�]pdQJ�ޏn*[����_��<x#����z�	����o�����;�_nf+!+�X��45ci@B�o���rύ���σA��j���ݡ;��Ua.�v{@���0�Pe ���`��;gdmY#��B�Ɨ�������jx���_���A���Ҝ���M�4߱ mh�2���[�?�I�RS�A O  
)�C�����J	��|5�)-���N�}%Z)�����WI^���mKнf����Yߧ����x�|8ب�8��A�����T|�t$�p���/N0H����5tjJ]r{`�?��4t���t��KDG[��T��r�����h$�/VҽR�ҽ�E�b���w]�t֥����P3]9r��7���>O��y:V>7D�e����Ҵ���>�]�x�V۰5tK�� 6jD�kIy;��[g���0�N���fԩ�-?����+�ݳd�u���[�f���w%⮥3��Nk��t����!���t�o*��F�шDj��6��]�m�vHe�PL"4!<	���U#��+�����z��%�<4/�+�{kwf� ��嗌����)��}83��Z$�e�Μ�!���-�_P�f8����{�����maYBB��U�)����ԫ�J��)��<Oa���O�?Q<M)��Ri�)�|���j�v�����~� ݙ�yp��.�LG�����,�w�`AS��U���N��i�9l<���c8Ѧ��=���ӛ7��a�-\��6n%�Z��5%5K�d���Fy	����?�u$��䑘-A�?�}���K����Os��]S����� 0����v/���)+V7��j^�u�0�ll����k'�%�< ��+��ZN��rrk:�ڀv\��;�Ru����و�t��$�RQ����{��6o�>����C����4ݜ]PKTUs���	�JN���hqh2=�8@��0��Ɨ67�:D��`G*�^Rn@�Im�uI�hnY����-}Z_�u/y�~h���?����o�k      A   N  x����N"A�5<��ɩ��ԭw���M�(�ILu]����JO?m0���J*U߹�uV�e��%(�`]d��>��2ZJ-3�����v���_���u�Ϊ ����tw���DLg�Ar7�1b�S.�"py�Y&t�%��6?(m�v����r)E��8#h��b�+�1C~:#�����aV�|��ܽ������4+�x&0��Ȧ<�]&j���Հ"6}@������Q��P�ެ�(6�[9|}���yv�_v6����EF5��1�4�`7��a�� �!���H�7����{AV���0��r_�"�t'������Ad�gT��柆R,Ukf�G��F!6�3��&��+W�i��g궻��r�`�ױ��� d&�������H�9W`��@�sF{.e�G�L�}�'��r���P�����z�n�*b�6�����6�3��spL�Q�P5����a������x�&�K=yܜ	�L���/��	�e�DZi�ᵭb3xe)L����bMś���a?�5)�Snm�w�j�p���(.����f8�#Z5���o�n�����      @      x������ � �      1   Y   x�3�445�3�0�31�321�4205�,)��J���CC\&��-8�3S�ˋ󓳋��0B�abb�Y��Z�M�!��@�r������� �+�      3      x������ � �      5   �   x���1�0��>He;q������J��_�$�6Q���8_f���-D
�����W�AH4P
��I��60'��:mN	�W0VW�+ϡa�����p鐌Z�H�@:Z�`n�k�cx�hj	��D?�	ROY�R�2�@�zl�g��X��{�܃2U}������Wgt�y@��@u�      7   >  x����N�@�����p\���eck<�E��4�mi��Ű������p��|�h����3���̌
�O�oY>ȥ/%|)AE�r��Eas��=�*M��h����#��~��k?XOQ�	$@A�&��),G�gy&�H�#AF���@AF8�`֢â��f{���_�������:N�G�����0�3H~k�b��"���;��|��8�7��2��$|4�V��\��tְ�o�n�춣�&�EΑqִ�Yō?�2�V2����/���kP�j:v�Y����ygX�5����*��N׾q�㋚	��F;AEQ~ ���      9      x������ � �      ;      x������ � �      =   �   x���K�0D��)�G�lǮ������h@��IE�#�,��o)�tj���4_��������˱��i����# i�[�A�E&e��O�*�SR"���<���ɕ�ټ#��X��Q?� ��E}H?qȹ�$
"Vc|Ih*�1��ǥS&��A��n;��AZ\���r6�>x�o�6QL     