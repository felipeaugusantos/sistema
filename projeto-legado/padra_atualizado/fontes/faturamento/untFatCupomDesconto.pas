unit untFatCupomDesconto;

interface

uses System.Classes, System.SysUtils, System.Math, untFuncFat, Uni, Variants,
  Data.DB, System.StrUtils;

type
  TFatCupomDesconto = class(TInterfacedObject, IInterface)
  private
    FObjVenda: TFatVenda;
    FQryCadCup: TUniQuery;
    FCupomGerado: String;
    function GetTotalProdutos: Double;
    function GerarNumeroCupom: String;
    function InformacoesCupom(): String;
    function GetCupomExiste(ACupom: String): Boolean;
    function GetCupomJaUtilizado(ACupom: String): Boolean;
    function GetCupomJaExpirou(ACupom: String): Boolean;
    function GetCupomIniciouValidade(ACupom: String): Boolean;
    function GetCupomInativado(ACupom: String): Boolean;
    function GetValorMinimoUtilizarCupom(ACupom: String): Double;
    function GetDocumentoUtilizado(ACupom: String): String;
    function GetCupomUtilizado(ADoc, AEsp, AEmp: String): String;
    function GetCuponsUtilizadoItens(): TArray<String>;
    function GetClienteDoCupom(ACupom: String): String;
    function GerarCupomValorFixo(): Boolean;
    function GerarCupomPercentualDesconto(): Boolean;
    function GerarCupomValorComprasAcumulado(): Boolean;
    function ValidarCupomExiste(ACupom: String; AMsg: Boolean): Boolean;
    function ValidarCupomJaUtilizado(ACupom: String; AMsg: Boolean): Boolean;
    function ValidarCupomInativado(ACupom: String; AMsg: Boolean): Boolean;
    function ValidarCupomJaExpirou(ACupom: String; AMsg: Boolean): Boolean;
    function ValidarCupomIniciouValidade(ACupom: String; AMsg: Boolean): Boolean;
    function ValidarClienteCupom(ACupom: String; AMsg: Boolean): Boolean;
    function ValidarValorMinimoVenda(ACupom: String; AMsg: Boolean): Boolean;
    procedure InserirCupomDesconto(AValorCupom: Double; AResumoCalculo: String);
    procedure CarregarCadastroCupomDesconto();
    procedure ProcessarCadastroCupomDesconto();
    procedure EnviarCupomDescontoParaCliente(strCodCup: String);
    function GetTotalProdutosCupom(): Double;
    procedure GerarCupomValorFixoItens();
    procedure GerarCupomPercentualDescontoItens();
    function VaiGerarCupom(AGerouCupom: Boolean): Boolean;
    procedure GerarCupomItens(ATipoCupom: string);
    function ValidaSituacaoCupom(ACupom: String; AMsg: Boolean = True): Boolean;
    procedure ImprimirCupomProxDesc(ACodCup: String);
    procedure ExecOpcCfgImpCpd(ACodCup: String; AValueMenu: Integer = -2);
  public
    constructor Create(AObjVenda: TFatVenda);
    destructor Destroy; override;
    procedure GerarCupomDesconto;
    function PodeUtilizarCupom(ACupom: String; AMsg: Boolean = True): Boolean;
    class procedure MarcarCupomUtilizado(ACupom, ADoc, AEsp, AEmp: String);
    class procedure DesmarcarCupomUtilizado(ADoc, AEsp, AEmp: String);
    class procedure InativarCuponsGerados(ADoc, AEsp, AEmp: String);
    class function GetNumeroCupom(ADoc, AEsp, AEmp: String): String;
    class function GetDescontoCupom(ACupom: String): Double;
    class function GetInformacoesCupom(ACupom: String): String;
    class function fRetornaValorCupomDescCliente(strCodCli: String): Double;
  end;

implementation

uses
  untFuncoesSimples, untFuncoes, untEditorFastImpressao, untTypesSistema, untFuncFatTypes;

{ TFatCupomDesconto }

procedure TFatCupomDesconto.CarregarCadastroCupomDesconto;
begin
  FQryCadCup.Close;
  FQryCadCup.SQL.Text := 'SELECT SQL_NO_CACHE * FROM ' +
    '  CADCUP WHERE TRUE AND :DTAVEN BETWEEN CUP_INIVIG AND CUP_FINVIG ' +
    '  AND (CUP_TIPPES = "A" OR CUP_TIPPES = :TIPPES) ORDER BY CUP_TIPCUP ';

  FQryCadCup.ParamByName('DTAVEN').AsDateTime := VS_Date;
  FQryCadCup.ParamByName('TIPPES').AsString := IIF(FObjVenda.intCgcCpf = 1,
    'J', 'F');
  FQryCadCup.Open;
end;

constructor TFatCupomDesconto.Create(AObjVenda: TFatVenda);
begin
  FCupomGerado := '';
  FObjVenda := AObjVenda;
  FQryCadCup := fCriaQuery;
end;

destructor TFatCupomDesconto.Destroy;
begin
  FreeAndNil(FQryCadCup);
  inherited;
end;

procedure TFatCupomDesconto.EnviarCupomDescontoParaCliente(strCodCup: String);
begin
  fDisparaWhatsappAutomatico(FObjVenda.strNumDoc, 'CD' { Cupom Desconto } ,
    FObjVenda.strEspDoc, '', '', FObjVenda.strEmpDoc, FObjVenda.strCodCli, '', True, strCodCup, Nil, '', '', '', Self.UnitName);

  fDisparaEmailAutomatico(FObjVenda.strNumDoc, 'CD' { Cupom Desconto } ,
    FObjVenda.strEspDoc, '', '', FObjVenda.strEmpDoc, FObjVenda.strCodCli, '', '', Nil, strCodCup);

  fDisparaSMSAutomatico(FObjVenda.strNumDoc, 'CD' { Cupom Desconto } ,
    FObjVenda.strEspDoc, '', '', FObjVenda.strEmpDoc, FObjVenda.strCodCli, '', True, strCodCup);
end;

function TFatCupomDesconto.GetCupomExiste(ACupom: String): Boolean;
begin
  Result := Not fEmptyStr(fCampoTabela('MCU_NUMCUP', 'MOVCUP', ['MCU_NUMCUP'],
    [ACupom]));
end;

function TFatCupomDesconto.GetCupomInativado(ACupom: String): Boolean;
begin
  Result := fCampoTabela('MCU_STATUS', 'MOVCUP', ['MCU_NUMCUP'],
    [ACupom]) = 'I';
end;

function TFatCupomDesconto.GetCupomIniciouValidade(ACupom: String): Boolean;
begin
  Result := fCampoTabela('MCU_INIVAL', 'MOVCUP', ['MCU_NUMCUP'], [ACupom])
    <= VS_Date;
end;

function TFatCupomDesconto.GetCupomJaExpirou(ACupom: String): Boolean;
begin
  Result := fCampoTabela('MCU_DTAVAL', 'MOVCUP', ['MCU_NUMCUP'], [ACupom])
    < VS_Date;
end;

function TFatCupomDesconto.GetCupomJaUtilizado(ACupom: String): Boolean;
begin
  Result := fCampoTabela('MCU_DTAUTI', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]) > 0;
end;

function TFatCupomDesconto.GetCupomUtilizado(ADoc, AEsp, AEmp: String): String;
begin
  Result := fCampoTabela('MCU_NUMCUP', 'MOVCUP', ['MCU_NUMPED', 'MCU_ESPPED',
    'MCU_EMPPED'], [ADoc, AEsp, AEmp]);
end;

function TFatCupomDesconto.GetCuponsUtilizadoItens: TArray<String>;
Var
  LItem: TDadosFechamento;
  LCupom: String;
begin
  SetLength(Result, 0);

  For LItem In FObjVenda.ArrMatItens Do
    If Not LItem.strNumOrc.IsEmpty Then
    Begin
      LCupom := GetCupomUtilizado(LItem.strNumOrc, LItem.strEspOrc,
        LItem.strEmpOrc);

      If Not LCupom.IsEmpty Then
        If Not MatchStr(LCupom, Result) Then
          pAddDados(Result, LCupom);
    End;

end;

function TFatCupomDesconto.PodeUtilizarCupom(ACupom: String;
  AMsg: Boolean = True): Boolean;
begin
  If Not ValidarCupomExiste(ACupom, AMsg) Then
    Exit(False);

  If Not ValidarCupomJaUtilizado(ACupom, AMsg) Then
    Exit(False);

  If Not ValidarCupomInativado(ACupom, AMsg) Then
    Exit(False);

  If Not ValidarCupomJaExpirou(ACupom, AMsg) Then
    Exit(False);

  If Not ValidaSituacaoCupom(ACupom, AMsg) Then
    Exit(False);

  Result := True;
end;

procedure TFatCupomDesconto.ProcessarCadastroCupomDesconto;
Var
  LGerouCupom: Boolean;
begin
  LGerouCupom := False;
  FQryCadCup.First;
  While Not FQryCadCup.Eof Do
  Begin
    If Not VaiGerarCupom(LGerouCupom) Then
    Begin
      FQryCadCup.Next;
      Continue;
    End;

    If FQryCadCup.FieldByName('CUP_TIPCUP').AsString = 'VF' Then
      LGerouCupom := GerarCupomValorFixo();

    If FQryCadCup.FieldByName('CUP_TIPCUP').AsString = 'PD' Then
      LGerouCupom := GerarCupomPercentualDesconto();

    If FQryCadCup.FieldByName('CUP_TIPCUP').AsString = 'VC' Then
      LGerouCupom := GerarCupomValorComprasAcumulado();

    GerarCupomItens(FQryCadCup.FieldByName('CUP_TIPCUP').AsString);

    FQryCadCup.Next;
  End;
end;

function TFatCupomDesconto.VaiGerarCupom(AGerouCupom: Boolean): Boolean;
begin
  Result := True;

  If (AGerouCupom) Then
  Begin
    If (FQryCadCup.FieldByName('CUP_TIPCUP').AsString <> 'VI') Then
    Begin
      If (FQryCadCup.FieldByName('CUP_TIPCUP').AsString <> 'PI') Then
      Begin
        Result := False;
      End;
    End;
  End;
end;

procedure TFatCupomDesconto.ExecOpcCfgImpCpd(ACodCup: String;
 AValueMenu: Integer = -2);
const
  LOpcGetMenu: Array Of String = ['1 - Somente Enviar WhatsApp, Email..',
                                  '2 - Somente Imprimir',
                                  '3 - Ambos'];
var
  LImpCpd: Integer;
begin
  If fEmptyStr(FCupomGerado) Then
    Exit;

  LImpCpd := IIF(AValueMenu >= -1, AValueMenu, fCfgSis('IMPCPD', varInteger));

  Case LImpCpd Of
    1: EnviarCupomDescontoParaCliente(ACodCup);
    2: ImprimirCupomProxDesc(ACodCup);
    3: Begin
         EnviarCupomDescontoParaCliente(ACodCup);
         ImprimirCupomProxDesc(ACodCup);
       End;
    4: ExecOpcCfgImpCpd(ACodCup, fGetMenu('Opção:',LOpcGetMenu,1,True));
  End;
end;

function TFatCupomDesconto.ValidarClienteCupom(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If GetClienteDoCupom(ACupom) <> FObjVenda.strCodCli Then
  Begin
    If AMsg Then
      pMensagemOk('Cupom de desconto foi gerado para outro cliente!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidarCupomExiste(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If Not GetCupomExiste(ACupom) Then
  Begin
    If AMsg Then
      pMensagemOk('Não existe um cupom de desconto com este código!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidarCupomInativado(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If GetCupomInativado(ACupom) Then
  Begin
    If AMsg Then
      pMensagemOk('Cupom de desconto foi inativado!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidarCupomIniciouValidade(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If Not GetCupomIniciouValidade(ACupom) Then
  Begin
    If AMsg Then
      pMensagemOk('Cupom de desconto ainda não está dentro do período '+
        'válido para utilização!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidarCupomJaExpirou(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If GetCupomJaExpirou(ACupom) Then
  Begin
    If AMsg Then
      pMensagemOk('Cupom de desconto já expirou!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidarCupomJaUtilizado(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If GetCupomJaUtilizado(ACupom) And
    (Not GetDocumentoUtilizado(ACupom).Equals(FObjVenda.strNumOrc +
    FObjVenda.strEspOrc + FObjVenda.strEmpOri)) Then
  Begin
    If AMsg Then
      pMensagemOk('Cupom de desconto já foi utilizado!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidarValorMinimoVenda(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  Result := True;
  If (GetValorMinimoUtilizarCupom(ACupom) > 0) And
    (GetValorMinimoUtilizarCupom(ACupom) > FObjVenda.fltTotPro) Then
  Begin
    If AMsg Then
      pMensagemOk('Valor mínimo para utilizar este cupom é de ' +
        FormatFloat(fMskDigitos(2), GetValorMinimoUtilizarCupom(ACupom)) + '!');
    Exit(False);
  End;
end;

function TFatCupomDesconto.ValidaSituacaoCupom(ACupom: String;
  AMsg: Boolean): Boolean;
begin
  If Not ValidarCupomIniciouValidade(ACupom, AMsg) Then
    Exit(False);

  If Not ValidarClienteCupom(ACupom, AMsg) Then
    Exit(False);

  If Not ValidarValorMinimoVenda(ACupom, AMsg) Then
    Exit(False);

  Result := True;
end;

class function TFatCupomDesconto.GetDescontoCupom(ACupom: String): Double;
begin
  Result := fCampoTabela('MCU_TOTCUP', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]);
end;

function TFatCupomDesconto.GetDocumentoUtilizado(ACupom: String): String;
begin
  Result := fCampoTabela('CONCAT(MCU_NUMPED,MCU_ESPPED,MCU_EMPPED)', 'MOVCUP',
    ['MCU_NUMCUP'], [ACupom]);
end;

class function TFatCupomDesconto.GetInformacoesCupom(ACupom: String): String;
begin
  Result := fCampoTabela('MCU_RESCAL', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]);
end;

class function TFatCupomDesconto.GetNumeroCupom(ADoc, AEsp,
  AEmp: String): String;
begin
  Result := fCampoTabela('MCU_NUMCUP', 'MOVCUP', ['MCU_NUMDOC', 'MCU_ESPDOC',
    'MCU_CODEMP'], [ADoc, AEsp, AEmp]);
end;

function TFatCupomDesconto.GetValorMinimoUtilizarCupom(ACupom: String): Double;
begin
  Result := fCampoTabela('MCU_MINVEN', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]);
end;

function TFatCupomDesconto.GetClienteDoCupom(ACupom: String): String;
begin
  Result := fCampoTabela('MCU_CODCLI', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]);
end;

function TFatCupomDesconto.GerarNumeroCupom: String;
begin
  Repeat
    Result := '';
    Result := Result + { 01 } RandomLetra;
    Result := Result + { 02 } RandomNumero;
    Result := Result + { 03 } RandomLetra;
    Result := Result + { 04 } RandomNumero;
    Result := Result + { 05 } RandomLetra;
    Result := Result + { 06 } RandomNumero;
    Result := Result + { 07 } RandomLetra;
    Result := Result + { 08 } RandomNumero;
    Result := Result + { 09 } RandomLetra;
    Result := Result + { 10 } RandomLetra;
  Until Not GetCupomExiste(Result);
  FCupomGerado := Result;
end;

function TFatCupomDesconto.GerarCupomPercentualDesconto: Boolean;
Var
  LValorCupom: Double;
  LResumoCalculo: String;
begin
  LValorCupom := fFormataFloat(GetTotalProdutos * FQryCadCup.FieldByName
    ('CUP_PERDES').AsFloat / 100, 2);

  If LValorCupom <= 0 Then
    Exit(False);

  LResumoCalculo := 'Cupom de desconto de ' + FormatFloat(fMskDigitos(2),
    FQryCadCup.FieldByName('CUP_PERDES').AsFloat) +
    '% sobre o total dos produtos R$ ' + FormatFloat(fMskDigitos(2),
    GetTotalProdutos) + ' totalizando R$ ' + FormatFloat(fMskDigitos(2),
    LValorCupom) +
    ' de desconto que poderá ser utilizado em uma próxima compra.' +
    InformacoesCupom;

  InserirCupomDesconto(LValorCupom, LResumoCalculo);

  Result := True;
end;

procedure TFatCupomDesconto.GerarCupomPercentualDescontoItens;
Var
  LValorCupom: Double;
  LResumoCalculo: String;
begin
  LValorCupom := fFormataFloat(GetTotalProdutosCupom() * FQryCadCup.FieldByName
    ('CUP_VLITPE').AsFloat / 100, 2);

  If LValorCupom <= 0 Then
    Exit;

  LResumoCalculo := 'Cupom de desconto de ' + FormatFloat(fMskDigitos(2),
    FQryCadCup.FieldByName('CUP_VLITPE').AsFloat) +
    '% sobre o total dos produtos R$ ' + FormatFloat(fMskDigitos(2),
    GetTotalProdutosCupom()) + ' totalizando R$ ' + FormatFloat(fMskDigitos(2),
    LValorCupom) +
    ' de desconto que poderá ser utilizado em uma próxima compra.' +
    InformacoesCupom;

  InserirCupomDesconto(LValorCupom, LResumoCalculo);
end;

function TFatCupomDesconto.GerarCupomValorComprasAcumulado: Boolean;
Var
  LValorCupom: Double;
  LResumoCalculo: String;
  LFator: Integer;
begin
  LFator := Floor(GetTotalProdutos / FQryCadCup.FieldByName
    ('CUP_VALCOM').AsFloat);
  LValorCupom := fFormataFloat(LFator * FQryCadCup.FieldByName('CUP_VALACU')
    .AsFloat, 2);

  If LValorCupom <= 0 Then
    Exit(False);

  LResumoCalculo := 'Cupom de desconto de R$ ' + FormatFloat(fMskDigitos(2),
    FQryCadCup.FieldByName('CUP_VALACU').AsFloat) + ' a cada R$ ' +
    FormatFloat(fMskDigitos(2), FQryCadCup.FieldByName('CUP_VALCOM').AsFloat) +
    ' em compras totalizando R$ ' + FormatFloat(fMskDigitos(2), LValorCupom) +
    ' de desconto que poderá ser utilizado em uma próxima compra.' +
    InformacoesCupom;

  InserirCupomDesconto(LValorCupom, LResumoCalculo);

  Result := True;
end;

function TFatCupomDesconto.GerarCupomValorFixo: Boolean;
Var
  LValorCupom: Double;
  LResumoCalculo: String;
begin
  LValorCupom := FQryCadCup.FieldByName('CUP_VALFIX').AsFloat;

  If LValorCupom <= 0 Then
    Exit(False);

  LResumoCalculo := 'Cupom de desconto no valor de R$ ' +
    FormatFloat(fMskDigitos(2), LValorCupom) +
    ' que poderá ser utilizado em uma próxima compra.' + InformacoesCupom;

  InserirCupomDesconto(LValorCupom, LResumoCalculo);

  Result := True;
end;

procedure TFatCupomDesconto.GerarCupomValorFixoItens;
Var
  LValorCupom: Double;
  LResumoCalculo: String;
begin
  if GetTotalProdutosCupom() <= 0 then
    Exit;

  LValorCupom := FQryCadCup.FieldByName('CUP_VLITFI').AsFloat;

  If LValorCupom <= 0 Then
    Exit;

  LResumoCalculo := 'Cupom de desconto no valor de R$ ' +
    FormatFloat(fMskDigitos(2), LValorCupom) +
    ' que poderá ser utilizado em uma próxima compra.' + InformacoesCupom;

  InserirCupomDesconto(LValorCupom, LResumoCalculo);
end;

class procedure TFatCupomDesconto.InativarCuponsGerados(ADoc, AEsp,
  AEmp: String);
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Try
    LQuery.SQL.Text := 'SELECT * FROM MOVCUP WHERE MCU_NUMDOC = :NUMDOC ' +
      'AND MCU_ESPDOC = :ESPDOC AND MCU_CODEMP = :EMPDOC ';
    LQuery.ParamByName('NUMDOC').AsString := ADoc;
    LQuery.ParamByName('ESPDOC').AsString := AEsp;
    LQuery.ParamByName('EMPDOC').AsString := AEmp;
    LQuery.Open;

    While Not LQuery.Eof Do
    Begin
      LQuery.Edit;
      LQuery.FieldByName('MCU_STATUS').AsString := 'I';
      LQuery.Post;
      LQuery.Next;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TFatCupomDesconto.InformacoesCupom: String;
begin
  Result := '';

  If FQryCadCup.FieldByName('CUP_MINVEN').AsFloat > 0 Then
    Result := Result +
      ' Este cupom poderá ser utilizado em uma próxima compra a partir de R$ ' +
      FormatFloat(fMskDigitos(2), FQryCadCup.FieldByName('CUP_MINVEN')
      .AsFloat) + '.';

  If FQryCadCup.FieldByName('CUP_DIAEXP').AsInteger > 0 Then
    Result := Result + ' Data limite para utilização deste cupom ' +
      DateToStr(VS_Date + FQryCadCup.FieldByName('CUP_DIAEXP').AsInteger) + '.';

  If Not FQryCadCup.FieldByName('CUP_INIVAL').IsNull Then
    Result := Result + ' Este cupom somente poderá ser utilizado entre ' +
      FQryCadCup.FieldByName('CUP_INIVAL').AsString + ' e ' +
        FQryCadCup.FieldByName('CUP_FINVAL').AsString + '.';
end;

procedure TFatCupomDesconto.InserirCupomDesconto(AValorCupom: Double;
  AResumoCalculo: String);
Var
  LQuery: TUniQuery;
  LCodCup: String;
begin
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Text := 'SELECT * FROM MOVCUP WHERE FALSE';
    LQuery.Open;
    LQuery.Append;

    LQuery.FieldByName('AUTOINCREM').AsString :=
      fRetAutoIncrem('MOVCUP', VS_strCodEmp);

    LQuery.FieldByName('MCU_NUMCUP').AsString := GerarNumeroCupom;

    LQuery.FieldByName('MCU_SEQGER').AsString :=
      fRetornaInformacaoVenda(FObjVenda.strNumDoc, FObjVenda.strEspDoc,
      FObjVenda.strEmpDoc, 'AUTOINCREM');

    LQuery.FieldByName('MCU_DTAVEN').AsDateTime := VS_Date;
    LQuery.FieldByName('MCU_TOTVEN').AsFloat := GetTotalProdutos;
    LQuery.FieldByName('MCU_CODCLI').AsString := FObjVenda.strCodCli;
    LQuery.FieldByName('MCU_NUMDOC').AsString := FObjVenda.strNumDoc;
    LQuery.FieldByName('MCU_ESPDOC').AsString := FObjVenda.strEspDoc;
    LQuery.FieldByName('MCU_CODEMP').AsString := FObjVenda.strEmpDoc;

    LQuery.FieldByName('MCU_CODCUP').AsString :=
      FQryCadCup.FieldByName('CUP_CODCUP').AsString;

    LQuery.FieldByName('MCU_MINVEN').AsString :=
      FQryCadCup.FieldByName('CUP_MINVEN').AsString;

    LQuery.FieldByName('MCU_STATUS').AsString := 'A';
    LQuery.FieldByName('MCU_RESCAL').AsString := AResumoCalculo;
    LQuery.FieldByName('MCU_TOTCUP').AsFloat := AValorCupom;

    If Not FQryCadCup.FieldByName('CUP_INIVAL').IsNull Then
    Begin
      LQuery.FieldByName('MCU_INIVAL').AsDateTime :=
        FQryCadCup.FieldByName('CUP_INIVAL').AsDateTime;

      LQuery.FieldByName('MCU_DTAVAL').AsDateTime :=
        FQryCadCup.FieldByName('CUP_FINVAL').AsDateTime;
    End
    Else If FQryCadCup.FieldByName('CUP_DIAEXP').AsInteger <= 0 Then
      LQuery.FieldByName('MCU_DTAVAL').AsDateTime := StrToDateTime('31/12/9999')
    Else
      LQuery.FieldByName('MCU_DTAVAL').AsDateTime := VS_Date +
        FQryCadCup.FieldByName('CUP_DIAEXP').AsInteger;

    LQuery.Post;

    LCodCup := FQryCadCup.FieldByName('CUP_CODCUP').AsString;
    ExecOpcCfgImpCpd(LCodCup);
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TFatCupomDesconto.MarcarCupomUtilizado(ACupom, ADoc, AEsp,
  AEmp: String);
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Try
    LQuery.SQL.Text := 'SELECT * FROM MOVCUP WHERE MCU_NUMCUP = :NUMCUP';
    LQuery.ParamByName('NUMCUP').AsString := ACupom;
    LQuery.Open;

    If LQuery.IsEmpty Then
      Exit;

    If Not LQuery.FieldByName('MCU_NUMPED').AsString.IsEmpty Then
      Exit;

    LQuery.Edit;
    LQuery.FieldByName('MCU_DTAUTI').AsDateTime := VS_Date;
    LQuery.FieldByName('MCU_NUMPED').AsString := ADoc;
    LQuery.FieldByName('MCU_ESPPED').AsString := AEsp;
    LQuery.FieldByName('MCU_EMPPED').AsString := AEmp;
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TFatCupomDesconto.ImprimirCupomProxDesc(ACodCup: String);
var
  LImpressao: TEditorFastImpressao;
  LQryCfgRel: TUniQuery;
begin
  LImpressao := TEditorFastImpressao.Create(nil);
  LQryCfgRel := fCriaQuery(Nil);

  Try
    pCarregaConfImpr(LQryCfgRel, 'frmFatVendas_CupProxDesc');
    fPreImpressao(LQryCfgRel, LImpressao.recDocume.strNomImp,
                  LImpressao.recDocume.strTipImp, False, '');

    LImpressao.recDocume.strNumDoc   := FObjVenda.strNumDoc;
    LImpressao.recDocume.strEspDoc   := FObjVenda.strEspDoc;
    LImpressao.recDocume.strCodEmp   := FObjVenda.strEmpDoc;
    LImpressao.recDocume.strCodCli   := FObjVenda.strCodCli;
    LImpressao.recDocume.strNumCup   := ACodCup;
    LImpressao.tpeTipoEtiqueta       := tpeCupomProxDesc;
    LImpressao.fImprimeDocumento;
  Finally
    FreeAndNil(LImpressao);
    FreeAndNil(LQryCfgRel);
  End;
end;

class procedure TFatCupomDesconto.DesmarcarCupomUtilizado(ADoc, AEsp,
  AEmp: String);
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Try
    LQuery.SQL.Text := 'SELECT * FROM MOVCUP WHERE MCU_NUMPED = :NUMPED ' +
      'AND MCU_ESPPED = :ESPPED AND MCU_EMPPED = :EMPPED';
    LQuery.ParamByName('NUMPED').AsString := ADoc;
    LQuery.ParamByName('ESPPED').AsString := AEsp;
    LQuery.ParamByName('EMPPED').AsString := AEmp;
    LQuery.Open;

    If LQuery.IsEmpty Then
      Exit;

    LQuery.Edit;
    LQuery.FieldByName('MCU_DTAUTI').Value := Null;
    LQuery.FieldByName('MCU_NUMPED').Value := Null;
    LQuery.FieldByName('MCU_ESPPED').Value := Null;
    LQuery.FieldByName('MCU_EMPPED').Value := Null;
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TFatCupomDesconto.GerarCupomDesconto;
begin
  If fCfgSis('CUPDES') <> 'S' Then
    Exit;

  If FObjVenda.strClaFis < '5000' Then
    Exit;

  If Pos(FObjVenda.strClaFis, VS_strClaVen) <= 0 Then
    Exit;

  If Not fEmptyStr(FObjVenda.strCupDes) Then
    Exit;

  If Pos(FObjVenda.strEspDoc, 'NF_EL_IF_FF_MI_') <= 0 Then
    Exit;

  If Pos(FObjVenda.strOpcDoc, 'VN_CP_') <= 0 Then
    Exit;

  If fClienteConsumidor(fRetNomCliente(FObjVenda.strCodCli), True, True) Then
    Exit;

  If Length(GetCuponsUtilizadoItens) > 0 Then
    Exit;

  CarregarCadastroCupomDesconto;
  ProcessarCadastroCupomDesconto;
end;

procedure TFatCupomDesconto.GerarCupomItens(ATipoCupom: string);
begin
  If ATipoCupom = 'VI' Then
    GerarCupomValorFixoItens()
  Else
  If ATipoCupom = 'PI' Then
    GerarCupomPercentualDescontoItens();
end;

function TFatCupomDesconto.GetTotalProdutos: Double;
begin
  Result := FObjVenda.fltTotPro - FObjVenda.fltDesEsp;
end;

function TFatCupomDesconto.GetTotalProdutosCupom: Double;
var
  qryItensCupom: TUniQuery;
  intIndice: integer;
begin
  qryItensCupom := fCriaQuery;

  try
    Result := 0;

    qryItensCupom.Close;
    qryItensCupom.SQL.Clear;
    qryItensCupom.SQL.Add('SELECT CUP_CODITE');
    qryItensCupom.SQL.Add('FROM ITECUP');
    qryItensCupom.SQL.Add('WHERE CUP_SEQCUP = :SEQCUP');

    qryItensCupom.ParamByName('SEQCUP').AsString := FQryCadCup.FieldByName('AUTOINCREM').AsString;

    qryItensCupom.Open;

    if qryItensCupom.IsEmpty then
      Exit;

    for intIndice := Low(FObjVenda.arrMatItens) to High(FObjVenda.arrMatItens) do
    begin
      if qryItensCupom.Locate('CUP_CODITE', FObjVenda.arrMatItens[intIndice].strCodIte, []) then
      begin
        Result := Result + FObjVenda.arrMatItens[intIndice].fltTotIte;
      end;
    end;

  finally
    FreeAndNil(qryItensCupom);
  end;
end;

class function TFatCupomDesconto.fRetornaValorCupomDescCliente(strCodCli: String): Double;
var
  qryMovCup: TUniQuery;
begin
  Result := 0;
  qryMovCup := fCriaQuery(nil);
  try
    qryMovCup.Close;
    qryMovCup.SQL.Clear;

    qryMovCup.SQL.Text :=
      ' SELECT                                    '+
      '   SUM(MCU_TOTCUP) AS MCU_TOTCUP           '+
      ' FROM                                      '+
      '   MOVCUP                                  '+
      ' WHERE MCU_DTAUTI IS NULL                  '+
      '   AND MCU_NUMPED IS NULL                  '+
      '   AND MCU_ESPPED IS NULL                  '+
      '   AND (                                   '+
      '     (                                     '+
      '       :MCU_DTATUAL BETWEEN MCU_INIVAL     '+
      '       AND MCU_DTAVAL                      '+
      '     )                                     '+
      '     OR (                                  '+
      '       MCU_INIVAL IS NULL                  '+
      '       AND MCU_DTAVAL >= :MCU_DTATUAL      '+
      '     )                                     '+
      '   )                                       '+
      '   AND MCU_CODCLI = :MCU_CODCLI            ';

    qryMovCup.ParamByName('MCU_DTATUAL').AsDate := VS_date;
    qryMovCup.ParamByName('MCU_CODCLI' ).AsString := strCodCli;
    qryMovCup.Open;

    if not qryMovCup.IsEmpty then
      Result := qryMovCup.FieldByName('MCU_TOTCUP').AsFloat;
  finally
    FreeAndNil(qryMovCup);
  end;
end;

end.
