using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage;
using DongThucVatQuangTri.Applications.Banners.ManageBanner;
using DongThucVatQuangTri.Applications.Banners.ManageBannerCat;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.Email;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.ConservationAreas;
using DongThucVatQuangTri.Applications.ConservationInfors;
using DongThucVatQuangTri.Applications.Contacts;
using DongThucVatQuangTri.Applications.EcotourismSafeties;
using DongThucVatQuangTri.Applications.GroupUsers;
using DongThucVatQuangTri.Applications.Introduces;
using DongThucVatQuangTri.Applications.Maps;
using DongThucVatQuangTri.Applications.MiddelWare;
using DongThucVatQuangTri.Applications.NewsItem.NewsCatManage;
using DongThucVatQuangTri.Applications.NewsItem.NewsManage;
using DongThucVatQuangTri.Applications.Roles;
using DongThucVatQuangTri.Applications.Tours;
using DongThucVatQuangTri.Applications.UserManage;
using DongThucVatQuangTri.Applications.Validation;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Server.Kestrel.Core;
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
    options.ExpireTimeSpan=TimeSpan.FromHours(1);
    options.SlidingExpiration = true;
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
//builder.Services.AddHttpContextAccessor();
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
builder.Services.AddTransient<IManageRole, ManageRole>();
builder.Services.AddTransient<IManageIntroduce, ManageIntroduce>();
builder.Services.AddTransient<IManageSpeciesNationPark, ManageSpeciesNationPark>();
builder.Services.AddTransient<IPublicManageSpecies, PublicManageSpecies>();
builder.Services.AddTransient<IStorageServiceEdit, FileStorageServiceEdit>();
builder.Services.AddTransient<IManageConservationInfor, ManageConservationInfor>();
builder.Services.AddTransient<IManageEcotourismSafety, ManageEcotourismSafety>();
builder.Services.AddTransient<IManageTourCat, ManageTourCat>();
builder.Services.AddTransient<IManageConservationArea, ManageConservationArea>();
builder.Services.AddTransient<IManageContact, ManageContact>();
builder.Services.AddTransient<IEmailSender, SendMailService>();
builder.Services.AddTransient<IManageGroupUser, ManageGroupUser>();

//builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromDays(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true; 
});
builder.Services.Configure<IdentityOptions>(option =>
{
    option.Password.RequiredLength = 8;
    option.Password.RequireUppercase = true;
    option.Password.RequireLowercase = true;
    option.Password.RequireDigit = true;
    option.Password.RequireNonAlphanumeric = true;
    option.User.RequireUniqueEmail = true;
    option.SignIn.RequireConfirmedEmail = false;            // Cấu hình xác thực địa chỉ email (email phải tồn tại)
    option.SignIn.RequireConfirmedPhoneNumber = false;
    option.Lockout.AllowedForNewUsers = false; // Không cho phép khóa tài khoản mới
    option.Lockout.MaxFailedAccessAttempts = int.MaxValue; // Đặt số lần đăng nhập sai tối đa rất cao
    option.Lockout.DefaultLockoutTimeSpan = TimeSpan.Zero;
});
builder.Services.Configure<SecurityStampValidatorOptions>(o => o.ValidationInterval = TimeSpan.FromHours(10));

builder.Services.Configure<IISServerOptions>(options =>
{
    options.MaxRequestBodySize = 2147483648;
});
builder.Services.Configure<KestrelServerOptions>(options =>
{
    options.Limits.MaxRequestBodySize = 2147483648;
});
builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 2147483648; // 2GB
});
builder.Services.AddOptions();                                        // Kích hoạt Options
var mailsettings = builder.Configuration.GetSection("MailSettings");  // đọc config
builder.Services.Configure<MailSettings>(mailsettings);               // đăng ký để Inject
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    //app.UseHsts();
}

//app.UseMiddleware<ErrorExceptionMiddleware>();

app.UseStatusCodePagesWithReExecute("/Error/{0}");
app.UseAuthentication();

app.UseStaticFiles();
//app.UseHttpsRedirection();

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
