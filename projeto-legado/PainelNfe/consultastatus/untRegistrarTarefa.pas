unit untRegistrarTarefa;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows, Dialogs, Forms,
{$ENDIF}
  Classes, DateUtils, SysUtils, strUtils, DB,

  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ;

type
  TRegistrarTarefa = class
    private
      FTarefa: String;
      FDescricao: String;
      FJaExecutando: Boolean;
      FBloquear: Boolean;
      FTerminar: Boolean;
      FOculInfo: Boolean;
      FProcessID: Integer;
      procedure pBloquearTerminarTarefa;
    public
      constructor Create(strTarefa: String);

      procedure pRegistrarTarefa;
      procedure pRemoverTarefa;

      procedure pSinalizarExecutando;
      procedure pAtualizarInformacao(AValue: string);

      property blnJaExecutando: Boolean Read FJaExecutando;
      property blnBloquear: Boolean Read FBloquear;  //Indica que NfeStatus.exe não pode mais fazer nada pois outro NfeStatus.exe entrou ou entrará em vigor
      property blnTerminar: Boolean Read FTerminar;  //Indica que NfeStatus.exe fará tudo o que tem que fazer e terminará após isso não aguardando o tempo limite
      property blnOculInfo: Boolean Read FOculInfo Write FOculInfo;
      property strDescricao: string Read FDescricao;
      property strTarefa: string Read FTarefa;
  end;

implementation

uses untDicSis, untLogDanfe;

constructor TRegistrarTarefa.Create(strTarefa: String);
begin
  FTarefa := Trim(ReplaceStr(strTarefa, VS_PidMD5DicSis, EmptyStr));

  FBloquear := False;
  FTerminar := False;
  FOculInfo := False;

  Try
    FProcessID := GetCurrentProcessId;
  Except
    FProcessID := 0;
  End;

  If Pos('NFE_PROCESSAR_STATUS', FTarefa) > 0 Then
  Begin
    FDescricao := FTarefa;

    If Pos('GE', FTarefa) > 0 Then
      FDescricao := 'Processando retorno de envio';

    If Pos('GC', FTarefa) > 0 Then
      FDescricao := 'Processando retorno de cancelamento';

    If Pos('GM', FTarefa) > 0 Then
      FDescricao := 'Processando retorno de manifesto eletronico';

    If Pos('AE', FTarefa) > 0 Then
      FDescricao := 'Enviando documento';
  End
  Else If Pos('NFE_COORDENADOR_STATUS', FTarefa) > 0 Then
  Begin
    FDescricao := 'Processando documentos pendentes';
  End
  Else If Pos('NFE_PENDENCIAS_DPEC', FTarefa) > 0 Then
  Begin
    FDescricao := 'Processando pendencias DPEC';
  End
  Else If Pos('NFE_ENVIAR_XML_SAT', FTarefa) > 0 Then
  Begin
    FDescricao := 'Enviando XML SAT pendentes';
  End
  Else If Pos('NFE_PAINEL_CITEL', FTarefa) > 0 Then
  Begin
    FDescricao := 'Processando integração Citel';
  End
  Else If Pos('NFE_LIMPAR_DANFES', FTarefa) > 0 Then
  Begin
    FDescricao := 'Apagando arquivos temporários DANFE';
  End
  Else If Pos('NFE_IMPORTAR_XML_TERCEIROS', FTarefa) > 0 Then
  Begin
    FDescricao := 'Importando XML de terceiros';
  End
  Else If Pos('NFE_CONFIRMAR_GRAVACAO_XML', FTarefa) > 0 Then
  Begin
    FDescricao := 'Confirmando gravação do XML';
  End
  Else If Pos('NFE_COMPLEMENTAR_DOCUMENTO', FTarefa) > 0 Then
  Begin
    FDescricao := 'Complementando dados do documento';
  End
  Else If Pos('NFE_AUDITAR_DOCUMENTO', FTarefa) > 0 Then
  Begin
    FDescricao := 'Auditando situação do documento';
  End
  Else If Pos('NFE_CONSULTA_CADASTRO', FTarefa) > 0 Then
  Begin
    FDescricao := 'Consultando situação cadastral destinatário';
  End
  Else If Pos('NFE_EMITENTE_CONSULTA_CADASTRO', FTarefa) > 0 Then
  Begin
    FDescricao := 'Consultando situação cadastral emitente';
  End;
end;

procedure TRegistrarTarefa.pAtualizarInformacao(AValue: string);
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If FOculInfo Then
    Exit;

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'UPDATE NFE_TAREFAS '+
                       '   SET NFE_DESCRI = :DESCRI '+
                       ' WHERE NFE_TAREFA = :TAREFA '+
                       '   AND NFE_DESCRI NOT IN ("'+consTagSinalParaTerminar+'","'+consTagSinalParaBloquear+'") ';
    qryGen.ParamByName('DESCRI').AsString := AValue;
    qryGen.ParamByName('TAREFA').AsString := FTarefa;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TRegistrarTarefa.pRegistrarTarefa;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery;

  frmModulo.Database.StartTransaction;
  Try
    qryGen.SQL.Add('INSERT INTO NFE_TAREFAS ( ');
    qryGen.SQL.Add('  NFE_TAREFA, ');
    qryGen.SQL.Add('  NFE_DESCRI, ');
    qryGen.SQL.Add('  NFE_PROCID, ');
    qryGen.SQL.Add('  NFE_CODEMP, ');
    qryGen.SQL.Add('  NFE_INICIO, ');
    qryGen.SQL.Add('  NFE_ULTSTA) ');
    qryGen.SQL.Add('VALUES (      ');
    qryGen.SQL.Add('  :TAREFA,    ');
    qryGen.SQL.Add('  :DESCRI,    ');
    qryGen.SQL.Add('  :PROCID,    ');
    qryGen.SQL.Add('  :CODEMP,    ');
    qryGen.SQL.Add('  nOW(),      ');
    qryGen.SQL.Add('  nOW() )     ');

    qryGen.ParamByName('TAREFA').AsString := FTarefa;
    qryGen.ParamByName('DESCRI').AsString := IIF(blnOculInfo, '', FDescricao);
    qryGen.ParamByName('PROCID').AsString := IntToStr(GetCurrentProcessId);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryGen.ExecSQL;

    FJaExecutando := False;

    frmModulo.Database.Commit;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      frmModulo.Database.Rollback;

      FreeAndNil(qryGen);

      If (Pos('DUPLICADA', UpperCase(E.Message)) > 0) Then
        FJaExecutando := True;

      If (Pos('DUPLICATE', UpperCase(E.Message)) > 0) Then
        FJaExecutando := True;

      If Not FJaExecutando Then
        Raise;
    End;
  End;
end;

procedure TRegistrarTarefa.pRemoverTarefa;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnConsiderarConID: Boolean;
begin
  blnConsiderarConID := (Self.FProcessID > 0) And ((Self.blnTerminar) Or (Self.blnBloquear));

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'DELETE FROM NFE_TAREFAS WHERE NFE_TAREFA = :TAREFA' + IIF(blnConsiderarConID, ' AND NFE_PROCID = :PROCID', '');

    qryGen.ParamByName('TAREFA').AsString := FTarefa;
    If blnConsiderarConID Then
      qryGen.ParamByName('PROCID').AsString := IntToStr(FProcessID);

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TRegistrarTarefa.pSinalizarExecutando;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  {$IFNDEF LINUX}
  pBloquearTerminarTarefa;
  {$ENDIF}

  If Self.blnBloquear Then
    Exit;

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'UPDATE NFE_TAREFAS SET NFE_ULTSTA = nOW() WHERE NFE_TAREFA = :TAREFA';
    qryGen.ParamByName('TAREFA').AsString := FTarefa;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TRegistrarTarefa.pBloquearTerminarTarefa;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strDescri: String;
begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT NFE_TAREFA, ');
    qryGen.SQL.Add('       NFE_DESCRI, ');
    qryGen.SQL.Add('       IFNULL(NFE_PROCID, 0) AS NFE_PROCID ');
    qryGen.SQL.Add('  FROM NFE_TAREFAS ');
    qryGen.SQL.Add(' WHERE NFE_TAREFA = :TAREFA');
    qryGen.ParamByName('TAREFA').AsString := FTarefa;
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
    Begin
      Try
        strDescri := Trim(AnsiUpperCase(qryGen.FieldByName('NFE_DESCRI').AsString));

        If (Self.FProcessID > 0) And (Self.FProcessID <> qryGen.FieldByName('NFE_PROCID').AsInteger) And (Not Self.FBloquear) Then
        Begin
          {************************************************************************************************************}
          {* CASO O NFE_COORDENADOR_STATUS XXX NÃO SEJA O MESMO QUE ESTÁ NA NFE_TAREFAS (FProcessID <> NFE_PROCID)    *}
          {* ESTE JÁ NÃO É MAIS VÁLIDO. ISSO ACONTECE QUANDO O NFE_TAREFAS É APAGADO VIA BANCO E O PainelNFe.exe      *}
          {* CRIA UM NOVO NFE_COORDENADOR_STATUS XXX EVIDENTEMENTE COM OUTRO ProcessID. NESSE CASO, DEVE-SE BLOQUEAR  *}
          {* A INSTÂNCIA CORRENTE POIS NUNCA DEVE HAVER DOIS NFE_COORDENADOR_STATUS XXX                               *}
          {*                                                                                                          *}
          {* OUTRO CASO É SE EU QUISER QUE O NfeStatus.exe CORRENTE SEJA ENCERRADO DE FORMA NATURAL SEM SER MORTO POR *}
          {* KILL. PARA TAL, BASTA EU SETAR NFE_PROCID COM -1 OU QUALQUER OUTRO NÚMERO                                *}
          {*********************************************************************************************************VA*}
          Self.FBloquear := True;

          SetLogDanfe;

          pLogImp('NfeStatus.exe '+qryGen.FieldByName('NFE_TAREFA').AsString+' com PID: '+
                  qryGen.FieldByName('NFE_PROCID').AsString+' é a instância vigente. '+
                  'Por isso eu, NfeStatus.exe '+qryGen.FieldByName('NFE_TAREFA').AsString+' com PID: '+
                  IntToStr(FProcessID)+', não posso mais fazer nada, vou fechar, e outro entrará em meu lugar.');
        End
        Else If (strDescri = consTagSinalParaBloquear) And (Not Self.FBloquear) Then
        Begin
          Self.FBloquear := True;

          SetLogDanfe;

          pLogImp('Eu, NfeStatus.exe '+qryGen.FieldByName('NFE_TAREFA').AsString+' com PID: '+
                  IntToStr(FProcessID)+' recebi sinal para me bloquear '+consTagSinalParaBloquear+
                  ', não posso mais fazer nada, vou fechar, e outro entrará em meu lugar.');
        End
        Else If (strDescri = consTagSinalParaTerminar) And (Not Self.FTerminar) Then
        Begin
          Self.FTerminar := True;

          SetLogDanfe;

          pLogImp('Eu, NfeStatus.exe '+qryGen.FieldByName('NFE_TAREFA').AsString+' com PID: '+
                  IntToStr(FProcessID)+' recebi sinal para eu terminar '+consTagSinalParaTerminar+'. '+
                  'Vou concluir a tarefa que comecei e após isso vou fechar.');
        End;
      Except
        On E: Exception Do
        Begin
          SetLogDanfe;

          pLogImp('TRegistrarTarefa.pSuspenderTerminarTarefa > '+E.Message);
        End;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
