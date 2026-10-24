unit faturamento.Classes.ManutencaoLocEqu;

interface

uses
  SysUtils, Windows, Classes, faturamento.Classes.FaturamentoLocEqu,
  cadastro.Model.ContratoLocacaoEquipamentos, Uni, untTypesLocEqu,
  cadastro.Controller.ContratoLocacaoEquipamentos, untLiberacao;

type
  TManutencaoContrato = class
  private
    FContrato: TContratoLocacaoEquipamentos;
    FFatura: TFaturamentoContrato;
    FMensagemRetorno: String;
    FBlnPermiteCancelamentoDocumento: Boolean;
    FUtilizaAcessorios: Boolean;
    FQryUpdateEnv: TUniQuery;
    FQryUpdateRet: TUniQuery;
    FQryUpdateAceEnv: TUniQuery;
    FQryUpdateAceRet: TUniQuery;
    FTipoManutencao: TTipoManutencao;
    FBlnManutencao: Boolean;
    FDtaFinCtr: TDateTime;
    FBlnAlterarDtaCtr: Boolean;
    FblnAlterarInspecao: Boolean;
    FobjValidaCtr: TValidarContrato;

    function fVerificarItemFaturado(const strCodEqu: String): Boolean;
    function fVerificarInspecaoEntradaEquipamentoEnviado(const strNumDoc, strCodEqu: String): Boolean;
    function fValidaPodeEncerrarContrato: Boolean;

    function GetContrato: TContratoLocacaoEquipamentos;
    procedure SetContrato(const AValue: TContratoLocacaoEquipamentos);
    function GetMsgRet: String;
    function GetCncDoc: Boolean;
    function GetTipMan: TTipoManutencao;
    procedure SetTipMan(const AValue: TTipoManutencao);
    function GetBlnMnt: Boolean;
    function GetDtaCtr: TDateTime;
    procedure SetDtaCtr(const Value: TDateTime);
    function GetBlnAltDta: Boolean;
    procedure SetBlnAltDta(const Value: Boolean);
    function GetBlnAltInsp: Boolean;
    procedure SetBlnAltInsp(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    function fIniciarManutencao(Const strNroCon: String; strNumPed: String): Boolean;
    function fPermiteRealizarManutencaoSaidaEqu(const strCodEqu: String; blnValidarDocEnv: Boolean = True; blnValidarInspecaoCancelamento: Boolean = False): Boolean;
    function fPermiteRealizarManutencaoEntradaEqu(const strCodEqu: String; blnValidarDocRet: Boolean = True): Boolean;
    function fConfirmarManutencao: Boolean;
    function fAlterarDataFinalContrato(const dtaFinCtr: TDateTime): Boolean;
    class function fRetornaEspecieNFRetorno(const strCodEmp, strCodCli, strEspDoc, strNumDoc: String): String;
    function fEncerrarContrato: Boolean;

    procedure pLimpaDocumentoEnvio(const strEspDoc, strEmpDoc, strNumDoc, strSerDoc: String);
    procedure pLimpaDocumentoRetorno(const strEspDoc, strEmpDoc, strNumDoc, strSerDoc: String);
    procedure pLimpar;

    property Contrato: TContratoLocacaoEquipamentos read GetContrato write SetContrato;
    property blnPermiteCancelamentoDocumento: Boolean read GetCncDoc;
    property MensagemRetorno: String read GetMsgRet;
    property TipoManutencao: TTipoManutencao read GetTipMan write SetTipMan;
    property EmManutencao: Boolean read GetBlnMnt;
    property dtaFinalContrato: TDateTime read GetDtaCtr write SetDtaCtr;
    property blnAlterarDtaFinalCtr: Boolean read GetBlnAltDta write SetBlnAltDta;
    property blnAlterarInspecao: Boolean read GetBlnAltInsp write SetBlnAltInsp;
    property objValidaCtr: TValidarContrato read FobjValidaCtr write FobjValidaCtr;
  end;

implementation

uses
  untFuncoesSimples;

{ TManutencaoContrato }

constructor TManutencaoContrato.Create;
begin
  FContrato := TContratoLocacaoEquipamentos.Create(opManutencao);
  FFatura := TFaturamentoContrato.Create(FContrato);
  FBlnPermiteCancelamentoDocumento := fCfgSis('LOCLIB', VarBoolean);
  FUtilizaAcessorios := fCfgSis('UTIACE', VarBoolean);
  FobjValidaCtr := TValidarContrato.Create(FContrato);

  pLimpar;

  FQryUpdateEnv := fCriaQuery;
  FQryUpdateEnv.DisableControls;

  FQryUpdateAceEnv := fCriaQuery;
  FQryUpdateAceEnv.DisableControls;

  FQryUpdateRet := fCriaQuery;
  FQryUpdateRet.DisableControls;

  FQryUpdateAceRet := fCriaQuery;
  FQryUpdateAceRet.DisableControls;
end;

destructor TManutencaoContrato.Destroy;
begin
  FreeAndNil(FQryUpdateEnv);
  FreeAndNil(FQryUpdateRet);
  FreeAndNil(FQryUpdateAceEnv);
  FreeAndNil(FQryUpdateAceRet);
  FreeAndNil(FContrato);
  FreeAndNil(FFatura);
  FreeAndNil(FobjValidaCtr);
end;

function TManutencaoContrato.fAlterarDataFinalContrato(const dtaFinCtr: TDateTime): Boolean;
begin
  If dtaFinCtr <= 0 Then
  Begin
    FMensagemRetorno := 'Não foi informada nova data para o final do contrato';
    Exit(False);
  End;

  Result := FContrato.fAlterarDataTerminoContrato(FContrato.DataInicialEstimada, dtaFinCtr,  '', '', True);
  If Not Result Then
    FMensagemRetorno :=  FContrato.MensagemRetorno;
end;

function TManutencaoContrato.fConfirmarManutencao: Boolean;
var
  intCnt: Integer;
  intCont: Integer;
begin

  fStartTransaction;
  Try
    If FblnAlterarInspecao Then
    Begin
      For intCnt := 0 To FContrato.Itens.Count-1 Do
      Begin
        If FContrato.Itens[intCnt].blnAtualizarInspSaida Then
          FContrato.Itens[intCnt].pConfirmarInspecaoSaida;

        If FContrato.Itens[intCnt].blnAtualizarInspEntrada Then
          FContrato.Itens[intCnt].pConfirmarInspecaoEntrada;

        If FUtilizaAcessorios Then
        Begin
          For intCont := 0 to FContrato.Itens[intCnt].Acessorios.Count-1 do
          Begin
            If Contrato.Itens[intCnt].Acessorios[intCont].blnAtualizarInspEntrada Then
              FContrato.Itens[intCnt].Acessorios[intCont].pConfirmarInspecaoEntrada;
            If Contrato.Itens[intCnt].Acessorios[intCont].blnAtualizarInspSaida Then
              FContrato.Itens[intCnt].Acessorios[intCont].pConfirmarInspecaoSaida;
          End;
        End;
      End;
    End;

    If FBlnAlterarDtaCtr Then
    Begin
      If Not fAlterarDataFinalContrato(FDtaFinCtr) Then
      Begin
        Result := False;
        fRollBack;
        Exit;
      End;
    End;

    fCommit;
    Result := True;
    FBlnManutencao := False;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, 'TManutencaoContrato.fConfirmarManutencao');
    End;
  End;
end;

function TManutencaoContrato.fValidaPodeEncerrarContrato: Boolean;
begin
  If Not FobjValidaCtr.fPodeEncerrarContrato Then
  Begin
    FMensagemRetorno := FobjValidaCtr.strMensagemRetorno;
    Exit(False);
  End;

  If fMensagem('ATENÇÃO!', 'Deseja realmente encerrar este contrato de locação de equipamentos?',
                             ['&Sim', '&Não']) = 2 Then
    Exit(False);

  Result := FobjValidaCtr.ValidaLiberacaoEncerramentoContratoSemFaturamento;
end;

function TManutencaoContrato.fEncerrarContrato: Boolean;
var
  objPedido: TPedidoContratoLocacao;
begin
  If Not fValidaPodeEncerrarContrato Then
    Exit(False);

  objPedido := TPedidoContratoLocacao.Create(FContrato);
  Try
    Result := objPedido.fCancelarPedido;
  Finally
    FreeAndNil(objPedido);
  End;

  If Result Then
  Begin
    Result := FContrato.fAlterarStatusContrato('', stEncerrado);
  End;
end;

function TManutencaoContrato.fIniciarManutencao(
  const strNroCon: String; strNumPed: String): Boolean;
begin
  Result := False;
  Try
    If FContrato.fCarregarContrato('', strNroCon, True, strNumPed) Then
    Begin
      FFatura.pCarregarFaturamento;
      FBlnManutencao := True;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TManutencaoContrato.fConfirmarManutencao');
    End;
  End;
end;

function TManutencaoContrato.fPermiteRealizarManutencaoEntradaEqu(
  const strCodEqu: String; blnValidarDocRet: Boolean = True): Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  For intCnt := 0 to FContrato.Itens.Count-1 Do
  Begin
    If FContrato.Itens[intCnt].Equipamento.Codigo = strCodEqu Then
    Begin
      If FContrato.Itens[intCnt].DataEncerramento > 0 Then
      Begin
        Result := False;
        FMensagemRetorno := 'Este equipamento já foi encerrado, não é permitido alterar a inspeção de entrada.';
        Break;
      End;

      If Not fEmptyStr(FContrato.Itens[intCnt].strDocRet) And blnValidarDocRet And (Not fVerificaAcessoSistema('LOCAIE')) Then
      Begin
        Result := False;
        FMensagemRetorno := ' Este equipamento já possui nota de retorno emitida. Sendo assim, se for preciso alterar a inspeção, deve-se efetuar o cancelamento da nota de retorno.';
        Break;
      End;

      If Not FContrato.Itens[intCnt].InspecaoSaidaRealizada  Then
      Begin
        Result := False;
        FMensagemRetorno := 'A inspeção de saída do equipamento não foi realizada.';
        Break;
      End;

      If fVerificarItemFaturado(strCodEqu) Then
      Begin
        Result := False;
        FMensagemRetorno := 'Este equipamento já possui faturamento emitido. Sendo assim, não é permitido alterar a inspeção de entrada.';
        Break;
      End;
    End;
  End;
end;

function TManutencaoContrato.fPermiteRealizarManutencaoSaidaEqu(
  const strCodEqu: String; blnValidarDocEnv: Boolean = True;
  blnValidarInspecaoCancelamento: Boolean = False): Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  For intCnt := 0 to FContrato.Itens.Count-1 Do
  Begin
    If FContrato.Itens[intCnt].Equipamento.Codigo = strCodEqu Then
    Begin
      If FContrato.Itens[intCnt].DataEncerramento > 0 Then
      Begin
        Result := False;
        FMensagemRetorno := 'Este equipamento já foi encerrado, não é permitido alterar a inspeção de saída.';
        Break;
      End;

      If FContrato.Itens[intCnt].InspecaoEntradaRealizada And (Not fVerificaAcessoSistema('LOCAIS')) Then
      Begin
        Result := False;
        FMensagemRetorno := 'Este equipamento já possui inspeção de entrada. Sendo assim, não é permitido alterar a inspeção de saída.';
        Break;
      End;

      If Not fEmptyStr(FContrato.Itens[intCnt].strDocEnv) and blnValidarDocEnv And (Not fVerificaAcessoSistema('LOCAIS')) Then
      Begin
        Result := False;
        FMensagemRetorno := ' Este equipamento já possui nota de envio emitida. Sendo assim, se for preciso alterar a inspeção, deve-se efetuar o cancelamento da nota de envio.';
        Break;
      End;

      If blnValidarInspecaoCancelamento Then
      Begin
        Result := fVerificarInspecaoEntradaEquipamentoEnviado(FContrato.Itens[intCnt].strDocEnv, strCodEqu);
        If Not Result Then
          Break;
      End;

      If fVerificarItemFaturado(strCodEqu) Then
      Begin
        Result := False;
        FMensagemRetorno := 'Este equipamento já possui faturamento emitido. Sendo assim, não é permitido alterar a inspeção de saída.';
        Break;
      End;
    End;
  End;
end;

class function TManutencaoContrato.fRetornaEspecieNFRetorno(const strCodEmp,
  strCodCli, strEspDoc, strNumDoc: String): String;
var
  qryAux : TUniQuery;
begin
  Result := EmptyStr;
  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                      ');
    qryAux.SQL.Add('  AUX_OPCDOC                ');
    qryAux.SQL.Add('FROM                        ');
    qryAux.SQL.Add('  MOVGER                    ');
    qryAux.SQL.Add('  INNER JOIN AUXMOV ON (AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM) ');
    qryAux.SQL.Add('WHERE GER_NUMDOC = :NUMDOC  ');
    qryAux.SQL.Add('  AND GER_ESPDOC = :ESPDOC  ');
    qryAux.SQL.Add('  AND GER_CODEMP = :CODEMP  ');
    qryAux.SQL.Add('  AND GER_CODCLI = :CODCLI  ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      Result := IIF(qryAux.FieldByName('AUX_OPCDOC').AsString = 'OE', strEspDoc, qryAux.FieldByName('AUX_OPCDOC').AsString);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TManutencaoContrato.fVerificarInspecaoEntradaEquipamentoEnviado(const strNumDoc, strCodEqu: String): Boolean;
var
  intCnt: Integer;
begin
  Result := True;
  For intCnt := 0 to FContrato.Itens.Count-1 Do
  Begin
    If (FContrato.Itens[intCnt].strDocEnv = strNumDoc) and
       (FContrato.Itens[intCnt].Equipamento.Codigo <> strCodEqu) Then
    Begin
      If FContrato.Itens[intCnt].InspecaoEntradaRealizada Then
      Begin
        Result := False;
        FMensagemRetorno := 'Já foi realziada inspeção de entrada para o equipamento ' +
                             FContrato.Itens[intCnt].Equipamento.Codigo +  ' - ' + FContrato.Itens[intCnt].Equipamento.Descricao + '. '+
                            'Sendo assim, não é permitido realizar o cancelamento da nota de saída.' ;
        Break;
      End;
    End;
  End;
end;

function TManutencaoContrato.fVerificarItemFaturado(
  const strCodEqu: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FFatura.ListaItens.Count-1 Do
  Begin
    If FFatura.ListaItens[intCnt].itemContrato.Equipamento.Codigo = strCodEqu Then
    Begin
      Result := FFatura.ListaItens[intCnt].ValorJaFaturado > 0;
    End;
  End;
end;

function TManutencaoContrato.GetBlnAltDta: Boolean;
begin
  Result := FBlnAlterarDtaCtr;
end;

function TManutencaoContrato.GetBlnMnt: Boolean;
begin
  Result := FBlnManutencao;
end;

function TManutencaoContrato.GetCncDoc: Boolean;
begin
  Result := FBlnPermiteCancelamentoDocumento;
end;

function TManutencaoContrato.GetContrato: TContratoLocacaoEquipamentos;
begin
  Result := FContrato;
end;

function TManutencaoContrato.GetDtaCtr: TDateTime;
begin
  Result := FDtaFinCtr;
end;

function TManutencaoContrato.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TManutencaoContrato.GetTipMan: TTipoManutencao;
begin
  Result := FTipoManutencao;
end;

procedure TManutencaoContrato.pLimpaDocumentoEnvio(const strEspDoc, strEmpDoc, strNumDoc, strSerDoc: String);
var
  intCnt: Integer;
begin
  FQryUpdateEnv.SQL.Clear;
  FQryUpdateEnv.SQL.Add('UPDATE EQLDET SET ');
  FQryUpdateEnv.SQL.Add('       EQD_NUMENV = NULL,');
  FQryUpdateEnv.SQL.Add('       EQD_EMPENV = NULL,');
  FQryUpdateEnv.SQL.Add('       EQD_ESPENV = NULL,');
  FQryUpdateEnv.SQL.Add('       EQD_SERENV = NULL ');
  FQryUpdateEnv.SQL.Add('WHERE  EQD_SEQCON = :EQD_SEQCON');
  FQryUpdateEnv.SQL.Add('   AND EQD_NUMENV = :EQD_NUMENV');
  FQryUpdateEnv.SQL.Add('   AND EQD_ESPENV = :EQD_ESPENV');
  FQryUpdateEnv.SQL.Add('   AND EQD_EMPENV = :EQD_EMPENV');
  FQryUpdateEnv.SQL.Add('   AND EQD_SERENV = :EQD_SERENV');
  FQryUpdateEnv.ParamByName('EQD_ESPENV').AsString := strEspDoc;
  FQryUpdateEnv.ParamByName('EQD_EMPENV').AsString := strEmpDoc;
  FQryUpdateEnv.ParamByName('EQD_NUMENV').AsString := strNumDoc;
  FQryUpdateEnv.ParamByName('EQD_SERENV').AsString := strSerDoc;
  FQryUpdateEnv.ParamByName('EQD_SEQCON').AsString := FContrato.AutInc;
  FQryUpdateEnv.ExecSQL;

  FQryUpdateAceEnv.SQL.Clear;
  FQryUpdateAceEnv.SQL.Add('UPDATE ACLDET SET ');
  FQryUpdateAceEnv.SQL.Add('       EQD_NUMENV = NULL,');
  FQryUpdateAceEnv.SQL.Add('       EQD_EMPENV = NULL,');
  FQryUpdateAceEnv.SQL.Add('       EQD_ESPENV = NULL,');
  FQryUpdateAceEnv.SQL.Add('       EQD_SERENV = NULL ');
  FQryUpdateAceEnv.SQL.Add('WHERE  EQD_SEQCON = :EQD_SEQCON');
  FQryUpdateAceEnv.SQL.Add('   AND EQD_NUMENV = :EQD_NUMENV');
  FQryUpdateAceEnv.SQL.Add('   AND EQD_ESPENV = :EQD_ESPENV');
  FQryUpdateAceEnv.SQL.Add('   AND EQD_EMPENV = :EQD_EMPENV');
  FQryUpdateAceEnv.SQL.Add('   AND EQD_SERENV = :EQD_SERENV');
  FQryUpdateAceEnv.ParamByName('EQD_ESPENV').AsString := strEspDoc;
  FQryUpdateAceEnv.ParamByName('EQD_EMPENV').AsString := strEmpDoc;
  FQryUpdateAceEnv.ParamByName('EQD_NUMENV').AsString := strNumDoc;
  FQryUpdateAceEnv.ParamByName('EQD_SERENV').AsString := strSerDoc;
  FQryUpdateAceEnv.ParamByName('EQD_SEQCON').AsString := Contrato.AutInc;
  FQryUpdateAceEnv.ExecSQL;

  For intCnt := 0 To FContrato.Itens.Count-1 Do
  Begin
    If (FContrato.Itens[intCnt].EspEnv = strEspDoc) And
       (FContrato.Itens[intCnt].EmpEnv = strEmpDoc) And
       (FContrato.Itens[intCnt].NumEnv = strNumDoc) And
       (FContrato.Itens[intCnt].SerEnv = strSerDoc)Then
    Begin
      FContrato.Itens[intCnt].pLimparDocumentoEnvio;
    End;
  End;
end;

procedure TManutencaoContrato.pLimpaDocumentoRetorno(const strEspDoc, strEmpDoc, strNumDoc, strSerDoc: String);
var
  intCnt: Integer;
begin
  FQryUpdateRet.SQL.Clear;
  FQryUpdateRet.SQL.Add('UPDATE EQLDET SET ');
  FQryUpdateRet.SQL.Add('       EQD_NUMRET = NULL,');
  FQryUpdateRet.SQL.Add('       EQD_EMPRET = NULL,');
  FQryUpdateRet.SQL.Add('       EQD_ESPRET = NULL,');
  FQryUpdateRet.SQL.Add('       EQD_SERRET = NULL ');
  FQryUpdateRet.SQL.Add('WHERE  EQD_SEQCON = :EQD_SEQCON');
  FQryUpdateRet.SQL.Add('   AND EQD_NUMRET = :EQD_NUMRET');
  FQryUpdateRet.SQL.Add('   AND EQD_ESPRET = :EQD_ESPRET');
  FQryUpdateRet.SQL.Add('   AND EQD_EMPRET = :EQD_EMPRET');
  FQryUpdateRet.SQL.Add('   AND EQD_SERRET = :EQD_SERRET');
  FQryUpdateRet.ParamByName('EQD_ESPRET').AsString := strEspDoc;
  FQryUpdateRet.ParamByName('EQD_EMPRET').AsString := strEmpDoc;
  FQryUpdateRet.ParamByName('EQD_NUMRET').AsString := strNumDoc;
  FQryUpdateRet.ParamByName('EQD_SERRET').AsString := strSerDoc;
  FQryUpdateRet.ParamByName('EQD_SEQCON').AsString := FContrato.AutInc;
  FQryUpdateRet.ExecSQL;

  FQryUpdateAceRet.SQL.Clear;
  FQryUpdateAceRet.SQL.Add('UPDATE ACLDET SET ');
  FQryUpdateAceRet.SQL.Add('       EQD_NUMRET = NULL,');
  FQryUpdateAceRet.SQL.Add('       EQD_EMPRET = NULL,');
  FQryUpdateAceRet.SQL.Add('       EQD_ESPRET = NULL,');
  FQryUpdateAceRet.SQL.Add('       EQD_SERRET = NULL ');
  FQryUpdateAceRet.SQL.Add('WHERE  EQD_SEQCON = :EQD_SEQCON');
  FQryUpdateAceRet.SQL.Add('   AND EQD_NUMRET = :EQD_NUMRET');
  FQryUpdateAceRet.SQL.Add('   AND EQD_ESPRET = :EQD_ESPRET');
  FQryUpdateAceRet.SQL.Add('   AND EQD_EMPRET = :EQD_EMPRET');
  FQryUpdateAceRet.SQL.Add('   AND EQD_SERRET = :EQD_SERRET');
  FQryUpdateAceRet.ParamByName('EQD_ESPRET').AsString := strEspDoc;
  FQryUpdateAceRet.ParamByName('EQD_EMPRET').AsString := strEmpDoc;
  FQryUpdateAceRet.ParamByName('EQD_NUMRET').AsString := strNumDoc;
  FQryUpdateAceRet.ParamByName('EQD_SERRET').AsString := strSerDoc;
  FQryUpdateAceRet.ParamByName('EQD_SEQCON').AsString := Contrato.AutInc;
  FQryUpdateAceRet.ExecSQL;

  For intCnt := 0 To FContrato.Itens.Count-1 Do
  Begin
    If (FContrato.Itens[intCnt].EspRet = strEspDoc) And
       (FContrato.Itens[intCnt].EmpRet = strEmpDoc) And
       (FContrato.Itens[intCnt].NumRet = strNumDoc) And
       (FContrato.Itens[intCnt].SerRet = strSerDoc)Then
    Begin
      FContrato.Itens[intCnt].pLimparDocumentoRetorno;
    End;
  End;
end;

procedure TManutencaoContrato.pLimpar;
begin
  FBlnManutencao := False;
  FBlnAlterarDtaCtr := False;
  FDtaFinCtr := 0;
  FblnAlterarInspecao := False;
end;

function TManutencaoContrato.GetBlnAltInsp: Boolean;
begin
  Result := FblnAlterarInspecao;
end;

procedure TManutencaoContrato.SetBlnAltDta(const Value: Boolean);
begin
  FBlnAlterarDtaCtr := Value;
end;

procedure TManutencaoContrato.SetBlnAltInsp(const Value: Boolean);
begin
  FblnAlterarInspecao := Value;
end;

procedure TManutencaoContrato.SetContrato(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FContrato := AValue;
end;

procedure TManutencaoContrato.SetDtaCtr(const Value: TDateTime);
begin
  FDtaFinCtr := Value;
end;

procedure TManutencaoContrato.SetTipMan(const AValue: TTipoManutencao);
begin
  FTipoManutencao := AValue;
end;

end.
