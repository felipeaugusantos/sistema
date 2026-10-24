unit untNetpointsWS;

interface

uses System.Classes, Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient,
     Soap.XSBuiltIns, untAssociadoServiceEndpointImpl, untAssociadoCompletoComAcumulo,
     untNetpointsTypes, untConfirmacaoAcumuloOnline;

type
  TNetpointsWS = Class(TComponent)
  private
    FCnpjParceiro : String;
    FUrlWsAssociadoServiceEndpointImpl : String;
    FUrlWsAssociadoCompletoComAcumulo : String;
    FUrlWsConfirmacaoAcumuloOnline : String;
    function fProcessaRetorno(objErro: TRemotable): String;// erro2
    function fGetTipoPagtoAssociadoCompletoComAcumulo(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_: String; blnDevolu: Boolean; strCnParc: String): untAssociadoCompletoComAcumulo.Array_Of_tipoPagamentoAcumuloOnline;
    function fGetTipoPagtoConfirmacaoAcumuloOnline(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_: String; blnDevolu: Boolean; strCnParc: String): untConfirmacaoAcumuloOnline.Array_Of_tipoPagamentoAcumuloOnline;
    function fGetSQLModalidade(strSerie_: String): String;
    procedure pMensagemErroTratada(strMensagem, strLocal: String);
  public
    function fCadastrarCliente(strCpfCli, strFonCli, strCpfOpe: String; dtaDtaNascto: TDateTime; blnMsgRet: Boolean = True; strCnParc: String = ''): Boolean;
    function fClienteCadastrado(strCpfCli: String; blnRetMsg: Boolean; var intQtdNps: Integer): Boolean;

    function fAcionarAcumuloOnLine(strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie_, strCpfCli, strCpfVen, strIdePdv: String; dtaDtaPed: TDateTime;
      fltValTot: Double; var intQtdNps: Integer; var strMensag: String; blnDevolu: Boolean;
      strCnParc: String; intNsuParc: Integer): TTipoStatusNps;

    function fConfirmacaoEDesfazimentoDeAcumulo(tipTipTra: TTipoTransacaoAcumulo; strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie_, strCpfCli, strCpfVen, strIdePdv: String; fltTotPro: Double;
      dtaDtaEnt: TDateTime; var intQtdNps: Integer; var strMensag: String; blnDevolu: Boolean;
      strCnParc: String; intNsuParc: Integer): TTipoStatusNps;

    constructor Create(AOwner: TComponent; strCodEmp: String); reintroduce;
    destructor Destroy; override;
  End;

function StringToXSDecimal(strValue: String): TXSDecimal;
function DoubleToXSDecimal(fltValue: Double): TXSDecimal;

implementation

{ TNetpointsWS }

uses untFuncoesSimples, System.SysUtils, Uni, Variants;

constructor TNetpointsWS.Create(Aowner: TComponent; strCodEmp: String);
begin
  Inherited Create(AOwner);

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  FCnpjParceiro := fCfgSis('CGCNPS', varString, strCodEmp);
  If fEmptyStr(FCnpjParceiro) Then
    FCnpjParceiro := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]);

  FUrlWsAssociadoServiceEndpointImpl := '';
  FUrlWsAssociadoCompletoComAcumulo := '';
  FUrlWsConfirmacaoAcumuloOnline := '';

  If (fCfgSis('HOMNPS') = 'N') Then
  Begin
    FUrlWsAssociadoServiceEndpointImpl := URL_WS_NETPONTS_PRODUCAO + 'AssociadoServiceEndpointImpl?wsdl';
    FUrlWsAssociadoCompletoComAcumulo  := URL_WS_NETPONTS_PRODUCAO + 'AssociadoCompletoComAcumulo?wsdl';
    FUrlWsConfirmacaoAcumuloOnline     := URL_WS_NETPONTS_PRODUCAO + 'ConfirmacaoAcumuloOnline?wsdl';
  End;
end;

destructor TNetpointsWS.Destroy;
begin
  inherited Destroy;
end;

function TNetpointsWS.fAcionarAcumuloOnLine(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie_, strCpfCli, strCpfVen, strIdePdv: String;
  dtaDtaPed: TDateTime; fltValTot: Double; var intQtdNps: Integer;
  var strMensag: String; blnDevolu: Boolean; strCnParc: String; intNsuParc: Integer): TTipoStatusNps;
  Var
    objServic : AssociadoCompletoComAcumuloServiceEndpoint;
    objRequis : consultaAssociadoCompletoComAcumuloRequest;
    objRespos : consultaAssociadoCompletoComAcumuloResponse;
    objArrTipoPagto : untAssociadoCompletoComAcumulo.Array_Of_tipoPagamentoAcumuloOnline;
    objAcumul : untAssociadoCompletoComAcumulo.acumuloOnlineRequest;
    intCnt : Integer;
begin
  intQtdNps := 0;
  strMensag := '';
  Result := tsnNull;
  objRequis := consultaAssociadoCompletoComAcumuloRequest.Create;
  objAcumul := untAssociadoCompletoComAcumulo.acumuloOnlineRequest.Create;
  Try
    Try
      With objRequis Do
      Begin
        atendente := strCpfVen;
        cnpj := StringToXSDecimal(strCnParc);
        cpf := StringToXSDecimal(strCpfCli);

        With objAcumul Do
        Begin
          dataPedido := DateTimeToXSDateTime(dtaDtaPed);
          nsuParceiro := IntToStr(intNsuParc);
          nuPdv := strIdePdv;
          valorTotal := DoubleToXSDecimal(fltValTot);

          objArrTipoPagto := fGetTipoPagtoAssociadoCompletoComAcumulo(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_, blnDevolu, strCnParc);

          tipoPagamento := objArrTipoPagto;
        End;

        acumuloOnline := objAcumul;
      End;

      objServic := GetAssociadoCompletoComAcumuloServiceEndpoint(True, FUrlWsAssociadoCompletoComAcumulo);
      objRespos := objServic.consultarStatusAssociadoCompletoComAcumulo(objRequis);

      If (objRespos.acumuloOnline.status = STATUS_ACUMULO_ONLINE_SUCESSO) Then
        Result := tsnAcumulado;

      If (Result <> tsnAcumulado) Then
      Begin
        If Assigned(objRespos.erro) Then
        Begin
          If (objRespos.erro.codigo = STATUS_ERRO_OBRIGATORIEDADE) Then
          Begin
            Result := tsnPendenteDeAcumulo;
          End
          Else If (objRespos.erro.codigo = STATUS_ERRO_INCONSISTENCIA) Then
          Begin
            Result := tsnPendenteDeAcumulo;

            If (Pos('Acumulo ja enviado', objRespos.erro.descricao) > 0) Then
            Begin
              Result := tsnAcumuloJaEnviado;
              //Valor de Pontos que será dado ao associado!!!!!
              intQtdNps := objRespos.acumuloOnline.qtPontos;
            End;
          End
          Else If (objRespos.erro.codigo = STATUS_ACUMULO_JA_ENVIADO) Then
          Begin
            Result := tsnAcumuloJaEnviado;
            //Valor de Pontos que será dado ao associado!!!!!
            intQtdNps := objRespos.acumuloOnline.qtPontos;
          End;
        End;

        strMensag := fProcessaRetorno(objRespos.erro);
      End
      Else
      Begin
        //Valor de Pontos que será dado ao associado!!!!!
        intQtdNps := objRespos.acumuloOnline.qtPontos;
      End;
    Except
      On E: Exception Do
      Begin
        intQtdNps := 0;
        Result := tsnPendenteDeAcumulo;
        strMensag := E.Message;
      End;
    End;
  Finally
    FreeAndNil(objRequis);
    For intCnt := 0 To Length(objArrTipoPagto)-1 Do
      FreeAndNil(objArrTipoPagto[intCnt]);
    SetLength(objArrTipoPagto, 0);
  End;
end;

function TNetpointsWS.fCadastrarCliente(strCpfCli, strFonCli, strCpfOpe: String; dtaDtaNascto: TDateTime; blnMsgRet: Boolean = True; strCnParc: String = ''): Boolean;
  Var
    objServic : AssociadoServiceEndpoint;
    objRequis : cadastroAssociadoRequest2;
    objRespos : cadastroAssociadoResponse2;
    strRespos : String;
begin
  objRequis := cadastroAssociadoRequest2.Create;
  Try
    Try
      With objRequis Do
      Begin
        cpf := StringToXSDecimal(strCpfCli);

        If Not fEmptyStr(strCnParc) Then
          cnpj := StringToXSDecimal(strCnParc)
        Else
          cnpj := StringToXSDecimal(FCnpjParceiro);

        telefone := StringToXSDecimal(strFonCli);
        dataNascimento := DateTimeToXSDateTime(dtaDtaNascto);
        funcionarioParceiro := strCpfOpe;
      End;

      objServic := GetAssociadoServiceEndpoint(True, FUrlWsAssociadoServiceEndpointImpl);
      objRespos := objServic.cadastrarAssociado(objRequis);

      Result := (objRespos.status = STATUS_ASSOCIADO_CADASTRADO_COM_SUCESSO);

      If (Not Result) Then
      Begin
        strRespos := fProcessaRetorno(objRespos.erro);
        If (Not fEmptyStr(strRespos)) And (blnMsgRet) Then
          fMensagem('', strRespos, ['&OK']);
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        If (blnMsgRet) Then
          pMensagemErroTratada(E.Message, '[TNetpointsWS.fCadastrarCliente]');
      End;
    End;
  Finally
    FreeAndNil(objRequis);
  End;
end;

function TNetpointsWS.fClienteCadastrado(strCpfCli: String; blnRetMsg: Boolean; var intQtdNps: Integer): Boolean;
  Var
    objServic : AssociadoServiceEndpoint;
    objRequis : consultaAssociadoRequest;
    objRespos : consultaAssociadoResponse2;
    strRespos : String;
begin
  objRequis := consultaAssociadoRequest.Create;
  Try
    Try
      intQtdNps := 0;

      With objRequis Do
      Begin
        cpf := StringToXSDecimal(strCpfCli);
        cnpj := StringToXSDecimal(FCnpjParceiro);
      End;

      objServic := GetAssociadoServiceEndpoint(True, FUrlWsAssociadoServiceEndpointImpl);
      objRespos := objServic.consultarStatusAssociado(objRequis);

      Result := Not ((objRespos.status = STATUS_ASSOCIADO_NAO_CADASTRADO_1) Or
                     (objRespos.status = STATUS_ASSOCIADO_NAO_CADASTRADO_2));

      If (Not Result) Then
      Begin
        If (blnRetMsg) Then
        Begin
          strRespos := fProcessaRetorno(objRespos.erro);
          If Not fEmptyStr(strRespos) Then
            fMensagem('', strRespos, ['&OK']);
        End;
      End
      Else
        intQtdNps := objRespos.saldoPontosNP;
    Except
      On E: Exception Do
      Begin
        intQtdNps := 0;
        Result := False;
        If (blnRetMsg) Then
          pMensagemErroTratada(E.Message, '[TNetpointsWS.fClienteCadastrado]');
      End;
    End;
  Finally
    FreeAndNil(objRequis);
  End;
end;

function TNetpointsWS.fConfirmacaoEDesfazimentoDeAcumulo(tipTipTra: TTipoTransacaoAcumulo; strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie_, strCpfCli, strCpfVen, strIdePdv: String; fltTotPro: Double;
  dtaDtaEnt: TDateTime; var intQtdNps: Integer; var strMensag: String; blnDevolu: Boolean;
  strCnParc: String; intNsuParc: Integer): TTipoStatusNps;
  Var
    objServic : ConfirmacaoAcumuloOnlineServiceEndpoint;
    objRequis : confirmacaoAcumuloOnlineRequest;
    objRespos : acumuloOnlineConfirmacaoResponse;
    objArrTipoPagto : untConfirmacaoAcumuloOnline.Array_Of_tipoPagamentoAcumuloOnline;
    objAcumul : untConfirmacaoAcumuloOnline.acumuloOnlineRequest;
    intCnt : Integer;
begin
  intQtdNps := 0;
  strMensag := '';
  Result := tsnNull;
  objRequis := confirmacaoAcumuloOnlineRequest.Create;
  objAcumul := untConfirmacaoAcumuloOnline.acumuloOnlineRequest.Create;
  Try
    Try
      With objRequis Do
      Begin
        cnpj := StringToXSDecimal(strCnParc);
        cpf := StringToXSDecimal(strCpfCli);
        atendente := strCpfVen;

        With objAcumul Do
        Begin
          nsuParceiro := IntToStr(intNsuParc);
          nuPdv := strIdePdv;
          valorTotal := DoubleToXSDecimal(fltTotPro);
          tipoTransacao := STATUS_TIPO_TRA_ACUM[tipTipTra];
          dataPedido := DateTimeToXSDateTime(dtaDtaEnt);

          objArrTipoPagto := fGetTipoPagtoConfirmacaoAcumuloOnline(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_, blnDevolu, strCnParc);

          tipoPagamento := objArrTipoPagto;
        End;

        acumuloOnline := objAcumul;
      End;

      objServic := GetConfirmacaoAcumuloOnlineServiceEndpoint(True, FUrlWsConfirmacaoAcumuloOnline);
      objRespos := objServic.confirmacaoAcumuloOnline(objRequis);

      If (objRespos.acumuloOnline.status = STATUS_ACUMULO_ONLINE_SUCESSO) Then
      Begin
        Case tipTipTra Of
          ttaConfirmacaoAcumulo: Result := tsnAcumulado;
          ttaDesfazimentoAcumulo: Result := tsnCancelado;
        End;
      End;

      If (Not (Result In [tsnAcumulado, tsnCancelado])) Then
      Begin
        If Assigned(objRespos.erro) Then
        Begin
          If (objRespos.erro.codigo = STATUS_ERRO_OBRIGATORIEDADE) Then
          Begin
            Case tipTipTra Of
              ttaConfirmacaoAcumulo: Result := tsnPendenteDeAcumulo;
              ttaDesfazimentoAcumulo: Result := tsnPendenteDesfazimento;
            End;
          End
          Else If (objRespos.erro.codigo = STATUS_ERRO_INCONSISTENCIA) Then
          Begin
            Case tipTipTra Of
              ttaConfirmacaoAcumulo: Result := tsnPendenteDeAcumulo;
              ttaDesfazimentoAcumulo: Result := tsnPendenteDesfazimento;
            End;

            If (Pos('Acumulo ja enviado', objRespos.erro.descricao) > 0) Then
            Begin
              Result := tsnAcumuloJaEnviado;
              //Valor de Pontos que será dado ao associado!!!!!
              intQtdNps := objRespos.acumuloOnline.qtPontos;
            End;
          End
          Else If (objRespos.erro.codigo = STATUS_ACUMULO_JA_ENVIADO) Then
          Begin
            Result := tsnAcumuloJaEnviado;
            //Valor de Pontos que será dado ao associado!!!!!
            intQtdNps := objRespos.acumuloOnline.qtPontos;
          End
          Else If (objRespos.erro.codigo = STATUS_ACUMULO_NAO_ENCONTRADO_PARA_ESTORNO) Then
          Begin
            Result := tsnAcumuloNaoEncontradoParaEstorno;
          End;
        End;

        strMensag := fProcessaRetorno(objRespos.erro);
      End
      Else
      Begin
        //Valor de Pontos que será dado ao associado!!!!!
        intQtdNps := objRespos.acumuloOnline.qtPontos;
      End;
    Except
      On E: Exception Do
      Begin
        intQtdNps := 0;
        Case tipTipTra Of
          ttaConfirmacaoAcumulo: Result := tsnPendenteDeAcumulo;
          ttaDesfazimentoAcumulo: Result := tsnPendenteDesfazimento;
        End;
        strMensag := E.Message;
      End;
    End
  Finally
    FreeAndNil(objRequis);
    For intCnt := 0 To Length(objArrTipoPagto)-1 Do
      FreeAndNil(objArrTipoPagto[intCnt]);
    SetLength(objArrTipoPagto, 0);
  End;
end;

function TNetpointsWS.fGetSQLModalidade(strSerie_: String): String;
begin
  Result := '';
  Result := Result + ' SELECT * ';
  Result := Result + '   FROM MOVMOD ';
  Result := Result + '  WHERE MOD_NUMDOC = :NUMDOC ';
  Result := Result + '    AND MOD_ESPDOC = :ESPDOC ';
  Result := Result + '    AND MOD_CODEMP = :CODEMP ';
  Result := Result + '    AND MOD_CODCLI = :CODCLI ';

  If Not fEmptyStr(strSerie_) Then
    Result := Result + ' AND MOD_SERIE_ = :SERIE_ '
  Else
    Result := Result + ' AND MOD_SERIE_ IS NULL ';
end;

function TNetpointsWS.fGetTipoPagtoAssociadoCompletoComAcumulo(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strSerie_: String; blnDevolu: Boolean; strCnParc: String): untAssociadoCompletoComAcumulo.Array_Of_tipoPagamentoAcumuloOnline;
  Var
    qryMovMod : TUniQuery;
begin
  qryMovMod := fCriaQuery(Self);
  Try
    With qryMovMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLModalidade(strSerie_));
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If Params.FindParam('SERIE_') <> Nil Then
        ParamByName('SERIE_').AsString := strSerie_;

      Open;

      // valpag   ou   valmod ??
      First;
      While Not Eof Do
      Begin

        If (FieldByName('MOD_VALMOD').AsFloat > 0) Then
        Begin
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := untAssociadoCompletoComAcumulo.tipoPagamentoAcumuloOnline.Create;
          Result[Length(Result) - 1].cnpjPagamento := StringToXSDecimal(strCnParc);

          If (FieldByName('MOD_CODMOD').AsString = '007') Then
            Result[Length(Result) - 1].idPagamento := STATUS_TIPO_ID_PAGTO[tipCartao]
          Else
            Result[Length(Result) - 1].idPagamento := STATUS_TIPO_ID_PAGTO[tipVarejo];

          Result[Length(Result) - 1].valorPagamento := DoubleToXSDecimal(IIF(blnDevolu, -Abs(FieldByName('MOD_VALMOD').AsFloat), FieldByName('MOD_VALMOD').AsFloat));
        End;

        Next;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryMovMod);
  End;
end;

function TNetpointsWS.fGetTipoPagtoConfirmacaoAcumuloOnline(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strSerie_: String; blnDevolu: Boolean; strCnParc: String): untConfirmacaoAcumuloOnline.Array_Of_tipoPagamentoAcumuloOnline;
  Var
    qryMovMod : TUniQuery;
begin
  qryMovMod := fCriaQuery(Self);
  Try
    With qryMovMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLModalidade(strSerie_));
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If Params.FindParam('SERIE_') <> Nil Then
        ParamByName('SERIE_').AsString := strSerie_;

      Open;

      // valpag   ou   valmod ??
      First;
      While Not Eof Do
      Begin

        If (FieldByName('MOD_VALMOD').AsFloat > 0) Then
        Begin
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := untConfirmacaoAcumuloOnline.tipoPagamentoAcumuloOnline.Create;
          Result[Length(Result) - 1].cnpjPagamento := StringToXSDecimal(strCnParc);

          If (FieldByName('MOD_CODMOD').AsString = '007') Then
            Result[Length(Result) - 1].idPagamento := STATUS_TIPO_ID_PAGTO[tipCartao]
          Else
            Result[Length(Result) - 1].idPagamento := STATUS_TIPO_ID_PAGTO[tipVarejo];

          Result[Length(Result) - 1].valorPagamento := DoubleToXSDecimal(IIF(blnDevolu, -Abs(FieldByName('MOD_VALMOD').AsFloat), FieldByName('MOD_VALMOD').AsFloat));
        End;

        Next;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryMovMod);
  End;
end;

function TNetpointsWS.fProcessaRetorno(objErro: TRemotable): String;
begin
  Result := '';
  If Assigned(objErro) Then
  Begin
    Result := Result + 'Código: '    + IntToStr(erro2(objErro).codigo) + sLineBreak;
    Result := Result + 'Categoria: ' + erro2(objErro).categoria + sLineBreak;
    Result := Result + 'Descrição: ' + erro2(objErro).descricao;
  End;
end;

procedure TNetpointsWS.pMensagemErroTratada(strMensagem, strLocal: String);
  Var
    strMsg : String;
begin
  If Pos('Unable to load WSDL File/Location', strMensagem) > 0 Then
    strMsg := 'Serviço indisponível no momento' + sLineBreak + 'Mensagem de Erro Original: ' + sLineBreak + strMensagem
  Else
    strMsg := strMensagem;

  pMensagensErro(strMsg, strLocal);
end;

function StringToXSDecimal(strValue: String): TXSDecimal;
begin
  Result := TXSDecimal.Create;
  If Not fEmptyStr(strValue) Then
    Result.AsBCD := fStrToFloat(strValue);
end;

function DoubleToXSDecimal(fltValue: Double): TXSDecimal;
begin
  Result := TXSDecimal.Create;
  Result.AsBCD := fltValue;
end;

end.
