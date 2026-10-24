unit untTefRecebimento;

interface

uses SysUtils, untFunTef, Classes, Forms, Windows, Genericos.Classes.OcultaTelas;

Const
  TEFREC_STATUS_CANCELAR = '1';
  TEFREC_STATUS_CONFIRMAR = '2';
  TEFREC_STATUS_VERIFICAR_CNC_NCN = '3';

  TEFREC_MENSAGEM_ARQUIVO_ECF_INVALIDO : String = 'Arquivo de configurações da ecf não é válido!';
  TEFREC_MENSAGEM_OBJETO_ECF_NULL : String = 'A impressora fiscal não foi devidamente inicializada!';

Type

  ITefRecebimento = Interface(IInterface)
    function fAdicionarRecebimento(fltValor: Double; Var strArquivo: String): Boolean;
    function fCancelarRecebimento(strArquivo: String): Boolean;

    function fConfirmaCartoes(var strMsgAdicional: String): Boolean;
    function fVerificaPendencias: Boolean;
  End;

  TTefRecebimentoVazio = class(TInterfacedObject, ITefRecebimento)
    function fAdicionarRecebimento(fltValor: Double; Var strArquivo: String): Boolean;
    function fCancelarRecebimento(strArquivo: String): Boolean;

    function fConfirmaCartoes(var strMsgAdicional: String): Boolean;
    function fVerificaPendencias: Boolean;
  end;

  TTefRecebimento = class(TInterfacedObject, ITefRecebimento)
    private
      objTef: TTef;
      blnPrimeiraVendaTEF: Boolean;
      fltTotal: Double;
      blnRotinaPagueFacil: Boolean;
      objOcultaTelas: TOcultaTelas;
      strTipoCartao: string;
      intParcelas: Integer;

      function fArquivoDeMarcacao: String;
      procedure pCriarArquivoMarcacao(strStatus: String);

      procedure pMarcarComoNadaAFazer;
      procedure pMarcarComoTemQueCancelar;
      procedure pMarcarComoTemQueConfirmar;

      function fStatusPendencia: String;
    public
      constructor Create(objTef: TTef; blnRotinaPagueFacil: Boolean=False; strTipoCartao: string = ''; intParcelas: Integer = 1);
      destructor Destroy; override;

      function fAdicionarRecebimento(fltValor: Double; Var strArquivo: String): Boolean;
      function fCancelarRecebimento(strArquivo: String): Boolean;

      function fConfirmaCartoes(var strMsgAdicional: String): Boolean;
      function fVerificaPendencias: Boolean;
  End;

  function fCriarTefRecebimento(objTef: TTef; blnRotinaPagueFacil: Boolean=False;
                                strTipoCartao: string = ''; intParcelas: Integer = 1): ITefRecebimento;

implementation

uses untFuncoes, untFuncoesSimples, untFiscal;

function fCriarTefRecebimento(objTef: TTef; blnRotinaPagueFacil: Boolean;
                              strTipoCartao: string; intParcelas: Integer): ITefRecebimento;
begin
  If (Not Assigned(objTef)) Or (Not fCfgSis('TEFREC', varBoolean)) Then
  Begin
    Result := TTefRecebimentoVazio.Create;
  End
  Else
  Begin
    Result := TTefRecebimento.Create(objTef, blnRotinaPagueFacil, strTipoCartao, intParcelas);
  End;
end;

{ TTefRecebimento }

constructor TTefRecebimento.Create(objTef: TTef; blnRotinaPagueFacil: Boolean; strTipoCartao: string; intParcelas: Integer);
begin
  Self.objTef := objTef;
  blnPrimeiraVendaTEF := True;
  fltTotal := 0;
  Self.blnRotinaPagueFacil := blnRotinaPagueFacil;
  if blnRotinaPagueFacil then
  begin
    Self.strTipoCartao := strTipoCartao;
    Self.intParcelas := intParcelas;
    Self.objOcultaTelas := TOcultaTelas.Create('TEF');
  end;
end;

destructor TTefRecebimento.Destroy;
begin
  if Assigned(Self.objOcultaTelas) then
    FreeAndNil(Self.objOcultaTelas);

  inherited;
end;

function TTefRecebimento.fAdicionarRecebimento(fltValor: Double; Var strArquivo: String): Boolean;
  Var
    strValorTEF: String;
begin
  Result := False;

  strValorTEF := FloatToStrF(fltValor, ffFixed, 12, 2);
  strValorTEF := fTiraCaracter(strValorTEF);

  if Self.blnRotinaPagueFacil then
    Self.objOcultaTelas.Start;

  If objTef.fTef_Crt(strValorTEF, blnPrimeiraVendaTEF, False, strArquivo,
     Self.blnRotinaPagueFacil, Self.strTipoCartao, Self.intParcelas) Then
  Begin
    blnPrimeiraVendaTEF := False;
    fltTotal := fltTotal + fltValor;

    pMarcarComoTemQueCancelar;
    Result := True;
  End;

  if Self.blnRotinaPagueFacil then
    Self.objOcultaTelas.Stop;
end;

function TTefRecebimento.fCancelarRecebimento(strArquivo: String): Boolean;
  Var
    fltValor: Double;
    arrMatRet: arrTStringList;
begin

  If fEmptyStr(strArquivo) Then
  Begin
    Result := True;
    Exit;
  End;

  objTef.pInicializaMatRet(arrMatRet);
  arrMatRet[ TF_strProIde ] := objTef.fLArqTxt( '001', strArquivo );   // Numero da Identificacao
  arrMatRet[ TF_strNomRed ] := objTef.fLArqTxt( '010', strArquivo );   // Nome da Rede
  arrMatRet[ TF_strNumTra ] := objTef.fLArqTxt( '012', strArquivo );   // Numero da Transacao
  arrMatRet[ TF_strDtaTra ] := objTef.fLArqTxt( '022', strArquivo );   // Data da Transacao DDMMAAAA
  arrMatRet[ TF_strHorTra ] := objTef.fLArqTxt( '023', strArquivo );   // Hora da Transacao HHMMSS
  arrMatRet[ TF_strChaFin ] := objTef.fLArqTxt( '027', strArquivo );   // Chave para Finalizacao
  arrMatRet[ TF_intQtdLin ] := objTef.fLArqTxt( '028', strArquivo );   // Qtd Linhas do Comprovante
  arrMatRet[ TF_lslLinImp ] := objTef.fLArqTxt( '029', strArquivo );   // Matriz com as linhas para impressao
  arrMatRet[ TF_curValRet ] := objTef.fLArqTxt( '003', strArquivo );   // Valor do Cupom
  arrMatRet[ TF_strMensag ] := objTef.fLArqTxt( '030', strArquivo );   // Mensagem
  arrMatRet[ TF_strStatus ] := objTef.fLArqTxt( '009', strArquivo );   // Status da Transacao
  arrMatRet[ TF_strOcorre ].Strings[0] := '0';                   // Ocorrencia 0-False 1-True

  Result := objTef.fEnviarCancelamentoCompleto(strArquivo, arrMatRet);

  If Result Then
  Begin
    fltValor := fStrToFloat(arrMatRet[ TF_curValRet ].Strings[0]) / 100;
    fltTotal := fltTotal - fltValor;

    If fltTotal <= 0 Then
    Begin
      blnPrimeiraVendaTEF := True;
      pMarcarComoNadaAFazer;
      fltTotal := 0;
    End;
  End;

end;

function TTefRecebimento.fConfirmaCartoes(var strMsgAdicional: String): Boolean;
  Var
    strArquivo : String;
    strNumSer : String;
begin
  strMsgAdicional := '';

  If fFormataFloat(fltTotal, 2) <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCfgSis('PAFECF', varBoolean)) Then
  Begin
    If Not Assigned(VS_objFiscal) Then
    Begin
      Result := False;
      strMsgAdicional := TEFREC_MENSAGEM_OBJETO_ECF_NULL;
      Exit;
    End;

    If (Not VS_objFiscal.fValidaSerieECFEmpresa(strNumSer)) Then
    Begin
      Result := False;
      strMsgAdicional := 'O número de série "' + strNumSer + '" não foi encontrado nos dados da ECF da empresa "' + VS_strCodEmp + '".';
      Exit;
    End;

    If Not VS_objFiscal.fArquivoEcfIniValido(strArquivo) Then
    Begin
      Result := False;
      strMsgAdicional := TEFREC_MENSAGEM_ARQUIVO_ECF_INVALIDO + sLineBreak + TEFREC_MENSAGEM_OBJETO_ECF_NULL;

      If Not fEmptyStr(strArquivo) Then
        strMsgAdicional := strMsgAdicional + sLineBreak + 'Arquivo: ' + strArquivo;

      Exit;
    End;
  End;

  pMarcarComoTemQueConfirmar;

  While (Not objTef.fTefFinRet(True)) Do
  Begin
    Application.ProcessMessages;
  End;

  pMarcarComoNadaAFazer;

  Result := True;

{  Result := objTef.fTefFinRet(True);

  If Not Result Then
  Begin
    objTef.pVerificaCncNcn;
  End
  Else
    pMarcarComoNadaAFazer;}

end;

function TTefRecebimento.fStatusPendencia: String;
  Var
    stlArq: TStringList;
    strArquivo: string;
begin
  Result := '';
  strArquivo := fArquivoDeMarcacao;
  If FileExists(strArquivo) Then
  Begin
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strArquivo);

    if stlArq.Count > 0 then
      Result := stlArq[0];

    FreeAndNil(stlArq);
  End;
end;

function TTefRecebimento.fVerificaPendencias: Boolean;
begin
  If fStatusPendencia = TEFREC_STATUS_CANCELAR Then
  Begin
    objTef.pVerificaCncNcn;
  End
  Else If fStatusPendencia = TEFREC_STATUS_CONFIRMAR Then
  Begin
    objTef.pEnviaConfirmacoesPendentes;
    If Assigned(VS_objFiscal) Then
    Begin
      VS_objFiscal.fFechaCNFVinculado(False); //alex relger
      VS_objFiscal.fFechaRelatorioGerencial(False);
    End;
    pMarcarComoNadaAFazer;
    fMensagem('', 'Última transação foi confirmada. Verificar: '+#13+
                ' - Se houve baixa do estoque. '+#13+
                ' - Se foi feito o registro do recebimento no resumo de caixa. '+#13+
                ' - A movimentação do cartão na manutenção de cartões. '+#13+
                ' - O comprovante da transação TEF.', ['&Ok']);
  End;
  Result := false;
end;

procedure TTefRecebimento.pCriarArquivoMarcacao(strStatus: String);
  Var
    stlArq: TStringList;
begin
  stlArq := TStringList.Create;
  stlArq.Add(strStatus);
  stlArq.SaveToFile(fArquivoDeMarcacao);
  FreeAndNil(stlArq);
end;

procedure TTefRecebimento.pMarcarComoNadaAFazer;
begin
  SysUtils.DeleteFile(fArquivoDeMarcacao);
end;

procedure TTefRecebimento.pMarcarComoTemQueCancelar;
begin
  pCriarArquivoMarcacao(TEFREC_STATUS_CANCELAR);
end;

procedure TTefRecebimento.pMarcarComoTemQueConfirmar;
begin
  pCriarArquivoMarcacao(TEFREC_STATUS_CONFIRMAR);
end;

function TTefRecebimento.fArquivoDeMarcacao: String;
begin
  Result := ExtractFilePath(Application.ExeName) + '.RECTEF';
end;

{ TTefRecebimentoVazio }

function TTefRecebimentoVazio.fAdicionarRecebimento(fltValor: Double; Var strArquivo: String): Boolean;
begin
  Result := True;
  strArquivo := '';
end;

function TTefRecebimentoVazio.fCancelarRecebimento(strArquivo: String): Boolean;
begin
  Result := True;
end;

function TTefRecebimentoVazio.fConfirmaCartoes(var strMsgAdicional: String): Boolean;
begin
  strMsgAdicional := '';
  Result := True;
end;

function TTefRecebimentoVazio.fVerificaPendencias: Boolean;
begin
  Result := True;
end;

end.
