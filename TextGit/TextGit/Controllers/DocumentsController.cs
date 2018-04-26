using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TextGit.Models;

namespace TextGit.Controllers
{
    public class DocumentsController : Controller
    {
        private TextGitEntities db = new TextGitEntities();

        // GET: Documents
        public ActionResult Index()
        {
            var documents = db.Documents.Include(db => db.Versions);
            return View(documents.ToList());
        }

        // GET: Documents/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Documents documents = db.Documents.Find(id);
            if (documents == null)
            {
                return HttpNotFound();
            }
            return View(documents);
        }

        // GET: Documents/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Documents/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Title")] Documents documents, [Bind(Include = "DocumentContent")] Versions versions)
        {
            if (ModelState.IsValid)
            {
                db.Documents.Add(documents);
                db.SaveChanges();
                versions.fkDocumentID = documents.DocumentID;
                versions.CreatedAt = DateTime.UtcNow;
                versions.ChangeNote = "Create Document";
                db.Versions.Add(versions);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(documents);
        }

        // GET: Documents/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Documents documents = db.Documents.Find(id);
            Versions versions = documents.Versions.OrderByDescending(v => v.CreatedAt).First();
            Versions version = new Versions();
            version.fkDocumentID = documents.DocumentID;
            version.DocumentContent = versions.DocumentContent;
            version.CreatedAt = DateTime.UtcNow;
            version.ChangeNote = ""; //somehow this isn't empty otherwise
            documents.Versions.Add(version);
            if (documents == null)
            {
                return HttpNotFound();
            }
            return View(documents);
        }

        // POST: Documents/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "DocumentID,Title")] Documents documents, [Bind(Include = "ChangeNote,DocumentContent")] Versions versions)
        {
            if (ModelState.IsValid)
            {
                db.Entry(documents).State = EntityState.Modified;
                versions.CreatedAt = DateTime.UtcNow;
                versions.fkDocumentID = documents.DocumentID;
                db.Versions.Add(versions);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(documents);
        }

        // GET: Documents/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Documents documents = db.Documents.Find(id);
            if (documents == null)
            {
                return HttpNotFound();
            }
            return View(documents);
        }

        // POST: Documents/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Documents documents = db.Documents.Find(id);
            db.Versions.RemoveRange(documents.Versions);
            db.Documents.Remove(documents);
            db.SaveChanges();
            return RedirectToAction("Index");
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
