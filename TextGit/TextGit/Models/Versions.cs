//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TextGit.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Versions
    {
        public int VersionID { get; set; }
        public string ChangeNote { get; set; }
        public string DocumentContent { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public int fkDocumentID { get; set; }
    
        public virtual Documents Documents { get; set; }
    }
}