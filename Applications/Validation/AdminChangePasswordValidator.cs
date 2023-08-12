using DongThucVatQuangTri.Applications.UserManage.Dtos;
using FluentValidation;

namespace DongThucVatQuangTri.Applications.Validation
{
    public class AdminChangePasswordValidator:AbstractValidator<AdminUpdatePasswordRequest>
    {
        public AdminChangePasswordValidator()
        {
            RuleFor(x => x.NewPassword)
        .NotEmpty().WithMessage("Mật khẩu không được trống.")
        .MinimumLength(8).WithMessage("Mật khẩu phải có ít nhất 8 kí tự.")
        .Matches(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$")
        .WithMessage("Mật khẩu phải chứa ít nhất một chữ cái hoa, thường, một số và một kí tự đặc biệt.");
            RuleFor(x => x).Custom((request, context) =>
            {
                if (request.NewPassword != request.ConfirmPassword)
                {
                    context.AddFailure("mật khẩu nhập lại không trùng nhau");
                }
            });
        }
        
    }
}
