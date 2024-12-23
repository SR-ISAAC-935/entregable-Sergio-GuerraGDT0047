
const verifyRole = (req, res, next) => {
  //console.log(req.user.role)
    const allowedRoles = ['Operador', 'Administrador'];
  if (!allowedRoles.includes(req.user.role)) {
      res.status(401).send({ mensaje: "No estás autorizado a entrar aquí" });
  } else {
   // console.log('autorizado',req.user.role)
    next();
  }
}

module.exports = verifyRole;