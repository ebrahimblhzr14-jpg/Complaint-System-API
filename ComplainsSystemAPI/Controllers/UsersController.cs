
using ComplaintManagement.Business.DTOs.Users;
using ComplaintManagement.Business.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;
using System.Security.Claims;

namespace ComplainsSystemAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _userService;

        public UsersController(
            IUserService userService)
        {
            _userService = userService;
        }


        // =====================================================
        // GET: api/users
        // =====================================================

        [HttpGet("All")]
        [Authorize(Roles = "SuperAdmin" )]
        public async Task<IActionResult> GetAll()
        {
            var users =
                await _userService.GetAllAsync();

            return Ok(users);
        }


        // =====================================================
        // GET: api/users/{id}
        // =====================================================

        [HttpGet("FindBy/{id:int}")]
        //[Authorize(Roles = "SuperAdmin")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(
            int id, IAuthorizationService authorizationService)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid user ID."
                });
            }

            var user =
                await _userService.GetByIdAsync(id);

            if (user == null)
            {
                return NotFound(new
                {
                    message = "User not found."
                });
            }

            var authResult = await authorizationService.AuthorizeAsync(
        User,
        user.Id,
        "OwnerOrSuperAdmin");

            if (!authResult.Succeeded)
                return Forbid(); // 403



            return Ok(user);
        }


        // =====================================================
        // POST: api/users
        // =====================================================

        [HttpPost("Create")]
        [Authorize(Roles = "SuperAdmin")]
        public async Task<IActionResult> Create(
            [FromBody] CreateUserDto dto)
        {
            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            try
            {
                int userId =
                    await _userService.CreateAsync(dto);

                var user =
                    await _userService.GetByIdAsync(userId);

                return CreatedAtAction(
                    nameof(GetById),
                    new { id = userId },
                    user);
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
        }


        // =====================================================
        // PUT: api/users/{id}
        // =====================================================

        [HttpPut("Update/{id:int}")]
        //[Authorize(Roles = "SuperAdmin")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(
            int id,
            [FromBody] UpdateUserDto dto, IAuthorizationService authorizationService)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid user ID."
                });
            }

            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }


            var authResult = await authorizationService.AuthorizeAsync(
        User,
        id,
        "OwnerOrSuperAdmin");

            if (!authResult.Succeeded)
                return Forbid(); // 403

            if (!User.IsInRole("SuperAdmin"))
            {
                var existingUser = await _userService.GetByIdAsync(id);
                if (existingUser == null)
                {
                    return NotFound(new
                    {
                        message = "User not found."
                    });
                }
                // Prevent privilege escalation and self-deactivation by non-superadmin
                dto.RoleId = existingUser.RoleId;
                dto.IsActive = existingUser.IsActive;
            }

            try
            {
                bool updated =
                    await _userService.UpdateAsync(
                        id,
                        dto);

                if (!updated)
                {
                    return NotFound(new
                    {
                        message = "User not found."
                    });
                }

                var user =
                    await _userService.GetByIdAsync(id);

                return Ok(user);
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
        }


        // =====================================================
        // PATCH: api/users/{id}/deactivate
        // =====================================================

        [HttpPatch("{id:int}/deactivate")]
        [Authorize(Roles = "SuperAdmin")]
        public async Task<IActionResult> Deactivate(
            int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid user ID."
                });
            }

            bool result =
                await _userService
                    .DeactivateAsync(id);

            if (!result)
            {
                return NotFound(new
                {
                    message = "User not found."
                });
            }

            return NoContent();
        }


        // =====================================================
        // PATCH: api/users/{id}/activate
        // =====================================================

        [HttpPatch("{id:int}/activate")]
        [Authorize(Roles = "SuperAdmin")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Activate(
            int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid user ID."
                });
            }

            bool result =
                await _userService
                    .ActivateAsync(id);

            if (!result)
            {
                return NotFound(new
                {
                    message = "User not found."
                });
            }

            return NoContent();
        }



        [HttpPut("PutDept/")]
        [Authorize(Roles = "SuperAdmin")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> PutDepartment(
           int UserId,int DepID)
        {
            if (UserId <= 0 || DepID <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid user ID or Dept ID."
                });
            }

            bool result =
                await _userService
                    .PutDepartmentAsync(UserId,DepID);

            if (!result)
            {
                return NotFound(new
                {
                    message = "User or Dept not found."
                });
            }

            return NoContent();
        }


        // =====================================================
        // PUT: api/users/me/password
        // =====================================================

        [HttpPut("me/password")]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult>
            ChangeMyPassword(
                [FromBody] ChangeMyPasswordDto dto)
        {
            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            int userId =
                GetCurrentUserId();

            if (userId <= 0)
            {
                return Unauthorized(new
                {
                    message = "Invalid user identity."
                });
            }

            try
            {
                bool result =
                    await _userService
                        .ChangeMyPasswordAsync(
                            userId,
                            dto);

                if (!result)
                {
                    return BadRequest(new
                    {
                        message =
                            "Current password is incorrect."
                    });
                }

                return NoContent();
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
        }


        // =====================================================
        // PUT: api/users/{id}/password
        // =====================================================

        [HttpPut("{id:int}/password")]
        [Authorize(Roles = "SuperAdmin")]

        public async Task<IActionResult>
            AdminChangePassword(
                int id,
                [FromBody] AdminChangePasswordDto dto)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid user ID."
                });
            }

            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            bool result =
                await _userService
                    .AdminChangePasswordAsync(
                        id,
                        dto);

            if (!result)
            {
                return NotFound(new
                {
                    message = "User not found."
                });
            }

            return NoContent();
        }








        // =====================================================
        // GET CURRENT USER ID FROM JWT
        // =====================================================

        private int GetCurrentUserId()
        {
            string? userId =
                User.FindFirstValue(
                    ClaimTypes.NameIdentifier);

            if (string.IsNullOrWhiteSpace(userId))
            {
                return 0;
            }

            return int.TryParse(
                userId,
                out int id)
                    ? id
                    : 0;
        }


        private string? GetCurrentUserEmail()
        {
            string? Email =
                User.FindFirstValue(
                    ClaimTypes.Email);

            if (string.IsNullOrWhiteSpace(Email))
            {
                return null;
            }

            return Email;
        }


    }
}

