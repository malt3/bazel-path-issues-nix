def _shell_rule_impl(ctx):
    launcher = ctx.actions.declare_file("launcher_%s.sh" % ctx.label.name)
    ctx.actions.expand_template(
        template = ctx.file._launcher_sh_tpl,
        output = launcher,
        is_executable = True,
    )
    output = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.run(
        outputs = [output],
        executable = launcher,
        arguments = [output.path],
    )
    return DefaultInfo(files = depset([output]))

some_rule = rule(
    implementation = _shell_rule_impl,
    attrs = {
        "_launcher_sh_tpl": attr.label(default = "launcher.sh.tpl", allow_single_file = True),
    },
)
