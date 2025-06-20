PGDMP  6    3                }            vpn_bot #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16389    vpn_bot    DATABASE     o   CREATE DATABASE vpn_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE vpn_bot;
                sarmad    false                        2615    17037    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sarmad    false                       0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   sarmad    false    5                       0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   sarmad    false    5            �            1259    17038    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    sarmad    false    5            �            1259    17167    config_cisco    TABLE       CREATE TABLE public.config_cisco (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    group_name character varying,
    group_password character varying,
    username character varying,
    password character varying,
    created_at timestamp without time zone DEFAULT now()
);
     DROP TABLE public.config_cisco;
       public         heap    sarmad    false    5            �            1259    17166    config_cisco_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_cisco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_cisco_id_seq;
       public          sarmad    false    235    5                       0    0    config_cisco_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_cisco_id_seq OWNED BY public.config_cisco.id;
          public          sarmad    false    234            �            1259    17183    config_ikev2    TABLE       CREATE TABLE public.config_ikev2 (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    certificate character varying,
    private_key character varying,
    created_at timestamp without time zone DEFAULT now()
);
     DROP TABLE public.config_ikev2;
       public         heap    sarmad    false    5            �            1259    17182    config_ikev2_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_ikev2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_ikev2_id_seq;
       public          sarmad    false    237    5                       0    0    config_ikev2_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ikev2_id_seq OWNED BY public.config_ikev2.id;
          public          sarmad    false    236            �            1259    17199    config_ipsec    TABLE       CREATE TABLE public.config_ipsec (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    psk character varying,
    ike_version character varying,
    created_at timestamp without time zone DEFAULT now()
);
     DROP TABLE public.config_ipsec;
       public         heap    sarmad    false    5            �            1259    17198    config_ipsec_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_ipsec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_ipsec_id_seq;
       public          sarmad    false    5    239                        0    0    config_ipsec_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ipsec_id_seq OWNED BY public.config_ipsec.id;
          public          sarmad    false    238            �            1259    17215    config_l2tp    TABLE     �   CREATE TABLE public.config_l2tp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    shared_secret character varying,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.config_l2tp;
       public         heap    sarmad    false    5            �            1259    17214    config_l2tp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_l2tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_l2tp_id_seq;
       public          sarmad    false    241    5            !           0    0    config_l2tp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_l2tp_id_seq OWNED BY public.config_l2tp.id;
          public          sarmad    false    240            �            1259    17076    config_openvpn    TABLE     <  CREATE TABLE public.config_openvpn (
    id bigint NOT NULL,
    username character varying,
    password character varying,
    created_at timestamp without time zone DEFAULT now(),
    config_id bigint NOT NULL,
    ca_cert character varying,
    client_cert character varying,
    client_key character varying
);
 "   DROP TABLE public.config_openvpn;
       public         heap    sarmad    false    5            �            1259    17075    config_openvpn_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_openvpn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.config_openvpn_id_seq;
       public          sarmad    false    5    223            "           0    0    config_openvpn_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.config_openvpn_id_seq OWNED BY public.config_openvpn.id;
          public          sarmad    false    222            �            1259    17231    config_pptp    TABLE     �   CREATE TABLE public.config_pptp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    mppe_enabled character varying,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.config_pptp;
       public         heap    sarmad    false    5            �            1259    17230    config_pptp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_pptp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_pptp_id_seq;
       public          sarmad    false    243    5            #           0    0    config_pptp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_pptp_id_seq OWNED BY public.config_pptp.id;
          public          sarmad    false    242            �            1259    17247    config_sstp    TABLE     �   CREATE TABLE public.config_sstp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    cert character varying,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.config_sstp;
       public         heap    sarmad    false    5            �            1259    17246    config_sstp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_sstp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_sstp_id_seq;
       public          sarmad    false    245    5            $           0    0    config_sstp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_sstp_id_seq OWNED BY public.config_sstp.id;
          public          sarmad    false    244            �            1259    17091    config_v2ray    TABLE     �  CREATE TABLE public.config_v2ray (
    id bigint NOT NULL,
    port integer,
    uuid character varying,
    alter_id integer,
    security character varying,
    network character varying,
    path character varying,
    host character varying,
    sni character varying,
    created_at timestamp without time zone DEFAULT now(),
    config_id bigint NOT NULL,
    address character varying
);
     DROP TABLE public.config_v2ray;
       public         heap    sarmad    false    5            �            1259    17090    config_v2ray_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_v2ray_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_v2ray_id_seq;
       public          sarmad    false    225    5            %           0    0    config_v2ray_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_v2ray_id_seq OWNED BY public.config_v2ray.id;
          public          sarmad    false    224            �            1259    17106    config_wireguard    TABLE     G  CREATE TABLE public.config_wireguard (
    id bigint NOT NULL,
    private_key character varying,
    public_key character varying,
    endpoint character varying,
    allowed_ips character varying,
    created_at timestamp without time zone DEFAULT now(),
    config_id bigint NOT NULL,
    preshared_key character varying
);
 $   DROP TABLE public.config_wireguard;
       public         heap    sarmad    false    5            �            1259    17105    config_wireguard_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_wireguard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.config_wireguard_id_seq;
       public          sarmad    false    227    5            &           0    0    config_wireguard_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.config_wireguard_id_seq OWNED BY public.config_wireguard.id;
          public          sarmad    false    226            �            1259    17121    configs    TABLE     �   CREATE TABLE public.configs (
    id bigint NOT NULL,
    user_id bigint,
    protocol character varying NOT NULL,
    name character varying,
    created_at timestamp with time zone DEFAULT now(),
    expiration_date timestamp without time zone
);
    DROP TABLE public.configs;
       public         heap    sarmad    false    5            �            1259    17120    configs_id_seq    SEQUENCE     w   CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.configs_id_seq;
       public          sarmad    false    5    229            '           0    0    configs_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;
          public          sarmad    false    228            �            1259    17044    inbounds    TABLE     �   CREATE TABLE public.inbounds (
    id integer NOT NULL,
    server character varying NOT NULL,
    port integer NOT NULL,
    protocol character varying NOT NULL,
    encryption character varying,
    password character varying
);
    DROP TABLE public.inbounds;
       public         heap    sarmad    false    5            �            1259    17043    inbounds_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inbounds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.inbounds_id_seq;
       public          sarmad    false    217    5            (           0    0    inbounds_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.inbounds_id_seq OWNED BY public.inbounds.id;
          public          sarmad    false    216            �            1259    17263    orders    TABLE       CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    status character varying,
    is_manual boolean,
    created_at timestamp with time zone DEFAULT now(),
    description character varying
);
    DROP TABLE public.orders;
       public         heap    sarmad    false    5            �            1259    17262    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          sarmad    false    247    5            )           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          sarmad    false    246            �            1259    17136    plans    TABLE     1  CREATE TABLE public.plans (
    id integer NOT NULL,
    name character varying NOT NULL,
    duration_days integer NOT NULL,
    volume_gb integer,
    price integer NOT NULL,
    description character varying,
    is_active boolean,
    created_at timestamp without time zone,
    inbound_id integer
);
    DROP TABLE public.plans;
       public         heap    sarmad    false    5            �            1259    17135    plans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.plans_id_seq;
       public          sarmad    false    5    231            *           0    0    plans_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;
          public          sarmad    false    230            �            1259    17053    servers    TABLE     [  CREATE TABLE public.servers (
    id integer NOT NULL,
    name character varying NOT NULL,
    ip character varying NOT NULL,
    port integer NOT NULL,
    protocol character varying NOT NULL,
    panel_path character varying NOT NULL,
    domain character varying,
    is_active boolean,
    current_clients integer,
    max_clients integer
);
    DROP TABLE public.servers;
       public         heap    sarmad    false    5            �            1259    17052    servers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.servers_id_seq;
       public          sarmad    false    5    219            +           0    0    servers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;
          public          sarmad    false    218            �            1259    17150    tickets    TABLE     $  CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    user_id bigint NOT NULL,
    message character varying NOT NULL,
    response character varying,
    status character varying,
    created_at timestamp with time zone DEFAULT now(),
    answered_at timestamp with time zone
);
    DROP TABLE public.tickets;
       public         heap    sarmad    false    5            �            1259    17149    tickets_ticket_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tickets_ticket_id_seq;
       public          sarmad    false    5    233            ,           0    0    tickets_ticket_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;
          public          sarmad    false    232            �            1259    17287    transactions    TABLE     p  CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    amount integer NOT NULL,
    currency character varying,
    status character varying,
    gateway character varying NOT NULL,
    reference character varying,
    type character varying,
    created_at timestamp with time zone DEFAULT now()
);
     DROP TABLE public.transactions;
       public         heap    sarmad    false    5            �            1259    17286    transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.transactions_id_seq;
       public          sarmad    false    5    249            -           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public          sarmad    false    248            �            1259    17063    users    TABLE     X  CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying,
    phone character varying,
    balance integer,
    lang character varying,
    role character varying,
    full_name character varying,
    language_code character varying,
    is_admin boolean,
    created_at timestamp with time zone DEFAULT now()
);
    DROP TABLE public.users;
       public         heap    sarmad    false    5            �            1259    17062    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          sarmad    false    5    221            .           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          sarmad    false    220                       2604    17170    config_cisco id    DEFAULT     r   ALTER TABLE ONLY public.config_cisco ALTER COLUMN id SET DEFAULT nextval('public.config_cisco_id_seq'::regclass);
 >   ALTER TABLE public.config_cisco ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    234    235    235                       2604    17186    config_ikev2 id    DEFAULT     r   ALTER TABLE ONLY public.config_ikev2 ALTER COLUMN id SET DEFAULT nextval('public.config_ikev2_id_seq'::regclass);
 >   ALTER TABLE public.config_ikev2 ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    237    236    237                       2604    17202    config_ipsec id    DEFAULT     r   ALTER TABLE ONLY public.config_ipsec ALTER COLUMN id SET DEFAULT nextval('public.config_ipsec_id_seq'::regclass);
 >   ALTER TABLE public.config_ipsec ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    239    238    239                       2604    17218    config_l2tp id    DEFAULT     p   ALTER TABLE ONLY public.config_l2tp ALTER COLUMN id SET DEFAULT nextval('public.config_l2tp_id_seq'::regclass);
 =   ALTER TABLE public.config_l2tp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    241    240    241            	           2604    17333    config_openvpn id    DEFAULT     v   ALTER TABLE ONLY public.config_openvpn ALTER COLUMN id SET DEFAULT nextval('public.config_openvpn_id_seq'::regclass);
 @   ALTER TABLE public.config_openvpn ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    223    222    223                       2604    17234    config_pptp id    DEFAULT     p   ALTER TABLE ONLY public.config_pptp ALTER COLUMN id SET DEFAULT nextval('public.config_pptp_id_seq'::regclass);
 =   ALTER TABLE public.config_pptp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    243    242    243                       2604    17250    config_sstp id    DEFAULT     p   ALTER TABLE ONLY public.config_sstp ALTER COLUMN id SET DEFAULT nextval('public.config_sstp_id_seq'::regclass);
 =   ALTER TABLE public.config_sstp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    244    245    245                       2604    17359    config_v2ray id    DEFAULT     r   ALTER TABLE ONLY public.config_v2ray ALTER COLUMN id SET DEFAULT nextval('public.config_v2ray_id_seq'::regclass);
 >   ALTER TABLE public.config_v2ray ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    225    224    225                       2604    17373    config_wireguard id    DEFAULT     z   ALTER TABLE ONLY public.config_wireguard ALTER COLUMN id SET DEFAULT nextval('public.config_wireguard_id_seq'::regclass);
 B   ALTER TABLE public.config_wireguard ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    226    227    227                       2604    17124 
   configs id    DEFAULT     h   ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);
 9   ALTER TABLE public.configs ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    228    229    229                       2604    17047    inbounds id    DEFAULT     j   ALTER TABLE ONLY public.inbounds ALTER COLUMN id SET DEFAULT nextval('public.inbounds_id_seq'::regclass);
 :   ALTER TABLE public.inbounds ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    216    217    217                        2604    17266 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    247    246    247                       2604    17139    plans id    DEFAULT     d   ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);
 7   ALTER TABLE public.plans ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    230    231    231                       2604    17056 
   servers id    DEFAULT     h   ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);
 9   ALTER TABLE public.servers ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    219    218    219                       2604    17153    tickets ticket_id    DEFAULT     v   ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);
 @   ALTER TABLE public.tickets ALTER COLUMN ticket_id DROP DEFAULT;
       public          sarmad    false    232    233    233            "           2604    17290    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    249    248    249                       2604    17066    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          sarmad    false    221    220    221            �          0    17038    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          sarmad    false    215   p�                 0    17167    config_cisco 
   TABLE DATA           q   COPY public.config_cisco (id, config_id, group_name, group_password, username, password, created_at) FROM stdin;
    public          sarmad    false    235   ��       	          0    17183    config_ikev2 
   TABLE DATA           o   COPY public.config_ikev2 (id, config_id, username, password, certificate, private_key, created_at) FROM stdin;
    public          sarmad    false    237   ��                 0    17199    config_ipsec 
   TABLE DATA           g   COPY public.config_ipsec (id, config_id, username, password, psk, ike_version, created_at) FROM stdin;
    public          sarmad    false    239   Ի                 0    17215    config_l2tp 
   TABLE DATA           c   COPY public.config_l2tp (id, config_id, username, password, shared_secret, created_at) FROM stdin;
    public          sarmad    false    241   �       �          0    17076    config_openvpn 
   TABLE DATA           y   COPY public.config_openvpn (id, username, password, created_at, config_id, ca_cert, client_cert, client_key) FROM stdin;
    public          sarmad    false    223   �                 0    17231    config_pptp 
   TABLE DATA           b   COPY public.config_pptp (id, config_id, username, password, mppe_enabled, created_at) FROM stdin;
    public          sarmad    false    243   +�                 0    17247    config_sstp 
   TABLE DATA           Z   COPY public.config_sstp (id, config_id, username, password, cert, created_at) FROM stdin;
    public          sarmad    false    245   H�       �          0    17091    config_v2ray 
   TABLE DATA           �   COPY public.config_v2ray (id, port, uuid, alter_id, security, network, path, host, sni, created_at, config_id, address) FROM stdin;
    public          sarmad    false    225   e�       �          0    17106    config_wireguard 
   TABLE DATA           �   COPY public.config_wireguard (id, private_key, public_key, endpoint, allowed_ips, created_at, config_id, preshared_key) FROM stdin;
    public          sarmad    false    227   ��                 0    17121    configs 
   TABLE DATA           [   COPY public.configs (id, user_id, protocol, name, created_at, expiration_date) FROM stdin;
    public          sarmad    false    229   ��       �          0    17044    inbounds 
   TABLE DATA           T   COPY public.inbounds (id, server, port, protocol, encryption, password) FROM stdin;
    public          sarmad    false    217   ��                 0    17263    orders 
   TABLE DATA           b   COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description) FROM stdin;
    public          sarmad    false    247   ټ                 0    17136    plans 
   TABLE DATA           z   COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at, inbound_id) FROM stdin;
    public          sarmad    false    231   ��       �          0    17053    servers 
   TABLE DATA           |   COPY public.servers (id, name, ip, port, protocol, panel_path, domain, is_active, current_clients, max_clients) FROM stdin;
    public          sarmad    false    219   w�                 0    17150    tickets 
   TABLE DATA           i   COPY public.tickets (ticket_id, user_id, message, response, status, created_at, answered_at) FROM stdin;
    public          sarmad    false    233   ��                 0    17287    transactions 
   TABLE DATA           |   COPY public.transactions (id, user_id, plan_id, amount, currency, status, gateway, reference, type, created_at) FROM stdin;
    public          sarmad    false    249   ��       �          0    17063    users 
   TABLE DATA           ~   COPY public.users (user_id, username, phone, balance, lang, role, full_name, language_code, is_admin, created_at) FROM stdin;
    public          sarmad    false    221   ��       /           0    0    config_cisco_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_cisco_id_seq', 1, false);
          public          sarmad    false    234            0           0    0    config_ikev2_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ikev2_id_seq', 1, false);
          public          sarmad    false    236            1           0    0    config_ipsec_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ipsec_id_seq', 1, false);
          public          sarmad    false    238            2           0    0    config_l2tp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_l2tp_id_seq', 1, false);
          public          sarmad    false    240            3           0    0    config_openvpn_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.config_openvpn_id_seq', 1, false);
          public          sarmad    false    222            4           0    0    config_pptp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_pptp_id_seq', 1, false);
          public          sarmad    false    242            5           0    0    config_sstp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_sstp_id_seq', 1, false);
          public          sarmad    false    244            6           0    0    config_v2ray_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_v2ray_id_seq', 1, false);
          public          sarmad    false    224            7           0    0    config_wireguard_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);
          public          sarmad    false    226            8           0    0    configs_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.configs_id_seq', 1, false);
          public          sarmad    false    228            9           0    0    inbounds_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.inbounds_id_seq', 1, false);
          public          sarmad    false    216            :           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public          sarmad    false    246            ;           0    0    plans_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.plans_id_seq', 60, true);
          public          sarmad    false    230            <           0    0    servers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.servers_id_seq', 8, true);
          public          sarmad    false    218            =           0    0    tickets_ticket_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);
          public          sarmad    false    232            >           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);
          public          sarmad    false    248            ?           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          sarmad    false    220            %           2606    17042 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            sarmad    false    215            ?           2606    17174    config_cisco config_cisco_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_pkey;
       public            sarmad    false    235            A           2606    17190    config_ikev2 config_ikev2_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_pkey;
       public            sarmad    false    237            C           2606    17206    config_ipsec config_ipsec_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_pkey;
       public            sarmad    false    239            E           2606    17222    config_l2tp config_l2tp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_pkey;
       public            sarmad    false    241            1           2606    17335 "   config_openvpn config_openvpn_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_pkey;
       public            sarmad    false    223            G           2606    17238    config_pptp config_pptp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_pkey;
       public            sarmad    false    243            I           2606    17254    config_sstp config_sstp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_pkey;
       public            sarmad    false    245            3           2606    17361    config_v2ray config_v2ray_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_pkey;
       public            sarmad    false    225            5           2606    17375 &   config_wireguard config_wireguard_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_pkey;
       public            sarmad    false    227            7           2606    17129    configs configs_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_pkey;
       public            sarmad    false    229            '           2606    17051    inbounds inbounds_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.inbounds
    ADD CONSTRAINT inbounds_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.inbounds DROP CONSTRAINT inbounds_pkey;
       public            sarmad    false    217            O           2606    17271    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            sarmad    false    247            9           2606    17143    plans plans_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_pkey;
       public            sarmad    false    231            *           2606    17060    servers servers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_pkey;
       public            sarmad    false    219            =           2606    17158    tickets tickets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public            sarmad    false    233            S           2606    17295    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            sarmad    false    249            /           2606    17071    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sarmad    false    221            J           1259    17282    ix_order_user_plan    INDEX     Q   CREATE INDEX ix_order_user_plan ON public.orders USING btree (user_id, plan_id);
 &   DROP INDEX public.ix_order_user_plan;
       public            sarmad    false    247    247            K           1259    17283    ix_orders_id    INDEX     =   CREATE INDEX ix_orders_id ON public.orders USING btree (id);
     DROP INDEX public.ix_orders_id;
       public            sarmad    false    247            L           1259    17284    ix_orders_plan_id    INDEX     G   CREATE INDEX ix_orders_plan_id ON public.orders USING btree (plan_id);
 %   DROP INDEX public.ix_orders_plan_id;
       public            sarmad    false    247            M           1259    17285    ix_orders_user_id    INDEX     G   CREATE INDEX ix_orders_user_id ON public.orders USING btree (user_id);
 %   DROP INDEX public.ix_orders_user_id;
       public            sarmad    false    247            (           1259    17061    ix_servers_id    INDEX     ?   CREATE INDEX ix_servers_id ON public.servers USING btree (id);
 !   DROP INDEX public.ix_servers_id;
       public            sarmad    false    219            :           1259    17164    ix_ticket_user_status    INDEX     T   CREATE INDEX ix_ticket_user_status ON public.tickets USING btree (user_id, status);
 )   DROP INDEX public.ix_ticket_user_status;
       public            sarmad    false    233    233            ;           1259    17165    ix_tickets_ticket_id    INDEX     M   CREATE INDEX ix_tickets_ticket_id ON public.tickets USING btree (ticket_id);
 (   DROP INDEX public.ix_tickets_ticket_id;
       public            sarmad    false    233            P           1259    17306    ix_transaction_user_status    INDEX     ^   CREATE INDEX ix_transaction_user_status ON public.transactions USING btree (user_id, status);
 .   DROP INDEX public.ix_transaction_user_status;
       public            sarmad    false    249    249            Q           1259    17307    ix_transactions_id    INDEX     I   CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);
 &   DROP INDEX public.ix_transactions_id;
       public            sarmad    false    249            +           1259    17072    ix_user_username_phone    INDEX     S   CREATE INDEX ix_user_username_phone ON public.users USING btree (username, phone);
 *   DROP INDEX public.ix_user_username_phone;
       public            sarmad    false    221    221            ,           1259    17073    ix_users_lang    INDEX     ?   CREATE INDEX ix_users_lang ON public.users USING btree (lang);
 !   DROP INDEX public.ix_users_lang;
       public            sarmad    false    221            -           1259    17074    ix_users_role    INDEX     ?   CREATE INDEX ix_users_role ON public.users USING btree (role);
 !   DROP INDEX public.ix_users_role;
       public            sarmad    false    221            Z           2606    17310 (   config_cisco config_cisco_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_config_id_fkey;
       public          sarmad    false    3383    235    229            [           2606    17316 (   config_ikev2 config_ikev2_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_config_id_fkey;
       public          sarmad    false    229    237    3383            \           2606    17322 (   config_ipsec config_ipsec_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_config_id_fkey;
       public          sarmad    false    229    239    3383            ]           2606    17328 &   config_l2tp config_l2tp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_config_id_fkey;
       public          sarmad    false    3383    241    229            T           2606    17342 ,   config_openvpn config_openvpn_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_config_id_fkey;
       public          sarmad    false    229    3383    223            ^           2606    17348 &   config_pptp config_pptp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_config_id_fkey;
       public          sarmad    false    229    243    3383            _           2606    17354 &   config_sstp config_sstp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_config_id_fkey;
       public          sarmad    false    229    3383    245            U           2606    17368 (   config_v2ray config_v2ray_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_config_id_fkey;
       public          sarmad    false    3383    229    225            V           2606    17382 0   config_wireguard config_wireguard_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_config_id_fkey;
       public          sarmad    false    229    227    3383            W           2606    17130    configs configs_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_user_id_fkey;
       public          sarmad    false    221    3375    229            `           2606    17272    orders orders_plan_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_plan_id_fkey;
       public          sarmad    false    231    247    3385            a           2606    17277    orders orders_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          sarmad    false    221    247    3375            X           2606    17144    plans plans_inbound_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_inbound_id_fkey FOREIGN KEY (inbound_id) REFERENCES public.inbounds(id);
 E   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_inbound_id_fkey;
       public          sarmad    false    3367    217    231            Y           2606    17159    tickets tickets_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_user_id_fkey;
       public          sarmad    false    221    3375    233            b           2606    17296 &   transactions transactions_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_plan_id_fkey;
       public          sarmad    false    249    3385    231            c           2606    17301 &   transactions transactions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_user_id_fkey;
       public          sarmad    false    3375    249    221            �      x�3640�L�4M4H5����� 'A�            x������ � �      	      x������ � �            x������ � �            x������ � �      �      x������ � �            x������ � �            x������ � �      �      x������ � �      �      x������ � �            x������ � �      �      x������ � �            x������ � �         q  x���1n[1@g���?H�����K�,�!@�)�G)���~�� 8~�D>Q���������`�5�Oy�^�J�*w�;�og���(����J�e\�2������BA�`[g�ɲ��p'��ؠ�^Н�NX�5`�z��>��I��m�m�YlT�ծ�U�Ļ��QᫍPԉ��Z�A�&�TE��MW���]�K���f��������?�W�K���xS�e�h�(�01��&L�&v[0�چ���k�Qo��xC��n�g"_}ҷ�w�g}��F���E E�u�jʸMw��M:a�h[b�9a�fx������՜q7�%�۸Y�I�W��W�4n���
�q;��Ԭp`��]K)�6ͨ��PB8�gţ���KVJ�B�cU�2�mxD�)'\��+�E�.p���'�^H�`I�6?�:�U.4��5�*��y9�)�6m�}�_VO���s�/+�d��L��q�ڝ�﷌qO�2�[���	�[��{��X�zʸ'oV,a8g�#�@ar�=���j$aܓn�l$c���V��;��X�ק�MR�ܚ?$����ꗤqASu�%k\���CKָ�7�z�8Pm����q��%+@��ƛ����n� ����      �   9  x����N�@�����p\������xh�J�i�mi��Ű�/�cx�x���T>��� ���d��vfT�||x��F��h)�3��v��IM
�mQ�w��,�Sg��Ã1��8֞����b���J��
�k��b
���%5�I���:�Q�SP��<�����:��8
o\%u`Tc�j��ϫޤ
/�y��hBlߝ��g+	%��	�r/�Y�6����do�U3P5)r�����l�*&nt�I_x�dC,��kѫ�a��휻i��f|i�vGUO�v��}��YW�ux�0U�av^��(_e��A            x������ � �            x������ � �      �   N   x�33727220�4��OLKL���4�LK�,-N-q��4N##S]]CCC3+SK+=ssSK#m�=... �jA     