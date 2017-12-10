package edu.sau.vtys.paylasim.resource;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OkunmaDao {

  @Autowired
  private EntityManager entityManager;

  public Integer calculateOkunmaSayisiWithProcedure(Integer okunmaSayisi, Integer gunSayisi){
    StoredProcedureQuery procedureQuery = entityManager.createStoredProcedureQuery("ortokunma");
    procedureQuery.registerStoredProcedureParameter("okunmasayisi", Integer.class, ParameterMode.IN);
    procedureQuery.registerStoredProcedureParameter("gunsayisi", Integer.class, ParameterMode.IN);
    procedureQuery.registerStoredProcedureParameter("result", Integer.class, ParameterMode.OUT);

    procedureQuery.setParameter("okunmasayisi", okunmaSayisi);
    procedureQuery.setParameter("gunsayisi", gunSayisi);

    procedureQuery.execute();

    return (Integer) procedureQuery.getOutputParameterValue("result");
  }
}
