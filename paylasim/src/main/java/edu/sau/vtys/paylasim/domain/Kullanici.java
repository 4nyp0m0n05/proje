package edu.sau.vtys.paylasim.domain;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Kullanicilar", schema = "public")
@Data
@NoArgsConstructor
public class Kullanici {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Kullanicilar_kull_id")
  @SequenceGenerator(name = "Kullanicilar_kull_id", sequenceName = "Kullanicilar_kull_id_seq")
  private Integer kull_id;

  private String kull_adi;

  private Integer yasi;

  private String email;

  private String sifre;

  @OneToMany(mappedBy = "kullanici", fetch = FetchType.EAGER)
  private List<Paylasim> paylasimList;

}
