unit untISetarParametros;

interface

Uses Uni;


Type
  IFatOrdProTintaMaquina = Interface
  ['{CAEEA4C3-7871-4C00-BC6A-A12B2CF66853}']
End;

Type
  IFuncoesSaldos = Interface
  ['{88C07739-DAAE-4358-89AB-6049CF460A4E}']
End;

Type
IFuncoesCRM = interface
  ['{A1472DFA-D192-4454-8F15-0D4387BB9B30}']
end;

type
  IFatDefineLotesPedidoWMS = interface
  ['{67134118-3D81-4D5F-A5FB-3DCBD2DA165A}']

end;

type
  IExecutaSQLReplicacaoTinta = Interface
  ['{2CCF42B9-E923-4F11-BBA9-3871CA05FB44}']
end;


Type
  ILiberacao = Interface
  ['{24B1EFE2-CD4E-465F-B3A3-EAB3594C53EB}']
End;

type
  ITransferencias = Interface
  ['{A2310CF4-AAE0-4DB8-B300-9BD7FF21C8FC}']

End;

Type
  TRecModulosAutcom = Record
    Banco : TUniConnection;
End;

type
  TfGravaMovDet = Interface
  ['{98BDACED-8707-4274-B339-1671D19EC917}']
End;

Type
  TfGravaMovGer = Interface
  ['{414026FC-34A3-40C3-8B5C-142BC935FCDF}']
End;


implementation

end.
