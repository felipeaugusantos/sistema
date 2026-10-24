unit untControlaNotSaldoMin;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  cxProgressBar, Forms, untFuncoesSimples,
{$ENDIF}
  uni, System.SysUtils, System.Classes, Data.DB, untMsgInterna;

  Type
    TArrCodOpe = array of string;

    TControlaNotificacaoSaldoMin = Class
    Private
      qryConsulta: TUniQuery;
      qryItens   : TUniQuery;
      arrCodOpe: TArrCodOpe;
      FstrCodite: String;
      FblnGeraNotificacao: Boolean;
      FblnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin: Boolean;
      msgMensagem: TMsgInterna;
      stlMensagem: TStringList;
      procedure pSetStrCodIte(const Value: string);
      function fCarregarOperadoresCadastradosComNotificacao: boolean;
      //Apos gerar a notificação desabilita no item a necessidade de gerar novamente a notificação
      //enquanto o saldo dele continuar abaixo do minimo
      procedure pDesativaNotificacao;
      // função que de fato gerar a notificação desde que blnGeraNotificao = True
      function  fProcessarGeracaoDeNotificao(prgBarra: TCxProgressBar): boolean;
      function fGetQtdOpe: Boolean;
      function fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC: String; strEmpSubtraiPedTransf: String = ''): String;
      function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean; strSQLCodSim: String = ''): String;
    public
      constructor create();
      destructor Destroy; override;
      // Chama uma tela com um grid mostrando todos os itens ativos com saldo abaixo do minimo
      // de toda a base separado por empresa e fornecedor
      class procedure pExbirProdutosComSaldoAbaixoMinimo(strCodOpe: string);
      // função chamada para gerar a notificação desde que blnGeraNotificao = True
      function fGerarNotificacoes: boolean;
      // Informa o item que devera ser gerado a notificação
      property strCodIte: string read FstrCodIte write pSetStrCodIte;
      //variavel para saber se esta apto para gerar a notificação
      property blnGeraNotificacao: Boolean read FblnGeraNotificacao;
      //variavel para saber se tem ao menos um operador disponivel para receber a notificação
      property blnTemOperadorParaReceberNotificacao: Boolean read fGetQtdOpe;
      //indica se a fProcessarGeracaoDeNotificao devolverá false caso não consiga enviar a notificação;
      property blnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin: Boolean read FblnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin write FblnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin;
  End;

implementation

{ TControlaNotificacaoSaldoMin }

{$IFNDEF LINUX}
uses untGravando, untFuncoesRel, untFuncoesRel2;
{$ENDIF}

constructor TControlaNotificacaoSaldoMin.Create();
begin
  qryConsulta := fCriaQuery;
  qryItens    := fCriaQuery;
  FblnGeraNotificacao := False;
  FblnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin := False;
  fCarregarOperadoresCadastradosComNotificacao;
  msgMensagem := TMsgInterna.Create(nil);
  stlMensagem := TStringList.Create();
end;

destructor TControlaNotificacaoSaldoMin.Destroy;
begin
  SetLength(arrCodOpe, 0);
  FreeAndNil(qryConsulta);
  FreeAndNil(msgMensagem);
  FreeAndNil(stlMensagem);
  FreeAndNil(qryItens);
end;

function TControlaNotificacaoSaldoMin.fGerarNotificacoes: boolean;
{$IFNDEF LINUX}
 var
   frmGranvandoLocal: TfrmGravando;
{$ENDIF}
begin
  Result := blnGeraNotificacao;
  If Not Result Then
    Exit;

{$IFDEF LINUX}
  try
    Result := fProcessarGeracaoDeNotificao(nil);
  finally
    if Result Then
      pDesativaNotificacao;
  end;
{$ELSE}
  pCriarFormularios(TfrmGravando, frmGranvandoLocal);
  Try
    frmGranvandoLocal.strChave := 'GERANDO MENSAGEM DE PRODUTO COM ESTOQUE ABAIXO DO MÍNIMO.';
    frmGranvandoLocal.lblGravando.Caption := 'Gerando mensagem de produto com estoque abaixo do mínimo.';
    frmGranvandoLocal.fExecutarAcao := fProcessarGeracaoDeNotificao;
    frmGranvandoLocal.ShowModal;
    Result :=  frmGranvandoLocal.blnConfirma;
  Finally
    FreeAndNil(frmGranvandoLocal);
    If Result Then
      pDesativaNotificacao;
  End;
{$ENDIF}
end;

function TControlaNotificacaoSaldoMin.fGetQtdOpe: Boolean;
begin
  //arrCodOpe alimentado em fCarregarOperadoresCadastradosComNotificacao;
  Result := High(arrCodOpe) >=0 ;
end;

function TControlaNotificacaoSaldoMin.fProcessarGeracaoDeNotificao(prgBarra: TCxProgressBar): boolean;
  Var
    i: integer;
    blnEnviouNotificaoItensAbaixoMin: Boolean;

  procedure pMontaMensagem;
  Begin
    stlMensagem.Add('Empresa         : ' + qryItens.FieldByName('CODEMP').AsString + ' - ' +
                                           qryItens.FieldByName('NOMFAN').AsString);
    stlMensagem.Add('Fornecedor      : ' + qryItens.FieldByName('CODFOR').AsString + ' - ' +
                                           qryItens.FieldByName('NOMFOR').AsString);
    stlMensagem.Add('Produto         : ' + qryItens.FieldByName('CODITE').AsString + ' - ' +
                                           qryItens.FieldByName('DESITE').AsString);
    stlMensagem.Add('Estoque Mínimo  : ' +  FormatFloat('#0.000', qryItens.FieldByName('ESTMIN').AsFloat));
    stlMensagem.Add('Saldo de Estoque: ' +  FormatFloat('#0.000', qryItens.FieldByName('SALDOS').AsFloat));
    stlMensagem.Add('Pedido de Compra: ' +  FormatFloat('#0.000', qryItens.FieldByName('PEDCOM').AsFloat));
    stlMensagem.Add('Ped Compra Geral: ' +  FormatFloat('#0.000', qryItens.FieldByName('PEDCOMGER').AsFloat));
    stlMensagem.Add('Referência      : ' + qryItens.FieldByName('REFERE').AsString);
    stlMensagem.Add('Código de Barras: ' + qryItens.FieldByName('CODBAR').AsString);
    stlMensagem.Add('Código de Fábric: ' + qryItens.FieldByName('CODFAB').AsString);
    stlMensagem.Add('Marca           : ' + qryItens.FieldByName('CODMAR').AsString + ' - ' +
                                           qryItens.FieldByName('DESMAR').AsString);
  End;

begin
  Try
    Result := True;
    prgBarra.Properties.Max := High(arrCodOpe);
    pMontaMensagem;
    //Se tiver grupo de compra e o grupo de compra tiver operador responsavel
    If (Not fEmptyStr(qryItens.FieldByName('ITE_GRUCMP').AsString)) And
       (Not fEmptyStr(qryItens.FieldByName('GRU_OPERES').AsString)) Then
    Begin
      blnEnviouNotificaoItensAbaixoMin :=
        msgMensagem.fEnviaMensagem('PRODUTO COM ESTOQUE ABAIXO DO ESTOQUE MÍNIMO',
                                   stlMensagem.Text,
                                   strLoginUsuarioLogado,
                                   qryItens.FieldByName('GRU_OPERES').AsString,
                                   'N',
                                   '');
      If (FblnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin) And (Not blnEnviouNotificaoItensAbaixoMin) Then
        Result := False;
    End
    Else
    Begin
      //todos os operadores configurados para receber a notificação
      For i := low(arrCodOpe) To High(arrCodOpe) Do
      Begin
        blnEnviouNotificaoItensAbaixoMin :=
          msgMensagem.fEnviaMensagem('PRODUTO COM ESTOQUE ABAIXO DO ESTOQUE MÍNIMO',
                                      stlMensagem.Text,
                                      strLoginUsuarioLogado,
                                      arrCodOpe[i],
                                      'N',
                                      '');
        If (FblnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin) And (Not blnEnviouNotificaoItensAbaixoMin) Then
          Result := False;

        prgBarra.Position := prgBarra.Position + 1;
        Application.processmessages;
      End;
    End;

  Except
    On E: Exception do
    begin
		    pMensagensErro(E.Message, '[TControlaNotificacaoSaldoMin.fProcessarGeracaoDeNotificao]');
      Result := False;
    End;
  End;
end;

function TControlaNotificacaoSaldoMin.fSQLCamposQuantidadePendenteCompra(
  blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC,
  strEmpSubtraiPedTransf: String): String;
begin
  Result := '';
  Result := Result + IIF(blnSoma, ' SUM(', ' (');

  Result := Result + 'IFNULL(';

  Result := Result + 'IFNULL(' + strAliasSALPDC + '.SAL_NFILIB, 0) ';

  If Not blnFiltraTE Then
    Result := Result + ' + IFNULL(' + strAliasSALPDC + '.SAL_FILLIB, 0) '
  Else iF blnFiltraTE And (not fEmptyStr(strEmpSubtraiPedTransf)) Then
    Result := Result + ' + IF(LOCATE(' + strAliasSALPDC + '.SAL_CODEMP, "' + strEmpSubtraiPedTransf + '") > 0, 0, IFNULL('  + strAliasSALPDC + '.SAL_FILLIB, 0)) ';

  If Not (blnLibPcm And fCfgSis('LIBPCM', varBoolean)) Then
  Begin
    Result := Result + ' + IFNULL(' + strAliasSALPDC + '.SAL_NFINLI, 0) ';

    If Not blnFiltraTE Then
      Result := Result + ' + IFNULL(' + strAliasSALPDC + '.SAL_FILNLI, 0) ';
  End;

  Result := Result + ', 0)';

  Result := Result +  ') ';
end;

function TControlaNotificacaoSaldoMin.fSQLQuantidadePendenteCompra(strSQLCodIte,
  strSQLCodEmp: String; blnCheckLibPcm, blnFiltraTE: Boolean;
  strSQLCodSim: String): String;
begin
  Result := '';
  Result := Result + ' IFNULL((SELECT ';

  Result := Result + '   SUM( ';

  Result := Result + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, blnFiltraTE, blnCheckLibPcm, 'SP');

  Result := Result + '   ) ';

  Result := Result + '   FROM ';
  Result := Result + '     SALPDC SP ';

  If Not fEmptyStr(strSQLCodSim) Then
    Result := Result + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = SP.SAL_CODITE ';

  Result := Result + '   WHERE ';

  If fEmptyStr(strSQLCodSim) Then
    Result := Result + '     SP.SAL_CODITE = ' + strSQLCodIte
  Else
    Result := Result + '     CS.ITE_CODSIM = ' + strSQLCodSim;

  If Not fEmptyStr(strSQLCodEmp) Then
  Begin
    Result := Result + '  AND SP.SAL_CODEMP = ITEGER.ITE_CODEMP ';
  End;

  Result := Result + ' ), 0) ';
end;

procedure TControlaNotificacaoSaldoMin.pSetStrCodIte(const Value: string);
  function fGerarNotificacao: Boolean;
  Begin
    //Verifica se o item esta apto para receber a notificação
    Result := (qryItens.FieldByName('ITE_NOTESM').AsString = 'S') And
              (qryItens.FieldByName('SALDOS').AsFloat <
              qryItens.FieldByName('ESTMIN').AsFloat);
    // Se o item tiver grupo de compra apenas é para enviar a notificação para o
    //Responsavel do grupo de compra, e ele deve ter a configuração
    // 'Receber mensagem de Produto com estoque abaixo do Estoque Mínimo'
    If Result And (Not fEmptyStr(qryItens.FieldByName('ITE_GRUCMP').AsString)) Then
      Result := qryItens.FieldByName('OPE_ITEMIN').AsString = 'S';
  End;

begin
  If blnTemOperadorParaReceberNotificacao Then
  begin
    FstrCodIte := Value;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT ITEGER.ITE_SALDOS AS SALDOS,');
    qryItens.SQL.Add('       ITEGER.ITE_ESTMIN AS ESTMIN,');
    qryItens.SQL.Add('       CADITE.ITE_CODITE AS CODITE,');
    qryItens.SQL.Add('       CADITE.ITE_DESITE AS DESITE,');
    qryItens.SQL.Add('       CADITE.ITE_CODFOR AS CODFOR,');
    qryItens.SQL.Add('       CADFOR.FOR_NOMFOR AS NOMFOR,');
    qryItens.SQL.Add('       CADEMP.EMP_NOMFAN AS NOMFAN,');
    qryItens.SQL.Add('       CADEMP.EMP_CODEMP AS CODEMP,');
    qryItens.SQL.Add('       ITEGER.ITE_NOTESM,');
    qryItens.SQL.Add('       CADITE.ITE_GRUCMP,');
    qryItens.SQL.Add('              GRU_OPERES,');
    qryItens.SQL.Add('              OPE_ITEMIN,');
    qryItens.SQL.Add('       CADITE.ITE_REFERE AS REFERE,');
    qryItens.SQL.Add('       CADITE.ITE_CODFAB AS CODFAB,');
    qryItens.SQL.Add('       CADITE.ITE_CODBAR AS CODBAR,');
    qryItens.SQL.Add('       CADITE.ITE_CODMAR AS CODMAR,');
    qryItens.SQL.Add('       CADMAR.MAR_DESMAR AS DESMAR,');
    qryItens.SQL.Add(  fSQLQuantidadePendenteCompra('ITEGER.ITE_CODITE', VS_strCodEmp, False, True) + ' AS PEDCOM, ');
    qryItens.SQL.Add(  fSQLQuantidadePendenteCompra('ITEGER.ITE_CODITE', '', False, True)           + ' AS PEDCOMGER ');
    qryItens.SQL.Add('  FROM ITEGER ');
    qryItens.SQL.Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
    qryItens.SQL.Add('  LEFT JOIN GRU_COMPRA ON GRU_CODIGO = ITE_GRUCMP ');
    qryItens.SQL.Add('  LEFT JOIN CADFOR ON CADFOR.FOR_CODFOR = CADITE.ITE_CODFOR ');
    qryItens.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = GRU_OPERES ');
    qryItens.SQL.Add('  LEFT JOIN CADEMP ON EMP_CODEMP =ITEGER.ITE_CODEMP ');
    qryItens.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR =CADITE.ITE_CODMAR ');
    qryItens.SQL.Add(' WHERE ITEGER.ITE_CODITE = :CODITE ');
    qryItens.SQL.Add('   AND ITEGER.ITE_CODEMP = :CODEMP ');
    qryItens.ParamByName('CODITE').AsString := FstrCodIte;
    qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryItens.Open;
    FblnGeraNotificacao := fGerarNotificacao;
  End;
end;

function TControlaNotificacaoSaldoMin.fCarregarOperadoresCadastradosComNotificacao: boolean;
Begin
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT OPE_CODOPE');
  qryConsulta.SQL.Add('  FROM CADOPE');
  qryConsulta.SQL.Add(' WHERE OPE_ITEMIN = "S"');
  qryConsulta.SQL.Add('   AND LOCATE(:CODEMP, OPE_EMPESM) > 0 ');
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConsulta.Open;
  Result := Not qryConsulta.IsEmpty;

  If Result Then
  Begin
     SetLength(arrCodOpe, qryConsulta.RecordCount);

    While not qryConsulta.Eof do
    Begin
      arrCodOpe[qryConsulta.RecNo -1] := qryConsulta.FieldByName('OPE_CODOPE').AsString;
      qryConsulta.Next;
    End;
  End;
End;

procedure TControlaNotificacaoSaldoMin.pDesativaNotificacao;
Begin
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('UPDATE ITEGER SET ITE_NOTESM = "N"');
    qryConsulta.SQL.Add(' WHERE ITE_CODITE = :CODITE');
    qryConsulta.SQL.Add('   AND ITE_CODEMP = :CODEMP');
    qryConsulta.ParamByName('CODITE').AsString := FstrCodIte;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.ExecSQL;
  Except
    {}
  End;
End;

class procedure TControlaNotificacaoSaldoMin.pExbirProdutosComSaldoAbaixoMinimo(strCodOpe: string);
  var qrySQL : TUniQuery;
Begin
{$IFNDEF LINUX}
  If fEmptyStr(strCodOpe) Then
  begin

     If Assigned(prcExecutaRelatorio) Then
     begin
       prcExecutaRelatorio(145, 6722, [],
                           [],
                           [],
                           nil,
                           nil,
                           True);
     End;

  end
  Else
  Begin

    qrySQL := fCriaQuery;
    Try

      qrySQL.SQL.Text := 'SELECT OPE_ITEMIN FROM CADOPE WHERE OPE_CODOPE = ' + QuotedStr(strCodOpe);
      qrySQL.Open;

      If ((not qrySQL.IsEmpty) And
         (fCfgSis('EXIESM', VarBoolean)) And
         (qrySQL.FieldByName('OPE_ITEMIN').AsString = 'S')) Then
      begin

        If (fMensagem('Atenção', 'Deseja encontrar e visualizar produtos com saldo abaixo do estoque mínimo?', ['&Sim', '&Não'], 1) = 1) then
        Begin

          prcExecutaRelatorio(145, 6722, [],
                                [],
                                [],
                                nil,
                                nil,
                                True);

        End;

      end;

    Finally
      FreeAndNil(qrySQL);
    End;

  End;
{$ENDIF}
End;

end.
