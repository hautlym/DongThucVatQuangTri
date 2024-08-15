using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using System.Net.Http;

namespace DongThucVatQuangTri.Applications.MiddelWare
{
    public class ErrorExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        //private readonly ILogger<ErrorExceptionMiddleware> _logger;
        private readonly IHostEnvironment _env;
        private readonly IActionResultExecutor<ViewResult> _viewResultExecutor;
        private readonly LinkGenerator _linkGenerator;
        public ErrorExceptionMiddleware(RequestDelegate next, /*ILogger<ErrorExceptionMiddleware> logger,*/
            IHostEnvironment env, IActionResultExecutor<ViewResult> viewResultExecutor)
        {
            _env = env;
            //_logger = logger;
            _next = next;
            _viewResultExecutor = viewResultExecutor;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                //_logger.LogError(ex, ex.Message);
                context.Response.ContentType = "application/json";
                context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

                await HandleExceptionAsync(context, ex);
            }
        }
        private async Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            context.Response.ContentType = "text/html";

            var routeData = new RouteData();
            routeData.Values["controller"] = "Error";
            routeData.Values["action"] = "General";

            var actionContext = new ActionContext(context, routeData, new Microsoft.AspNetCore.Mvc.Abstractions.ActionDescriptor());

            var result = new ViewResult { ViewName = "Error" };
            await _viewResultExecutor.ExecuteAsync(actionContext, result);
        }
    }
}
