unit Produto.GS1CNP.Consulta.Factory;

interface

uses Produto.GS1CNP.Interfaces.Consulta, untFuncoesSimples, Produto.GS1CNP.Consulta.View;

type
  TProdutoGS1CNPConsultaFactory = class(TInterfacedObject, IProdutoGS1CNPConsultaFactory)
  private
  public
    procedure Consultar(dicValoresAtuais, dicResultado: TDicionario;
      const ACodBar: String; const AInsert: Boolean; const AAccessToken: String);

    class function New(): IProdutoGS1CNPConsultaFactory;
  end;

implementation

{ TProdutoGS1CNPConsulta }

procedure TProdutoGS1CNPConsultaFactory.Consultar(dicValoresAtuais, dicResultado: TDicionario;
      const ACodBar: String; const AInsert: Boolean; const AAccessToken: String);
var
  intIdx: Integer;
begin
  pCriarFormularios(TProdutoGS1CNPConsultaView, ProdutoGS1CNPConsultaView);
  try
    ProdutoGS1CNPConsultaView.dicValoresAtuais.Limpar;
    for intIdx := 0 to dicValoresAtuais.Chaves.Count - 1 do
      ProdutoGS1CNPConsultaView.dicValoresAtuais.Adicionar(dicValoresAtuais.Chaves[intIdx],
                                                           dicValoresAtuais.Retorna(dicValoresAtuais.Chaves[intIdx]));

    ProdutoGS1CNPConsultaView.strCodBar := ACodBar;
    ProdutoGS1CNPConsultaView.blnInsert := AInsert;
    ProdutoGS1CNPConsultaView.strAccessToken := AAccessToken;
    ProdutoGS1CNPConsultaView.ShowModal;

    If ProdutoGS1CNPConsultaView.blnConfirma Then
    Begin
      for intIdx := 0 to ProdutoGS1CNPConsultaView.dicResultado.Chaves.Count - 1 do
        dicResultado.Adicionar(ProdutoGS1CNPConsultaView.dicResultado.Chaves[intIdx],
                               ProdutoGS1CNPConsultaView.dicResultado.Retorna(ProdutoGS1CNPConsultaView.dicResultado.Chaves[intIdx]));
    End;
  finally
    pFreeAndNil(ProdutoGS1CNPConsultaView);
  end;
end;

class function TProdutoGS1CNPConsultaFactory.New: IProdutoGS1CNPConsultaFactory;
begin
  Result := Self.Create;
end;

end.
