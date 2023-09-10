using DongThucVatQuangTri.Applications.UserManage.Dtos;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Validation
{
    public class RegisterRequestValidator : AbstractValidator<RegisterRequest>
    {
        public RegisterRequestValidator()
        {
            RuleFor(x => x.Password).NotEmpty().WithMessage("Vui lòng điền mật khẩu");
            RuleFor(x => x.Address).NotEmpty().WithMessage("Vui lòng điền địa chỉ");
            RuleFor(x => x.FirstName).NotEmpty().WithMessage("Vui lòng điền họ tên");
            RuleFor(x => x.PhoneNumber).NotEmpty().WithMessage("Vui lòng điền số điện thoại");
            RuleFor(x => x.Password)
         .NotEmpty().WithMessage("Mật khẩu không được trống.")
         .MinimumLength(8).WithMessage("Mật khẩu phải có ít nhất 8 kí tự.")
         .Matches(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$")
         .WithMessage("Mật khẩu phải chứa ít nhất một chữ cái cái hoa, thường, một số và một kí tự đặc biệt.");
            RuleFor(x => x).Custom((request, context) =>
              {
                  if (request.Password != request.ConfirmPassword)
                  {
                      context.AddFailure("mật khẩu không chính xác");
                  }
              });
            RuleFor(x => x.Dob).GreaterThan(DateTime.Now.AddYears(-100)).WithMessage("Ngày sinh không quá 100 tuổi");
            RuleFor(x => x.Email).NotEmpty().WithMessage("Vui lòng điền Email")
                .Matches(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
        }
    }
}
