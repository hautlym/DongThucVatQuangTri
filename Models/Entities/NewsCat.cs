﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace DongThucVatQuangTri.Models.Entities
{
    public partial class NewsCat
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public int ParentId { get; set; }
        public string Path { get; set; }
        public short Level { get; set; }
        public string Image { get; set; }
        public string Description { get; set; }
        public int SortOrder { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public short Status { get; set; }
        public string Language { get; set; }
        public string TitleSeo { get; set; }
        public string ContentSeo { get; set; }
        public string KeySeo { get; set; }
        public int? IdRelated { get; set; }
        public string? TypeNationPark { get; set; }
    }
}