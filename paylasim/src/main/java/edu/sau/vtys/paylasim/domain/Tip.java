package edu.sau.vtys.paylasim.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.criteria.CriteriaBuilder.In;
import lombok.Data;

@Entity
@Table(name = "Tip", schema = "public")
@Data
public class Tip {

  @Id
  private Integer tip_id;

  private String tip;
}
