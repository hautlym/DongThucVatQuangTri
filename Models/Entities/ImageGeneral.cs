﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace DongThucVatQuangTri.Models.Entities
{
    public partial class ImageGeneral
    {
        public long Id { get; set; }
        public int ObjectId { get; set; }
        public int UserId { get; set; }
        public string Name { get; set; }
        public string Title { get; set; }
        public short Type { get; set; }
        public DateTime? CreatedAt { get; set; }
        public short Status { get; set; }
        public short Mode { get; set; }
        public int? IdDir { get; set; }
    }
}