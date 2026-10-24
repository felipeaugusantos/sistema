unit untFuncoesDLLContasAReceber;

interface

uses  

procedure pSetDigSenVarRelContasAReceber(objSenVar : IDigSenVar); stdcall;

implementation

Procedure pSetDigSenVarRelContasAReceber(objSenVar : IDigSenVar);
Begin
  pSetDigSenVar(objSenVar);
End;

end.
