using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using ClkCam.Models;

namespace ClkCam.Controllers
{
    public class AdminController : Controller
    {
        ClkCamDB db = new ClkCamDB();

        // GET: Admins
        public ActionResult Index()
        {
            var userCookie = Request.Cookies["userCookie"];
            var userCookie2 = Request.Cookies["userCookie2"];


            if (Request.Cookies["userCookie"] != null)
            {
                var adminId = Convert.ToInt16(userCookie["AdminId"]);
                var adminName = userCookie["FullName"];

                ViewBag.Blog = db.Products.Count();
                ViewBag.Service = db.Service.Count();
                ViewBag.Category = db.Category.Count();
                ViewBag.AdminName = db.Admin.ToList();
                ViewBag.LoginDate = db.AdminLog.OrderByDescending(x => x.AdminLogId);
            }
            else
            {
                return RedirectToAction("Login", "Admin");
            }

            var categoryList = db.Category.ToList();
            return View(categoryList);
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Admin admin, string password)
        {
            HttpCookie userCookie = new HttpCookie("userCookie");
            userCookie.Expires = DateTime.Now.AddMinutes(30);
            HttpCookie userCookie2 = new HttpCookie("userCookie2");
            userCookie2.Expires = DateTime.Now.AddMinutes(30);


            var md5pass = Crypto.Hash(password, "MD5");
            var login = db.Admin.Where(x => x.Email == admin.Email && x.Password == md5pass).FirstOrDefault();

            AdminLog adminLog = new AdminLog();

            if (login != null)
            {
                if (login.Password == md5pass && login.Email == admin.Email)
                {
                    userCookie2["adminid"] = login.AdminId.ToString();
                    userCookie["adminid"] = login.AdminId.ToString();
                    userCookie["email"] = login.Email;
                    userCookie["Auth"] = login.Auth;
                    userCookie["FullName"] = login.FullName;
                    userCookie["Job"] = login.Job;
                    userCookie["Phone"] = login.Phone;
                    userCookie["OldPassword"] = login.RePassword;


                    adminLog.AdminId = login.AdminId;
                    adminLog.State = "Giriş Yapıldı";
                    adminLog.LogDate = DateTime.Now; ;
                    db.AdminLog.Add(adminLog);
                    db.SaveChanges();

                    Response.Cookies.Add(userCookie);
                    Response.Cookies.Add(userCookie2);

                    return RedirectToAction("Index", "Admin");
                }
            }
            ViewBag.Danger = "E-posta veya Şifre hatalı";
            return View(admin);
        }

        public ActionResult Logout()
        {
            var userCookie1 = Request.Cookies["userCookie"];
            var userCookie2 = Request.Cookies["userCookie2"];

            AdminLog adminLog = new AdminLog();
            adminLog.AdminId = Convert.ToInt16(userCookie1["AdminId"]);
            adminLog.State = "Çıkış Yapıldı";
            adminLog.LogDate = DateTime.Now; ;
            db.AdminLog.Add(adminLog);
            db.SaveChanges();

            Request.Cookies.Remove(userCookie1.ToString());
            Request.Cookies.Remove(userCookie2.ToString());

            return RedirectToAction("Login", "Admin");
        }

        public ActionResult ForgotMyPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ForgotMyPassword(string email = null)
        {

            var user = db.Admin.Where(x => x.Email == email).SingleOrDefault();

            if (user != null)
            {
                Random random = new Random();
                int rndPass = random.Next(10035, 999654);
                int rndPass2 = random.Next(10035, 999654);

                string newPassword = rndPass.ToString() + rndPass2.ToString();

                Admin admin = new Admin();
                user.Password = Crypto.Hash(newPassword, "MD5");
                user.RePassword = Crypto.Hash(newPassword, "MD5");
                db.SaveChanges();

                var message = "Yeni şifrenizi değiştirmeyi unutmayınız!" + '\n' + "Yeni Şifre: " + newPassword;

                try
                {


                    SmtpClient client = new SmtpClient("mail.clkcam.com", 587);
                    MailAddress from = new MailAddress("info@clkcam.com");
                    MailAddress to = new MailAddress(user.Email);
                    MailMessage msg = new MailMessage(from, to);
                    msg.IsBodyHtml = true;
                    msg.Subject = "CLK CAM Yönetim paneline yeni giriş şifresi";
                    msg.Body += "info@clkcam.com" + to + "<br /><b>Ad:</b> " + user.FullName + "<br />" + "<b>Konu: </b>" + "DekOM Yönetim paneline yeni giriş şifresi" + "<br /> \n" + "<b> Yeni Şifre:</b> " + message;
                    msg.CC.Add("info@clkcam.com");

                    NetworkCredential Credentials = new NetworkCredential("info@clkcam.com", "#45teh60E");
                    client.Credentials = Credentials;
                    client.DeliveryMethod = SmtpDeliveryMethod.Network;
                    client.Port = 587;
                    client.Host = "peterpan.wlsrv.com";
                    client.EnableSsl = false;
                    client.Send(msg);

                    ViewBag.Danger = "Yeni Şifreniz gönderilmiştir.";
                    Response.Write("<script>alert('Yeni Şifreniz gönderilmiştir.')</script>");
                    return Redirect("/Admin/forgotmypassword");
                }
                catch (Exception e)
                {
                    ViewBag.Danger = "Hata oluştu. Tekrar deneyiniz.";
                }
            }
            else
            {
                ViewBag.Danger = "Kayıtlı kullanıcı bulunamadı!";
                Response.Write("<script>alert('Kayıtlı kullanıcı bulunamadı!')</script>");
            }

            return View();
        }

        public ActionResult Admins()
        {
            return View(db.Admin.ToList());
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Admin admin, string password)
        {
            if (ModelState.IsValid)
            {
                admin.Password = Crypto.Hash(password, "MD5");
                admin.RePassword = Crypto.Hash(password, "MD5");
                db.Admin.Add(admin);
                db.SaveChanges();

                return RedirectToAction("Admins");
            }

            return View(admin);
        }

        public ActionResult Edit(int id)
        {
            var admin = db.Admin.Where(x => x.AdminId == id).SingleOrDefault();
            return View(admin);
        }

        [HttpPost]
        public ActionResult Edit(int id, Admin admin, string password)
        {
            if (ModelState.IsValid)
            {
                var adm = db.Admin.Where(x => x.AdminId == id).SingleOrDefault();
                if (password != adm.Password)
                {
                    adm.Password = Crypto.Hash(password, "MD5");
                    adm.RePassword = Crypto.Hash(password, "MD5");
                }
                adm.Phone = admin.Phone;
                adm.Job = admin.Job;
                adm.FullName = admin.FullName;
                adm.Email = admin.Email;
                adm.Auth = admin.Auth;

                db.SaveChanges();
                return RedirectToAction("Admins");
            }

            return View(admin);
        }

        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Admin admin = db.Admin.Find(id);
            if (admin == null)
            {
                return HttpNotFound();
            }
            return View(admin);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Admin admin = db.Admin.Find(id);
            db.Admin.Remove(admin);
            db.SaveChanges();
            return RedirectToAction("Admins");
        }
    }
}