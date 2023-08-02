def _symlink_impl(context):
    symlink = context.actions.declare_symlink(context.attr.symlink_name)
    context.actions.symlink(
        output = symlink,
        target_path = context.attr.target,
    )
    default_info = DefaultInfo(files = depset([symlink]))
    return [default_info]

symlink = rule(
    implementation = _symlink_impl,
    attrs = {
        "target": attr.string(
            mandatory = True,
            doc = "Target the symlink will point to",
        ),
        "symlink_name": attr.string(
            mandatory = True,
            doc = "Name of the symlink",
        ),
    },
    provides = [DefaultInfo],
    doc = "Create a symlink",
)
