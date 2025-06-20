PGDMP  4                    }            vpn_bot #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) #   16.8 (Ubuntu 16.8-0ubuntu0.24.04.1) �    "           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            #           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            $           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            %           1262    16389    vpn_bot    DATABASE     o   CREATE DATABASE vpn_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE vpn_bot;
                sarmad    false                        2615    17403    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sarmad    false            &           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   sarmad    false    5            '           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   sarmad    false    5            �            1259    17404    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    sarmad    false    5            �            1259    17488    config_cisco    TABLE     *  CREATE TABLE public.config_cisco (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    group_name character varying,
    group_password character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.config_cisco;
       public         heap    sarmad    false    5            �            1259    17487    config_cisco_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_cisco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_cisco_id_seq;
       public          sarmad    false    5    229            (           0    0    config_cisco_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_cisco_id_seq OWNED BY public.config_cisco.id;
          public          sarmad    false    228            �            1259    17503    config_ikev2    TABLE     (  CREATE TABLE public.config_ikev2 (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    certificate character varying,
    private_key character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.config_ikev2;
       public         heap    sarmad    false    5            �            1259    17502    config_ikev2_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_ikev2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_ikev2_id_seq;
       public          sarmad    false    231    5            )           0    0    config_ikev2_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ikev2_id_seq OWNED BY public.config_ikev2.id;
          public          sarmad    false    230            �            1259    17518    config_ipsec    TABLE        CREATE TABLE public.config_ipsec (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    ike_version character varying,
    username character varying,
    password character varying,
    psk character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.config_ipsec;
       public         heap    sarmad    false    5            �            1259    17517    config_ipsec_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_ipsec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_ipsec_id_seq;
       public          sarmad    false    233    5            *           0    0    config_ipsec_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_ipsec_id_seq OWNED BY public.config_ipsec.id;
          public          sarmad    false    232            �            1259    17533    config_l2tp    TABLE       CREATE TABLE public.config_l2tp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    shared_secret character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.config_l2tp;
       public         heap    sarmad    false    5            �            1259    17532    config_l2tp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_l2tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_l2tp_id_seq;
       public          sarmad    false    5    235            +           0    0    config_l2tp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_l2tp_id_seq OWNED BY public.config_l2tp.id;
          public          sarmad    false    234            �            1259    17548    config_openvpn    TABLE     H  CREATE TABLE public.config_openvpn (
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
       public         heap    sarmad    false    5            �            1259    17547    config_openvpn_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.config_openvpn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.config_openvpn_id_seq;
       public          sarmad    false    237    5            ,           0    0    config_openvpn_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.config_openvpn_id_seq OWNED BY public.config_openvpn.id;
          public          sarmad    false    236            �            1259    17563    config_pptp    TABLE       CREATE TABLE public.config_pptp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    mppe_enabled character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.config_pptp;
       public         heap    sarmad    false    5            �            1259    17562    config_pptp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_pptp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_pptp_id_seq;
       public          sarmad    false    5    239            -           0    0    config_pptp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_pptp_id_seq OWNED BY public.config_pptp.id;
          public          sarmad    false    238            �            1259    17675    config_shadowsocks    TABLE       CREATE TABLE public.config_shadowsocks (
    id integer NOT NULL,
    config_id integer,
    address character varying NOT NULL,
    port integer NOT NULL,
    encryption character varying NOT NULL,
    password character varying NOT NULL,
    created_at timestamp without time zone
);
 &   DROP TABLE public.config_shadowsocks;
       public         heap    sarmad    false    5            �            1259    17674    config_shadowsocks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_shadowsocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.config_shadowsocks_id_seq;
       public          sarmad    false    5    251            .           0    0    config_shadowsocks_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.config_shadowsocks_id_seq OWNED BY public.config_shadowsocks.id;
          public          sarmad    false    250            �            1259    17578    config_sstp    TABLE     �   CREATE TABLE public.config_sstp (
    id bigint NOT NULL,
    config_id bigint NOT NULL,
    username character varying,
    password character varying,
    cert character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.config_sstp;
       public         heap    sarmad    false    5            �            1259    17577    config_sstp_id_seq    SEQUENCE     {   CREATE SEQUENCE public.config_sstp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.config_sstp_id_seq;
       public          sarmad    false    241    5            /           0    0    config_sstp_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.config_sstp_id_seq OWNED BY public.config_sstp.id;
          public          sarmad    false    240            �            1259    17593    config_v2ray    TABLE        CREATE TABLE public.config_v2ray (
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
       public         heap    sarmad    false    5            �            1259    17592    config_v2ray_id_seq    SEQUENCE     |   CREATE SEQUENCE public.config_v2ray_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.config_v2ray_id_seq;
       public          sarmad    false    5    243            0           0    0    config_v2ray_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.config_v2ray_id_seq OWNED BY public.config_v2ray.id;
          public          sarmad    false    242            �            1259    17608    config_wireguard    TABLE     S  CREATE TABLE public.config_wireguard (
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
       public         heap    sarmad    false    5            �            1259    17607    config_wireguard_id_seq    SEQUENCE     �   CREATE SEQUENCE public.config_wireguard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.config_wireguard_id_seq;
       public          sarmad    false    245    5            1           0    0    config_wireguard_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.config_wireguard_id_seq OWNED BY public.config_wireguard.id;
          public          sarmad    false    244            �            1259    17442    configs    TABLE     �  CREATE TABLE public.configs (
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
    active boolean
);
    DROP TABLE public.configs;
       public         heap    sarmad    false    5            �            1259    17441    configs_id_seq    SEQUENCE     w   CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.configs_id_seq;
       public          sarmad    false    223    5            2           0    0    configs_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;
          public          sarmad    false    222            �            1259    17410    inbounds    TABLE     Y  CREATE TABLE public.inbounds (
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
       public         heap    sarmad    false    5            �            1259    17409    inbounds_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inbounds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.inbounds_id_seq;
       public          sarmad    false    5    217            3           0    0    inbounds_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.inbounds_id_seq OWNED BY public.inbounds.id;
          public          sarmad    false    216            �            1259    17623    orders    TABLE       CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    plan_id integer NOT NULL,
    status character varying,
    is_manual boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    description character varying
);
    DROP TABLE public.orders;
       public         heap    sarmad    false    5            �            1259    17622    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          sarmad    false    5    247            4           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          sarmad    false    246            �            1259    17457    plans    TABLE       CREATE TABLE public.plans (
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
       public         heap    sarmad    false    5            �            1259    17456    plans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.plans_id_seq;
       public          sarmad    false    225    5            5           0    0    plans_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;
          public          sarmad    false    224            �            1259    17419    servers    TABLE     [  CREATE TABLE public.servers (
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
       public         heap    sarmad    false    5            �            1259    17418    servers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.servers_id_seq;
       public          sarmad    false    5    219            6           0    0    servers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;
          public          sarmad    false    218            �            1259    17471    tickets    TABLE     0  CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    user_id bigint NOT NULL,
    message character varying NOT NULL,
    response character varying,
    status character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    answered_at timestamp with time zone
);
    DROP TABLE public.tickets;
       public         heap    sarmad    false    5            �            1259    17470    tickets_ticket_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tickets_ticket_id_seq;
       public          sarmad    false    227    5            7           0    0    tickets_ticket_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;
          public          sarmad    false    226            �            1259    17647    transactions    TABLE     |  CREATE TABLE public.transactions (
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
       public         heap    sarmad    false    5            �            1259    17646    transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.transactions_id_seq;
       public          sarmad    false    5    249            8           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public          sarmad    false    248            �            1259    17429    users    TABLE     d  CREATE TABLE public.users (
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
       public         heap    sarmad    false    5            �            1259    17428    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          sarmad    false    221    5            9           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          sarmad    false    220                       2604    17491    config_cisco id    DEFAULT     r   ALTER TABLE ONLY public.config_cisco ALTER COLUMN id SET DEFAULT nextval('public.config_cisco_id_seq'::regclass);
 >   ALTER TABLE public.config_cisco ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    228    229    229                       2604    17506    config_ikev2 id    DEFAULT     r   ALTER TABLE ONLY public.config_ikev2 ALTER COLUMN id SET DEFAULT nextval('public.config_ikev2_id_seq'::regclass);
 >   ALTER TABLE public.config_ikev2 ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    231    230    231                       2604    17521    config_ipsec id    DEFAULT     r   ALTER TABLE ONLY public.config_ipsec ALTER COLUMN id SET DEFAULT nextval('public.config_ipsec_id_seq'::regclass);
 >   ALTER TABLE public.config_ipsec ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    233    232    233                       2604    17536    config_l2tp id    DEFAULT     p   ALTER TABLE ONLY public.config_l2tp ALTER COLUMN id SET DEFAULT nextval('public.config_l2tp_id_seq'::regclass);
 =   ALTER TABLE public.config_l2tp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    235    234    235                       2604    17551    config_openvpn id    DEFAULT     v   ALTER TABLE ONLY public.config_openvpn ALTER COLUMN id SET DEFAULT nextval('public.config_openvpn_id_seq'::regclass);
 @   ALTER TABLE public.config_openvpn ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    236    237    237                       2604    17566    config_pptp id    DEFAULT     p   ALTER TABLE ONLY public.config_pptp ALTER COLUMN id SET DEFAULT nextval('public.config_pptp_id_seq'::regclass);
 =   ALTER TABLE public.config_pptp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    239    238    239            )           2604    17678    config_shadowsocks id    DEFAULT     ~   ALTER TABLE ONLY public.config_shadowsocks ALTER COLUMN id SET DEFAULT nextval('public.config_shadowsocks_id_seq'::regclass);
 D   ALTER TABLE public.config_shadowsocks ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    250    251    251                       2604    17581    config_sstp id    DEFAULT     p   ALTER TABLE ONLY public.config_sstp ALTER COLUMN id SET DEFAULT nextval('public.config_sstp_id_seq'::regclass);
 =   ALTER TABLE public.config_sstp ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    241    240    241            !           2604    17596    config_v2ray id    DEFAULT     r   ALTER TABLE ONLY public.config_v2ray ALTER COLUMN id SET DEFAULT nextval('public.config_v2ray_id_seq'::regclass);
 >   ALTER TABLE public.config_v2ray ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    243    242    243            #           2604    17611    config_wireguard id    DEFAULT     z   ALTER TABLE ONLY public.config_wireguard ALTER COLUMN id SET DEFAULT nextval('public.config_wireguard_id_seq'::regclass);
 B   ALTER TABLE public.config_wireguard ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    244    245    245                       2604    17445 
   configs id    DEFAULT     h   ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);
 9   ALTER TABLE public.configs ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    223    222    223            
           2604    17413    inbounds id    DEFAULT     j   ALTER TABLE ONLY public.inbounds ALTER COLUMN id SET DEFAULT nextval('public.inbounds_id_seq'::regclass);
 :   ALTER TABLE public.inbounds ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    217    216    217            %           2604    17626 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    247    246    247                       2604    17460    plans id    DEFAULT     d   ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);
 7   ALTER TABLE public.plans ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    225    224    225                       2604    17422 
   servers id    DEFAULT     h   ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);
 9   ALTER TABLE public.servers ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    219    218    219                       2604    17474    tickets ticket_id    DEFAULT     v   ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);
 @   ALTER TABLE public.tickets ALTER COLUMN ticket_id DROP DEFAULT;
       public          sarmad    false    227    226    227            '           2604    17650    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public          sarmad    false    249    248    249                       2604    17432    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          sarmad    false    221    220    221            �          0    17404    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          sarmad    false    215   ��       	          0    17488    config_cisco 
   TABLE DATA           q   COPY public.config_cisco (id, config_id, username, password, group_name, group_password, created_at) FROM stdin;
    public          sarmad    false    229   ��                 0    17503    config_ikev2 
   TABLE DATA           o   COPY public.config_ikev2 (id, config_id, username, password, certificate, private_key, created_at) FROM stdin;
    public          sarmad    false    231   ��                 0    17518    config_ipsec 
   TABLE DATA           g   COPY public.config_ipsec (id, config_id, ike_version, username, password, psk, created_at) FROM stdin;
    public          sarmad    false    233   �                 0    17533    config_l2tp 
   TABLE DATA           c   COPY public.config_l2tp (id, config_id, username, password, shared_secret, created_at) FROM stdin;
    public          sarmad    false    235   1�                 0    17548    config_openvpn 
   TABLE DATA           y   COPY public.config_openvpn (id, config_id, username, password, ca_cert, client_cert, client_key, created_at) FROM stdin;
    public          sarmad    false    237   N�                 0    17563    config_pptp 
   TABLE DATA           b   COPY public.config_pptp (id, config_id, username, password, mppe_enabled, created_at) FROM stdin;
    public          sarmad    false    239   k�                 0    17675    config_shadowsocks 
   TABLE DATA           l   COPY public.config_shadowsocks (id, config_id, address, port, encryption, password, created_at) FROM stdin;
    public          sarmad    false    251   ��                 0    17578    config_sstp 
   TABLE DATA           Z   COPY public.config_sstp (id, config_id, username, password, cert, created_at) FROM stdin;
    public          sarmad    false    241   ��                 0    17593    config_v2ray 
   TABLE DATA           �   COPY public.config_v2ray (id, config_id, server, port, uuid, encryption, password, alter_id, security, network, path, host, sni, created_at, address) FROM stdin;
    public          sarmad    false    243   ��                 0    17608    config_wireguard 
   TABLE DATA           �   COPY public.config_wireguard (id, config_id, private_key, public_key, preshared_key, endpoint, allowed_ips, created_at) FROM stdin;
    public          sarmad    false    245   ��                 0    17442    configs 
   TABLE DATA           �   COPY public.configs (id, user_id, protocol, name, created_at, expiration_date, config_name, domain, port, uuid, active) FROM stdin;
    public          sarmad    false    223   ��       �          0    17410    inbounds 
   TABLE DATA           n   COPY public.inbounds (id, server, port, protocol, encryption, password, network, path, host, sni) FROM stdin;
    public          sarmad    false    217   ��                 0    17623    orders 
   TABLE DATA           b   COPY public.orders (id, user_id, plan_id, status, is_manual, created_at, description) FROM stdin;
    public          sarmad    false    247   d�                 0    17457    plans 
   TABLE DATA           n   COPY public.plans (id, name, duration_days, volume_gb, price, description, is_active, created_at) FROM stdin;
    public          sarmad    false    225   ��       �          0    17419    servers 
   TABLE DATA           |   COPY public.servers (id, name, ip, port, protocol, panel_path, domain, is_active, current_clients, max_clients) FROM stdin;
    public          sarmad    false    219   Z�                 0    17471    tickets 
   TABLE DATA           i   COPY public.tickets (ticket_id, user_id, message, response, status, created_at, answered_at) FROM stdin;
    public          sarmad    false    227   ��                 0    17647    transactions 
   TABLE DATA           |   COPY public.transactions (id, user_id, plan_id, amount, currency, status, gateway, reference, type, created_at) FROM stdin;
    public          sarmad    false    249   ��                 0    17429    users 
   TABLE DATA           ~   COPY public.users (user_id, username, phone, balance, lang, role, full_name, language_code, is_admin, created_at) FROM stdin;
    public          sarmad    false    221   n�       :           0    0    config_cisco_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_cisco_id_seq', 1, false);
          public          sarmad    false    228            ;           0    0    config_ikev2_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ikev2_id_seq', 1, false);
          public          sarmad    false    230            <           0    0    config_ipsec_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.config_ipsec_id_seq', 1, false);
          public          sarmad    false    232            =           0    0    config_l2tp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_l2tp_id_seq', 1, false);
          public          sarmad    false    234            >           0    0    config_openvpn_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.config_openvpn_id_seq', 1, false);
          public          sarmad    false    236            ?           0    0    config_pptp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_pptp_id_seq', 1, false);
          public          sarmad    false    238            @           0    0    config_shadowsocks_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.config_shadowsocks_id_seq', 1, false);
          public          sarmad    false    250            A           0    0    config_sstp_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_sstp_id_seq', 1, false);
          public          sarmad    false    240            B           0    0    config_v2ray_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.config_v2ray_id_seq', 4, true);
          public          sarmad    false    242            C           0    0    config_wireguard_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.config_wireguard_id_seq', 1, false);
          public          sarmad    false    244            D           0    0    configs_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.configs_id_seq', 8, true);
          public          sarmad    false    222            E           0    0    inbounds_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.inbounds_id_seq', 4, true);
          public          sarmad    false    216            F           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public          sarmad    false    246            G           0    0    plans_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.plans_id_seq', 10, true);
          public          sarmad    false    224            H           0    0    servers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.servers_id_seq', 8, true);
          public          sarmad    false    218            I           0    0    tickets_ticket_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);
          public          sarmad    false    226            J           0    0    transactions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.transactions_id_seq', 4, true);
          public          sarmad    false    248            K           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          sarmad    false    220            +           2606    17408 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            sarmad    false    215            ?           2606    17496    config_cisco config_cisco_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_pkey;
       public            sarmad    false    229            A           2606    17511    config_ikev2 config_ikev2_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_pkey;
       public            sarmad    false    231            C           2606    17526    config_ipsec config_ipsec_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_pkey;
       public            sarmad    false    233            E           2606    17541    config_l2tp config_l2tp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_pkey;
       public            sarmad    false    235            G           2606    17556 "   config_openvpn config_openvpn_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_pkey;
       public            sarmad    false    237            I           2606    17571    config_pptp config_pptp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_pkey;
       public            sarmad    false    239            [           2606    17682 *   config_shadowsocks config_shadowsocks_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_pkey;
       public            sarmad    false    251            K           2606    17586    config_sstp config_sstp_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_pkey;
       public            sarmad    false    241            M           2606    17601    config_v2ray config_v2ray_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_pkey;
       public            sarmad    false    243            O           2606    17616 &   config_wireguard config_wireguard_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_pkey;
       public            sarmad    false    245            7           2606    17450    configs configs_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_pkey;
       public            sarmad    false    223            -           2606    17417    inbounds inbounds_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.inbounds
    ADD CONSTRAINT inbounds_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.inbounds DROP CONSTRAINT inbounds_pkey;
       public            sarmad    false    217            U           2606    17631    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            sarmad    false    247            9           2606    17464    plans plans_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_pkey;
       public            sarmad    false    225            0           2606    17426    servers servers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_pkey;
       public            sarmad    false    219            =           2606    17479    tickets tickets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public            sarmad    false    227            Y           2606    17655    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            sarmad    false    249            5           2606    17437    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sarmad    false    221            P           1259    17642    ix_order_user_plan    INDEX     Q   CREATE INDEX ix_order_user_plan ON public.orders USING btree (user_id, plan_id);
 &   DROP INDEX public.ix_order_user_plan;
       public            sarmad    false    247    247            Q           1259    17643    ix_orders_id    INDEX     =   CREATE INDEX ix_orders_id ON public.orders USING btree (id);
     DROP INDEX public.ix_orders_id;
       public            sarmad    false    247            R           1259    17644    ix_orders_plan_id    INDEX     G   CREATE INDEX ix_orders_plan_id ON public.orders USING btree (plan_id);
 %   DROP INDEX public.ix_orders_plan_id;
       public            sarmad    false    247            S           1259    17645    ix_orders_user_id    INDEX     G   CREATE INDEX ix_orders_user_id ON public.orders USING btree (user_id);
 %   DROP INDEX public.ix_orders_user_id;
       public            sarmad    false    247            .           1259    17427    ix_servers_id    INDEX     ?   CREATE INDEX ix_servers_id ON public.servers USING btree (id);
 !   DROP INDEX public.ix_servers_id;
       public            sarmad    false    219            :           1259    17485    ix_ticket_user_status    INDEX     T   CREATE INDEX ix_ticket_user_status ON public.tickets USING btree (user_id, status);
 )   DROP INDEX public.ix_ticket_user_status;
       public            sarmad    false    227    227            ;           1259    17486    ix_tickets_ticket_id    INDEX     M   CREATE INDEX ix_tickets_ticket_id ON public.tickets USING btree (ticket_id);
 (   DROP INDEX public.ix_tickets_ticket_id;
       public            sarmad    false    227            V           1259    17666    ix_transaction_user_status    INDEX     ^   CREATE INDEX ix_transaction_user_status ON public.transactions USING btree (user_id, status);
 .   DROP INDEX public.ix_transaction_user_status;
       public            sarmad    false    249    249            W           1259    17667    ix_transactions_id    INDEX     I   CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);
 &   DROP INDEX public.ix_transactions_id;
       public            sarmad    false    249            1           1259    17438    ix_user_username_phone    INDEX     S   CREATE INDEX ix_user_username_phone ON public.users USING btree (username, phone);
 *   DROP INDEX public.ix_user_username_phone;
       public            sarmad    false    221    221            2           1259    17439    ix_users_lang    INDEX     ?   CREATE INDEX ix_users_lang ON public.users USING btree (lang);
 !   DROP INDEX public.ix_users_lang;
       public            sarmad    false    221            3           1259    17440    ix_users_role    INDEX     ?   CREATE INDEX ix_users_role ON public.users USING btree (role);
 !   DROP INDEX public.ix_users_role;
       public            sarmad    false    221            ^           2606    17497 (   config_cisco config_cisco_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_cisco
    ADD CONSTRAINT config_cisco_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_cisco DROP CONSTRAINT config_cisco_config_id_fkey;
       public          sarmad    false    229    223    3383            _           2606    17512 (   config_ikev2 config_ikev2_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ikev2
    ADD CONSTRAINT config_ikev2_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ikev2 DROP CONSTRAINT config_ikev2_config_id_fkey;
       public          sarmad    false    223    3383    231            `           2606    17527 (   config_ipsec config_ipsec_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_ipsec
    ADD CONSTRAINT config_ipsec_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_ipsec DROP CONSTRAINT config_ipsec_config_id_fkey;
       public          sarmad    false    223    3383    233            a           2606    17542 &   config_l2tp config_l2tp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_l2tp
    ADD CONSTRAINT config_l2tp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_l2tp DROP CONSTRAINT config_l2tp_config_id_fkey;
       public          sarmad    false    223    235    3383            b           2606    17557 ,   config_openvpn config_openvpn_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_openvpn
    ADD CONSTRAINT config_openvpn_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.config_openvpn DROP CONSTRAINT config_openvpn_config_id_fkey;
       public          sarmad    false    223    3383    237            c           2606    17572 &   config_pptp config_pptp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_pptp
    ADD CONSTRAINT config_pptp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_pptp DROP CONSTRAINT config_pptp_config_id_fkey;
       public          sarmad    false    3383    239    223            k           2606    17683 4   config_shadowsocks config_shadowsocks_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_shadowsocks
    ADD CONSTRAINT config_shadowsocks_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id);
 ^   ALTER TABLE ONLY public.config_shadowsocks DROP CONSTRAINT config_shadowsocks_config_id_fkey;
       public          sarmad    false    223    251    3383            d           2606    17587 &   config_sstp config_sstp_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_sstp
    ADD CONSTRAINT config_sstp_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.config_sstp DROP CONSTRAINT config_sstp_config_id_fkey;
       public          sarmad    false    241    3383    223            e           2606    17602 (   config_v2ray config_v2ray_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_v2ray
    ADD CONSTRAINT config_v2ray_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.config_v2ray DROP CONSTRAINT config_v2ray_config_id_fkey;
       public          sarmad    false    243    3383    223            f           2606    17617 0   config_wireguard config_wireguard_config_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.config_wireguard
    ADD CONSTRAINT config_wireguard_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.configs(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.config_wireguard DROP CONSTRAINT config_wireguard_config_id_fkey;
       public          sarmad    false    245    3383    223            \           2606    17451    configs configs_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.configs DROP CONSTRAINT configs_user_id_fkey;
       public          sarmad    false    223    221    3381            g           2606    17632    orders orders_plan_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_plan_id_fkey;
       public          sarmad    false    225    3385    247            h           2606    17637    orders orders_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          sarmad    false    247    3381    221            ]           2606    17480    tickets tickets_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_user_id_fkey;
       public          sarmad    false    3381    227    221            i           2606    17656 &   transactions transactions_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_plan_id_fkey;
       public          sarmad    false    249    225    3385            j           2606    17661 &   transactions transactions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_user_id_fkey;
       public          sarmad    false    3381    221    249            �      x�K63�H156�LI������ +J�      	      x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �         �   x��бq1И�� �� m��!�³�?�&��y���>C��89Ax��=���[�M�Y/���Z�C��|,�_� �rE���|�v���k�
\-�SIY�A~�1�������p�s��CC��k�O�S8Yk���+P�|��a�J�l8WJ���O��k�A����tfK9����+/�aU5��k��B�ݤ�
�ը����k�n�[*�^�����8~ ��c�            x������ � �           x�}бN�@����('�g�ϷU0 !ѡK�4	��4IA�=�d@������࢒�Zp�m߻�i�JTfaN���.1\!f�ɣ������,BQvۇ�)�?*j�8�R͌��!��M�X,.)�����:άD��2�D��g!�3�D12-�8�u����?�Q��3�y�D�ZZ"Mi� dK*9�𳿹~_5�G��/�wzAd��8..7�h�6w����f}s�9��掟��N�����vp	��S�M]b�4%�P��IK��S��a�b닢�����      �   Z   x�3�445�3�0�31�321�411�,�I-.��CC\F�-,8�r��6FWmd`j�YR�����E�	����)�������,����� Q�+�            x������ � �         �   x���;1��>�'��h�h��@*�/�d�$Q�i�l��~~� ��F�ഇ���uC}G������2����Ĺq:�����q{]/����k��� `�͌�c�<��|�e�-�+��u`�T4o��1����6��J3���*�V���ed�m�[�[�k3A�Uՙܰ���*#�iU�y�i��o#u�      �   9  x����N�@�����p\������xh�J�i�mi��Ű�/�cx�x���T>��� ���d��vfT�||x��F��h)�3��v��IM
�mQ�w��,�Sg��Ã1��8֞����b���J��
�k��b
���%5�I���:�Q�SP��<�����:��8
o\%u`Tc�j��ϫޤ
/�y��hBlߝ��g+	%��	�r/�Y�6����do�U3P5)r�����l�*&nt�I_x�dC,��kѫ�a��휻i��f|i�vGUO�v��}��YW�ux�0U�av^��(_e��A            x������ � �         �   x��н
�@�z�)�%������؊�M�FP�I��{�@�8�T�C`�Ό{�p<�k�]�1>�����\DEU*\�70�(�Q�hX3�vl��x	3�&lnF+�6�&����pY���\�Ȅ�=#�x�eY�
�}��i��h���jEu��9���4S         �   x���1
�0Eg��K�$K��Cti���� Mz�Z�.]
B�'��3�2ْ֫Bo�޷�ÈYg���DR+sT�h�cc���l����Us�E(���8�.��~|��	�q��~e������йl�!�҉1K     