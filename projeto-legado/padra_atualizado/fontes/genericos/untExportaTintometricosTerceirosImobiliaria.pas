unit untExportaTintometricosTerceirosImobiliaria;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes,
  untThreadExportacaoTerceiros, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TComp = Record
    Componente: String;
    Quantidade: Double;
    Quantiddil: Double;
  End;

Type
  TExcel = Record
    Produto: String;
    SubProduto: String;
  End;

Type
  TColecao = Record
  Colecao: String;
End;

TArrExcel = Array Of TExcel;
TArrColecao = Array Of TColecao;


type
  TExportaTintometricosTerceirosImobiliaria = class abstract(TThreadExportacaoTerceiros)
  private

  protected
    procedure pRetornaPrecoTinta(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;

    procedure pRetornaPrecoTintaImobiliaria(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Virtual;

    procedure pRetornaQuantidadeFormulacao(dicRetorno: TDicionario;
      qryGen: TUniQuery; qryBases: TUniQuery); override;

    procedure pRetornaQuantidadeFormula(dicRetorno: TDicionario;
      qryGen: TUniQuery; qryBases: TUniQuery); Virtual;

    Procedure pProcessarCadastroEmpresaExportacao(); Virtual;

    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery; qryBases: TUniQuery; fltPerAcr: Double); Virtual;

    procedure pGravaTintometricoTabelasTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); virtual;

    procedure pPreencheDicRetorno(dicRetorno: TDicionario; qryGen: TUniQuery;
      strTabUni, strTabPre: String); override;

    function fCriaTabelaColorantes: TUniQuery; override;
  public
    strCfgPre: String;
    stlTabPre: TStringList;
    dicPrecoAdicional: TDicionario;
    slEmpExportacao: TStringList;
  End;

implementation

{ TExportaTintometricosTerceirosImobiliaria }

function TExportaTintometricosTerceirosImobiliaria.fCriaTabelaColorantes: TUniQuery;
begin
  Result := fCriaNovaQuery(fRetornaColorantes);
end;

procedure TExportaTintometricosTerceirosImobiliaria.pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
begin
  //
end;

procedure TExportaTintometricosTerceirosImobiliaria.pGravaTintometricoTabelasTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0);
begin
  pGravaTintometricoTabelasTerceirosPorTinta(qryInsert, fltPreVen, qryTinta, intParam);
end;

procedure TExportaTintometricosTerceirosImobiliaria.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  With qryInsert Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fSQLInsert);
    pAdicionaParamentros(qryInsert, qryTinta, fltPreVen);
    ExecSQL;
  End;
end;

procedure TExportaTintometricosTerceirosImobiliaria.pPreencheDicRetorno(
  dicRetorno: TDicionario; qryGen: TUniQuery; strTabUni, strTabPre: String);
begin
  dicRetorno['idepro']       := FIdePro;
  dicRetorno['montad']       := '';
  dicRetorno['a_n_o_']       := '';
  dicRetorno['itetin']       := qryGen.FieldByName(fRetMD5KEY).AsString;
  dicRetorno['tippre']       := '';
  dicRetorno['itebas']       := qryGen.FieldByName(fRetItemBase).AsString;
  dicRetorno['iteemb']       := '';
  dicRetorno['codemp']       := VS_strCodEmp;
  dicRetorno['volpro']       := 1;
  dicRetorno['linha_']       := '';
  dicRetorno['qtdemb']       := 1;
  dicRetorno['descri']       := qryGen.FieldByName(fRetDescricao).AsString;
  dicRetorno['complementob'] := '';
  dicRetorno['tipcor']       := '';
  dicRetorno['tabelaunica']  := strTabUni;
  dicRetorno['tabpre']       := strTabPre;

  dicRetorno['exportacaoterceiros'] := 'S';
end;

procedure TExportaTintometricosTerceirosImobiliaria.pProcessarCadastroEmpresaExportacao;
begin
  //
end;

procedure TExportaTintometricosTerceirosImobiliaria.pRetornaPrecoTinta(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
begin
  pRetornaPrecoTintaImobiliaria(dicRetorno, qryColorantes, qryBases, fltPerAcr);
end;

procedure TExportaTintometricosTerceirosImobiliaria.pRetornaPrecoTintaImobiliaria(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
  intContador: Integer;
  fltQuantidade,
  fltPrecoVenda,
  fltPrecoVendaTotal,
  fltPrecoColorante,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
begin
  fltPrecoVendaTotal := 0;
  fltPrecoColorante  := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];

  Try
    SetLength(ArrComponentes, fQuantidadeFormulacao);

    //Adiciona a formulacao no array
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] / fFatorTinta, 3);
    End;

    //Calcula o preco de venda
    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
        Break;

      If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente,[]) Then
      Begin
        If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoColorante := fltPreVenPro
        Else
          fltPrecoColorante := qryColorantes.FieldByName('ITE_PREVEN').AsFloat;
      End;

      fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
      fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));

      fltPrecoVendaTotal := fltPrecoVendaTotal + fltPrecoVenda;
    End;

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
      Else
        fltPrecoEmbalagem := qryBases.FieldByName('ITE_PREVEN').AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PREVEN').AsFloat);
    End;

    fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;

    dicRetorno['preve' + strTabelaUnica] := fltPrecoVendaTotal;

    pCarregarPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);
  Finally
    SetLength(ArrComponentes, 0);
  End;
end;


procedure TExportaTintometricosTerceirosImobiliaria.pRetornaQuantidadeFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
var
  intContador: Integer;
begin
  For intContador := 1 To fQuantidadeFormulacao Do
  Begin
    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat * fFatorTinta;
  End;
end;

procedure TExportaTintometricosTerceirosImobiliaria.pRetornaQuantidadeFormulacao(
  dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery);
begin
  pRetornaQuantidadeFormula(dicRetorno, qryGen, qryBases);
end;

end.
