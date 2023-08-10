using DongThucVatQuangTri.Applications.UserManage.Dtos;
using FluentValidation;

namespace DongThucVatQuangTri.Applications.Validation
{
    public class UpdateUserRequestValidator: AbstractValidator<UserUpdateRequest>
    {
        public UpdateUserRequestValidator()
        {
            RuleFor(x => x.FirstName).NotEmpty().WithMessage("Vui lòng điền họ tên");
            RuleFor(x => x.Address).NotEmpty().WithMessage("Vui lòng điền địa chỉ");
            RuleFor(x => x.Dob).GreaterThan(DateTime.Now.AddYears(-100)).WithMessage("Ngày sinh không quá 100 tuổi");
        }
    }
}
