using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TextGit.Startup))]
namespace TextGit
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
