unit untTConsultaCadastroFit;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  System.SysUtils, Data.DB, untIConsultaCadastroFit, Uni,
  DateUtils, untLibNfe, untTypesSistema, untInterfaces;

type
  TConsultaCadastroFit = class(TInterfacedObject, IConsultaCadastroFit)
  strict private
    class var FstrMsgRetornoImplicit: string;

  private
    class function __VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE: string;
      out pStrMsgRetorno: string): Boolean; overload;

    class function __VerificaSituacaoRegular(const pStrCodCli: String; pBlnExibirMsg: Boolean;
      out pStrMsgRetorno: string): Boolean; overload;

  public
    procedure pConsulta(dicValoresAtuais,
                        dicResultado: TDicionario;
                        strCnpj: String;
                        blnMostraCnae: Boolean;
                        Var blnTemDivergencia: Boolean;
                        blnPermiteAtualiza: Boolean = True;
                        strOrigem: String = '');

    //CFG_UCSFIT
    class function VerificaSituacaoRegular(const pStrCodCli: String; pBlnExibirMsg: Boolean;
      out pStrMsgRetorno: string): Boolean; overload;

    class function VerificaSituacaoRegular(const pStrCodCli: String;
      pBlnExibirMsg: Boolean): Boolean; overload;

    class function VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE: string;
      out pStrMsgRetorno: string): Boolean; overload;

    class function VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE: string): Boolean; overload;

    //CFG_UCCFIT
    class function VerificaSituacaoRegularConfirmacao(const pStrCodCli: String; pBlnExibirMsg: Boolean;
      out pStrMsgRetorno: string): Boolean; overload;

    class function VerificaSituacaoRegularConfirmacao(const pStrCodCli: String;
      pBlnExibirMsg: Boolean): Boolean; overload;

    class function VerificaSituacaoRegularConfirmacao(pStrCNPJ, pStrUF, pStrIE: string;
      out pStrMsgRetorno: string): Boolean; overload;

    class function VerificaSituacaoRegularConfirmacao(pStrCNPJ, pStrUF, pStrIE: string): Boolean; overload;

    class function PesquisaDadosCNPJ(pStrCNPJ, pStrUF, pStrIE: string; out pHabilitado : boolean; out pErro: string): Boolean;
  end;

implementation

{$IFNDEF LINUX}
uses
  untConsultaCadastroFit, untGravando;
{$ENDIF}

{ TConsultaCadastroFit }

procedure TConsultaCadastroFit.pConsulta(dicValoresAtuais,
                                         dicResultado: TDicionario;
                                         strCnpj: String;
                                         blnMostraCnae: Boolean;
                                         Var blnTemDivergencia: Boolean;
                                         blnPermiteAtualiza: Boolean = True;
                                         strOrigem: String = '');
{$IFDEF LINUX}
begin
  raise Exception.Create('TConsultaCadastroFit.pConsulta ainda não possui implementação linux');
end;
{$ELSE}
var
  intIdx: Integer;
begin
  pCriarFormularios(TfrmConsultaCadastroFit, frmConsultaCadastroFit);
  try
    blnTemDivergencia := False;

    frmConsultaCadastroFit.strCnpj := strCnpj;
    frmConsultaCadastroFit.blnMostraCnae := blnMostraCnae;

    frmConsultaCadastroFit.dicValoresAtuais.Limpar;
    for intIdx := 0 to dicValoresAtuais.Chaves.Count - 1 do
      frmConsultaCadastroFit.dicValoresAtuais.Adicionar(dicValoresAtuais.Chaves[intIdx],
                                                        dicValoresAtuais.Retorna(dicValoresAtuais.Chaves[intIdx]));

    frmConsultaCadastroFit.grdDadosConsultaTableViewTrocar.Visible := blnPermiteAtualiza;
    frmConsultaCadastroFit.grdDadosConsultaTableViewValorCadCli.Visible := Not blnPermiteAtualiza;
    frmConsultaCadastroFit.grdDadosConsultaTableViewValor.Caption := IIF(blnPermiteAtualiza, 'Valor', 'Valor Consulta');
    frmConsultaCadastroFit.strOrigem := strOrigem;

    TfrmGravando.fExecutarModal(frmConsultaCadastroFit.pExecConsulta, 'Realizando consulta...', '');

    If (frmConsultaCadastroFit.grdDadosConsultaTableView.DataController.RecordCount = 0) Then
      Exit;

    frmConsultaCadastroFit.ShowModal;

    If frmConsultaCadastroFit.blnConfirma And blnPermiteAtualiza Then
    Begin
      for intIdx := 0 to frmConsultaCadastroFit.dicResultado.Chaves.Count - 1 do
        dicResultado.Adicionar(frmConsultaCadastroFit.dicResultado.Chaves[intIdx],
                               frmConsultaCadastroFit.dicResultado.Retorna(frmConsultaCadastroFit.dicResultado.Chaves[intIdx]));

      blnTemDivergencia := frmConsultaCadastroFit.blnTemDivergencia;
    End;
  finally
    FreeAndNil(frmConsultaCadastroFit);
  end;
end;
{$ENDIF}

class function TConsultaCadastroFit.__VerificaSituacaoRegular(pStrCNPJ, pStrUF,
  pStrIE: string; out pStrMsgRetorno: string): Boolean;
var
  libNfe: TLibNfe;
  objRetorno: TRetornoConsultaCadastro;
const
  strMSG_SITUACAO_IRREGULAR = '%s com situação irregular perante o Fisco. Verifique!';
  strMSG_CAMPO_NAO_INFORMADO = '%s não informado para consultar situação perante o Fisco. Verifique!';
begin
  pStrMsgRetorno := String.Empty;

  pStrCNPJ := fTiraCaracEspeciaisPonto(pStrCNPJ);
  pStrIE   := fTiraCaracEspeciaisPonto(pStrIE);

  if fEmptyStr(pStrCNPJ) and fEmptyStr(pStrIE) then
    pStrMsgRetorno := Format(strMSG_CAMPO_NAO_INFORMADO, ['CNPJ/IE']);

  if fEmptyStr(pStrUF)then
    pStrMsgRetorno := Format(strMSG_CAMPO_NAO_INFORMADO, ['UF']);

  if not fEmptyStr(pStrMsgRetorno)then
    Exit(False);

  libNfe := TLibNfe.Create(VS_strCodEmp);
  objRetorno := Nil;
  try
    try
      objRetorno := libNfe.fConsultaCadastro(pStrUF, pStrCNPJ, pStrIE);
      result := objRetorno.blnHabilitado;
      if not result then
      begin
        if not fEmptyStr(pStrCNPJ) then
          pStrMsgRetorno := Format(strMSG_SITUACAO_IRREGULAR, ['CNPJ: ' + pStrCNPJ])
        else if not fEmptyStr(pStrIE) then
          pStrMsgRetorno := Format(strMSG_SITUACAO_IRREGULAR, ['IE: ' + pStrIE]);
      end;
    except
      on E: Exception do
      begin
        pStrMsgRetorno := E.Message;
        result := False;
      end;
    end;
  finally
    if Assigned(objRetorno) then
      objRetorno.free;

    if Assigned(libNfe) then
      libNfe.Free;
  end;
end;

class function TConsultaCadastroFit.__VerificaSituacaoRegular(
  const pStrCodCli: String; pBlnExibirMsg: Boolean;
  out pStrMsgRetorno: string): Boolean;
var
  qryAux: TUniQuery;
  blnConsultar: Boolean;
  intIntervalo: Integer;
  intUltConsDias: Integer;
  dtaUltConsulta: TDateTime;
begin
  pStrMsgRetorno := String.Empty;

  Result := True;
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Text :=
      'SELECT CLI_CODCLI, ' + sLineBreak +
      '       CLI_C_G_C_, ' + sLineBreak +
      '       CLI_I_E_S_, ' + sLineBreak +
      '       CLI_PESFIT, ' + sLineBreak +
      '       (SELECT CID_ESTADO ' + sLineBreak +
      '          FROM CADCID ' + sLineBreak +
      '         WHERE CID_CODCID = CLI_CODCID) AS CID_ESTADO ' + sLineBreak +
      '  FROM CADCLI ' + sLineBreak +
      ' WHERE CLI_CGCCPF = 1 ' + sLineBreak +
      '   AND CLI_CODCLI = :CODCLI ';

    qryAux.ParamByName('CODCLI').AsString := pStrCodCli;
    qryAux.Open;

    If qryAux.isEmpty Then
      Exit(True);

    intIntervalo   := fCfgSis('QDPFIT', varInteger);
    dtaUltConsulta := qryAux.FieldByName('CLI_PESFIT').AsDateTime;
    intUltConsDias := DaysBetween(dtaUltConsulta, VS_Date);
    blnConsultar   := (intUltConsDias > intIntervalo);

    if not blnConsultar then
      Exit(True);

    try
      result := Self.__VerificaSituacaoRegular(qryAux.FieldByName('CLI_C_G_C_').AsString,
                                        qryAux.FieldByName('CID_ESTADO').AsString,
                                        qryAux.FieldByName('CLI_I_E_S_').AsString,
                                        pStrMsgRetorno);

      If result Then
      Begin
        qryAux.Edit;
        qryAux.FieldByName('CLI_PESFIT').AsDateTime := VS_Date;
        qryAux.Post;
      End
      else If pBlnExibirMsg Then
      begin
        fMensagem('ATENÇÃO',
                  pStrMsgRetorno,
                  ['&Ok']);
      end;
    except
      on E: Exception do
      begin
        pStrMsgRetorno := e.Message;
        If pBlnExibirMsg Then
          fMensagem('Erro', pStrMsgRetorno, ['&Ok']);
      end;
    end;

    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

//CFG_UCSFIT
class function TConsultaCadastroFit.VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE: string;
  out pStrMsgRetorno: string): Boolean;
begin
  If not fCfgSis('UCSFIT', varBoolean) Then
    exit(True);

  Result := Self.__VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE, pStrMsgRetorno);
end;

class function TConsultaCadastroFit.PesquisaDadosCNPJ(pStrCNPJ, pStrUF,
  pStrIE: string; out pHabilitado: boolean; out pErro: string): Boolean;
var
  libNfe: TLibNfe;
  objRetorno: TRetornoConsultaCadastro;
  LCnpjConsulta, LCnpjRetorno: String;

begin
  pStrCNPJ := fTiraCaracEspeciaisPonto(pStrCNPJ);
  pStrIE   := fTiraCaracEspeciaisPonto(pStrIE);

  libNfe := TLibNfe.Create(VS_strCodEmp);
  objRetorno := Nil;
  try
    try
      objRetorno  := libNfe.fConsultaCadastro(pStrUF, pStrCNPJ, pStrIE);

      LCnpjConsulta := fPadL(fTiraCaracEspeciaisPonto(pStrCNPJ), 14, '0');
      LCnpjRetorno  := fTiraCaracEspeciaisPonto(objRetorno.strCpfCnpj);

      If Not objRetorno.blnHabilitado Then
      Begin
        If  (fEmptyStr(LCnpjRetorno)) or
            (LCnpjRetorno = StringOfChar('0', 14)) or
            (LCnpjRetorno <> LCnpjConsulta) or
            (fEmptyStr(objRetorno.strRazaoSocial)) or
            (UpperCase(objRetorno.strRazaoSocial) = 'NFE-ERRO') or
            (fEmptyStr(objRetorno.strDescSituacao)) Then
        Begin
          pErro  := 'Retorno da FIT sem dados suficientes para confirmar situação do CNPJ';
          Result := False;
          Exit;
        End;
      End;

      pHabilitado := objRetorno.blnHabilitado;
      Result      := true;

    except
      on E: Exception do
      begin
        pErro  := E.message;
        result := False;
      end;
    end;
  finally
    if Assigned(objRetorno) then
      objRetorno.free;

    if Assigned(libNfe) then
      libNfe.Free;
  end;
end;


class function TConsultaCadastroFit.VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE: string): Boolean;
begin
  Result := VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE, FstrMsgRetornoImplicit);
end;

class function TConsultaCadastroFit.VerificaSituacaoRegular(const pStrCodCli: String;
  pBlnExibirMsg: Boolean; out pStrMsgRetorno: string): Boolean;
begin
  If not fCfgSis('UCSFIT', varBoolean) Then
    Exit(True);

  Result := Self.__VerificaSituacaoRegular(pStrCodCli, pBlnExibirMsg, pStrMsgRetorno);
end;

class function TConsultaCadastroFit.VerificaSituacaoRegular(const pStrCodCli: String;
  pBlnExibirMsg: Boolean): Boolean;
begin
  Result := VerificaSituacaoRegular(pStrCodCli, pBlnExibirMsg, FstrMsgRetornoImplicit);
end;

//CFG_UCCFIT
class function TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(pStrCNPJ,
  pStrUF, pStrIE: string; out pStrMsgRetorno: string): Boolean;
begin
  If not fCfgSis('UCCFIT', varBoolean) Then
    exit(True);

  Result := Self.__VerificaSituacaoRegular(pStrCNPJ, pStrUF, pStrIE, pStrMsgRetorno);
end;

class function TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(pStrCNPJ,
  pStrUF, pStrIE: string): Boolean;
begin
  Result := VerificaSituacaoRegularConfirmacao(pStrCNPJ, pStrUF, pStrIE, FstrMsgRetornoImplicit);
end;

class function TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(
  const pStrCodCli: String; pBlnExibirMsg: Boolean;
  out pStrMsgRetorno: string): Boolean;
begin
  If not fCfgSis('UCCFIT', varBoolean) Then
    Exit(True);

  Result := Self.__VerificaSituacaoRegular(pStrCodCli, pBlnExibirMsg, pStrMsgRetorno);
end;

class function TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(
  const pStrCodCli: String; pBlnExibirMsg: Boolean): Boolean;
begin
  Result := VerificaSituacaoRegularConfirmacao(pStrCodCli, pBlnExibirMsg, FstrMsgRetornoImplicit);
end;

initialization
  objConsultaCadastroFit := TConsultaCadastroFit.Create;

end.


