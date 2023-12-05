using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage;
using DongThucVatQuangTri.Applications.Banners.ManageBanner;
using DongThucVatQuangTri.Applications.Banners.ManageBannerCat;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Maps;
using DongThucVatQuangTri.Applications.NewsItem.NewsCatManage;
using DongThucVatQuangTri.Applications.NewsItem.NewsManage;
using DongThucVatQuangTri.Applications.Tours;
using DongThucVatQuangTri.Applications.UserManage;
using DongThucVatQuangTri.Applications.Validation;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Configuration;
using System.Security.Claims;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);
var mvcBuilder = builder.Services.AddRazorPages();
builder.Services.AddControllers().AddFluentValidation(fv =>
    {
        fv.RegisterValidatorsFromAssemblyContaining<LoginRequestValidator>();
    });
builder.Services.AddControllersWithViews()
                .AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
// Add services to the container.
builder.Services.AddControllersWithViews();
if (builder.Environment.IsDevelopment())
{
    mvcBuilder.AddRazorRuntimeCompilation();
}
builder.Services.AddHttpClient();


builder.Services.AddDbContext<DongThucVatContext>(option => option.UseSqlServer(builder.Configuration.GetConnectionString("DatabaseDongThucVat")));
builder.Services.AddIdentity<AppUser, AppRoles>()
        .AddEntityFrameworkStores<DongThucVatContext>()
        .AddDefaultTokenProviders();
string issuer = "https://hello.api.com";
string signingKey = "123456789987654321";
byte[] signingKeyBytes = System.Text.Encoding.UTF8.GetBytes(signingKey);
builder.Services.AddAuthentication(options =>
{
    
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
})
.AddCookie(CookieAuthenticationDefaults.AuthenticationScheme, options =>
{
    options.LoginPath = "/admin/Login/Index";
    options.AccessDeniedPath = "/Home/Index";
});
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("AdminPolicy", policy =>
    {
        policy.RequireClaim(ClaimTypes.Role, "Admin");
    });
    options.AddPolicy("AdministratorPolicy", policy =>
    {
        policy.RequireClaim(ClaimTypes.Role, "Administator");
    });
    options.AddPolicy("AdministatorOrNationParkPolicy", policy =>
    {
        policy.RequireAssertion(context =>
        {
            return context.User.HasClaim(c =>
                (c.Type == ClaimTypes.Role && c.Value == "NationParkNamGiang") ||
                (c.Type == ClaimTypes.Role && c.Value == "NationParkMuongTe") ||
                (c.Type == ClaimTypes.Role && c.Value == "Administator"));
        });
    });
    options.AddPolicy("AdministatorOrAdminPolicy", policy =>
    {
        policy.RequireAssertion(context =>
        {
            return context.User.HasClaim(c =>
                (c.Type == ClaimTypes.Role && c.Value == "Admin") ||
                (c.Type == ClaimTypes.Role && c.Value == "Administator"));
        });
    });
});
//builder.Services.ConfigureApplicationCookie(options => options.LoginPath = "/admin/Login/Index");
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
builder.Services.AddTransient<IStorageService, FileStorageService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IManageBanner, ManageBanner>();
builder.Services.AddTransient<IManageBannerCat, ManageBannerCat>();
builder.Services.AddTransient<IManageFile, ManageFile>();
builder.Services.AddTransient<IManageNewsCat, ManageNewsCat>();
builder.Services.AddTransient<IManageNews, ManageNews>();
builder.Services.AddTransient<IManageBranch, ManageBranch>();
builder.Services.AddTransient<IManageClass, ManageClass>();
builder.Services.AddTransient<IManageSet, ManageSet>();
builder.Services.AddTransient<IManageFamily, ManageFamily>();
builder.Services.AddTransient<IManageSpecies, ManageSpecies>();
builder.Services.AddTransient<IManageTour, ManageTour>();
builder.Services.AddTransient<IManageMap, ManageMap>();
builder.Services.AddTransient<IManageSpeciesNationPark, ManageSpeciesNationPark>();
builder.Services.AddTransient<IPublicManageSpecies, PublicManageSpecies>();
//builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseAuthentication();
app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();
app.UseSession();
//app.MapControllerRoute(
//    name: "default",
//    pattern: "{controller=Home}/{action=Index}/{id?}");
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
      name: "admin",
      pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}"
    );
    endpoints.MapControllerRoute(
      name: "default",
      pattern: "{controller=Home}/{action=Index}/{id?}"
    );
});

app.Run();
