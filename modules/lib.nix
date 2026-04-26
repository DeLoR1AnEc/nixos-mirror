{
  _module.args.dlib = {
    withUsers = includes: {
      inherit includes;
      provides.to-users = { inherit includes; };
    };
  };
}