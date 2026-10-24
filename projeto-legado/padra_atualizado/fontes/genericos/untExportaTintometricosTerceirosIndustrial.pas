unit untExportaTintometricosTerceirosIndustrial;

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
  TExportaTintometricosTerceirosIndustrial = Class Abstract(TThreadExportacaoTerceiros)
  Private

  Protected
    procedure pRetornaPrecoTinta(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
      fltPerAcr: Double); Override;

    procedure pRetornaPrecoCatalisador(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
      fltPerAcr: Double); Virtual;

    procedure pRetornaPrecosCustoVenda(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
      fltPerAcr: Double; GeraCatalisador: Boolean); Virtual;

    procedure pRetornaPrecosCustoVendaCatalisador(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
      fltPerAcr: Double); Virtual;

    procedure pRetornaQuantidadeFormulacao(dicRetorno: TDicionario; qryGen:TUniQuery;
      qryBases: TUniQuery); Override;

    procedure pGravaTintometricoTabelasTerceiros(qryInsert: TFDQuery; fltPreVen: Double;
      qryTinta: TUniQuery; intParam: Integer = 0); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); virtual;

    procedure pPreencheDicRetorno(dicRetorno: TDicionario; qryGen: TUniQuery;
      strTabUni, strTabPre: String); Override;

    function fCriaTabelaColorantes(): TUniQuery; Override;
    function fPrefixoQuantCatalisador(): String; Virtual;
    function fPrefixoCatalisador(): String; Virtual;

  Public
    dicPrecosCatalisador: TDicionario;
    dicPrecosVendaCusto: TDicionario;
    stlTabPreco: TStringList;
  End;

implementation

{ TExportaTintometricosTerceirosIndustrial }

function TExportaTintometricosTerceirosIndustrial.fCriaTabelaColorantes: TUniQuery;
begin
  Result := fCriaNovaQuery(fRetornaColorantes);
end;

function TExportaTintometricosTerceirosIndustrial.fPrefixoCatalisador: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosIndustrial.fPrefixoQuantCatalisador: String;
begin
  Result := '';
end;

procedure TExportaTintometricosTerceirosIndustrial.pGravaTintometricoTabelasTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0);
begin
  pGravaTintometricoTabelasTerceirosPorTinta(qryInsert, fltPreVen, qryTinta, intParam);
end;

procedure TExportaTintometricosTerceirosIndustrial.pGravaTintometricoTabelasTerceirosPorTinta(
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

procedure TExportaTintometricosTerceirosIndustrial.pPreencheDicRetorno(
  dicRetorno: TDicionario; qryGen: TUniQuery; strTabUni, strTabPre: String);
begin
  dicRetorno['idepro']              := FIdePro;
  dicRetorno['montad']              := '';
  dicRetorno['a_n_o_']              := '';
  dicRetorno['itetin']              := qryGen.FieldByName(fRetMD5KEY).AsString;
  dicRetorno['tippre']              := '';
  dicRetorno['itebas']              := qryGen.FieldByName(fRetItemBase).AsString;
  dicRetorno['iteemb']              := '';
  dicRetorno['codemp']              := VS_strCodEmp;
  dicRetorno['volpro']              := 1;
  dicRetorno['linha_']              := '';
  dicRetorno['qtdemb']              := 1;
  dicRetorno['descri']              := qryGen.FieldByName(fRetDescricao).AsString;
  dicRetorno['complementob']        := '';
  dicRetorno['tipcor']              := '';
  dicRetorno['tabelaunica']         := strTabUni;
  dicRetorno['tabpre']              := strTabPre;
  dicRetorno['exportacaoterceiros'] := 'S';
end;

procedure TExportaTintometricosTerceirosIndustrial.pRetornaPrecoCatalisador(
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
  dicPrecosCatalisador.Limpar;

  Try
    SetLength(arrComponentes, fQuantidadeFormulacao());

    //Adicionar Colorantes, Catalisador e suas quantidades no Array
    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['BASE_' + fStrZero(intContador, 2)], ''))) Then
        Break;

      ArrComponentes[intContador].Componente := dicRetorno['BASE_' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['QTDB_' + fStrZero(intContador, 2)] / fFatorTinta, 3);
      ArrComponentes[intContador].Tipo       := dicRetorno['TIPB_' + fStrZero(intContador, 2)];
    End;

    //Calcula o preço de venda de Colorantes e Catalisador
    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(arrComponentes[intContador].Componente) Then
        Break;

      If arrComponentes[intContador].Tipo = 'COLORANTE' Then
      Begin
        If qryColorantes.Locate('COL_CODCOL', arrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreVenPro
          Else
            fltPrecoColorante := qryColorantes.FieldByName('ITE_PREVEN').AsFloat;
        End;

        fltQuantidade := arrComponentes[intContador].Quantidade * fFatorTinta;
        fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
      End
      Else If arrComponentes[intContador].Tipo = 'BASE' Then
      Begin
        If qryBases.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([arrComponentes[intContador].Componente, dicRetorno['CODEMB']]), []) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreVenPro
          Else
            fltPrecoColorante := qryBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        fltQuantidade := 1;
        fltPrecoVenda := fltQuantidade * (fltPrecoColorante / 1);
      End
      Else
        fltPrecoVenda := 0;

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
    dicPrecosCatalisador['PRECO_CATALISADOR'] := fltPrecoVendaTotal;
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosIndustrial.pRetornaPrecosCustoVenda(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double; GeraCatalisador: Boolean);
Var
  intContador: Integer;
  fltQuantidade,
  fltPrecoVenda,
  fltPrecoVendaTotal,
  fltPrecoColorante,
  fltPrecoEmbalagem,
  fltPrecoCusto,
  fltPrecoCustoTotal: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  intPreVen: Integer;
begin
  fltPrecoColorante  := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];
  dicPrecosVendaCusto.Limpar;

  Try
    SetLength(arrComponentes, fQuantidadeFormulacao());

    //Adiciona  Colorantes e Quantidades no Array
    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['BASE_' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If IfNull(dicRetorno['TIPB_' + fStrZero(intContador, 2)], '') = 'BASE' Then
        Continue;

      ArrComponentes[intContador].Componente := dicRetorno['BASE_' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := IfNull(dicRetorno['QTDB_' + fStrZero(intContador, 2)], 0.0);
      ArrComponentes[intContador].Tipo       := IfNull(dicRetorno['TIPB_' + fStrZero(intContador, 2)], 0.0);
    End;

    //Calcula o Preço de vendas(Tabelas de clientes 1 a 7)
    For intPreVen := 1 To 7 Do
    Begin
      fltPrecoVendaTotal := 0;

      If stlTabPreco[intPreVen] <> 'S' Then
        Continue;

      For intContador := 1 To Length(arrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreVenPro
          Else
            fltPrecoColorante := qryColorantes.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat;
        End;

        fltQuantidade := arrComponentes[intContador].Quantidade * fFatorTinta;
        fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
        fltPrecoVendaTotal := fltPrecoVendaTotal + fltPrecoVenda;
      End;

      If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'], []) Then
      Begin
        If fCarregaPromocao(dicRetorno['itebas'], IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := qryBases.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat);
      End;

      fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;
      dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2)] := fltPrecoVendaTotal;
    End;


    //Calculando o preço de Custo
    fltPreCusPro       := 0;
    fltPreVenPro       := 0;
    fltPrecoColorante  := 0;
    fltPrecoCustoTotal := 0;
    fltPrecoEmbalagem  := 0;
    strCodCli          := '';
    strCodCnd          := '';
    intPrzMed          := 0;

    For intContador := 1 To Length(arrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

      If qryColorantes.Locate('COL_CODCOL', arrComponentes[intContador].Componente, []) Then
      Begin
        If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          fltPrecoColorante := fltPreCusPro;

          If fltPrecoColorante = 0 Then
            fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
        End
        Else
          fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
      End;

      fltQuantidade := arrComponentes[intContador].Quantidade;
      fltPrecoCusto := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
      fltPrecoCustoTotal := fltPrecoCustoTotal + fltPrecoCusto;
    End;

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'], []) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      Begin
        fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro);

        If fltPrecoEmbalagem = 0 Then
          fltPrecoEmbalagem := qryBases.FieldByName('ITE_PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PRECUS').AsFloat);
      End
      Else
        fltPrecoEmbalagem := qryBases.FieldByName('ITE_PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PRECUS').AsFloat);
    End;

    fltPrecoCustoTotal := fltPrecoCustoTotal + (fltPerAcr * fltPrecoCustoTotal) + fltPrecoEmbalagem;
    dicPrecosVendaCusto['PRECUS'] := fltPrecoCustoTotal;

    If GeraCatalisador Then
      pRetornaPrecosCustoVendaCatalisador(dicRetorno, qryColorantes, qryBases, fltPerAcr);
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosIndustrial.pRetornaPrecosCustoVendaCatalisador(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  fltQuantidade,
  fltPrecoVenda,
  fltPrecoVendaTotal,
  fltPrecoColorante,
  fltPrecoEmbalagem,
  fltPrecoCusto,
  fltPrecoCustoTotal: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  intPreVen: Integer;
begin
  fltPrecoColorante  := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];

  Try
    SetLength(arrComponentes, fQuantidadeFormulacao());

    //Adiciona  Colorantes, Catalisador e Quantidades no Array
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['BASE_' + fStrZero(intContador, 2)], ''))) Then
        Break;

      arrComponentes[intContador].Componente := dicRetorno['BASE_' + fStrZero(intContador, 2)];
      arrComponentes[intContador].Quantidade := dicRetorno['QTDB_' + fStrZero(intContador, 2)];
      arrComponentes[intContador].Tipo       := dicRetorno['TIPB_' + fStrZero(intContador, 2)];
    End;

    //Calcula o Preço de venda dos colorantes e catalisador (Tabelas de clientes 1 a 7)
    For intPreVen := 1 To 7 Do
    Begin
      fltPrecoVendaTotal := 0;

      If stlTabPreco[intPreVen] <> 'S' Then
        Continue;

      For intContador := 1 To Length(arrComponentes) Do
      Begin

        If fEmptyStr(arrComponentes[intContador].Componente) Then
          Break;

        If arrComponentes[intContador].Tipo = 'COLORANTE' Then
        Begin
          If qryColorantes.Locate('COL_CODCOL', arrComponentes[intContador].Componente, []) Then
          Begin
            If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoColorante := fltPreVenPro
            Else
              fltPrecoColorante := qryColorantes.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltQuantidade := arrComponentes[intContador].Quantidade;
          fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
        End
        Else If arrComponentes[intContador].Tipo = 'BASE' Then
        Begin
          If qryBases.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([arrComponentes[intContador].Componente, dicRetorno['CODEMB']]), []) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString, IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoColorante := fltPreVenPro
            Else
              fltPrecoColorante := qryBases.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltQuantidade := 1;
          fltPrecoVenda := fltQuantidade * fltPrecoColorante / 1;
        End
        Else
          fltPrecoVenda := 0.0;

        fltPrecoVendaTotal := fltPrecoVendaTotal + fltPrecoVenda;
      End;

      If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'], []) Then
      Begin
        If fCarregaPromocao(dicRetorno['itebas'], IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := qryBases.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PREVE' + IntToStr(intPreVen)).AsFloat);
      End;

      fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;
      dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2) + '_CATALISADOR'] :=  fltPrecoVendaTotal;
    End;

    //Calculando o preço de Custo dos colorantes e catalisador
    fltPreCusPro       := 0;
    fltPreVenPro       := 0;
    fltPrecoColorante  := 0;
    fltPrecoCustoTotal := 0;
    fltPrecoEmbalagem  := 0;
    strCodCli          := '';
    strCodCnd          := '';
    intPrzMed          := 0;

    For intContador := 1 To Length(arrComponentes) Do
    Begin
      fltPrecoCusto := 0.0;

      If fEmptyStr(arrComponentes[intContador].Componente) Then
        Break;

      If arrComponentes[intContador].Tipo = 'COLORANTE' Then
      Begin
        If qryColorantes.Locate('COL_CODCOL', arrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreCusPro
          Else
            fltPrecoColorante := qryColorantes.FieldByName('ITE_PRECUS').AsFloat;
        End;

        fltQuantidade := arrComponentes[intContador].Quantidade * fFatorTinta;
        fltPrecoCusto := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
      End
      Else If arrComponentes[intContador].Tipo = 'BASE' Then
      Begin
        If qryBases.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([ArrComponentes[intContador].Componente, dicRetorno['CODEMB']]), []) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString, strTabelaUnica,strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreCusPro
          Else
            fltPrecoColorante := qryBases.FieldByName('ITE_PRECUS').AsFloat;

          fltQuantidade := 1;
          fltPrecoCusto := fltQuantidade * (fltPrecoColorante / 1);
        End;
      End;

      fltPrecoCustoTotal := fltPrecoCustoTotal + fltPrecoCusto;
    End;

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'], []) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro)
      Else
        fltPrecoEmbalagem := qryBases.FieldByName('ITE_PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PRECUS').AsFloat);
    End;

    fltPrecoCustoTotal := fltPrecoCustoTotal + (fltPerAcr * fltPrecoCustoTotal) + fltPrecoEmbalagem;
    dicPrecosVendaCusto['PRECUS_CATALISADOR'] := fltPrecoCustoTotal;
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosIndustrial.pRetornaPrecoTinta(
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
  GeraCatalisador: Boolean;
begin
  fltPrecoVendaTotal := 0;
  fltPrecoColorante  := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  GeraCatalisador    := False;

  strTabelaUnica := dicRetorno['tabelaunica'];
  dicPrecosCatalisador.Limpar;

  Try
    SetLength(ArrComponentes, fQuantidadeFormulacao());

    //Adiciona Colorantes e Quantidades no Array
    For intContador := 1  To fQuantidadeFormulacao() Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['BASE_' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If IfNull(dicRetorno['TIPB_' + fStrZero(intContador, 2)], '') = 'BASE' Then
      Begin
        GeraCatalisador := True;
        Continue;
      End;

      ArrComponentes[intContador].Componente := dicRetorno['BASE_' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['QTDB_' + fStrZero(intContador, 2)] / fFatorTinta, 3);
      ArrComponentes[intContador].Tipo       := dicRetorno['TIPB_' + fStrZero(intContador, 2)];
    End;

    //Calcula o preco de venda dos colorantes
    For intContador := 1 To Length(arrComponentes) Do
    Begin
      If fEmptyStr(arrComponentes[intContador].Componente) Then
        Break;

      If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente, []) Then
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

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'], []) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
      Else
        fltPrecoEmbalagem := qryBases.FieldByName('ITE_PREVEN').AsFloat + (fltPerAcr * qryBases.FieldByName('ITE_PREVEN').AsFloat);
    End;

    fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;
    dicRetorno['preve' + strTabelaUnica] := fltPrecoVendaTotal;

    If GeraCatalisador Then
      pRetornaPrecoCatalisador(dicRetorno, qryColorantes, qryBases, fltPerAcr);

    pRetornaPrecosCustoVenda(dicRetorno, qryColorantes, qryBases, fltPerAcr, GeraCatalisador);
  Finally
    SetLength(ArrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosIndustrial.pRetornaQuantidadeFormulacao(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
var
  intContador: Integer;
  UsaCatalisador: Boolean;
  intCatalisador: Integer;
begin
  intCatalisador := 1;

  If Not fEmptyStr(fPrefixoQuantCatalisador) Then
    UsaCatalisador := qryGen.FieldByName(fPrefixoQuantCatalisador).AsFloat > 0
  Else
    UsaCatalisador := False;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['BASE_' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['QTDB_' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat * fFatorTinta;
    dicRetorno['TIPB_' + fStrZero(intContador, 2)] := 'COLORANTE';
    Inc(intCatalisador);
  End;

  If (UsaCatalisador) Then
  Begin
    dicRetorno['BASE_' + fStrZero(intCatalisador, 2)] := qryGen.FieldByName(fPrefixoCatalisador).AsString;
    dicRetorno['QTDB_' + fStrZero(intCatalisador, 2)] := qryGen.FieldByName(fPrefixoQuantCatalisador).AsFloat * fFatorTinta;
    dicRetorno['TIPB_' + fStrZero(intCatalisador, 2)] := 'BASE';
  End;

  dicRetorno['CODEMB'] := qryGen.FieldByName('ADT_CODEMB').AsString;
end;

end.
