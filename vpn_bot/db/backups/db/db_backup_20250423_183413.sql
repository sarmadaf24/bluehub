PGDMP      "                }            vpn_bot #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) �    #           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            $           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            %           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            &           1262    16390    vpn_bot    DATABASE     s   CREATE DATABASE vpn_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE vpn_bot;
                sarmad    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sarmad    false            '           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   sarmad    false    5            (           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
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
       public          sarmad    false    216    5            )           0    0    config_cisco_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_cisco_id_seq OWNED BY public.config_cisco.id;
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
       public          sarmad    false    5    218            *           0    0    config_ikev2_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ikev2_id_seq OWNED BY public.config_ikev2.id;
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
       public          sarmad    false    220    5            +           0    0    config_ipsec_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ipsec_id_seq OWNED BY public.config_ipsec.id;
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
       public          sarmad    false    5    222            ,           0    0    config_l2tp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_l2tp_id_seq OWNED BY public.config_l2tp.id;
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
       public          sarmad    false    224    5            -           0    0    config_openvpn_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.config_openvpn_id_seq OWNED BY public.config_openvpn.id;
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
       public          sarmad    false    5    226            .           0    0    config_pptp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_pptp_id_seq OWNED BY public.config_pptp.id;
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
       public          sarmad    false    228    5            /           0    0    config_shadowsocks_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.config_shadowsocks_id_seq OWNED BY public.config_shadowsocks.id;
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
       public          sarmad    false    5    230            0           0    0    config_sstp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_sstp_id_seq OWNED BY public.config_sstp.id;
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
       public          sarmad    false    5    232            1           0    0    config_v2ray_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_v2ray_id_seq OWNED BY public.config_v2ray.id;
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
       public          sarmad    false    5    234            2           0    0    config_wireguard_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.config_wireguard_id_seq OWNED BY public.config_wireguard.id;
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
    transfer_enable bigint
);
    DROP TABLE public.configs;
       public         heap    sarmad    false    5            �            1259    16470    configs_id_seq    SEQUENCE     w   CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.configs_id_seq;
       public          sarmad    false    236    5            3           0    0    configs_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;
          public          sarmad    false    237            �            1259    16471    inbounds    TABLE     Y  CREATE TABLE public.inbounds (
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
       public          sarmad    false    5    238            4           0    0    inbounds_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.inbounds_id_seq OWNED BY public.inbounds.id;
          public          sarmad    false    239            �            1259    16477    orders    TABLE       CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    status character varying,
    is_manual boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    description character varying
);
    DROP TABLE public.orders;
       public         heap    sarmad    false    5            �            1259    16483    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          sarmad    false    240    5            5           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
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
       public          sarmad    false    5    242            6           0    0    plans_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;
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
       public          sarmad    false    5    244            7           0    0    servers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;
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
       public          sarmad    false    246    5            8           0    0    tickets_ticket_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;
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
       public          sarmad    false    248    5            9           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public          sarmad    false    249            �            1259    16510    users    TABLE     d  CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying,
    phone character varying,
    balance integer,
    lang character varying,
    role character varying,
    full_name character varying,
    language_code character varying,
    is_admin boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.users;
       public         heap    sarmad    false    5            �            1259    16516    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          sarmad    false    250    5            :           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          sarmad    false    251                       2604    16517    config_cisco id    DEFAULT     r   ALTER TABLE ONLY public.config_cisco ALTER COLUMN id SET DEFAULT nextval('public.config_cisco_id_seq'::regclass);
 >   ALTER TABLE public.config_cisco ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    217    216                       2604    16518    config_ikev2 id    DEFAULT     r   ALTER TABLE ONLY public.config_ikev2 ALTER COLUMN id SET DEFAULT nextval('public.config_ikev2_id_seq'::regclass);
 >   ALTER TABLE public.config_ikev2 ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    219    218                       2604    16519    config_ipsec id    DEFAULT     r   ALTER TABLE ONLY public.config_ipsec ALTER COLUMN id SET DEFAULT nextval('public.config_ipsec_id_seq'::regclass);
 >   ALTER TABLE public.config_ipsec ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    221    220                       2604    16520    config_l2tp id    DEFAULT     p   ALTER TABLE ONLY public.config_l2tp ALTER COLUMN id SET DEFAULT nextval('public.config_l2tp_id_seq'::regclass);
 =   ALTER TABLE public.config_l2tp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    223    222                       2604    16521    config_openvpn id    DEFAULT     v   ALTER TABLE ONLY public.config_openvpn ALTER COLUMN id SET DEFAULT nextval('public.config_openvpn_id_seq'::regclass);
 @   ALTER TABLE public.config_openvpn ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    225    224                       2604    16522    config_pptp id    DEFAULT     p   ALTER TABLE ONLY public.config_pptp ALTER COLUMN id SET DEFAULT nextval('public.config_pptp_id_seq'::regclass);
 =   ALTER TABLE public.config_pptp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    227    226                       2604    16523    config_shadowsocks id    DEFAULT     ~   ALTER TABLE ONLY public.config_shadowsocks ALTER COLUMN id SET DEFAULT nextval('public.config_shadowsocks_id_seq'::regclass);
 D   ALTER TABLE public.config_shadowsocks ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    229    228                       2604    16524    config_sstp id    DEFAULT     p   ALTER TABLE ONLY public.config_sstp ALTER COLUMN id SET DEFAULT nextval('public.config_sstp_id_seq'::regclass);
 =   ALTER TABLE public.config_sstp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    231    230                       2604    16525    config_v2ray id    DEFAULT     r   ALTER TABLE ONLY public.config_v2ray ALTER COLUMN id SET DEFAULT nextval('public.config_v2ray_id_seq'::regclass);
 >   ALTER TABLE public.config_v2ray ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    233    232                       2604    16526    config_wireguard id    DEFAULT     z   ALTER TABLE ONLY public.config_wireguard ALTER COLUMN id SET DEFAULT nextval('public.config_wireguard_id_seq'::regclass);
 B   ALTER TABLE public.config_wireguard ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    235    234                       2604    16527 
   configs id    DEFAULT     h   ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);
 9   ALTER TABLE public.configs ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    237    236                        2604    16528    inbounds id    DEFAULT     j   ALTER TABLE ONLY public.inbounds ALTER COLUMN id SET DEFAULT nextval('public.inbounds_id_seq'::regclass);
 :   ALTER TABLE public.inbounds ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    239    238            !           2604    16529 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    241    240            #           2604    16530    plans id    DEFAULT     d   ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);
 7   ALTER TABLE public.plans ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    243    242            $           2604    16531 
   servers id    DEFAULT     h   ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);
 9   ALTER TABLE public.servers ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    245    244            %           2604    16532    tickets ticket_id    DEFAULT     v   ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);
 @   ALTER TABLE public.tickets ALTER COLUMN ticket_id DROP DEFAULT;
       public          sarmad    false    247    246            '           2604    16533    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    249    248            )           2604    16534    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          sarmad    false    251    250            �          0    16392    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          sarmad    false    215   ��       �          0    16395    config_cisco 
   TABLE DATA           q   COPY public.config_cisco (id, config_id, username, password, group_name, group_password, created_at) FROM stdin;
    public          sarmad    false    216   ��       �          0    16402    config_ikev2 
   TABLE DATA           o   COPY public.config_ikev2 (id, config_id, username, password, certificate, private_key, created_at) FROM stdin;
    public          sarmad    false    218   ��                 0    16409    config_ipsec 
   TABLE DATA           g   COPY public.config_ipsec (id, config_id, ike_version, username, password, psk, created_at) FROM stdin;
    public          sarmad    false    220   �                 0    16416    config_l2tp 
   TABLE DATA           c   COPY public.config_l2tp (id, config_id, username, password, shared_secret, created_at) FROM stdin;
    public          sarmad    false    222   4�                 0    16423    config_openvpn 
   TABLE DATA           y   COPY public.config_openvpn (id, config_id, username, password, ca_cert, client_cert, client_key, created_at) FROM stdin;
    public          sarmad    false    224   Q�                 0    16430    config_pptp 
   TABLE DATA           b   COPY public.config_pptp (id, config_id, username, password, mppe_enabled, created_at) FROM stdin;
    public          sarmad    false    226   n�       	          0    16437    config_shadowsocks 
   TABLE DATA           l   COPY public.config_shadowsocks (id, config_id, address, port, encryption, password, created_at) FROM stdin;
    public          sarmad    false    228   ��                 0    16443    config_sstp 
   TABLE DATA           Z   COPY public.config_sstp (id, config_id, username, password, cert, created_at) FROM stdin;
    public          sarmad    false    230   ��                 0    16450    config_v2ray 
   TABLE DATA           �   COPY public.config_v2ray (id, config_id, server, port, uuid, encryption, password, alter_id, security, network, path, host, sni, created_at, address) FROM stdin;
    public          sarmad    false    232   ��                 0    16457    config_wireguard 
   TABLE DATA           �   COPY public.config_wireguard (id, config_id, private_key, public_key, preshared_key, endpoint, allowed_ips, created_at) FROM stdin;
    public          sarmad    false    234   ��                 0    16464    configs 
   TABLE DATA           �   COPY public.configs (id, user_id, protocol, name, created_at, expiration_date, config_name, domain, port, uuid, active, transfer_enable) FROM stdin;
    public          sarmad    false    236   ��                 0    16471    inbounds 
   TABLE DATA           n   COPY public.inbounds (id, server, port, protocol, encryption, password, network, path, host, sni) FROM stdin;
    public          sarmad    false    238   �                 0    16477    orders 
   TABLE DATA           b   COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description) FROM stdin;
    public          sarmad    false    240   w�                 0    16484    plans 
   TABLE DATA           n   COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at) FROM stdin;
    public          sarmad    false    242   ��                 0    16490    servers 
   TABLE DATA           �   COPY public.servers (id, name, ip, port, protocol, panel_path, domain, is_active, current_clients, max_clients, panel_username, panel_password) FROM stdin;
    public          sarmad    false    244   \�                 0    16496    tickets 
   TABLE DATA           i   COPY public.tickets (ticket_id, user_id, message, response, status, created_at, answered_at) FROM stdin;
    public          sarmad    false    246   ��                 0    16503    transactions 
   TABLE DATA           |   COPY public.transactions (id, user_id, plan_id, amount, currency, status, gateway, reference, type, created_at) FROM stdin;
    public          sarmad    false    248   ��                 0    16510    users 
   TABLE DATA           ~   COPY public.users (user_id, username, phone, balance, lang, role, full_name, language_code, is_admin, created_at) FROM stdin;
    public          sarmad    false    250   ��       ;           0    0    config_cisco_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_cisco_id_seq', 1, false);
          public          sarmad    false    217            <           0    0    config_ikev2_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ikev2_id_seq', 1, false);
          public          sarmad    false    219            =           0    0    config_ipsec_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ipsec_id_seq', 1, false);
          public          sarmad    false    221            >           0    0    config_l2tp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_l2tp_id_seq', 1, false);
          public          sarmad    false    223            ?           0    0    config_openvpn_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.config_openvpn_id_seq', 1, false);
          public          sarmad    false    225            @           0    0    config_pptp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_pptp_id_seq', 1, false);
          public          sarmad    false    227            A           0    0    config_shadowsocks_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.config_shadowsocks_id_seq', 1, false);
          public          sarmad    false    229            B           0    0    config_sstp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_sstp_id_seq', 1, false);
          public          sarmad    false    231            C           0    0    config_v2ray_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_v2ray_id_seq', 4, true);
          public          sarmad    false    233            D           0    0    config_wireguard_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);
          public          sarmad    false    235            E           0    0    configs_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.configs_id_seq', 115, true);
          public          sarmad    false    237            F           0    0    inbounds_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.inbounds_id_seq', 4, true);
          public          sarmad    false    239            G           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public          sarmad    false    241            H           0    0    plans_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.plans_id_seq', 10, true);
          public          sarmad    false    243            I           0    0    servers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.servers_id_seq', 8, true);
          public          sarmad    false    245            J           0    0    tickets_ticket_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);
          public          sarmad    false    247            K           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);
          public          sarmad    false    249            L           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          sarmad    false    251            ,           2606    16536 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            sarmad    false    215            .           2606    16538    config_cisco config_cisco_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_pkey;
       public            sarmad    false    216            0           2606    16540    config_ikev2 config_ikev2_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_pkey;
       public            sarmad    false    218            2           2606    16542    config_ipsec config_ipsec_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_pkey;
       public            sarmad    false    220            4           2606    16544    config_l2tp config_l2tp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_pkey;
       public            sarmad    false    222            6           2606    16546 "   config_openvpn config_openvpn_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_pkey;
       public            sarmad    false    224            8           2606    16548    config_pptp config_pptp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_pkey;
       public            sarmad    false    226            :           2606    16550 *   config_shadowsocks config_shadowsocks_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_pkey;
       public            sarmad    false    228            <           2606    16552    config_sstp config_sstp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_pkey;
       public            sarmad    false    230            >           2606    16554    config_v2ray config_v2ray_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_pkey;
       public            sarmad    false    232            @           2606    16556 &   config_wireguard config_wireguard_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_pkey;
       public            sarmad    false    234            B           2606    16558    configs configs_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_pkey;
       public            sarmad    false    236            D           2606    16560    inbounds inbounds_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.inbounds
    ADD CONSTRAINT inbounds_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.inbounds DROP CONSTRAINT inbounds_pkey;
       public            sarmad    false    238            J           2606    16562    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            sarmad    false    240            L           2606    16564    plans plans_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_pkey;
       public            sarmad    false    242            O           2606    16566    servers servers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_pkey;
       public            sarmad    false    244            S           2606    16568    tickets tickets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public            sarmad    false    246            W           2606    16570    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            sarmad    false    248            \           2606    16572    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sarmad    false    250            E           1259    16573    ix_order_user_plan    INDEX     Q   CREATE INDEX ix_order_user_plan ON public.orders USING btree (user_id, plan_id);
 &   DROP INDEX public.ix_order_user_plan;
       public            sarmad    false    240    240            F           1259    16574    ix_orders_id    INDEX     =   CREATE INDEX ix_orders_id ON public.orders USING btree (id);
     DROP INDEX public.ix_orders_id;
       public            sarmad    false    240            G           1259    16575    ix_orders_plan_id    INDEX     G   CREATE INDEX ix_orders_plan_id ON public.orders USING btree (plan_id);
 %   DROP INDEX public.ix_orders_plan_id;
       public            sarmad    false    240            H           1259    16576    ix_orders_user_id    INDEX     G   CREATE INDEX ix_orders_user_id ON public.orders USING btree (user_id);
 %   DROP INDEX public.ix_orders_user_id;
       public            sarmad    false    240            M           1259    16577    ix_servers_id    INDEX     ?   CREATE INDEX ix_servers_id ON public.servers USING btree (id);
 !   DROP INDEX public.ix_servers_id;
       public            sarmad    false    244            P           1259    16578    ix_ticket_user_status    INDEX     T   CREATE INDEX ix_ticket_user_status ON public.tickets USING btree (user_id, status);
 )   DROP INDEX public.ix_ticket_user_status;
       public            sarmad    false    246    246            Q           1259    16579    ix_tickets_ticket_id    INDEX     M   CREATE INDEX ix_tickets_ticket_id ON public.tickets USING btree (ticket_id);
 (   DROP INDEX public.ix_tickets_ticket_id;
       public            sarmad    false    246            T           1259    16580    ix_transaction_user_status    INDEX     ^   CREATE INDEX ix_transaction_user_status ON public.transactions USING btree (user_id, status);
 .   DROP INDEX public.ix_transaction_user_status;
       public            sarmad    false    248    248            U           1259    16581    ix_transactions_id    INDEX     I   CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);
 &   DROP INDEX public.ix_transactions_id;
       public            sarmad    false    248            X           1259    16582    ix_user_username_phone    INDEX     S   CREATE INDEX ix_user_username_phone ON public.users USING btree (username, phone);
 *   DROP INDEX public.ix_user_username_phone;
       public            sarmad    false    250    250            Y           1259    16583    ix_users_lang    INDEX     ?   CREATE INDEX ix_users_lang ON public.users USING btree (lang);
 !   DROP INDEX public.ix_users_lang;
       public            sarmad    false    250            Z           1259    16584    ix_users_role    INDEX     ?   CREATE INDEX ix_users_role ON public.users USING btree (role);
 !   DROP INDEX public.ix_users_role;
       public            sarmad    false    250            ]           2606    16585 (   config_cisco config_cisco_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_config_id_fkey;
       public          sarmad    false    236    216    3394            ^           2606    16590 (   config_ikev2 config_ikev2_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_config_id_fkey;
       public          sarmad    false    3394    218    236            _           2606    16595 (   config_ipsec config_ipsec_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_config_id_fkey;
       public          sarmad    false    236    3394    220            `           2606    16600 &   config_l2tp config_l2tp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_config_id_fkey;
       public          sarmad    false    236    3394    222            a           2606    16605 ,   config_openvpn config_openvpn_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_config_id_fkey;
       public          sarmad    false    224    3394    236            b           2606    16610 &   config_pptp config_pptp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_config_id_fkey;
       public          sarmad    false    3394    226    236            c           2606    16615 4   config_shadowsocks config_shadowsocks_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 ^   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_config_id_fkey;
       public          sarmad    false    228    3394    236            d           2606    16620 &   config_sstp config_sstp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_config_id_fkey;
       public          sarmad    false    3394    236    230            e           2606    16625 (   config_v2ray config_v2ray_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_config_id_fkey;
       public          sarmad    false    232    236    3394            f           2606    16630 0   config_wireguard config_wireguard_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_config_id_fkey;
       public          sarmad    false    234    236    3394            g           2606    16635    configs configs_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_user_id_fkey;
       public          sarmad    false    3420    250    236            h           2606    16640    orders orders_plan_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_plan_id_fkey;
       public          sarmad    false    242    240    3404            i           2606    16645    orders orders_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          sarmad    false    3420    240    250            j           2606    16650    tickets tickets_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_user_id_fkey;
       public          sarmad    false    246    250    3420            k           2606    16655 &   transactions transactions_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_plan_id_fkey;
       public          sarmad    false    248    242    3404            l           2606    16660 &   transactions transactions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_user_id_fkey;
       public          sarmad    false    3420    250    248            O           826    16391    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     [   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO sarmad;
          public          postgres    false    5            �      x�3H24MJN65NK1����� .�9      �      x������ � �      �      x������ � �            x������ � �            x������ � �            x������ � �            x������ � �      	      x������ � �            x������ � �         �   x��бq1И�� �� m��!�³�?�&��y���>C��89Ax��=���[�M�Y/���Z�C��|,�_� �rE���|�v���k�
\-�SIY�A~�1�������p�s��CC��k�O�S8Yk���+P�|��a�J�l8WJ���O��k�A����tfK9����+/�aU5��k��B�ݤ�
�ը����k�n�[*�^�����8~ ��c�            x������ � �            x��}koɒ�g�_���e��|?\�ʦ�+����)q�0_����g�1����{�,R�æd-�6l���S�qNddJ}�N:)������?��p���7&��F��ɥa\3�~�Ą�;"|��漵�-���8��ҝ_��?z�u֊����N��hw�O[[]�&�O3ϟv������[����<N��:\���q��דUJk�<�8�n���#����	ޗn�2�	�cB>Y�S\�O��TK�ßâ����8���Ϟ"���'<t��6��W�d!p��˿N����ާ��Ҏ�i>�>��r�W=����^�������Ud��*������1ã�EDT�{g�w�]r��{��̀�oRa<'Fu��F��?��`���;-~gr��'�����J^��}�_�>:�%���tt={��Pd��?/?]���ד���<>��'��Oz�v����ӥ��t���ׇ������t�����$��$���σK��������E��q:��L>�T���x:M���Y�g~Z�������]�d���_Ӈ�=��R���������ǿ��㟫����vaDy�@���gu�������JŪ0����LX٨����.jӄڬ|$��Խ��C'	���1������
���Iӕ�T�[�Y,���5+
��EԮ	�p��A���;Zw��'Z�����=��~������������_�=����~�������������i������/yP�_��r�u����[+GH�+�~�_*�Uh*WbXҳ���Tc.t)	��<��/_�ߟh۱Z�`�_YU�ά�~��"}X�İt��w�Y��LM,	��<�ů^��?Q�L��@�Z[��]���|��o���|�y��^?� %����l�����4�O�����齂���.���q�"H!��UH����@�)|�$} ��ozW���N��Ƙ���r����L��4Oýq�^7YM1�������UQ����Sɍ���s3!���%ق��.����} ��q�t~�}�J,έչm�ҚutZN��,������~"��p��$F����s��1[�����و�D^�ym��ׇT^��7��aJ��G�4d@D4,h^��ʨ� =wUھ��-s�eGy��HWF��^���m�j)d��R:�A_Xa��<66(�/7���K>�����_�Wn_�`�>�Uy�V���Mrq������������O��j�"��>�2щ�Ui?�ؿ�BX���Y�,��F��U�kA�7���D��/�\��
<v�=��$'	�"��K��f���� y����wq����"�V�������0T���b!r�a_{Q��Ubͭ@+����vjtk�>x}�Ӽw�-2x:�����������}6>��#1K�![�#�Ld~q�c�ڃ>Z^0�f��'��lX����V-���m���U�pD�C�[+2�< ��q6��t�- p��� �1��{�KO?��S
o�^�r�.���e�֪+�X��楎,GX���ζ���@{�UBki�Э�l���fw>��d�3`��d|�7����~�E���w2!��"92���*`��LW���ay� �,+��M��ƺ�(�އ�6�M�
�i*�O�/��dA�;��}�?}LH���Uop+���ƧG�TR��b��
�;F�,� �k[q_��zfq�5M_,���*�F8m�n��q����'N[3GԺ���H����y��M��HM�ҞaY{���B�*�|e��K��F1y�r�]��"1'*t����s���BT���5�戁d�g���1�s��K|�n�w�ô��^���&�^�5Ļ���p�_�j��Z9�b�:��%��g�ےqϾ��${�9&U�8ie3�fu62��+.�Dp��[V� ���,<o�����Z��9�m���7� :Ax,�o��Z�w7��e%��%H@�*�f>Fx&�����%قu��~/
}�P����J�}�k+�V+��VR���i��Bj1�n>CZ�c��٭�?q��,˻Q��H(��!��h�kX��H5u�l�KaJ���C�m��y�[D����� �:$�{}Ȟ��W����U>������G٘����QY$��蘫ʚi�H�:���%T�kY$_SB�N�?��í�e�m�Rڭ���V'�Yҝ�lq�>��C�=E�B�E��d:�d��Er�=$�D�������AGh9�9�c͂i&���J�Vۨ70^rI8 ��ln��=�
�whf��AJL�1I�C�g����h>�:�C�H�`DGf�3�D�=�xv��Y��� ��Tڄ��k;�q�DG"ᨰum�2���E[Ԣ�L5��Q{�k^ʽ��l9^[�y�G�`�@u	��/�$~7�>3ʵv���I����O�V��8�'�<�LP����b5~;�<������QZ$�X(J�Bp�b)xm]X����R�K�����U)��?��x���_-& zJ�LPy?Kf����8\B�	���Qu�v�s,&�.X#�X�<�,B�7�ւJ��I#w����]�ޝ������<���xJ�����4g"���|��B�����ѕl��%gewk8��Xf�&z��J��J~C��?1����@�Z[�P� �?fy�|��ߍ	`���N�� ��#qwq-S��g`G�wS�*����V�a����F��[�ʾ��E�5��joIo�\k{pM?fc���=�.q*� �@���ع�.�)��|7E,?����\p��R�h�|��}SG7׮�<�7T�xڕ��s�K����(Moy:M�ʗ��g�${2����y<����%^Αz7�h\��-$��PF����8�[���+6�
�<B1c� ?Y���.W�%���n�Ű"g&�gd#��K���Ư�a� qovo�Hfnw�Gb�H��W\�XYՖ�^_W�q�^�����<h_�f{P�:RJa���*̚@?mo�2�I
��T/̻ t�u�/=��/������P���|u��ho%<�r�.A�,yİ�L�3�X����_D,�t���l�͓E5K�*�=���16���s�x���A`�T�qܭ���`II�E*M�N�gV�QP[�����\�_8��͐JЩ<Cp����|���� m�tp$����r�yb,ڻ���u)k�w��F��D�;�,����U���?f�,�B>{�}�3!���'`.�#$q�_�J�c(���(]k�((��Xk$��L^�2 �ն����k�t���W��*�K\�� �N�^Q��n��.�P�2�qѽ�@g�d�5ܚ^w8I��.�LٔR0kAW����qQ�Ԙ�2-[�o`k���:�)�W�}�Z�;��U*�F #���&�~3Ig���@~�糛a>&�v��9W��X�(]~V�vkQǦ*mc+F�Vu�5���
��f;U�-F��Үk?[���t�OL�ǂ����ϧ�{�������j�:��򋳇dIS��5x���j�)j��N���,��k�?]�[�
'\u��Z��[�2���7�.�aڍ kS3��*toi�+Z��[���(�X��3�X����+dk�Τ��ڈPr�bi1�t�o��zav怣�V%Nn(�SA{���g���6LAKiom�ϲ��4��H�cJ�kb�)86V��2)��(jm+����%�p"����w{�7Vk�;������dp��d� ������lu�����K�����Z���޲������v��"�H�+��kfKXʞ(D�`l؛�O�e'�ٍ\��yC�y?���=�}k�t�{>NWp�Ǥ�-�*�-Q+�n���� ,ʪ�B�A�4�`9-]�
�y���
r�����
�N�9V�'Oߌ���}6��65@�^?��4���^�ZǺfI�iPV�4T�!8�p.[�M�1�J)G��~�/�ASK����c�@o�i�pˑ��EME�lv3[����`z��>����,;�`
�֔UC�$����B�+M�5e��V���@�,}'p�= ��J�6��{���`�    �&�O��w#���9 b>����S�0��xT~�������)�A1SF���JQ8�JQ�vUZmd�s'픰��&�^j�۠���3�6O��M	���_4`���S�x�E��Q�ʽ�����l��W�HIMF���>���Ú ��3�ڗ��d|;�=�!i�g|�n�Ғy�ⷼ������Hǣ��0Se>Ph
�U͔^�Z6E�����\9BҖ�FR�fdkUP2z�n73��u�|�'��1ݨ�A��gU7��z�|�G�`��g�>�Cd��M�ϬR;�>3��}"F�<&��>�C~D����n�."T��,��f�_n�D˔��i����qVWιF7�7��2�g�dtG��mY1C�x�D6;[ T�݀��e"��9��f	�H��8�<GIޭ=�PE�.����|�<.�c���B�Uݪ&��Nz^�����=XR*��'�Vaͦ9~]�,o��K�,-�@¦��Md�����"�K��o�O$r�c:�~�d��� _��^t�v�)Y�Ղ�V8e�p��V��&�|dV��OA��ԁh�>쵕���vՋbѵ�Jz�4����q�F�&ɜ+,�E�ϡ�>��^S� ��/���%���T�w��)d�+��jo{��䲁MR����d�Z*�>�t�C�?/�ZZ!�Q�3���(�OG�ic{v5��C� {y�D]{�k��kJM{�+M@V�e	�S*Ѵ;M��+�+��e[�2Z�
�gVa5A�ļ����Gś�e��^�#_\��e���4��.��M̲�	H����g����Z��4M��m0V��j$T���Z��gVk��c���HZ�Kg��G����$�۬�D^��@َ�Pϑ*]ݘ����
�KG[W�J��٦T���ƚ��@�Ӕ�8ڴ��7OV��b�:�4R�Bq˪��j�Ԭ������J�R�_�o^��\��Y�K:w������&�ϭ�9����tv;����{��L�:&(����g�<��=O����Z��;���	��D���U!�z���1Ar���v�v��3+"��5���wS:���ԋ�rA%�Ҙ���g��f���;�ݏ��;�mjjg���h�(PŚ��Eŋ�Iֺ�2!r��QV�]J�̪��9ɲ�Q8	Q��!�`}E��ڙZ����#[��M��Jp�H7k�ٴ��l$�l���)��K�7cj�����y��P�|�U�!�D^>��J�AY�P[���H;�F(���K�Ԗ�mxh�[ ��@�Y[��䡭�q�v>�ق�R�=�$����4�~�x-��yz���c����J�����7*hVF_1�*+�c\�_:��|#Ifj���=�dTn�}h�ԍ-��Y���JKVp�7���u����k���������1r�`�s���e[-$����|�}R�	+���	��K�◯�i+��ʼ�cwZ��[[�~�q��{A��SsM!=T�ҕ�1[B��2���#[����EIEY˹�9=�̊��9ӳ��E��OI�-�E5]�v��D�/�1�^���I޿]�G�8��� ��Ԫ�`�E�D%U�+��Оrp?M��o�Sb5F����
����3(�YN�0[�.�$zF$�+5]S�=b��C:Έdi^Ѣ��-��\�1p�h�$�Q�s��rڼvZC����Nt�Jw��fZy渄������g�L%
�_��_�-X��F`���xAW���r�שJ<�ᦉ������JJ���F��.ʊ�=�?Ï?����Z�
��&bEM�fuk�a}ˈ����t��ԧN��� ϗ<qR�Et�@�y7%�t�~g(Cm*Uc	Jʱ�f��	�l)c�*�ӄr��;.�M�֪B��ڹ�`�3��Z>�%ˎ�dA��HfW�D3YL� ���(� �d^Rv�
�T`\���Q�B���O�%,c���LF�n���`���f���F �
�ͤץ��pY�gTm��q�+'���;��%����Z��Fz�ض���@��>!��ͲOVd�<�d��!���xC��8���lA}F73�C�G��C:ӟ�Ihj�E��/���`�n�L��*�B��J��p��E�X����^[9Wj���b��i��h��K� ���{Nm����7@ Ӊ�#��k��%tI�����*����7��vz���>,�TD��SA���j�9Ƥv���K��s�{H�Zv��6�kj�������t�u~T/)�(�m��H$�F��1���Z/�7�H:��O�M�^�y�ɪ�<��I2�����}FWcݣ��A>L��K����T�����Q��z�ִSYx�\h�4�X���zM��D*Z�Ft��Ǽ6r�bGi�
�Μ�$_���w�\�bI_ђ���ǜ���cĹԲ�ut`�0[_�RbI[�D�� z�rHoބYYre�a��e���7�yNgל*��r�Lkp3�}� {>��%&����UB�5��t�*K]t����g�M��Xv��@�7�&�Gwb�^��X�������Anԁ������Z�]:�y���R�iޭ���z�\���9S�L�&@-8�@ �f�źruS)�r�Z�ڐ�C�s m�V�%��|�&�,ǻ"�NrD����N����:���(�:K��~��k����@ UE��R!ـ��Zզ�Dío+5�-��!#;\p�����ʑc͡�9�t&�u$&�����:�0�l�"��"��k=&c�c��������UU��UdEc��%e����o!�fy]&�x;'·�����]��w{�t��9I���Mڽ�uyF!]L'	(�<�keC,#p�]�-+<Op���U�m�Vx4�0'�w�G��AOV���=@ݨ�n:K)�v'ԧ�H'Ozݯzy��"�C�t|;O���P9�U��y:/|d�{:KSk�nCPx�r:�P#C�cROFCk������oE:�8U�&�KM�"��9��^�[��O�1���H��X^yVK�c(0;!jk8�����B-mZ���~e��JO<�h�{X\Q2�H�2���ե#tĨ5���/���ge�$2��1P����Ō�MUK-Lٞ$o�������ef|_o�
�2
c^s8�t�d:�$,�ͧk��lq��<O��􏝶QQB���CTn5�`�]�'��<x���կ�P��K���r��ʑ+�n�JG�wW׌{�5�q�
S�*U�_s�K����D��r�v.�޲:H��w
qpej'����偌�K䮄���3\^ѡy��>vWa-�����tܨ��</L,k���v���PIO�`��@��<8�.�m��
bi�!�s����S�"��&�������#��U""�c��t�d�i<p��B�^'/���N�(��ڥ�n�I>3
c6�)��kh�K&��'K�QIh�J.���5'�_�~x�����U�B�]m�d��r�>D��!�GȎ���8��R��tL�,$tZ1�o��k�J<��Zk�}Iw�:I
>F�Z�SbU�J[W�u���5NR�Q;����c���܊�Nj�
'>��	�x�58�z�<=8C���=|�7�R`�n���rB�1��|��ɜN���"���~�*ڄU�_�r�[�w����|�i6;�-� '����Ndp9O�]�7�l��ۤ��E�^�e���M�/�:�RZLM�D�����\ɦ�<"]���B��3C[V��7���G��a��q�V�B%����I�Z�v��q��o9��1�9��J��	���P�7�h��^{����-Ԏ����Ж���x{Ȫ6۞]��U�M䔍�����C���a��o��} ���E�\.u���~�?�'+7?8W��u�t�.��(���G�6��k�?��g�C7B������C�?�Uz���bg��-i%dEq�a9�B�&*��ፖ�8CS�s�����r�/hm\\[�;pG7�*��M��=`U�����Pe aä�;���"k�Y�P�6���lDmAx���ijHI��9�7�[���ۧ�Z���`�����x��ꠌ�����e�l��,    ZJ�2p�m��
��}�*i�Ĩ�*[�t�X-1I����n�/`����7�ΰI&�2C؜߷����æ�B��%wĭ4�����*�ZQS�۽�~�T�j�q{���m���������E#�jY��nr��X�,�����K߸T^���j �?���V���ND�y:�U��e�2�j��4mɪ�$J;�/��6l���<@o�iY���|3�Gg���0�N�8��f�O�-'����+�}�d�u��ߏG�f�;�w%b��3�C0k��t?�~����M���Ó[�<�ш?jo�=���2�tni��
�$����|�j�u����zR�tn��#����������i�.HG���ϭR����L��I�y3��%�^\͖w�/�63e�te=�g�����,1	�h'*���	ok�T��MӔ\������df�u�D�e�Ŕ�{S��U�w�;_e:���ݫ����Cgo~*�A�yp��.�G�����(�ǻ`AS���`Y͝Ve����������wY�         Y   x�3�445�3�0�31�321�4205�,)��J���CC\&��-8�3S�ˋ󓳋��0B�abb�Y��Z�M�!��@�r������� �+�            x������ � �         �   x���1�0��>He;q������J��_�$�6Q���8_f���-D
�����W�AH4P
��I��60'��:mN	�W0VW�+ϡa�����p鐌Z�H�@:Z�`n�k�cx�hj	��D?�	ROY�R�2�@�zl�g��X��{�܃2U}������Wgt�y@��@u�         >  x����N�@�����p\���eck<�E��4�mi��Ű������p��|�h����3���̌
�O�oY>ȥ/%|)AE�r��Eas��=�*M��h����#��~��k?XOQ�	$@A�&��),G�gy&�H�#AF���@AF8�`֢â��f{���_�������:N�G�����0�3H~k�b��"���;��|��8�7��2��$|4�V��\��tְ�o�n�춣�&�EΑqִ�Yō?�2�V2����/���kP�j:v�Y����ygX�5����*��N׾q�㋚	��F;AEQ~ ���            x������ � �            x������ � �         �   x����
�0�s���J>���E�d���|ہ� x	I��#Ab��<�}}��Ǻ����c���p�]]B�#Ȉ<�E-a6A?��M՘�{�p�-��o �II��]:@ Jh�h�� (�A�T,Q8\�K]�_���$�	���)����?u     