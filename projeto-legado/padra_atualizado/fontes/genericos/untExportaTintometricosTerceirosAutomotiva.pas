unit untExportaTintometricosTerceirosAutomotiva;

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

//Tipos
Type
  TTipoEmb = Record
    strTipo: String;
  End;

Type
  TTipoLinha = Record
    strNome: String;
    strLinha: String;
  End;


TArrTipo = Array Of TTIpoEmb;
TArrLinha = Array Of TTipoLinha;


// Embalagens
Type
  TEmbalagens = record
    strNomEmb: String;
    strSigEmb: String;
    fltVolume: Double;
    strIteEmb: String;
End;

Type
  TComp = Record
    Componente: String;
    Quantidade: Double;
    Quantiddil: Double;
    Quantidil2: Double; // Criado para tintas que tem duas quantidades diluidas.
  End;


TArrEmbalagens = Array of TEmbalagens;

// Preco final por embalagem
Type
  TPrecoPorEmbalagens = record
    strSigEmb: String;
    fltValCon: Double;
    fltValDil: Double;
    fltValDi2: Double;
    strIteEmb: String;
    fltPreEmb: Double;
    strCodDil: String;
    fltPorDil: Double;
End;

TArrPrecoPorEmb = Array of TPrecoPorEmbalagens;

//Guarda o preco do item embalagem por conta da performance
Type
  TPrecoProdutoEmbalagem = record
    strIteEmb: String;
    fltPreVen: Double;
End;

TArrPrecoProdutoEmbalagem = Array of TPrecoProdutoEmbalagem;

type
  TExportaTintometricosTerceirosAutomotiva = class abstract(TThreadExportacaoTerceiros)
  private
    arrPrecoProdutoEmbalagem: TArrPrecoProdutoEmbalagem;
  protected
    arrPrecosPorEmb: TArrPrecoPorEmb;
    procedure pRetornaPrecoTinta(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;

    procedure pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double); virtual;

    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Virtual;

    procedure pRetornaQuantidadeFormulacao(dicRetorno: TDicionario;
      qryGen: TUniQuery; qryBases: TUniQuery); override;

    procedure pGravaTintometricoTabelasTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); virtual;

    procedure pPreencheDicRetorno(dicRetorno: TDicionario; qryGen: TUniQuery;
      strTabUni, strTabPre: String); override;

   {$IFDEF LINUX}
    procedure pValidarPrecoExportacao(AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double; dicPrecos: TDicionario; APrefix: String);
   {$ENDIF}

    function fRetornaCampoEmbalagem(strSigEmb: String;
      dicRetorno: TDicionario): String; virtual; abstract;

//    procedure pCriaClientEmbalagem;

    function fRetornaPrecoVendaEmbalagem(strCodIte: String;
      fltPerAcr: Double): Double;

    function fSelecionaPrecoVendaEmbalagem(strCodIte: String;
      fltPerAcr: Double): Double;

    function fSelecionaPrecoVendaEmbalagemTabClientes(strCodIte: String; fltPerAcr:Double; intTabVen: Integer): Double;

    function fSelecionaPrecoCustoEmbalagem(strCodIte: String; fltPerAcr: Double): Double;

    function fRetornaSelectProdutoEmbalagensTabCliente(strCodIte: String; intTabVen: Integer): String;

    function fRetornaSelectProdutoEmbalagens(strCodIte: String): String;

    function fRetornaSelectPrecoCustoEmbalagens(strCodIte: String): String;

  public
    arrEmbalagens: TArrEmbalagens;
    cdsEmbalagens: TUniClientDataSet;
    cdsDiluentes: TUniClientDataSet;
    arrTipo: TArrTipo;
    arrLinha: TArrLinha;
    dicPrecoAdicional: TDicionario;
    strCfgPre: String;
    stlTabPre: TStringList;

    procedure pRecalculaFormula(dicRetorno: TDicionario;
      qryGen: TUniQuery; qryBases: TUniQuery); virtual; abstract;

    function fRetTipoCor: String; virtual; abstract;

    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; virtual;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; virtual;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;

    destructor Destroy; override;
  End;

implementation

{ TExportaTintometricosTerceirosAutomotiva }

constructor TExportaTintometricosTerceirosAutomotiva.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  SetLength(arrPrecoProdutoEmbalagem, 1);
end;

destructor TExportaTintometricosTerceirosAutomotiva.Destroy;
begin
  If Assigned(cdsEmbalagens) Then FreeAndNil(cdsEmbalagens);
  If Assigned(cdsDiluentes) Then FreeAndNil(cdsDiluentes);
  SetLength(arrPrecoProdutoEmbalagem, 0);
  inherited;
end;

function TExportaTintometricosTerceirosAutomotiva.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosAutomotiva.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosAutomotiva.fRetornaPrecoVendaEmbalagem(
  strCodIte: String; fltPerAcr: Double): Double;
var
  intCont: Integer;
begin
  //Verifica se o produto embalagem ja foi utilizado
  For intCont := 0 To Length(arrPrecoProdutoEmbalagem) - 1 Do
  Begin
    If arrPrecoProdutoEmbalagem[intCont].strIteEmb = strCodIte Then
    Begin
      Result := arrPrecoProdutoEmbalagem[intCont].fltPreVen;
      Exit;
    End;
  End;

  //Se o produto embalagem ainda nao foi utilizado entao seleciona o valor
  Result := fSelecionaPrecoVendaEmbalagem(strCodIte, fltPerAcr);

  //Adiciona no array arrPrecoProdutoEmbalagem
  arrPrecoProdutoEmbalagem[Length(arrPrecoProdutoEmbalagem) - 1].strIteEmb := strCodIte;
  arrPrecoProdutoEmbalagem[Length(arrPrecoProdutoEmbalagem) - 1].fltPreVen := Result;
  SetLength(arrPrecoProdutoEmbalagem, Length(arrPrecoProdutoEmbalagem) + 1);
end;

function TExportaTintometricosTerceirosAutomotiva.fRetornaSelectPrecoCustoEmbalagens(
  strCodIte: String): String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    ITE_PRECUS          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    ITEGER              ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    ITE_CODITE = "' + strCodIte + '"  AND         ';
  Result := Result + '    ITE_CODEMP = "' + Vs_strCodEmp + '"           ';
end;

function TExportaTintometricosTerceirosAutomotiva.fRetornaSelectProdutoEmbalagens(
  strCodIte: String): String;
begin
  Result := ' SELECT ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN ' +
            '   FROM ITEGER ' +
            '  WHERE ITE_CODITE = ' + QuotedStr(strCodIte) +
            '    AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;


function TExportaTintometricosTerceirosAutomotiva.fRetornaSelectProdutoEmbalagensTabCliente(
  strCodIte: String; intTabVen: Integer): String;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ITE_PREVE' + IntToStr(intTabVen) + ' AS ITE_PREVEN      ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ITEGER                ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    ITE_CODITE = "' + strCodIte + '" AND          ';
  Result := Result + '    ITE_CODEMP = "' + Vs_strCodEmp + '"           ';
end;

function TExportaTintometricosTerceirosAutomotiva.fSelecionaPrecoCustoEmbalagem(
  strCodIte: String; fltPerAcr: Double): Double;
Var
  qryCusEmb: TUniQuery;
begin
  Try
    qryCusEmb := fCriaNovaQuery(fRetornaSelectPrecoCustoEmbalagens(strCodIte));
    Result := qryCusEmb.FieldByName('ITE_PRECUS').AsFloat;
  Finally
    FreeAndNil(qryCusEmb);
  End;
end;

function TExportaTintometricosTerceirosAutomotiva.fSelecionaPrecoVendaEmbalagem(
  strCodIte: String; fltPerAcr: Double): Double;
var
  qryProEmb: TUniQuery;
begin
  Try
    qryProEmb := fCriaNovaQuery(fRetornaSelectProdutoEmbalagens(strCodIte));
    Result := qryProEmb.FieldByName('ITE_PREVEN').AsFloat +
      (fltPerAcr * qryProEmb.FieldByName('ITE_PREVEN').AsFloat);
  Finally
    FreeAndNil(qryProEmb);
  End;
end;

function TExportaTintometricosTerceirosAutomotiva.fSelecionaPrecoVendaEmbalagemTabClientes(
  strCodIte: String; fltPerAcr: Double; intTabVen: Integer): Double;
Var
  qryProEmb: TUniQuery;
begin
  Try
    qryProEmb := fCriaNovaQuery(fRetornaSelectProdutoEmbalagensTabCliente(strCodIte, intTabVen));
    Result := qryProEmb.FieldByName('ITE_PREVEN').AsFloat +
      (fltPerAcr * qryProEmb.FieldByName('ITE_PREVEN').AsFloat);
  Finally
    FreeAndNil(qryProEmb);
  End;
end;

procedure TExportaTintometricosTerceirosAutomotiva.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0);
var
  intEmb: Integer;
  strSigEmb: String;
begin
  Try
    With qryInsert Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSQLInsert);
      pAdicionaParamentros(qryInsert, qryTinta, fltPreVen);

      For intEmb := 0 To Length(arrEmbalagens) - 1 Do
      Begin
        strSigEmb := arrEmbalagens[intEmb].strSigEmb;

        ParamByName('PREC' + strSigEmb).AsFloat  := arrPrecosPorEmb[intEmb].fltValCon; //preco concentrado
        ParamByName('PRED' + strSigEmb).AsFloat  := arrPrecosPorEmb[intEmb].fltValDil; //preco diluido
        ParamByName('EMBA' + strSigEmb).AsString := arrPrecosPorEmb[intEmb].strIteEmb; //Produto embalagem
        ParamByName('VOLU' + strSigEmb).AsFloat  := arrEmbalagens[intEmb].fltVolume;   //Volume vendido
        ParamByName('PREE' + strSigEmb).AsFloat  := arrPrecosporEmb[intEmb].fltPreEmb; //Preco da embalagem
        ParamByName('TIPO' + strSigEmb).AsString := strSigEmb;                         //Tipo da embalagem
        ParamByName('CODDIL').AsString := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
        ParamByName('PORDIL').AsFloat  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
      End;

      ExecSQL;
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;

end;

procedure TExportaTintometricosTerceirosAutomotiva.pGravaTintometricoTabelasTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0);
begin
  pGravaTintometricoPorTintaTerceiros(qryInsert, fltPreVen, qryTinta, intParam);
end;

procedure TExportaTintometricosTerceirosAutomotiva.pPreencheDicRetorno(
  dicRetorno: TDicionario; qryGen: TUniQuery; strTabUni, strTabPre: String);
begin
  dicRetorno.Limpar;
  dicRetorno['idepro']      := FIdePro;
  dicRetorno['montad']      := '';
  dicRetorno['a_n_o_']      := '';
  dicRetorno['itetin']      := qryGen.FieldByName(fRetMD5KEY).AsString;
  dicRetorno['tippre']      := '';
  dicRetorno['codemp']      := VS_strCodEmp;
  dicRetorno['linha_']      := '';
  dicRetorno['qtdemb']      := 1;
  dicRetorno['descri']      := qryGen.FieldByName(fRetDescricao).AsString;
  dicRetorno['tabelaunica'] := strTabUni;
  dicRetorno['tabpre']      := strTabPre;

  dicRetorno['tipcor']      := qryGen.FieldByName(fRetTipoCor).AsString;


  dicRetorno['exportacaoterceiros'] := 'S';
end;

procedure TExportaTintometricosTerceirosAutomotiva.pRetornaPrecoTinta(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
begin
  pRetPrecoTintas(dicRetorno, qryColorantes, qryBases, fltPerAcr);
end;

procedure TExportaTintometricosTerceirosAutomotiva.pRetornaQuantidadeFormulacao(
  dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery);
var
  intContador: Integer;
begin
  For intContador := 1 To fQuantidadeFormulacao Do
  Begin
    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;
  End;

  //Algumas tintas possuem regras de diluicao
  pRecalculaFormula(dicRetorno, qryGen, qryBases);
end;

procedure TExportaTintometricosTerceirosAutomotiva.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
begin
  //
end;

procedure TExportaTintometricosTerceirosAutomotiva.pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
  intContador: Integer;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
  intEmb: Integer;
  strCamEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  //fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoVendaTotalDil := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    //Verificar se existe a embalagem
    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    //Verificar se existe produto vinculado
    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao);

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        fltEmbala := fRetEmbalagem(qryBases);

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / fltEmbala);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / fltEmbala);
      End;

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (fltQuantCon * fltPrecoBase);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;


        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := (fltQuantDil * fltPrecoBase);
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(
            cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      //Preco de venda concentrado
      fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
        (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      //Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      //Adiciona informacoes no array para gravar
      arrPrecosPorEmb[intEmb].strSigEmb := arrEmbalagens[intEmb].strSigEmb;
      arrPrecosPorEmb[intEmb].fltValCon := fltPrecoVendaTotalCon;
      arrPrecosPorEmb[intEmb].fltValDil := fltPrecoVendaTotalDil;
      arrPrecosPorEmb[intEmb].strIteEmb := cdsEmbalagens.FieldByName('CFG_VALCFG').AsString;
      arrPrecosPorEmb[intEmb].fltPreEmb := fltPrecoEmbalagem;
      arrPrecosPorEmb[intEmb].strCodDil := fRetornaCodigoDiluente(dicRetorno);
      arrPrecosPorEmb[intEmb].fltPorDil := fRetornaPorcentagemDiluente(dicRetorno);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;

  pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);
end;

{$IFDEF LINUX}
procedure TExportaTintometricosTerceirosAutomotiva.pValidarPrecoExportacao(AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double; dicPrecos: TDicionario; APrefix: String);
var
  LValInfo: TValidateInf;
begin
  LValInfo.strIdePro := FIdePro;
  LValInfo.strMD5Key := AMd5Key;
  LValInfo.strEmbPro := AEmbPro;
  LValInfo.strTabPre := fRetornaTabelaPreco;
  LValInfo.strModVen := AModVen;
  LValInfo.fltPreVen := fltPreVen;
  LValInfo.strCodDil := '';
  LValInfo.fltPreCus := IfNull(dicPrecos['PRECUS' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe1 := IfNull(dicPrecos['PREVE1' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe2 := IfNull(dicPrecos['PREVE2' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe3 := IfNull(dicPrecos['PREVE3' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe4 := IfNull(dicPrecos['PREVE4' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe5 := IfNull(dicPrecos['PREVE5' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe6 := IfNull(dicPrecos['PREVE6' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe7 := IfNull(dicPrecos['PREVE7' + APrefix + ASigEmb], 0.0);
  pValidacaoFormula(LValInfo, VS_strCodEmp);
end;
{$ENDIF}

end.
