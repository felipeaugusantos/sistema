unit Contabilidade.Classes.TShowModalFormContasPorEmpresa;

interface

uses Contabilidade.Interfaces, UniClientDataSet;

type
  TShowModalFormContasPorEmpresa = Class(TInterfacedObject, IShowModalFormContasPorEmpresa)
  public
    procedure ShowModal(AParams: IParametrosFormContasPorEmpresa);
    class function New: IShowModalFormContasPorEmpresa;
  end;

  TCarregaCdsContasPorEmpresa = Class(TInterfacedObject, ICarregaCdsContasPorEmpresa)
  public
    function fCarregar(const AParams: IParametrosFormContasPorEmpresa): TUniClientDataSet;
    class function New: ICarregaCdsContasPorEmpresa;
  end;

  TSalvaCdsContasPorEmpresa = Class(TInterfacedObject, ISalvarCdsContasPorEmpresa)
  public
    procedure pSalvar(const AParams: IParametrosFormContasPorEmpresa);
    class function New: ISalvarCdsContasPorEmpresa;
  end;

implementation

uses Contabilidade.View.ContasPorEmpresa, untFuncoesSimples, Contabilidade.Funcoes;

{ TShowModalFormContasPorEmpresa }

class function TShowModalFormContasPorEmpresa.New: IShowModalFormContasPorEmpresa;
begin
  Result := Self.Create;
end;

procedure TShowModalFormContasPorEmpresa.ShowModal(
  AParams: IParametrosFormContasPorEmpresa);
  var
    frmContasPorEmpresa : TfrmContasPorEmpresa;
begin
  pCriarFormularios(TfrmContasPorEmpresa, frmContasPorEmpresa);
  try
    frmContasPorEmpresa.strTabela := AParams.Tabela;
    frmContasPorEmpresa.strCampoChave := AParams.CampoChave;
    frmContasPorEmpresa.blnCriaDataSet := AParams.CriaDataSet;
    frmContasPorEmpresa.cdsDados := AParams.cdsDados;
    frmContasPorEmpresa.strCreDeb := AParams.CreditoDebito;
    frmContasPorEmpresa.strValorChave := AParams.ValorChave;
    frmContasPorEmpresa.ReadOnly := AParams.ReadOnly;
    frmContasPorEmpresa.ShowModal;
  finally
    pFreeAndNil(frmContasPorEmpresa);
  end;
end;

{ TCarregaCdsContasPorEmpresa }

function TCarregaCdsContasPorEmpresa.fCarregar(
  const AParams: IParametrosFormContasPorEmpresa): TUniClientDataSet;
var
  LcdsDados: TUniClientDataSet ;
begin
  LcdsDados := AParams.CdsDados ;

  pCarregaDadosNCO(AParams.Tabela, AParams.CampoChave, AParams.ValorChave, LcdsDados) ;

  Result := LcdsDados ;
end;

class function TCarregaCdsContasPorEmpresa.New: ICarregaCdsContasPorEmpresa;
begin
  Result := Self.Create;
end;

{ TSalvaCdsContasPorEmpresa }

procedure TSalvaCdsContasPorEmpresa.pSalvar(
  const AParams: IParametrosFormContasPorEmpresa);
begin
  fSalvaDadosNCO(AParams.Tabela, AParams.CampoChave, AParams.ValorChave, AParams.CdsDados) ;
end;

class function TSalvaCdsContasPorEmpresa.New: ISalvarCdsContasPorEmpresa;
begin
  Result := Self.Create;
end;

end.
