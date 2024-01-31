--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2024-01-31 22:18:39

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

ALTER TABLE ONLY public.threads DROP CONSTRAINT threads_thread_list_id_fkey;
ALTER TABLE ONLY public.thread_list DROP CONSTRAINT thread_list_category_id_fkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.threads DROP CONSTRAINT threads_pkey;
ALTER TABLE ONLY public.thread_list DROP CONSTRAINT thread_list_pkey;
ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
ALTER TABLE public.users ALTER COLUMN _id DROP DEFAULT;
ALTER TABLE public.threads ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.thread_list ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users__id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.threads_id_seq;
DROP TABLE public.threads;
DROP SEQUENCE public.thread_list_id_seq;
DROP TABLE public.thread_list;
DROP SEQUENCE public.category_id_seq;
DROP TABLE public.category;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24725)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    category_name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    create_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24724)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 214
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- TOC entry 217 (class 1259 OID 24763)
-- Name: thread_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thread_list (
    id integer NOT NULL,
    question character varying(255),
    description character varying(255),
    category_id integer,
    date_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id integer NOT NULL
);


ALTER TABLE public.thread_list OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24762)
-- Name: thread_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.thread_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thread_list_id_seq OWNER TO postgres;

--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 216
-- Name: thread_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.thread_list_id_seq OWNED BY public.thread_list.id;


--
-- TOC entry 219 (class 1259 OID 24778)
-- Name: threads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.threads (
    id integer NOT NULL,
    description character varying(255),
    thread_list_id integer,
    date_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id integer NOT NULL
);


ALTER TABLE public.threads OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24777)
-- Name: threads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.threads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.threads_id_seq OWNER TO postgres;

--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 218
-- Name: threads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.threads_id_seq OWNED BY public.threads.id;


--
-- TOC entry 221 (class 1259 OID 24797)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    _id integer NOT NULL,
    user_name character varying(225),
    email character varying(225),
    user_password text,
    user_thread_likes integer[],
    user_thread_dislikes integer[],
    date_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24796)
-- Name: users__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users__id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users__id_seq OWNER TO postgres;

--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 220
-- Name: users__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users__id_seq OWNED BY public.users._id;


--
-- TOC entry 3188 (class 2604 OID 24728)
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- TOC entry 3190 (class 2604 OID 24766)
-- Name: thread_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread_list ALTER COLUMN id SET DEFAULT nextval('public.thread_list_id_seq'::regclass);


--
-- TOC entry 3192 (class 2604 OID 24781)
-- Name: threads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads ALTER COLUMN id SET DEFAULT nextval('public.threads_id_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 24800)
-- Name: users _id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN _id SET DEFAULT nextval('public.users__id_seq'::regclass);


--
-- TOC entry 3349 (class 0 OID 24725)
-- Dependencies: 215
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, category_name, description, create_date) FROM stdin;
1	c	It is a basic programming language.	2024-01-13 16:24:52.701643
3	cpluse	An object-oriented version of c.	2024-01-14 11:32:56.312676
4	C-hash	It is an object-oriented programming language created by Microsoft that runs on the .NET Framework.	2024-01-14 11:32:56.312676
5	Java	Java is high level object oriented language.	2024-01-14 11:32:56.312676
6	python	python is dynamic interpreting scripting language	2024-01-14 11:32:56.312676
7	kotlin	Kotlin is a modern, trending programming language.	2024-01-14 11:32:56.312676
8	HTML	hyper text markup language is used develop webpage	2024-01-14 11:32:56.312676
9	CSS	Cascading Style Sheets, fondly referred to as CSS, is a simply designed language intended to simplif	2024-01-14 11:32:56.312676
10	javascript	javascript is object oriented programming language \\r\\nused for developing backend process	2024-01-14 11:32:56.312676
11	bootstrap	Bootstrap is a free, open source front-end development framework for the creation of websites and we	2024-01-14 11:32:56.312676
12	react	React is a JavaScript library created by Facebook\\r\\n\\r\\nReact is a User Interface (UI) library\\r\\n\\r\\nReact	2024-01-14 11:32:56.312676
13	php	php is a server-side language that can be used in conjunction with a database to create dynamic web 	2024-01-14 11:32:56.312676
2	Node.js	javaScripts runtime environment.	2024-01-14 11:32:56.312676
14	MySql	It is an open source database management system.	2024-01-31 21:52:15.239766
15	SQL	It is a standard programming language for DBMS 	2024-01-31 21:55:12.696394
\.


--
-- TOC entry 3351 (class 0 OID 24763)
-- Dependencies: 217
-- Data for Name: thread_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thread_list (id, question, description, category_id, date_time, user_id) FROM stdin;
\.


--
-- TOC entry 3353 (class 0 OID 24778)
-- Dependencies: 219
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.threads (id, description, thread_list_id, date_time, user_id) FROM stdin;
\.


--
-- TOC entry 3355 (class 0 OID 24797)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (_id, user_name, email, user_password, user_thread_likes, user_thread_dislikes, date_time) FROM stdin;
\.


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 214
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 15, true);


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 216
-- Name: thread_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.thread_list_id_seq', 1, false);


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 218
-- Name: threads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.threads_id_seq', 1, false);


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 220
-- Name: users__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users__id_seq', 1, false);


--
-- TOC entry 3197 (class 2606 OID 24733)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 24771)
-- Name: thread_list thread_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread_list
    ADD CONSTRAINT thread_list_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 24784)
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);


--
-- TOC entry 3203 (class 2606 OID 24805)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (_id);


--
-- TOC entry 3204 (class 2606 OID 24772)
-- Name: thread_list thread_list_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread_list
    ADD CONSTRAINT thread_list_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- TOC entry 3205 (class 2606 OID 24785)
-- Name: threads threads_thread_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_thread_list_id_fkey FOREIGN KEY (thread_list_id) REFERENCES public.thread_list(id);


-- Completed on 2024-01-31 22:18:40

--
-- PostgreSQL database dump complete
--

