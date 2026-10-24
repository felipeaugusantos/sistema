unit untTRegistro1050Cat42;

interface

uses System.Generics.Collections, untTRegistroBaseCat42, untTDadosBloco1Cat42, Forms,
     untTItensPresentesLfe, SysUtils, Classes;

type
  TRegistro1050 = class(TRegistroBase)
  private
    FItensPresentes: TItensPresentes;
    FDados: TObjectList<TSaldoCat42>;
  public
    procedure pGerar; override;

    property itensPresentes: TItensPresentes read FItensPresentes write FItensPresentes;
    property listaDados: TObjectList<TSaldoCat42> read FDados write FDados;
  end;

implementation

uses untFuncoes;

{ TRegistro1050 }

procedure TRegistro1050.pGerar;
  var
    dado: TSaldoCat42;
begin
  inherited;

  abertura.lblOperacao.Caption := 'Gerando registro 1050...';
  abertura.progressoTela.Max := FDados.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for dado in FDados do
  begin
    pInicializaLinha;

    pCampo(strTipoRegistro);                                  //001 Texto fixo contendo "1050"
    pCampo(dado.strCodigoProduto);                            //002 Código do item conforme Registro 0200
    pCampo(fFloatToStrVirgula(dado.fltQtdIni, 12, 3));        //003 Quantidade inicial do item no início do primeiro dia do período
    pCampo(fFloatToStrVirgula(dado.fltSalIni, 12, 2));        //004 Valor inicial acumulado do total do ICMS suportado pelo contribuinte, relativamente ao item, no início do primeiro dia do período
    pCampo(fFloatToStrVirgula(dado.fltQtdFin, 12, 3));        //005 Quantidade final do item no final do último dia do período
    pCampo(fFloatToStrVirgula(dado.fltSalFin, 12, 2), False); //006 Valor final acumulado do total do ICMS suportado pelo contribuinte, relativamente ao item, no início do primeiro dia do período

    intQuantidadeGerada := intQuantidadeGerada + 1;

    abertura.progressoTela.StepBy(1);
    Application.ProcessMessages;

    pAdicionaLista;

    //guarda os codigos de itens utilizados no arquivo
    FItensPresentes.listaItens.Sorted := True;
    FItensPresentes.listaItens.Duplicates := dupIgnore;
    FItensPresentes.listaItens.Add(dado.strCodigoProduto);
  end;
end;

end.
