package edu.sau.vtys.paylasim.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/okunma")
public class OkunmaResource {

  @Autowired
  private OkunmaDao okunmaDao;


  @RequestMapping(value = "/hesapla/{okunmaSayisi}/{gunSayisi}")
  @ResponseBody
  public Integer calculateOkunmaSayisiWithProcedure(@PathVariable("okunmaSayisi") Integer okunmaSayisi,
      @PathVariable("gunSayisi") Integer gunSAyisi) {
    return okunmaDao.calculateOkunmaSayisiWithProcedure(okunmaSayisi, gunSAyisi);
  }

}