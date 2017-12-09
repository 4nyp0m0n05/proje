--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: paylasim; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA paylasim;


ALTER SCHEMA paylasim OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: ortokunma(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ortokunma(okunmasayisi integer, gunsayisi integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ -- Fonksiyon govdesinin (tanımının) başlangıcı
BEGIN
    RETURN  okunmasayisi / gunsayisi;
END;
$$;


ALTER FUNCTION public.ortokunma(okunmasayisi integer, gunsayisi integer) OWNER TO postgres;

--
-- Name: yaziDegisikligiTR1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "yaziDegisikligiTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."yazi" <> OLD."yazi" THEN
        INSERT INTO "paylasim"."Paylasim"("paylasim_id", "yazi", "ptipi", "zaman_id","kull_id","eski_yazi")
        VALUES(OLD."paylasim_id", NEW."yazi", NEW."ptipi", OLD."zaman_id", OLD."kull_id",OLD."yazi");
    END IF;


    RETURN NEW;
END;
$$;


ALTER FUNCTION public."yaziDegisikligiTR1"() OWNER TO postgres;

SET search_path = paylasim, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Ana_konu; Type: TABLE; Schema: paylasim; Owner: postgres
--

CREATE TABLE "Ana_konu" (
    paylasim_id integer NOT NULL,
    tip_id integer NOT NULL
);


ALTER TABLE "Ana_konu" OWNER TO postgres;

--
-- Name: Ana_konu_paylasim_id_seq; Type: SEQUENCE; Schema: paylasim; Owner: postgres
--

CREATE SEQUENCE "Ana_konu_paylasim_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Ana_konu_paylasim_id_seq" OWNER TO postgres;

--
-- Name: Ana_konu_paylasim_id_seq; Type: SEQUENCE OWNED BY; Schema: paylasim; Owner: postgres
--

ALTER SEQUENCE "Ana_konu_paylasim_id_seq" OWNED BY "Ana_konu".paylasim_id;


--
-- Name: Paylasim; Type: TABLE; Schema: paylasim; Owner: postgres
--

CREATE TABLE "Paylasim" (
    paylasim_id integer NOT NULL,
    yazi character varying(500) NOT NULL,
    ptipi character(1) NOT NULL,
    zaman_id integer NOT NULL,
    kull_id integer NOT NULL,
    eski_yazi character varying(500)
);


ALTER TABLE "Paylasim" OWNER TO postgres;

--
-- Name: Paylasim_paylasim_id_seq; Type: SEQUENCE; Schema: paylasim; Owner: postgres
--

CREATE SEQUENCE "Paylasim_paylasim_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Paylasim_paylasim_id_seq" OWNER TO postgres;

--
-- Name: Paylasim_paylasim_id_seq; Type: SEQUENCE OWNED BY; Schema: paylasim; Owner: postgres
--

ALTER SEQUENCE "Paylasim_paylasim_id_seq" OWNED BY "Paylasim".paylasim_id;


--
-- Name: Yorum; Type: TABLE; Schema: paylasim; Owner: postgres
--

CREATE TABLE "Yorum" (
    paylasim_id integer NOT NULL,
    ana_konu_id integer NOT NULL
);


ALTER TABLE "Yorum" OWNER TO postgres;

--
-- Name: Yorum_paylasim_id_seq; Type: SEQUENCE; Schema: paylasim; Owner: postgres
--

CREATE SEQUENCE "Yorum_paylasim_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Yorum_paylasim_id_seq" OWNER TO postgres;

--
-- Name: Yorum_paylasim_id_seq; Type: SEQUENCE OWNED BY; Schema: paylasim; Owner: postgres
--

ALTER SEQUENCE "Yorum_paylasim_id_seq" OWNED BY "Yorum".paylasim_id;


SET search_path = public, pg_catalog;

--
-- Name: Begenme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Begenme" (
    begenme_id integer NOT NULL,
    paylasim_id integer NOT NULL,
    kull_id integer NOT NULL
);


ALTER TABLE "Begenme" OWNER TO postgres;

--
-- Name: Begenme_begenme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Begenme_begenme_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Begenme_begenme_id_seq" OWNER TO postgres;

--
-- Name: Begenme_begenme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Begenme_begenme_id_seq" OWNED BY "Begenme".begenme_id;


--
-- Name: Kull_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Kull_tipi" (
    kull_tipi_id integer NOT NULL,
    kull_tipi character(11) NOT NULL
);


ALTER TABLE "Kull_tipi" OWNER TO postgres;

--
-- Name: Kull_tipi_kull_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Kull_tipi_kull_tipi_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Kull_tipi_kull_tipi_id_seq" OWNER TO postgres;

--
-- Name: Kull_tipi_kull_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Kull_tipi_kull_tipi_id_seq" OWNED BY "Kull_tipi".kull_tipi_id;


--
-- Name: Kullanicilar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Kullanicilar" (
    kull_id integer NOT NULL,
    kull_adi character varying(40) NOT NULL,
    yasi smallint NOT NULL,
    email character(50) NOT NULL,
    sifre character(64) NOT NULL,
    kull_tip integer DEFAULT 0
);


ALTER TABLE "Kullanicilar" OWNER TO postgres;

--
-- Name: Kullanicilar_kull_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Kullanicilar_kull_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Kullanicilar_kull_id_seq" OWNER TO postgres;

--
-- Name: Kullanicilar_kull_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Kullanicilar_kull_id_seq" OWNED BY "Kullanicilar".kull_id;


--
-- Name: Okunma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Okunma" (
    okunma_id integer NOT NULL,
    sayac integer NOT NULL,
    paylasim_id integer NOT NULL
);


ALTER TABLE "Okunma" OWNER TO postgres;

--
-- Name: Okunma_okunma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Okunma_okunma_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Okunma_okunma_id_seq" OWNER TO postgres;

--
-- Name: Okunma_okunma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Okunma_okunma_id_seq" OWNED BY "Okunma".okunma_id;


--
-- Name: Takip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Takip" (
    takip_id integer NOT NULL,
    takip_eden integer NOT NULL,
    takip_edilen integer NOT NULL
);


ALTER TABLE "Takip" OWNER TO postgres;

--
-- Name: Takip_takip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Takip_takip_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Takip_takip_id_seq" OWNER TO postgres;

--
-- Name: Takip_takip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Takip_takip_id_seq" OWNED BY "Takip".takip_id;


--
-- Name: Tip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Tip" (
    tip_id integer NOT NULL,
    tip character(8) NOT NULL
);


ALTER TABLE "Tip" OWNER TO postgres;

--
-- Name: Tip_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Tip_tip_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Tip_tip_id_seq" OWNER TO postgres;

--
-- Name: Tip_tip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Tip_tip_id_seq" OWNED BY "Tip".tip_id;


--
-- Name: Zam_ok; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Zam_ok" (
    zam_ok_id integer NOT NULL,
    zaman_id integer NOT NULL,
    okunma_id integer NOT NULL
);


ALTER TABLE "Zam_ok" OWNER TO postgres;

--
-- Name: Zam_ok_zam_ok_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Zam_ok_zam_ok_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Zam_ok_zam_ok_id_seq" OWNER TO postgres;

--
-- Name: Zam_ok_zam_ok_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Zam_ok_zam_ok_id_seq" OWNED BY "Zam_ok".zam_ok_id;


--
-- Name: Zaman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Zaman" (
    zaman_id integer NOT NULL,
    zaman date DEFAULT '2017-01-01'::date NOT NULL
);


ALTER TABLE "Zaman" OWNER TO postgres;

--
-- Name: Zaman_zaman_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Zaman_zaman_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Zaman_zaman_id_seq" OWNER TO postgres;

--
-- Name: Zaman_zaman_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Zaman_zaman_id_seq" OWNED BY "Zaman".zaman_id;


SET search_path = paylasim, pg_catalog;

--
-- Name: Ana_konu paylasim_id; Type: DEFAULT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Ana_konu" ALTER COLUMN paylasim_id SET DEFAULT nextval('"Ana_konu_paylasim_id_seq"'::regclass);


--
-- Name: Paylasim paylasim_id; Type: DEFAULT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Paylasim" ALTER COLUMN paylasim_id SET DEFAULT nextval('"Paylasim_paylasim_id_seq"'::regclass);


--
-- Name: Yorum paylasim_id; Type: DEFAULT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Yorum" ALTER COLUMN paylasim_id SET DEFAULT nextval('"Yorum_paylasim_id_seq"'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: Begenme begenme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Begenme" ALTER COLUMN begenme_id SET DEFAULT nextval('"Begenme_begenme_id_seq"'::regclass);


--
-- Name: Kull_tipi kull_tipi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kull_tipi" ALTER COLUMN kull_tipi_id SET DEFAULT nextval('"Kull_tipi_kull_tipi_id_seq"'::regclass);


--
-- Name: Kullanicilar kull_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kullanicilar" ALTER COLUMN kull_id SET DEFAULT nextval('"Kullanicilar_kull_id_seq"'::regclass);


--
-- Name: Okunma okunma_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Okunma" ALTER COLUMN okunma_id SET DEFAULT nextval('"Okunma_okunma_id_seq"'::regclass);


--
-- Name: Takip takip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Takip" ALTER COLUMN takip_id SET DEFAULT nextval('"Takip_takip_id_seq"'::regclass);


--
-- Name: Tip tip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Tip" ALTER COLUMN tip_id SET DEFAULT nextval('"Tip_tip_id_seq"'::regclass);


--
-- Name: Zam_ok zam_ok_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Zam_ok" ALTER COLUMN zam_ok_id SET DEFAULT nextval('"Zam_ok_zam_ok_id_seq"'::regclass);


--
-- Name: Zaman zaman_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Zaman" ALTER COLUMN zaman_id SET DEFAULT nextval('"Zaman_zaman_id_seq"'::regclass);


SET search_path = paylasim, pg_catalog;

--
-- Data for Name: Ana_konu; Type: TABLE DATA; Schema: paylasim; Owner: postgres
--

INSERT INTO "Ana_konu" VALUES (1, 2);
INSERT INTO "Ana_konu" VALUES (2, 1);


--
-- Name: Ana_konu_paylasim_id_seq; Type: SEQUENCE SET; Schema: paylasim; Owner: postgres
--

SELECT pg_catalog.setval('"Ana_konu_paylasim_id_seq"', 1, false);


--
-- Data for Name: Paylasim; Type: TABLE DATA; Schema: paylasim; Owner: postgres
--

INSERT INTO "Paylasim" VALUES (1, 'Hikayem var, var, var.', 'H', 1, 1, NULL);
INSERT INTO "Paylasim" VALUES (2, 'Romanım var, var, var.', 'R', 1, 2, NULL);
INSERT INTO "Paylasim" VALUES (3, 'Ooo kardeş yazın şekil.', 'Y', 1, 2, NULL);


--
-- Name: Paylasim_paylasim_id_seq; Type: SEQUENCE SET; Schema: paylasim; Owner: postgres
--

SELECT pg_catalog.setval('"Paylasim_paylasim_id_seq"', 3, true);


--
-- Data for Name: Yorum; Type: TABLE DATA; Schema: paylasim; Owner: postgres
--

INSERT INTO "Yorum" VALUES (3, 1);


--
-- Name: Yorum_paylasim_id_seq; Type: SEQUENCE SET; Schema: paylasim; Owner: postgres
--

SELECT pg_catalog.setval('"Yorum_paylasim_id_seq"', 1, false);


SET search_path = public, pg_catalog;

--
-- Data for Name: Begenme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Begenme" VALUES (1, 1, 2);


--
-- Name: Begenme_begenme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Begenme_begenme_id_seq"', 2, true);


--
-- Data for Name: Kull_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Kull_tipi" VALUES (1, 'Yönetici   ');
INSERT INTO "Kull_tipi" VALUES (2, 'Normal     ');
INSERT INTO "Kull_tipi" VALUES (3, 'Bilinmeyen ');


--
-- Name: Kull_tipi_kull_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Kull_tipi_kull_tipi_id_seq"', 3, true);


--
-- Data for Name: Kullanicilar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Kullanicilar" VALUES (1, 'Ahmet Hasan', 18, 'ahmet@gmail.com                                   ', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2);
INSERT INTO "Kullanicilar" VALUES (2, 'Mehmet Hasan', 20, 'mehmet@gmail.com                                  ', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1);


--
-- Name: Kullanicilar_kull_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Kullanicilar_kull_id_seq"', 2, true);


--
-- Data for Name: Okunma; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Okunma" VALUES (1, 1, 1);


--
-- Name: Okunma_okunma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Okunma_okunma_id_seq"', 1, true);


--
-- Data for Name: Takip; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Takip" VALUES (1, 1, 2);


--
-- Name: Takip_takip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Takip_takip_id_seq"', 1, true);


--
-- Data for Name: Tip; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Tip" VALUES (1, 'Roman   ');
INSERT INTO "Tip" VALUES (2, 'Hikaye  ');


--
-- Name: Tip_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Tip_tip_id_seq"', 2, true);


--
-- Data for Name: Zam_ok; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Zam_ok_zam_ok_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Zam_ok_zam_ok_id_seq"', 1, false);


--
-- Data for Name: Zaman; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Zaman" VALUES (1, '2017-01-01');


--
-- Name: Zaman_zaman_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Zaman_zaman_id_seq"', 1, true);


SET search_path = paylasim, pg_catalog;

--
-- Name: Ana_konu ana_konuPK; Type: CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Ana_konu"
    ADD CONSTRAINT "ana_konuPK" PRIMARY KEY (paylasim_id);


--
-- Name: Paylasim paylasimPK; Type: CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Paylasim"
    ADD CONSTRAINT "paylasimPK" PRIMARY KEY (paylasim_id);


--
-- Name: Yorum yorumPK; Type: CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Yorum"
    ADD CONSTRAINT "yorumPK" PRIMARY KEY (paylasim_id);


SET search_path = public, pg_catalog;

--
-- Name: Begenme begenmePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Begenme"
    ADD CONSTRAINT "begenmePK" PRIMARY KEY (begenme_id);


--
-- Name: Kull_tipi kull_tipiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kull_tipi"
    ADD CONSTRAINT "kull_tipiPK" PRIMARY KEY (kull_tipi_id);


--
-- Name: Kullanicilar kullanicilarPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kullanicilar"
    ADD CONSTRAINT "kullanicilarPK" PRIMARY KEY (kull_id);


--
-- Name: Okunma okunmaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Okunma"
    ADD CONSTRAINT "okunmaPK" PRIMARY KEY (okunma_id);


--
-- Name: Takip takipPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Takip"
    ADD CONSTRAINT "takipPK" PRIMARY KEY (takip_id);


--
-- Name: Tip tipPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Tip"
    ADD CONSTRAINT "tipPK" PRIMARY KEY (tip_id);


--
-- Name: Zam_ok zam_okPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Zam_ok"
    ADD CONSTRAINT "zam_okPK" PRIMARY KEY (zam_ok_id);


--
-- Name: Zaman zamanPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Zaman"
    ADD CONSTRAINT "zamanPK" PRIMARY KEY (zaman_id);


SET search_path = paylasim, pg_catalog;

--
-- Name: Paylasim yaziDegisikligiYap; Type: TRIGGER; Schema: paylasim; Owner: postgres
--

CREATE TRIGGER "yaziDegisikligiYap" BEFORE UPDATE ON "Paylasim" FOR EACH ROW EXECUTE PROCEDURE public."yaziDegisikligiTR1"();


--
-- Name: Ana_konu Ana_konu; Type: FK CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Ana_konu"
    ADD CONSTRAINT "Ana_konu" FOREIGN KEY (paylasim_id) REFERENCES "Paylasim"(paylasim_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Yorum Yorum; Type: FK CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Yorum"
    ADD CONSTRAINT "Yorum" FOREIGN KEY (paylasim_id) REFERENCES "Paylasim"(paylasim_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Yorum ana_konuFK; Type: FK CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Yorum"
    ADD CONSTRAINT "ana_konuFK" FOREIGN KEY (ana_konu_id) REFERENCES "Ana_konu"(paylasim_id);


--
-- Name: Paylasim kullFK; Type: FK CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Paylasim"
    ADD CONSTRAINT "kullFK" FOREIGN KEY (kull_id) REFERENCES public."Kullanicilar"(kull_id);


--
-- Name: Ana_konu tipFK; Type: FK CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Ana_konu"
    ADD CONSTRAINT "tipFK" FOREIGN KEY (tip_id) REFERENCES public."Tip"(tip_id);


--
-- Name: Paylasim zamanFK; Type: FK CONSTRAINT; Schema: paylasim; Owner: postgres
--

ALTER TABLE ONLY "Paylasim"
    ADD CONSTRAINT "zamanFK" FOREIGN KEY (zaman_id) REFERENCES public."Zaman"(zaman_id);


SET search_path = public, pg_catalog;

--
-- Name: Begenme begenmekullFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Begenme"
    ADD CONSTRAINT "begenmekullFK" FOREIGN KEY (kull_id) REFERENCES "Kullanicilar"(kull_id);


--
-- Name: Begenme begenmepayFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Begenme"
    ADD CONSTRAINT "begenmepayFK" FOREIGN KEY (paylasim_id) REFERENCES paylasim."Paylasim"(paylasim_id);


--
-- Name: Kullanicilar kulltipiFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kullanicilar"
    ADD CONSTRAINT "kulltipiFK" FOREIGN KEY (kull_tip) REFERENCES "Kull_tipi"(kull_tipi_id);


--
-- Name: Zam_ok okunmaFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Zam_ok"
    ADD CONSTRAINT "okunmaFK" FOREIGN KEY (okunma_id) REFERENCES "Okunma"(okunma_id);


--
-- Name: Okunma paylasimFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Okunma"
    ADD CONSTRAINT "paylasimFK" FOREIGN KEY (paylasim_id) REFERENCES paylasim."Paylasim"(paylasim_id);


--
-- Name: Takip takipedenFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Takip"
    ADD CONSTRAINT "takipedenFK" FOREIGN KEY (takip_eden) REFERENCES "Kullanicilar"(kull_id);


--
-- Name: Takip takipedilenFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Takip"
    ADD CONSTRAINT "takipedilenFK" FOREIGN KEY (takip_edilen) REFERENCES "Kullanicilar"(kull_id);


--
-- Name: Zam_ok zamanFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Zam_ok"
    ADD CONSTRAINT "zamanFK" FOREIGN KEY (zaman_id) REFERENCES "Zaman"(zaman_id);


--
-- PostgreSQL database dump complete
--

