using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using ClkCam.Models;
using ClkCam.Models.Dto;

namespace ClkCam.Controllers
{
    public class ProductsController : Controller
    {
        private ClkCamDB db = new ClkCamDB();

        // GET: Products
        public ActionResult Index()
        {
            //...
            var products = db.Products.Include(p => p.Admin).Include(p => p.Category);
            return View(products.OrderBy(x => x.ProductId).ToList());
        }

        public ActionResult CategoriesPartial()
        {
            CategoriesDto categoriesDto = new CategoriesDto();
            categoriesDto.Categories = new SelectList(db.Category, "CategoryId", "CategoryName");
            categoriesDto.SubCategories = new SelectList(db.SubCategory, "SubCategoryId", "SubCategoryName");

            return View(categoriesDto);
        }

        public JsonResult SubCategory(int categoryId)
        {
            var subCategories = (from x in db.SubCategory
                                 join y in db.Category on x.Category.CategoryId equals y.CategoryId
                                 where x.Category.CategoryId == categoryId
                                 select new
                                 {
                                     Text = x.SubCategoryName,
                                     Value = x.SubCategoryId.ToString()
                                 }).ToList();
            return Json(subCategories, JsonRequestBehavior.AllowGet);
        }

        // GET: Product/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Products products = db.Products.Find(id);
            if (products == null)
            {
                return HttpNotFound();
            }
            return View(products);
        }

        // GET: Product/Create
        public ActionResult Create()
        {
            ViewBag.Categories = db.Category.ToList();
            ViewBag.AdminId = new SelectList(db.Admin, "AdminId", "FullName");
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CategoryName");
            return View();
        }

        // POST: Product/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Create(Products products, HttpPostedFileBase imgUrl)
        {
            var userCookie = Request.Cookies["userCookie"];

            if (ModelState.IsValid)
            {
                if (imgUrl != null)
                {
                    WebImage image = new WebImage(imgUrl.InputStream);
                    FileInfo fileInfo = new FileInfo(imgUrl.FileName);

                    string imgName = Guid.NewGuid() + fileInfo.Extension;
                    image.Resize(1024, 460);
                    image.Save("~/Uploads/Product/" + imgName);

                    products.ImgUrl = "/Uploads/Product/" + imgName;


                    products.Date = DateTime.Now;
                    try
                    {
                        products.AdminId = Convert.ToInt16(userCookie["AdminId"]); ;
                    }
                    catch (Exception ex)
                    {
                        return RedirectToAction("Login","Admin");
                    }

                    products.Price = 0;

                    db.Products.Add(products);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.Warning = "Lütfen Resim Seçiniz";
                }

            }

            ViewBag.AdminId = new SelectList(db.Admin, "AdminId", "FullName", products.AdminId);
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CategoryName", products.CategoryId);
            return View(products);
        }

        // GET: Product/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Products products = db.Products.Find(id);
            if (products == null)
            {
                return HttpNotFound();
            }
            ViewBag.AdminId = new SelectList(db.Admin, "AdminId", "FullName", products.AdminId);
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CategoryName", products.CategoryId);
            return View(products);
        }

        // POST: Product/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit(Products product, HttpPostedFileBase ImgUrl, int id, HttpPostedFileBase uploadFile)
        {
            if (ModelState.IsValid)
            {
                var productId = db.Products.Where(x => x.ProductId == id).SingleOrDefault();
                if (ImgUrl != null)
                {
                    if (System.IO.File.Exists(Server.MapPath(productId.ImgUrl)))
                    {
                        System.IO.File.Delete(Server.MapPath(productId.ImgUrl));
                    }

                    WebImage image = new WebImage(ImgUrl.InputStream);
                    FileInfo fileInfo = new FileInfo(ImgUrl.FileName);

                    string imgName = Guid.NewGuid() + fileInfo.Extension;
                    image.Resize(1024, 460);
                    image.Save("~/Uploads/Product/" + imgName);

                    productId.ImgUrl = "/Uploads/Product/" + imgName;
                }


                productId.Content = product.Content;
                productId.Title = product.Title;


                productId.CategoryId = product.CategoryId;

                if (productId.SubCategoryId != null && product.SubCategoryId == null)
                {
                    productId.SubCategoryId = productId.SubCategoryId;
                }
                else if (product.SubCategoryId != null)
                {
                    productId.SubCategoryId = product.SubCategoryId;
                }
                else
                {
                    ViewBag.SubCategory = "Lütfen kategori seçiniz";
                }
                var userCookie = Request.Cookies["userCookie"];
                productId.Price = product.Price;
                productId.UpdateDate = DateTime.Now;
                productId.Tag = product.Tag;
                productId.EmendatorAdminId = Convert.ToInt16(userCookie["AdminId"]);

                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AdminId = new SelectList(db.Admin, "AdminId", "FullName", product.AdminId);
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CategoryName", product.CategoryId);
            return View(product);
        }

        // GET: Product/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Products products = db.Products.Find(id);
            if (products == null)
            {
                return HttpNotFound();
            }
            return View(products);
        }

        // POST: Product/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var product = db.Products.Find(id);

            if (product == null)
            {
                return HttpNotFound();
            }

            if (System.IO.File.Exists(Server.MapPath(product.ImgUrl)))
            {
                System.IO.File.Delete(Server.MapPath(product.ImgUrl));
            }

            try
            {
                db.Products.Remove(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception m)
            {
                ViewBag.Danger = "Ürünü silmek için öncelikle slider içerisinde bulunun resimleri silmeniz gerekir";
                ViewBag.Danger2 = "İşlemler > Slider Resim";
                return View(product);
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
