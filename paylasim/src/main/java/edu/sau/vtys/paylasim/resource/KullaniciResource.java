package edu.sau.vtys.paylasim.resource;

import edu.sau.vtys.paylasim.domain.Kullanici;
import edu.sau.vtys.paylasim.repository.KullaniciDao;
import edu.sau.vtys.paylasim.repository.KullaniciRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/kullanici")
public class KullaniciResource {

  @Autowired
  private KullaniciRepository kullaniciRepository;

  @Autowired
  private KullaniciDao kullaniciDao;

  @RequestMapping(value = "/all")
  @ResponseBody
  public List<Kullanici> getKullaniciLar() {
    return kullaniciDao.getAll();
  }

}
