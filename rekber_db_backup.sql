--
-- PostgreSQL database dump
--

\restrict kHmOs6TICGNbgDRcaHLfKksALdR1Jxg8ImATmV20t4X6aN3gCUdccNVlmCgWcRR

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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
-- Name: transaction_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transaction_status AS ENUM (
    'waiting',
    'active',
    'sent',
    'accepted',
    'complete',
    'payment_pending',
    'failed'
);


ALTER TYPE public.transaction_status OWNER TO postgres;

--
-- Name: verification_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.verification_status AS ENUM (
    'unverified',
    'pending',
    'verified'
);


ALTER TYPE public.verification_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: listings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listings (
    id integer NOT NULL,
    seller_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    price numeric(15,2) NOT NULL,
    category character varying(100) NOT NULL,
    image_url text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.listings OWNER TO postgres;

--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listings_id_seq OWNER TO postgres;

--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listings_id_seq OWNED BY public.listings.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    sender_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    sid character varying NOT NULL,
    sess jsonb NOT NULL,
    expire timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    buyer_id integer NOT NULL,
    seller_id integer,
    listing_id integer,
    title text NOT NULL,
    price numeric(15,2) NOT NULL,
    room_code character varying(20) NOT NULL,
    status public.transaction_status DEFAULT 'waiting'::public.transaction_status NOT NULL,
    account_email text,
    account_password text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_paid boolean DEFAULT false NOT NULL,
    snap_token text,
    payment_url text,
    midtrans_order_id character varying(100),
    payment_deadline timestamp with time zone
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    replit_user_id character varying NOT NULL,
    username character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    profile_image_url character varying,
    phone character varying,
    dana_number character varying,
    verification_status public.verification_status DEFAULT 'unverified'::public.verification_status NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    identity_photo_path text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listings ALTER COLUMN id SET DEFAULT nextval('public.listings_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listings (id, seller_id, title, description, price, category, image_url, is_active, created_at, updated_at) FROM stdin;
1	2	Akun Mobile Legends Mythic Glory	Akun ML season 30, rank Mythic Glory 700 stars. Hero 120+, skin 85+, custom emblem maximal. Semua mode sudah unlock. Aman dan terverifikasi.	2500000.00	Mobile Legends	https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
2	2	Akun PUBG Mobile Conqueror	PUBG M season 28 Conqueror. KD ratio 4.2, win rate 62%. UC 15000, M416 Glacier, AWM Chromatic. Account level 90.	1800000.00	PUBG Mobile	https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
3	3	Akun Genshin Impact AR60 Full	Genshin Impact AR60, semua karakter 5 bintang sudah ada: Hu Tao, Raiden, Kazuha, Venti, Zhongli, Ayaka dan 8 lainnya. Welkin sudah aktif 90 hari.	5500000.00	Genshin Impact	https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
4	3	Akun Free Fire Heroic Rank	Free Fire rank Heroic season 37. Diamond 50000+, semua karakter maximal (Alok, Chrono, Skyler). Pet Robo dan Detective Panda. Aman dijamin.	750000.00	Free Fire	https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
5	4	Akun Valorant Immortal 3	Valorant rank Immortal 3, 78 skin agent unlocked. Vandal Champions 2023, Prime Phantom, Reaver Karambit. 500+ hours playtime. Region SEA.	3200000.00	Valorant	https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
6	2	Akun ML Mythic Epic Gear	Mobile Legends Mythic rank, hero 80+, skin epic 30+. Termasuk skin Granger Legend. Akun lama 5 tahun aman.	1200000.00	Mobile Legends	https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
7	3	Akun PUBG Global Conqueror	PUBG PC/Global Conqueror dengan KD 6.8. Inventory penuh senjata rare. Level 800+. Semua mode Conqueror.	4500000.00	PUBG Mobile	https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
8	4	Akun Genshin Starter Pack	Genshin Impact AR30, Hu Tao + Venti sudah ada. Bagus untuk pemula yang mau langsung punya karakter kuat. Harga terjangkau.	350000.00	Genshin Impact	https://images.unsplash.com/photo-1614680376408-81e91ffe3db7?w=400&q=80	t	2026-05-03 03:47:58.329806+00	2026-05-03 03:47:58.329806+00
9	6	epep sultan	max 1 s1, full bandle kakasi, full passs	250000.00	Free Fire	\N	t	2026-05-03 04:12:26.481586+00	2026-05-03 04:12:26.481586+00
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, transaction_id, sender_id, content, created_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, buyer_id, seller_id, listing_id, title, price, room_code, status, account_email, account_password, created_at, updated_at, is_paid, snap_token, payment_url, midtrans_order_id, payment_deadline) FROM stdin;
1	5	2	1	Akun Mobile Legends Mythic Glory	2500000.00	DEMO01	active	\N	\N	2026-05-03 03:48:15.989094+00	2026-05-03 03:48:15.989094+00	f	\N	\N	\N	\N
2	5	3	3	Akun Genshin Impact AR60 Full	5500000.00	DEMO02	waiting	\N	\N	2026-05-03 03:48:15.989094+00	2026-05-03 03:48:15.989094+00	f	\N	\N	\N	\N
3	6	\N	9	epep sultan	250000.00	405E5B56	waiting	\N	\N	2026-05-03 04:13:23.542508+00	2026-05-03 04:13:23.542508+00	f	\N	\N	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, replit_user_id, username, first_name, last_name, profile_image_url, phone, dana_number, verification_status, is_admin, created_at, updated_at, identity_photo_path) FROM stdin;
1	demo_admin_001	AdminRekber	Admin	Rekber	https://api.dicebear.com/7.x/avataaars/svg?seed=admin	\N	\N	verified	t	2026-05-03 03:47:26.215974+00	2026-05-03 03:47:26.215974+00	\N
2	demo_seller_001	GamingPro99	Budi	Santoso	https://api.dicebear.com/7.x/avataaars/svg?seed=budi	\N	\N	verified	f	2026-05-03 03:47:26.215974+00	2026-05-03 03:47:26.215974+00	\N
3	demo_seller_002	MLBBKing	Rina	Wijaya	https://api.dicebear.com/7.x/avataaars/svg?seed=rina	\N	\N	verified	f	2026-05-03 03:47:26.215974+00	2026-05-03 03:47:26.215974+00	\N
4	demo_seller_003	PUBGMaster	Deni	Kusuma	https://api.dicebear.com/7.x/avataaars/svg?seed=deni	\N	\N	pending	f	2026-05-03 03:47:26.215974+00	2026-05-03 03:47:26.215974+00	\N
5	demo_buyer_001	NewGamer123	Sari	Indah	https://api.dicebear.com/7.x/avataaars/svg?seed=sari	\N	\N	unverified	f	2026-05-03 03:47:26.215974+00	2026-05-03 03:47:26.215974+00	\N
6	58564438	haharisaamin	Haharisaamin		https://lh3.googleusercontent.com/a/ACg8ocJurwCbCGkkFBAll_lCvIccnDqmuHc24CirvsswG-SZYyDgZeo=s96-c	+6287656783456	0853854099071	unverified	f	2026-05-03 04:09:42.204801+00	2026-05-03 04:42:11.388+00	\N
\.


--
-- Name: listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listings_id_seq', 10, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_room_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_room_code_unique UNIQUE (room_code);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_replit_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_replit_user_id_unique UNIQUE (replit_user_id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_session_expire" ON public.sessions USING btree (expire);


--
-- Name: transactions_midtrans_order_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX transactions_midtrans_order_id_unique ON public.transactions USING btree (midtrans_order_id) WHERE (midtrans_order_id IS NOT NULL);


--
-- Name: listings listings_seller_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_seller_id_users_id_fk FOREIGN KEY (seller_id) REFERENCES public.users(id);


--
-- Name: messages messages_sender_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_users_id_fk FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: messages messages_transaction_id_transactions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_transaction_id_transactions_id_fk FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: transactions transactions_buyer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_buyer_id_users_id_fk FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: transactions transactions_listing_id_listings_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_listing_id_listings_id_fk FOREIGN KEY (listing_id) REFERENCES public.listings(id);


--
-- Name: transactions transactions_seller_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_seller_id_users_id_fk FOREIGN KEY (seller_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict kHmOs6TICGNbgDRcaHLfKksALdR1Jxg8ImATmV20t4X6aN3gCUdccNVlmCgWcRR

