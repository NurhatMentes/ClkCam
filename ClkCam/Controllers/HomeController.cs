using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using ClkCam.Models;

namespace ClkCam.Controllers
{
    public class HomeController : Controller
    {
        ClkCamDB db = new ClkCamDB();

        private void ViewBags()
        {
            ViewBag.Identity = db.SiteIdentity.SingleOrDefault();
            ViewBag.Keywords = db.SiteIdentity.Select(x => x.Keywords).SingleOrDefault();
            ViewBag.Service = db.Service.ToList().OrderByDescending(x => x.ServiceId);
            ViewBag.Categories = db.Category.ToList().OrderBy(x => x.CategoryId);
            ViewBag.Contact = db.Contact.SingleOrDefault();
        }

        [Route("Anasayfa/Index")]
        [Route("")]
        [Route("Anasayfa")]
        public ActionResult Index()
        {
            //ViewBag***
            ViewBags();
            return View();
        }

        [Route("İletisim")]
        public ActionResult Contact()
        {
            //ViewBag***
            ViewBags();

            return View(db.Contact.SingleOrDefault());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Contact(string email, string message, string name, string subject)
        {
            //var language = this.Language_Code();

            var systemAdmin = db.SystemAdmin.FirstOrDefault();

            if (name != null && email != null)
            {
                WebMail.SmtpServer = "smtp.gmail.com";
                WebMail.EnableSsl = true;
                WebMail.UserName = systemAdmin.Email;
                WebMail.Password = systemAdmin.Password;
                WebMail.SmtpUseDefaultCredentials = true;
                WebMail.SmtpPort = 587;
                WebMail.Send(systemAdmin.Email, subject, email + '\n' + message);
                ViewBag.Danger = "Mesajınız başarı ile gönderilmiştir.";
                return Redirect("/Home");
            }
            else
            {
                ViewBag.Danger = "Hata oluştu. Tekrar deneyiniz.";
            }
            return View();
        }

        public ActionResult SliderPartial()
        {
            //ViewBag***
            ViewBags();

            ViewBag.Slider = db.Slider.ToList();

            return View();
        }

        [Route("Hizmetler")]
        public ActionResult Service()
        {
            //ViewBag***
            ViewBags();

            return View(db.Service.ToList().OrderByDescending(x => x.ServiceId));
        }

        [Route("Hizmetler/{title}-{id:int}")]
        public ActionResult ServiceDetail(int id)
        {

            //ViewBag***
            ViewBags();

            var service = db.Service.SingleOrDefault(x => x.ServiceId == id);

            return View(service);
        }

        [Route("Urunler")]
        public ActionResult Products()
        {

            //ViewBag***
            ViewBags();

            return View(db.Products.Include("Category").ToList());
        }


        [Route("Urunler/{title}-{id:int}")]
        public ActionResult ProductDetail(int id)
        {
            //var language = this.Language_Code();
            //ViewBag***
            ViewBags();

            ViewBag.ProductImage = db.Products.Where(x => x.ProductId == id).Select(x => x.ImgUrl).FirstOrDefault();

            ViewBag.ProductName = db.Products.Where(x => x.ProductId == id).Select(x => x.Title).FirstOrDefault();
            ViewBag.ProductCategory = db.Products.Where(x => x.ProductId == id).FirstOrDefault();
            ViewBag.ProductSubCategory = db.Products.Where(x => x.ProductId == id && x.SubCategoryId != null).FirstOrDefault();
            ViewBag.Keywords = db.Products.Where(x => x.ProductId == id).Select(x => x.Tag).FirstOrDefault();

            var product = db.Products.Include("Category").Where(x => x.ProductId == id).SingleOrDefault();

            return View(product);
        }

        [Route("Urunler/{categoryName}/{id:int}")]
        public ActionResult CategoryProducts(int id)
        {
            //ViewBag***
            ViewBags();
            ViewBag.CategoryName = db.Category.Where(x => x.CategoryId == id).Select(x => x.CategoryName).FirstOrDefault();
            ViewBag.CategoryImg = db.Category.Where(x => x.CategoryId == id).Select(x => x.ImgUrl).FirstOrDefault();

            var product = db.Products.Where(x => x.CategoryId == id).OrderByDescending(x => x.ProductId).ToList();
            return View(product);
        }

        //categories on the home page
        public ActionResult HomeProductsCategoryPartial()
        {

            var categories = db.Category.Include("Products").Include("SubCategory").ToList()
                .OrderBy(x => x.CategoryId);
            return PartialView(categories);
        }


        [Route("Hakkımızda")]
        public ActionResult AboutUs()
        {
            //ViewBag***
            ViewBags();


            var aboutUs = db.AboutUs.FirstOrDefault();
            return View(aboutUs);
        }

        public ActionResult FooterPartial()
        {
            ViewBags();

            return PartialView();
        }
    }
}