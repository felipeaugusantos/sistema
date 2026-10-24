unit Cashback.Controle;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  System.Classes, System.SysUtils, System.StrUtils, System.DateUtils, Uni,
  Data.DB, System.Generics.Collections, Cashback.Classes, Cashback.Calculo,
  Cashback.Controle.Utilizacao, untTypesSistema;

type
  TControleCashback = class sealed
  private
    FblnOcorreuErro                : Boolean;
    FstrNumDoc,
    FstrEspDoc,
    FstrCodEmp,
    FstrCodCli,
    FstrCodCnd,
    FstrCodVen,
    FstrCodOpe,
    FstrOrigem,
    FstrFonCli,
    FstrCgcCpf,
    FstrCpfCli                     : String;
    FfltQtdEmb                     : Double;
    FblnDispararMensagens          : Boolean;
    FobjControleUtilizacaoCashback : TControleUtilizacaoCashback;
    FcdsItens                      : TUniClientDataSet;
    FblnUtilizouCashback           : Boolean;

    procedure SetCodEmp(const Value: String);
    procedure SetEspDoc(const Value: String);
    procedure SetNumDoc(const Value: String);
    procedure SetCodCli(const Value: String);
    procedure SetCodCnd(const Value: String);
    procedure SetCodVen(const Value: String);
    procedure SetCodOpe(const Value: String);
    procedure SetOrigem(const Value: String);
    procedure SetCgcCpf(const Value: String);
    procedure SetCpfCli(const Value: String);
    procedure SetFonCli(const Value: String);
    procedure SetQtdEmb(const Value: Double);
    procedure SetcdsItens(const Value: TUniClientDataSet);
    procedure SetUtilizouCashback(const Value: Boolean);

  private
    function fPermiteUtilizarCashback(const strEspDoc: String): Boolean;
    function fPermiteGerarCashback: Boolean;

    function fGerarNumeroCashback: String;
    procedure pGravarCashback(const lstVendaCashback: TList<TVendaCashback>);
    procedure pGravarCashbackMovAux(const objVendaCashback: TVendaCashback);
    procedure pGravarUtilizacaoCashback(const lstUtilizacaoCashback: TList<TUtilizacaoCashback>);

    function fAjustarSaldoCashbackGerado: Boolean;
    function fValorSimulacaoGeracaoCashback: Double;

    function fEhClienteFilial: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    class function fPermiteUtilizarRotinaCashback: Boolean;
    class function fExisteCashbackGerado(const strCodCsh: String): Boolean;
    class function fExisteCashbackValidoNaVENCSH(const strCodCsh: String): Boolean;

    procedure pLimparObjeto;

    function fGerarCashback: Boolean;
    function fUtilizarCashback: Boolean;
    function fRemoveUtilizacaoCashbackVenda: Boolean;
    function fDevolucaoCashbackGerado: Boolean;
    function fCancelaCashbackGeradoDocumento: Boolean;
    function fCancelaCashbackGeradoDevolucaoEmbalagem(
      const AAutInc: String): Boolean;

    function fRetornaValorSimulacaoCashback: Double;
    procedure pExecutarMensagemSimulacaoCashback;
    function fPossuiSaldoCashbackCliente(const dtaDtaVen: TDateTime;
      out strMensagem: String): Boolean;

    function fExisteCashbackUtilizadoDaVenda(const strNumVnd, strEspVnd,
      strEmpVnd: String; out strDocUti: String): Boolean;
    function fValorDescontoCashbackDocumento: Double;
    function fCashbackDisponivelCliente(const dtaDtaVen: TDateTime;
      out strMensagem: String): Double;

    function fPermiteDispararEmailSmsWhatsapp: Boolean;
    procedure pDispararEmailWhatsappCashback;

    function ExisteCashbackDevolucaoEmbalagemVigente: Boolean;
    function ExisteRegraCashBackDevolucaoEmbalagemVigenteParaCliente: Boolean;
    function ValorUnitarioRegraCashBackDevolucaoEmbalagemVigenteParaCliente: Double;
    function fRetornaSaldoCashbackDevolucaoEmbalagemCliente: Double;

    property strNumDoc            : String                                       write SetNumDoc;
    property strEspDoc            : String                                       write SetEspDoc;
    property strCodEmp            : String                                       write SetCodEmp;
    property strCodCli            : String                                       write SetCodCli;
    property strCodCnd            : String                                       write SetCodCnd;
    property strCodVen            : String                                       write SetCodVen;
    property strCodOpe            : String                                       write SetCodOpe;
    property strOrigem            : String                                       write SetOrigem;
    property strFonCli            : String                                       write SetFonCli;
    property strCpfCli            : String                                       write SetCpfCli;
    property strCgcCpf            : String                                       write SetCgcCpf;
    property fltQtdEmb            : Double                                       write SetQtdEmb;

    property blnOcorreuErro       : Boolean           read FblnOcorreuErro;
    property blnDispararMensagens : Boolean           read FblnDispararMensagens;
    property cdsItens             : TUniClientDataSet                            write SetcdsItens;
    property blnUtilizouCashback  : Boolean                                      write SetUtilizouCashback;
  end;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesSimples, untFuncoes, untDisparaEmailAut, untDisparaSMSAut,
{$ENDIF}
  Shared.Functions.Funcoes.Faturamento, System.Variants;

{ TControleCashback }

constructor TControleCashback.Create;
begin
  FcdsItens := TUniClientDataSet.Create(Nil);
  FObjControleUtilizacaoCashback := TControleUtilizacaoCashback.Create;

  pLimparObjeto;
end;

destructor TControleCashback.Destroy;
begin
  FreeAndNil(FObjControleUtilizacaoCashback);
  FreeAndNil(FcdsItens);

  inherited;
end;

function TControleCashback.ExisteCashbackDevolucaoEmbalagemVigente: Boolean;
var
  LqryConsulta: TUniQuery;
begin
  LqryConsulta := fCriaQuery;
  Try
    LqryConsulta.Close;
    LqryConsulta.SQL.Text := 'SELECT '
                           + '       B.AUTOINCREM '
                           + '  FROM CADCSH B '
                           + ' WHERE CURRENT_DATE BETWEEN B.CSH_INIVIG AND B.CSH_FINVIG '
                           + '   AND B.CSH_TIPCSH = "DE" '
                           + ' ORDER BY '
                           + '       B.CSH_INIVIG ';
    LqryConsulta.Open;

    Result := (Not LqryConsulta.IsEmpty);

    If Not Result Then
    Begin
      pMensagemOk('Não existe regra vigente de cashback cadastrada ' +
                  'para esta rotina. Verifique!');
    End;
  Finally
    FreeAndNil(LqryConsulta);
  End;
end;

function TControleCashback.ExisteRegraCashBackDevolucaoEmbalagemVigenteParaCliente: Boolean;
begin
  Result := (ValorUnitarioRegraCashBackDevolucaoEmbalagemVigenteParaCliente > 0);
end;

function TControleCashback.fAjustarSaldoCashbackGerado: Boolean;
begin
  FobjControleUtilizacaoCashback.pLimparObjeto;
  FobjControleUtilizacaoCashback.strNumDoc := FstrNumDoc;
  FobjControleUtilizacaoCashback.strEspDoc := FstrEspDoc;
  FobjControleUtilizacaoCashback.strCodEmp := FstrCodEmp;
  FobjControleUtilizacaoCashback.strCodCli := FstrCodCli;
  FobjControleUtilizacaoCashback.strOrigem := FstrOrigem;

  If FobjControleUtilizacaoCashback.fCalcularSaldoCashbackDevolver Then
    pGravarUtilizacaoCashback(FobjControleUtilizacaoCashback.ListaCashbackUtilizados);

  Result := True;
end;

function TControleCashback.fCancelaCashbackGeradoDevolucaoEmbalagem(
  const AAutInc: String): Boolean;
var
  qryAtualizar : TUniQuery;
begin
  If (Not fPermiteUtilizarRotinaCashback) Then
    Exit(True);

  If (fEmptyStr(AAutInc)) Then
    Exit(False);

  qryAtualizar := fCriaQuery;
  Try
    qryAtualizar.Close;
    qryAtualizar.SQL.Text := 'UPDATE VENCSH '
                           + '   SET VCB_STATUS = "I" '
                           + ' WHERE AUTOINCREM = :AUTINC '
                           + '   AND VCB_ORIGEM = "E" ';
    qryAtualizar.ParamByName('AUTINC').AsString := AAutInc;
    qryAtualizar.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryAtualizar);
  End;
end;

function TControleCashback.fCancelaCashbackGeradoDocumento: Boolean;
var
  qryAtualizar : TUniQuery;
begin
  If (Not fPermiteUtilizarRotinaCashback) Or
     (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_GERACAO_CASHBACK)) Then
    Exit(True);

  If (fEmptyStr(FstrNumDoc)) Or
     (fEmptyStr(FstrCodEmp)) Then
    Exit(False);

  qryAtualizar := fCriaQuery;
  Try
    qryAtualizar.Close;
    qryAtualizar.SQL.Text := 'UPDATE VENCSH '
                           + '   SET VCB_STATUS = "I" '
                           + ' WHERE VCB_NUMDOC = :NUMDOC '
                           + '   AND VCB_ESPDOC = :ESPDOC '
                           + '   AND VCB_CODEMP = :CODEMP ';

    qryAtualizar.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryAtualizar.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryAtualizar.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryAtualizar.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryAtualizar);
  End;
end;

function TControleCashback.fCashbackDisponivelCliente(
  const dtaDtaVen: TDateTime; out strMensagem: String): Double;
begin
  If fEhClienteFilial Then
    Exit(0);

  FobjControleUtilizacaoCashback.pLimparObjeto;
  FobjControleUtilizacaoCashback.strNumDoc := FstrNumDoc;
  FobjControleUtilizacaoCashback.strEspDoc := FstrEspDoc;
  FobjControleUtilizacaoCashback.strCodEmp := FstrCodEmp;
  FobjControleUtilizacaoCashback.strCodCli := FstrCodCli;
  FobjControleUtilizacaoCashback.strOrigem := FstrOrigem;
  FobjControleUtilizacaoCashback.strFonCli := FstrFonCli;
  FobjControleUtilizacaoCashback.strCpfCli := FstrCpfCli;

  Result := FobjControleUtilizacaoCashback.fCashbackDisponivelCliente(
              dtaDtaVen,
              FCdsItens,
              strMensagem);
end;

function TControleCashback.fDevolucaoCashbackGerado: Boolean;
begin
  If (Not fPermiteUtilizarRotinaCashback) Or
     (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_DEV_CASHBACK_GERADO)) Or
     (fEmptyStr(FstrNumDoc)) Or
     (fEmptyStr(FstrCodEmp)) Then
    Exit(True);

  Result := fAjustarSaldoCashbackGerado;
end;

function TControleCashback.fEhClienteFilial: Boolean;
var
  LqryConsulta: TUniQuery;
begin
  LqryConsulta := fCriaQuery;
  Try
    LqryConsulta.Close;
    LqryConsulta.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP '
                           + ' WHERE EMP_CLIFIL = :CODCLI ';
    LqryConsulta.ParamByName('CODCLI').AsString := FstrCodCli;
    LqryConsulta.Open;

    Result := (Not LqryConsulta.IsEmpty);
  Finally
    FreeAndNil(LqryConsulta);
  End;
end;

class function TControleCashback.fExisteCashbackGerado(
  const strCodCsh: String): Boolean;
var
  qryDados : TUniQuery;
begin
  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT AUTOINCREM '
                       + '  FROM VENCSH '
                       + ' WHERE VCB_CODCSH = :CODCSH ';

    qryDados.ParamByName('CODCSH').AsString := strCodCsh;
    qryDados.Open;

    Result := qryDados.RecordCount > 0;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TControleCashback.fExisteCashbackUtilizadoDaVenda(const strNumVnd,
  strEspVnd, strEmpVnd: String; out strDocUti: String): Boolean;
var
  qryDados : TUniQuery;
begin
  If (Not fPermiteUtilizarRotinaCashback) Or
     (Not MatchStr(strEspVnd, ARR_DOCUMENTOS_GERACAO_CASHBACK)) Then
    Exit(False);

  qryDados := fCriaQuery;
  Try
    qryDados.Close;

    qryDados.SQL.Text := 'SELECT '
                       + '       U.UCB_NUMPED '
                       + '     , U.UCB_ESPPED '
                       + '  FROM VENCSH V '
                       + ' INNER JOIN UTICSH U ON U.UCB_NUMCSH = V.VCB_NUMCSH '
                       + ' WHERE V.VCB_NUMDOC = :NUMDOC '
                       + '   AND V.VCB_ESPDOC = :ESPDOC '
                       + '   AND V.VCB_CODEMP = :CODEMP '
                       + '   AND U.UCB_ESPPED <> "DV" ';

    qryDados.ParamByName('NUMDOC').AsString := strNumVnd;
    qryDados.ParamByName('ESPDOC').AsString := strEspVnd;
    qryDados.ParamByName('CODEMP').AsString := strEmpVnd;
    qryDados.Open;

    Result := qryDados.RecordCount > 0;

    If Not Result Then
      Exit;

    strDocUti := EmptyStr;
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      TFunctionFuncoesFaturamento
        .IncrementaListaStr(qryDados.FieldByName('UCB_NUMPED').AsString + '-' +
                            qryDados.FieldByName('UCB_ESPPED').AsString,
                            strDocUti);
      qryDados.Next;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

class function TControleCashback.fExisteCashbackValidoNaVENCSH(
  const strCodCsh: String): Boolean;
var
  qryDados : TUniQuery;
begin
  qryDados := nil;
  Try
    qryDados := fCriaQuery;
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT AUTOINCREM FROM VENCSH '
                       + ' WHERE VCB_CODCSH = :CODCSH '
                       + '   AND VCB_STATUS = "A" '
                       + '   AND IFNULL(VCB_VLRDSP, 0) > 0 '
                       + '   AND CURRENT_DATE BETWEEN IFNULL(VCB_INIVAL, VCB_DTAENT) AND VCB_DTAVAL ';

    qryDados.ParamByName('CODCSH').AsString := strCodCsh;
    qryDados.Open;

    Result := qryDados.RecordCount > 0;

    If Result Then
    Begin
      pMensagemOk('Não é possível remover este registro, pois existem clientes '
                 +'com saldos disponíveis deste cashback dentro do prazo de '
                 +'validade de uso e que podem gerar descontos em vendas.');
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TControleCashback.fGerarCashback: Boolean;
var
  objProcessaRegraCalculo: TProcesssaRegraCashback;
begin
  FblnDispararMensagens := False;

  If Not fPermiteGerarCashback Then
    Exit(True);

  If fEhClienteFilial Then
    Exit(True);

  objProcessaRegraCalculo := TProcesssaRegraCashback.Create;
  Try
    Try
      objProcessaRegraCalculo.strNumDoc := FstrNumDoc;
      objProcessaRegraCalculo.strEspDoc := FstrEspDoc;
      objProcessaRegraCalculo.strCodEmp := FstrCodEmp;
      objProcessaRegraCalculo.strCodCli := FstrCodCli;
      objProcessaRegraCalculo.strCodCnd := FstrCodCnd;
      objProcessaRegraCalculo.strCodVen := FstrCodVen;
      objProcessaRegraCalculo.strCodOpe := FstrCodOpe;
      objProcessaRegraCalculo.strOrigem := FstrOrigem;
      objProcessaRegraCalculo.fltQtdEmb := FfltQtdEmb;
      objProcessaRegraCalculo.strFonCli := FstrFonCli;
      objProcessaRegraCalculo.strCgcCpf := FstrCgcCpf;
      objProcessaRegraCalculo.strCpfCli := FstrCpfCli;
      objProcessaRegraCalculo.pProcessarCashback;

      If objProcessaRegraCalculo.blnPermiteGravar Then
      Begin
        pGravarCashback(objProcessaRegraCalculo.lstVendaCashback);
        FblnDispararMensagens := True;
      End;

      FblnOcorreuErro := objProcessaRegraCalculo.blnOcorreuErro;

      If FblnOcorreuErro Then
        Exit(False);

      Result := True;
    Except
      Result                := False;
      FblnOcorreuErro       := True;
      FblnDispararMensagens := False;
      raise;
    End;
  Finally
    FreeAndNil(objProcessaRegraCalculo);
  End;
end;

function TControleCashback.fGerarNumeroCashback: String;
var
  intContador     : Integer;
  qryDados        : TUniQuery;
  blnNumeroValido : Boolean;
  intTentativas   : Integer;
const
  STR_CARACTERES = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  MAX_TENTATIVAS = 100;
begin
  Result := EmptyStr;

  If Not fPermiteGerarCashback Then
    Exit;

  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT AUTOINCREM '
                       + '  FROM VENCSH '
                       + ' WHERE VCB_NUMCSH = :NUMCSH ';

    blnNumeroValido := False;
    intTentativas   := 0;
    While Not blnNumeroValido Do
    Begin
      Inc(intTentativas);
      Result := EmptyStr;

      For intContador := 1 To 10 Do
      Begin
        Result := Result
                + STR_CARACTERES[Random(Length(STR_CARACTERES)) + 1];
      End;

      qryDados.Close;
      qryDados.ParamByName('NUMCSH').AsString := Result;
      qryDados.Open;

      blnNumeroValido := (qryDados.RecordCount = 0);

      If intTentativas > MAX_TENTATIVAS Then
      Begin
        raise Exception.Create(
          'Não foi possível gerar um número único para o cashback após '
          + IntToStr(MAX_TENTATIVAS) + ' tentativas. Contate a Citel.');
      End;
    end;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TControleCashback.pDispararEmailWhatsappCashback;
{$IFDEF LINUX}
begin
  raise Exception.Create('TControleCashback.pDispararEmailWhatsappCashback ainda não possui implementação linux');
end;
{$ELSE}
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;

  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT G.AUTOINCREM '
                       + '  FROM MOVGER G '
                       + ' INNER JOIN VENCSH V ON V.VCB_SEQGER = G.AUTOINCREM '
                       + ' WHERE G.GER_NUMDOC = :NUMDOC '
                       + '   AND G.GER_ESPDOC = :ESPDOC '
                       + '   AND G.GER_CODEMP = :CODEMP ';

    qryDados.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryDados.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryDados.Open;

    If Not qryDados.IsEmpty Then
    begin
      fDisparaWhatsappAutomatico(FstrNumDoc,
                                 'CH',
                                 FstrEspDoc,
                                 EmptyStr,
                                 EmptyStr,
                                 FstrCodEmp,
                                 FstrCodCli);

      fDisparaEmailAutomatico(FstrNumDoc,
                              'CH',
                              FstrEspDoc,
                              EmptyStr,
                              EmptyStr,
                              FstrCodEmp,
                              FstrCodCli);

      fDisparaSMSAutomatico(FstrNumDoc,
                              'CH',
                              FstrEspDoc,
                              EmptyStr,
                              EmptyStr,
                              FstrCodEmp,
                              FstrCodCli);
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;
{$ENDIF}

procedure TControleCashback.pExecutarMensagemSimulacaoCashback;
var
  fltValorSimulacao: Double;
begin

  If (FstrEspDoc <> 'PD') Or
     (Not fPermiteUtilizarRotinaCashback) Or
     (Not fCfgSis('EXBCSH', varBoolean)) Then
    Exit;

  fltValorSimulacao := fValorSimulacaoGeracaoCashback;
  If fltValorSimulacao > 0 Then
  Begin
    pMensagemOk('Este Pedido poderá gerar um Cashback de R$ ' +
                FormatFloat(',0.00', fltValorSimulacao) + '!');
  End;
end;

procedure TControleCashback.pGravarCashback(
  const lstVendaCashback: TList<TVendaCashback>);
var
  qryGravar,
  qryDadosConsumidor: TUniQuery;
  objVendaCashback  : TVendaCashback;

  procedure pCarregaDadosConsumidorVenda;
  begin
    qryDadosConsumidor.Close;
    qryDadosConsumidor.SQL.Text := 'SELECT '
                                 + '       GER_TELCON '
                                 + '     , GER_CGCCPF '
                                 + '     , GER_CGCCON '
                                 + '  FROM MOVGER '
                                 + ' WHERE GER_NUMDOC = :NUMDOC '
                                 + '   AND GER_ESPDOC = :ESPDOC '
                                 + '   AND GER_CODEMP = :CODEMP ';
    qryDadosConsumidor.ParamByName('NUMDOC').AsString := objVendaCashback.strNumDoc;
    qryDadosConsumidor.ParamByName('ESPDOC').AsString := objVendaCashback.strEspDoc;
    qryDadosConsumidor.ParamByName('CODEMP').AsString := objVendaCashback.strCodEmp;
    qryDadosConsumidor.Open;

    If qryDadosConsumidor.IsEmpty Then
      Exit;

    objVendaCashback.strTelCon := qryDadosConsumidor.FieldByName('GER_TELCON').AsString;
    objVendaCashback.strCgcCpf := qryDadosConsumidor.FieldByName('GER_CGCCPF').AsString;
    objVendaCashback.strCgcCon := qryDadosConsumidor.FieldByName('GER_CGCCON').AsString;
  end;
begin
  qryGravar          := nil;
  qryDadosConsumidor := nil;
  Try
    qryGravar          := fCriaQuery;
    qryDadosConsumidor := fCriaQuery;

    qryGravar.SQL.Text := 'INSERT INTO VENCSH( '
                        + '       AUTOINCREM '
                        + '     , VCB_NUMCSH '
                        + '     , VCB_SEQGER '
                        + '     , VCB_DTAENT '
                        + '     , VCB_CODCLI '
                        + '     , VCB_NUMDOC '
                        + '     , VCB_ESPDOC '
                        + '     , VCB_CODEMP '
                        + '     , VCB_CODCSH '
                        + '     , VCB_RESCAL '
                        + '     , VCB_INIVAL '
                        + '     , VCB_DTAVAL '
                        + '     , VCB_VLRDOC '
                        + '     , VCB_VLRCSH '
                        + '     , VCB_VLRDSP '
                        + '     , VCB_MINPRX '
                        + '     , VCB_PERMAX '
                        + '     , VCB_STATUS '
                        + '     , VCB_DIAUTI '
                        + '     , VCB_CODOPE '
                        + '     , VCB_ORIGEM '
                        + '     , VCB_TELCON '
                        + '     , VCB_CGCCPF '
                        + '     , VCB_CGCCON '
                        + '     , VCB_QTDEMB '
                        + ') VALUES ( '
                        + '       :AUTINC '
                        + '     , :NUMCSH '
                        + '     , :SEQGER '
                        + '     , :DTAENT '
                        + '     , :CODCLI '
                        + '     , :NUMDOC '
                        + '     , :ESPDOC '
                        + '     , :CODEMP '
                        + '     , :CODCSH '
                        + '     , :RESCAL '
                        + '     , :INIVAL '
                        + '     , :DTAVAL '
                        + '     , :VLRDOC '
                        + '     , :VLRCSH '
                        + '     , :VLRDSP '
                        + '     , :MINPRX '
                        + '     , :PERMAX '
                        + '     , :STATUS '
                        + '     , :DIAUTI '
                        + '     , :CODOPE '
                        + '     , :ORIGEM '
                        + '     , :TELCON '
                        + '     , :CGCCPF '
                        + '     , :CGCCON '
                        + '     , :QTDEMB '
                        + ') ';

    For objVendaCashback In lstVendaCashback Do
    Begin
      objVendaCashback.strAutInc := fRetAutoIncrem('VENCSH', VS_strCodEmp);
      objVendaCashback.strNumCsh := fGerarNumeroCashback;

      If (objVendaCashback.strOrigem = 'V') And
         (fClienteConsumidor(fRetNomCliente(objVendaCashback.strCodCli), True, True)) Then
        pCarregaDadosConsumidorVenda;

      qryGravar.Close;
      qryGravar.ParamByName('AUTINC').AsString   := objVendaCashback.strAutInc;
      qryGravar.ParamByName('CODCLI').AsString   := objVendaCashback.strCodCli;
      qryGravar.ParamByName('NUMCSH').AsString   := objVendaCashback.strNumCsh;
      qryGravar.ParamByName('DTAENT').AsDateTime := objVendaCashback.dtaDtaEnt;
      qryGravar.ParamByName('CODCSH').AsString   := objVendaCashback.strCodCsh;
      qryGravar.ParamByName('RESCAL').AsString   := objVendaCashback.strResCal;
      qryGravar.ParamByName('INIVAL').AsDateTime := objVendaCashback.dtaIniVal;
      qryGravar.ParamByName('DTAVAL').AsDateTime := objVendaCashback.dtaDtaVal;
      qryGravar.ParamByName('VLRDOC').AsFloat    := objVendaCashback.fltVlrDoc;
      qryGravar.ParamByName('VLRCSH').AsFloat    := objVendaCashback.fltVlrCsh;
      qryGravar.ParamByName('VLRDSP').AsFloat    := objVendaCashback.fltVlrDsp;
      qryGravar.ParamByName('MINPRX').AsFloat    := objVendaCashback.fltMinPrx;
      qryGravar.ParamByName('PERMAX').AsFloat    := objVendaCashback.fltPerMax;
      qryGravar.ParamByName('STATUS').AsString   := objVendaCashback.strStatus;
      qryGravar.ParamByName('DIAUTI').AsInteger  := objVendaCashback.intDiaUti;
      qryGravar.ParamByName('CODEMP').AsString   := objVendaCashback.strCodEmp;
      qryGravar.ParamByName('CODOPE').AsString   := objVendaCashback.strCodOpe;
      qryGravar.ParamByName('ORIGEM').AsString   := objVendaCashback.strOrigem;

      If objVendaCashback.strOrigem = 'V' Then
      Begin
        qryGravar.ParamByName('SEQGER').AsString := objVendaCashback.strSeqGer;
        qryGravar.ParamByName('NUMDOC').AsString := objVendaCashback.strNumDoc;
        qryGravar.ParamByName('ESPDOC').AsString := objVendaCashback.strEspDoc;

        qryGravar.ParamByName('QTDEMB').Clear;
      End
      Else
      Begin
        qryGravar.ParamByName('SEQGER').Clear;
        qryGravar.ParamByName('NUMDOC').Clear;
        qryGravar.ParamByName('ESPDOC').Clear;

        qryGravar.ParamByName('QTDEMB').AsFloat := objVendaCashback.fltQtdEmb;
      End;

      If fEmptyStr(objVendaCashback.strTelCon) Then
        qryGravar.ParamByName('TELCON').Clear
      Else
        qryGravar.ParamByName('TELCON').AsString := objVendaCashback.strTelCon;

      If fEmptyStr(objVendaCashback.strCgcCpf) Then
        qryGravar.ParamByName('CGCCPF').Clear
      Else
        qryGravar.ParamByName('CGCCPF').AsString := objVendaCashback.strCgcCpf;

      If fEmptyStr(objVendaCashback.strCgcCon) Then
        qryGravar.ParamByName('CGCCON').Clear
      Else
        qryGravar.ParamByName('CGCCON').AsString := objVendaCashback.strCgcCon;

      qryGravar.ExecSQL;

      pGravarCashbackMovAux(objVendaCashback);
    End;
  Finally
    FreeAndNil(qryGravar);
    FreeAndNil(qryDadosConsumidor);
  End;
end;

procedure TControleCashback.pGravarCashbackMovAux(const objVendaCashback: TVendaCashback);
var
  objItem   : TItemCashbackVenda;
  qryGravar : TUniQuery;
begin
  qryGravar := fCriaQuery;
  Try
    qryGravar.Close;
    qryGravar.SQL.Text := 'UPDATE MOVAUX '
                        + '   SET DET_DESCSH = :DESCSH '
                        + ' WHERE DET_SEQGER = :AUTINC ';

    For objItem in objVendaCashback.ListaItemCashbackVenda Do
    Begin
      qryGravar.Close;
      qryGravar.ParamByName('AUTINC').AsString := objItem.strIncDet;
      qryGravar.ParamByName('DESCSH').AsFloat  := objItem.fltDesCsh;
      qryGravar.ExecSQL;
    End;
  Finally
    FreeAndNil(qryGravar);
  End;
end;

procedure TControleCashback.pGravarUtilizacaoCashback(
  const lstUtilizacaoCashback: TList<TUtilizacaoCashback>);
var
  qryGravar     : TUniQuery;
  qryBaixaSaldo : TUniQuery;
  item          : TUtilizacaoCashback;
begin
  qryGravar     := fCriaQuery;
  qryBaixaSaldo := fCriaQuery;

  Try
    qryGravar.Close;
    qryGravar.SQL.Text := 'INSERT INTO UTICSH( '
                        + '       AUTOINCREM '
                        + '     , UCB_NUMCSH '
                        + '     , UCB_VLRUTI '
                        + '     , UCB_DTAUTI '
                        + '     , UCB_NUMPED '
                        + '     , UCB_ESPPED '
                        + '     , UCB_EMPPED '
                        + ') VALUES ( '
                        + '       :AUTINC '
                        + '     , :NUMCSH '
                        + '     , :VLRUTI '
                        + '     , :DTAUTI '
                        + '     , :NUMPED '
                        + '     , :ESPPED '
                        + '     , :EMPPED '
                        + ') ';

    qryBaixaSaldo.Close;
    qryBaixaSaldo.SQL.Text := 'UPDATE VENCSH V '
                            + '   SET VCB_VLRDSP = VCB_VLRDSP '
                            + '                  - :VLRUTI '
                            + ' WHERE V.VCB_NUMCSH = :NUMCSH ';

    For item In lstUtilizacaoCashback Do
    Begin
      item.strAutInc := fRetAutoIncrem('UTICSH', VS_strCodEmp);

      qryGravar.Close;
      qryGravar.ParamByName('AUTINC').AsString   := item.strAutInc;
      qryGravar.ParamByName('NUMCSH').AsString   := item.strNumCsh;
      qryGravar.ParamByName('VLRUTI').AsFloat    := item.fltVlrUti;
      qryGravar.ParamByName('DTAUTI').AsDateTime := item.dtaDtaUti;
      qryGravar.ParamByName('NUMPED').AsString   := item.strNumPed;
      qryGravar.ParamByName('ESPPED').AsString   := item.strEspPed;
      qryGravar.ParamByName('EMPPED').AsString   := item.strEmpPed;
      qryGravar.ExecSQL;

      qryBaixaSaldo.Close;
      qryBaixaSaldo.ParamByName('NUMCSH').AsString := item.strNumCsh;
      qryBaixaSaldo.ParamByName('VLRUTI').AsFloat  := item.fltVlrUti;
      qryBaixaSaldo.ExecSQL;
    End;
  Finally
    FreeAndNil(qryBaixaSaldo);
    FreeAndNil(qryGravar);
  End;
end;

procedure TControleCashback.pLimparObjeto;
begin
  FblnOcorreuErro       := False;
  FblnDispararMensagens := False;
  FblnUtilizouCashback  := False;
  FstrNumDoc            := EmptyStr;
  FstrEspDoc            := EmptyStr;
  FstrCodEmp            := EmptyStr;
  FstrCodCli            := EmptyStr;
  FstrCodCnd            := EmptyStr;
  FstrCodVen            := EmptyStr;
  FstrCodOpe            := EmptyStr;
  FstrOrigem            := EmptyStr;
  FstrFonCli            := EmptyStr;
  FstrCgcCpf            := EmptyStr;
  FstrCpfCli            := EmptyStr;
  FfltQtdEmb            := 0;

  If Assigned(FcdsItens) And
     (FcdsItens.Active) Then
    FcdsItens.EmptyDataSet;

  FobjControleUtilizacaoCashback.pLimparObjeto;
end;

function TControleCashback.fPermiteDispararEmailSmsWhatsapp: Boolean;
var
  qryDados : TUniQuery;
begin
  If (Not fPermiteUtilizarRotinaCashback) Or
     (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_GERACAO_CASHBACK)) Or
     (fEmptyStr(FstrNumDoc)) Or
     (fEmptyStr(FstrCodEmp)) Then
    Exit(False);

  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT G.AUTOINCREM '
                       + '  FROM MOVGER G '
                       + ' INNER JOIN VENCSH V ON G.AUTOINCREM = V.VCB_SEQGER '
                       + ' WHERE G.GER_NUMDOC = :NUMDOC '
                       + '   AND G.GER_ESPDOC = :ESPDOC '
                       + '   AND G.GER_CODEMP = :CODEMP '
                       + '   AND CAST(G.GER_CLAFIS AS UNSIGNED) >= 5000 ';

    qryDados.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryDados.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryDados.Open;

    Result := qryDados.RecordCount > 0;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TControleCashback.fPermiteGerarCashback: Boolean;
var
  qryDados : TUniQuery;
begin
  Result := True;

  If (Not fPermiteUtilizarRotinaCashback) Then
    Exit(False);

  If (FstrOrigem = 'V') Then
  Begin
    If (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_GERACAO_CASHBACK)) Or
       (fEmptyStr(FstrNumDoc)) Or
       (fEmptyStr(FstrCodEmp)) Then
      Exit(False);

    qryDados := fCriaQuery;
    Try
      qryDados.Close;
      qryDados.SQL.Text := 'SELECT AUTOINCREM '
                         + '  FROM MOVGER '
                         + ' WHERE GER_NUMDOC = :NUMDOC '
                         + '   AND GER_ESPDOC = :ESPDOC '
                         + '   AND GER_CODEMP = :CODEMP '
                         + '   AND CAST(GER_CLAFIS AS UNSIGNED) >= 5000 ';

      qryDados.ParamByName('NUMDOC').AsString := FstrNumDoc;
      qryDados.ParamByName('ESPDOC').AsString := FstrEspDoc;
      qryDados.ParamByName('CODEMP').AsString := FstrCodEmp;
      qryDados.Open;

      Result := qryDados.RecordCount > 0;
    Finally
      FreeAndNil(qryDados);
    End;
  End
  Else
  Begin
    If (fEmptyStr(FstrCodCli)) Or
       (FfltQtdEmb <= 0) Then
      Exit(False);

    If fClienteConsumidor(fRetNomCliente(FstrCodCli), True, True) Then
    Begin
      If (fCfgSis('CLCCSH') = '1') And fEmptyStr(FstrFonCli) Then
        Exit(False);
      If (fCfgSis('CLCCSH') = '2') And fEmptyStr(FstrCpfCli) Then
        Exit(False);
    End;
  End;
end;

function TControleCashback.fPermiteUtilizarCashback(
  const strEspDoc: String): Boolean;
begin
  Result := (fPermiteUtilizarRotinaCashback) And
            (MatchStr(strEspDoc, ARR_DOCUMENTOS_UTILIZACAO_CASHBACK));
end;

class function TControleCashback.fPermiteUtilizarRotinaCashback: Boolean;
begin
  Result := fCfgSis('CBKUTI', varBoolean);
end;

function TControleCashback.fPossuiSaldoCashbackCliente(
  const dtaDtaVen: TDateTime; out strMensagem: String): Boolean;
begin
  If fEhClienteFilial Then
    Exit(False);

  FobjControleUtilizacaoCashback.pLimparObjeto;
  FobjControleUtilizacaoCashback.strNumDoc := FstrNumDoc;
  FobjControleUtilizacaoCashback.strEspDoc := FstrEspDoc;
  FobjControleUtilizacaoCashback.strCodEmp := FstrCodEmp;
  FobjControleUtilizacaoCashback.strCodCli := FstrCodCli;
  FobjControleUtilizacaoCashback.strOrigem := FstrOrigem;
  FobjControleUtilizacaoCashback.strFonCli := FstrFonCli;
  FobjControleUtilizacaoCashback.strCpfCli := FstrCpfCli;

  Result := FobjControleUtilizacaoCashback.fPossuiSaldoCashbackCliente(
              dtaDtaVen,
              strMensagem);
end;

function TControleCashback.fRemoveUtilizacaoCashbackVenda: Boolean;
begin
  If (Not fPermiteUtilizarCashback(FstrEspDoc)) Then
    Exit(True);

  FobjControleUtilizacaoCashback.pLimparObjeto;
  FobjControleUtilizacaoCashback.strNumDoc := FstrNumDoc;
  FobjControleUtilizacaoCashback.strEspDoc := FstrEspDoc;
  FobjControleUtilizacaoCashback.strCodEmp := FstrCodEmp;
  FobjControleUtilizacaoCashback.strCodCli := FstrCodCli;
  FobjControleUtilizacaoCashback.strOrigem := FstrOrigem;

  FobjControleUtilizacaoCashback.pAtualizaUtilizacaoCashbackVenda;
  Result := True;
end;

function TControleCashback.fRetornaSaldoCashbackDevolucaoEmbalagemCliente: Double;
var
  strMensagem: String;
begin
  FstrOrigem := 'E';
  Result     := fCashbackDisponivelCliente(fNow, strMensagem);
end;

function TControleCashback.fRetornaValorSimulacaoCashback: Double;
begin
  If (FstrEspDoc <> 'PD') Or
     (Not fPermiteUtilizarRotinaCashback) Or
     (Not fCfgSis('EXBCSH', varBoolean)) Then
    Exit(0);

  Result := fValorSimulacaoGeracaoCashback;
end;

function TControleCashback.fValorSimulacaoGeracaoCashback: Double;
var
  objProcessaRegraCalculo: TProcesssaRegraCashback;
  objVendaCashback       : TVendaCashback;
begin
  If (Not fPermiteUtilizarRotinaCashback) Then
    Exit(0);

  If (FstrOrigem = 'V') Then
  Begin
    If (FstrEspDoc <> 'PD') Then
      Exit(0)
  End
  Else
  Begin
    If (FstrOrigem <> 'E') Then
      Exit(0);
  End;

  objProcessaRegraCalculo := TProcesssaRegraCashback.Create;
  Try
    objProcessaRegraCalculo.strNumDoc           := FstrNumDoc;
    objProcessaRegraCalculo.strEspDoc           := FstrEspDoc;
    objProcessaRegraCalculo.strCodEmp           := FstrCodEmp;
    objProcessaRegraCalculo.strCodCli           := FstrCodCli;
    objProcessaRegraCalculo.strCodCnd           := FstrCodCnd;
    objProcessaRegraCalculo.strCodVen           := FstrCodVen;
    objProcessaRegraCalculo.strCodOpe           := FstrCodOpe;
    objProcessaRegraCalculo.strOrigem           := FstrOrigem;
    objProcessaRegraCalculo.fltQtdEmb           := FfltQtdEmb;
    objProcessaRegraCalculo.cdsItens            := FcdsItens;
    objProcessaRegraCalculo.blnSimulacaoPedido  := True;
    objProcessaRegraCalculo.blnSilenciarAvisos  := True;
    objProcessaRegraCalculo.blnUtilizouCashback := FblnUtilizouCashback;
    objProcessaRegraCalculo.pProcessarCashback;

    Result := 0;
    For objVendaCashback In objProcessaRegraCalculo.lstVendaCashback Do
    Begin
      Result := Result
              + objVendaCashback.fltVlrCsh;
    End;
  Finally
    FreeAndNil(objProcessaRegraCalculo);
  End;
end;

function TControleCashback.fUtilizarCashback: Boolean;
begin
  If (Not fPermiteUtilizarCashback(FstrEspDoc)) Then
    Exit(True);

  If fEhClienteFilial Then
    Exit(True);

  FobjControleUtilizacaoCashback.pLimparObjeto;
  FobjControleUtilizacaoCashback.strNumDoc := FstrNumDoc;
  FobjControleUtilizacaoCashback.strEspDoc := FstrEspDoc;
  FobjControleUtilizacaoCashback.strCodEmp := FstrCodEmp;
  FobjControleUtilizacaoCashback.strCodCli := FstrCodCli;
  FobjControleUtilizacaoCashback.strOrigem := FstrOrigem;

  If FobjControleUtilizacaoCashback.fProcessar Then
    pGravarUtilizacaoCashback(FobjControleUtilizacaoCashback.ListaCashbackUtilizados);

  Result := True;
end;

function TControleCashback.fValorDescontoCashbackDocumento: Double;
begin
  If (Not fPermiteUtilizarCashback(FstrEspDoc)) Then
    Exit(0);

  FobjControleUtilizacaoCashback.pLimparObjeto;
  FobjControleUtilizacaoCashback.strNumDoc := FstrNumDoc;
  FobjControleUtilizacaoCashback.strEspDoc := FstrEspDoc;
  FobjControleUtilizacaoCashback.strCodEmp := FstrCodEmp;
  FobjControleUtilizacaoCashback.strCodCli := FstrCodCli;
  FobjControleUtilizacaoCashback.strOrigem := FstrOrigem;

  Result := FobjControleUtilizacaoCashback.fValorDescontoCashbackDocumento;
end;

procedure TControleCashback.SetcdsItens(const Value: TUniClientDataSet);
begin
  If FcdsItens.Active Then
    FcdsItens.EmptyDataSet;

  pCloneDataSet(FcdsItens, Value);

  FcdsItens.Filtered := False;
  FcdsItens.Filter   := 'ITE_UNITAR = 0';
  FcdsItens.Filtered := True;

  FcdsItens.First;
  While FcdsItens.RecordCount > 0 Do
    FcdsItens.Delete;

  FcdsItens.Filtered := False;
  FcdsItens.Filter   := EmptyStr;
  FcdsItens.First;
end;

procedure TControleCashback.SetCgcCpf(const Value: String);
begin
  FstrCgcCpf := Value;
end;

procedure TControleCashback.SetCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TControleCashback.SetCodCnd(const Value: String);
begin
  FstrCodCnd := Value;
end;

procedure TControleCashback.SetCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TControleCashback.SetCodOpe(const Value: String);
begin
  FstrCodOpe := Value;
end;

procedure TControleCashback.SetCodVen(const Value: String);
begin
  FstrCodVen := Value;
end;

procedure TControleCashback.SetCpfCli(const Value: String);
begin
  FstrCpfCli := Value;
end;

procedure TControleCashback.SetEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TControleCashback.SetFonCli(const Value: String);
begin
  FstrFonCli := Value;
end;

procedure TControleCashback.SetNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TControleCashback.SetOrigem(const Value: String);
begin
  FstrOrigem := Value;
end;

procedure TControleCashback.SetQtdEmb(const Value: Double);
begin
  FfltQtdEmb := Value;
end;

procedure TControleCashback.SetUtilizouCashback(const Value: Boolean);
begin
  FblnUtilizouCashback := Value;
end;

function TControleCashback.ValorUnitarioRegraCashBackDevolucaoEmbalagemVigenteParaCliente: Double;
begin
  If (FstrOrigem <> 'E') Or
     (Not fPermiteUtilizarRotinaCashback) Or
     (fCfgSis('DVECSH') = 'N') Then
    Exit(0);

  FfltQtdEmb := 1;
  Result     := fValorSimulacaoGeracaoCashback;
end;

end.

