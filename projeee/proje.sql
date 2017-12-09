CREATE SCHEMA "paylasim";
DATE DEFAULT '2017-01-01'

CREATE TABLE "Kullanicilar" (
	"kull_id" SERIAL,
	"kull_adi" VARCHAR(40) NOT NULL,
	"yasi" SMALLINT NOT NULL,
	"email" CHAR(50) NOT NULL,
	"sifre" CHAR(256) NOT NULL,--sha256
	"kull_tip" INTEGER DEFAULT '0', --fk
	CONSTRAINT "kullanicilarPK" PRIMARY KEY("kull_id")
);
ALTER TABLE "Kullanicilar" ADD CONSTRAINT "kulltipiFK" FOREIGN KEY("kull_tip") REFERENCES "Kull_tipi"("kull_tipi_id");
CREATE TABLE "Kull_tipi" (
	"kull_tipi_id" SERIAL,
	"kull_tipi" CHAR(11) NOT NULL,
	CONSTRAINT "kull_tipiPK" PRIMARY KEY("kull_tipi_id")
);

CREATE TABLE "Begenme" (
	"begenme_id" SERIAL,
	"paylasim_id" INTEGER NOT NULL, --fk
	"kull_id" INTEGER NOT NULL, --fk
	CONSTRAINT "begenmePK" PRIMARY KEY("begenme_id")
);
ALTER TABLE "Begenme" ADD CONSTRAINT "begenmepayFK" FOREIGN KEY("paylasim_id") REFERENCES "paylasim"."Paylasim"("paylasim_id");
ALTER TABLE "Begenme" ADD CONSTRAINT "begenmekullFK" FOREIGN KEY("kull_id") REFERENCES "Kullanicilar"("kull_id");
CREATE TABLE "Takip" (
	"takip_id" SERIAL,
	"takip_eden" INTEGER NOT NULL,--fk
	"takip_edilen" INTEGER NOT NULL, --fk
	CONSTRAINT "takipPK" PRIMARY KEY("takip_id")
);
ALTER TABLE "Takip" ADD CONSTRAINT "takipedenFK" FOREIGN KEY("takip_eden") REFERENCES "Kullanicilar"("kull_id");
ALTER TABLE "Takip" ADD CONSTRAINT "takipedilenFK" FOREIGN KEY("takip_edilen") REFERENCES "Kullanicilar"("kull_id");
CREATE TABLE "paylasim"."Paylasim" (
	"paylasim_id" SERIAL,
	"yazi" VARCHAR(500) NOT NULL,
	"eski_yazi" VARCHAR(500) ,
	"ptipi" CHAR(1) NOT NULL,
	"zaman_id" INTEGER NOT NULL,--fk
	"kull_id" INTEGER NOT NULL,--fk
	CONSTRAINT "paylasimPK" PRIMARY KEY("paylasim_id")
);
ALTER TABLE "paylasim"."Paylasim" ADD CONSTRAINT "zamanFK" FOREIGN KEY("zaman_id") REFERENCES "Zaman"("zaman_id");
ALTER TABLE "paylasim"."Paylasim" ADD CONSTRAINT "kullFK" FOREIGN KEY("kull_id") REFERENCES "Kullanicilar"("kull_id");
CREATE TABLE "paylasim"."Ana_konu" (
	"paylasim_id" SERIAL,
	"tip_id" INTEGER NOT NULL,--fk
	CONSTRAINT "ana_konuPK" PRIMARY KEY("paylasim_id")
);
ALTER TABLE "paylasim"."Ana_konu" ADD CONSTRAINT "tipFK" FOREIGN KEY("tip_id") REFERENCES "Tip"("tip_id");
CREATE TABLE "paylasim"."Yorum" (
	"paylasim_id" SERIAL,
	"ana_konu_id" INTEGER NOT NULL,--fk
	CONSTRAINT "yorumPK" PRIMARY KEY("paylasim_id")
);
ALTER TABLE "paylasim"."Yorum" ADD CONSTRAINT "ana_konuFK" FOREIGN KEY("ana_konu_id") REFERENCES "paylasim"."Ana_konu"("paylasim_id");
CREATE TABLE "Tip" (
	"tip_id" SERIAL,
	"tip" CHAR(8) NOT NULL,
	CONSTRAINT "tipPK" PRIMARY KEY("tip_id")
);

CREATE TABLE "Zaman" (
	"zaman_id" SERIAL,
	"zaman" DATE DEFAULT '2017-01-01' NOT NULL,
	CONSTRAINT "zamanPK" PRIMARY KEY("zaman_id")
);

CREATE TABLE "Okunma" (
	"okunma_id" SERIAL,
	"sayac" INTEGER NOT NULL,
	"paylasim_id" INTEGER NOT NULL,--fk
	CONSTRAINT "okunmaPK" PRIMARY KEY("okunma_id")
);
ALTER TABLE "Okunma" ADD CONSTRAINT "paylasimFK" FOREIGN KEY("paylasim_id") REFERENCES "paylasim"."Paylasim"("paylasim_id");

CREATE TABLE "Zam_ok" (
	"zam_ok_id" SERIAL,
	"zaman_id" INTEGER NOT NULL,--fk
	"okunma_id" INTEGER NOT NULL,--fk
	CONSTRAINT "zam_okPK" PRIMARY KEY("zam_ok_id")
);
ALTER TABLE "Zam_ok" ADD CONSTRAINT "zamanFK" FOREIGN KEY("zaman_id") REFERENCES "Zaman"("zaman_id");
ALTER TABLE "Zam_ok" ADD CONSTRAINT "okunmaFK" FOREIGN KEY("okunma_id") REFERENCES "Okunma"("okunma_id");
--kalitim

    ALTER TABLE "paylasim"."Ana_konu"
	ADD CONSTRAINT "Ana_konu" FOREIGN KEY ("paylasim_id")
	REFERENCES "paylasim"."Paylasim" ("paylasim_id")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
    ALTER TABLE "paylasim"."Yorum"
	ADD CONSTRAINT "Yorum" FOREIGN KEY ("paylasim_id")
	REFERENCES "paylasim"."Paylasim" ("paylasim_id")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

---------
--fonk
--ortalama okunma sayisi
CREATE OR REPLACE FUNCTION OrtOkunma(okunmasayisi INTEGER,gunsayisi INTEGER)
RETURNS INTEGER
AS
$$ -- Fonksiyon govdesinin (tanımının) başlangıcı
BEGIN
    RETURN  okunmasayisi / gunsayisi;
END;
$$ -- Fonksiyon govdesinin (tanımının) sonu
LANGUAGE plpgsql;


SELECT * FROM OrtOkunma(123124,20);

--triggers tetikleyiciler


CREATE OR REPLACE FUNCTION "yaziDegisikligiTR1"()
RETURNS TRIGGER 
AS
$$
BEGIN
    IF NEW."yazi" <> OLD."yazi" THEN
        INSERT INTO "paylasim"."Paylasim"("paylasim_id", "yazi", "ptipi", "zaman_id","kull_id","eski_yazi")
        VALUES(OLD."paylasim_id", NEW."yazi", NEW."ptipi", OLD."zaman_id", OLD."kull_id",OLD."yazi");
    END IF;


    RETURN NEW;
END;
$$
LANGUAGE "plpgsql";

CREATE TRIGGER "yaziDegisikligiYap"
BEFORE UPDATE ON "paylasim"."Paylasim"
FOR EACH ROW
EXECUTE PROCEDURE "yaziDegisikligiTR1"();

ALTER TABLE "paylasim"."Paylasim"
ENABLE TRIGGER "yaziDegisikligiYap";


DELETE  FROM "Begenme" WHERE "begenme_id"=2;