unit untFuncoesFiscais;

interface

Uses
  SysUtils,
  Uni,
  Classes,
  StrUtils,
  DB,
  Windows,
  untFiscal,
  untFormGrid,
  untWaitWindow,
  untFuncoesSimples;

procedure pLeituraX;
procedure pPrimeiroLogin(strCodOpe: String);
procedure pMostraProdutosComPrecoPautaFiscalVencido(strCodOpe: String);

implementation

procedure pLeituraX;
  Var
    ecfFiscal: TUntFiscal;
    strPatIni,
    strCodErr,
    strModEcf,
    strPorta: String;

    procedure pLeituraXNovo;
    Begin
      If fMensagem('ATENÇÃO', 'Efetuar Leitura X?', ['&Sim', '&Não']) = 1 Then
      Begin
        VS_objFiscal.fLeituraX('N', False);
      End;
    End;
Begin
  If Assigned(VS_objFiscal) Then
  Begin
    pLeituraXNovo;
    Exit;
  End;

  If fMensagem('AVISO', 'Imprimir Leitura(X)?', ['&Sim', '&Não']) = 2 Then
    Exit;

  strPatIni := fCfgSis('DIRINI');
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
  strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

  ecfFiscal := TUntFiscal.Create;
  ecfFiscal.strCodVen := strLoginUsuarioLogado;
  ecfFiscal.strNomVen := fRetNomeOperador(strLoginUsuarioLogado);

  Try

    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.lblTexto.Caption := 'Aguarde, Imprimindo Leitura(X)';
    frmWaitWindow.tmrWait.Enabled := False;

    Try

      If Not ecfFiscal.pSetModEcf( strModEcf ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      //Tela de Espera

      AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
      frmWaitWindow.Show;
      frmWaitWindow.Refresh;

      Try

        ecfFiscal.fLeituraX( strCodErr, False );
        ecfFiscal.fRetMensErro( strCodErr, True );

      Finally
        If Not ecfFiscal.fFinalizaEcf( strCodErr ) Then
        Begin
          fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        End;
      End;

    Except
      On E: Exception Do
        fMensagem('ATENÇÃO!',E.Message + #13 + 'Não foi possível emitir a Leitura(X). Verifique as configurações do sistema!', ['&Ok']);
    End;

    frmWaitWindow.Close;

  Except
    On E: Exception Do
    Begin
     pMensagensErro(E.Message, '[frmGerImpFiscais.btnLeituraxClick]');
    End;
  End;

  pFreeAndNil(frmWaitWindow);
  ecfFiscal.Free;
End;

procedure pPrimeiroLogin(strCodOpe: String);
var
  dtaLogAce: TDate;
begin
  dtaLogAce := fCampoTabela('LOG_DTAENT', 'LOGACE', ['LOG_CODOPE','LOG_DTAENT'], [strCodOpe, Date], False);

  VS_blnPrimeiroLogin := (dtaLogAce = 0);
end;

procedure pMostraProdutosComPrecoPautaFiscalVencido(strCodOpe: String);
var
  qryAux: TUniQuery;
  strItePPF: String;
begin
  If not fCfgSis('USA_PF', varBoolean) Then
    Exit;

  strItePPF := fCampoTabela('OPE_ITEPPF', 'CADOPE', ['OPE_CODOPE'], [strCodOpe], False);

  If not (strItePPF = 'S') Then
    Exit;

  If not VS_blnPrimeiroLogin Then
    Exit;

  qryAux := fCriaQuery(Nil);
  frmGrid := TfrmGrid.Create(Nil);
  Try
    If (fCfgSis('TIPABF') = '1') Then
      qryAux.SQL.Text := 'SELECT ITE_CODITE, ITE_DESITE, MIN(PPF_DTAFIN) AS PPF_DTAFIN FROM CADITE '+
                         'INNER JOIN CADPPF ON ITE_CODITE = PPF_CODITE '+
                         'WHERE ITE_USAPPF = "S" '+
                         '  AND CURRENT_DATE > PPF_DTAFIN '+
                         'GROUP BY ITE_CODITE, ITE_DESITE '
    Else
      qryAux.SQL.Text := 'SELECT CADITE.ITE_CODITE, CADITE.ITE_DESITE, MIN(PPF_DTAFIN) AS PPF_DTAFIN FROM CADITE '+
                         'INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE '+
                         'INNER JOIN CADPPF ON CADPPF.PPF_CODITE = ITEGER.ITE_CODITE '+
                         'WHERE ITEGER.ITE_USAPPF = "S" '+
                         '  AND ITEGER.ITE_CODEMP = "'+VS_strCodEmp+'" '+
                         '  AND CURRENT_DATE > PPF_DTAFIN '+
                         'GROUP BY CADITE.ITE_CODITE, CADITE.ITE_DESITE ';

    qryAux.Open;

    If (qryAux.RecordCount > 0) Then
    Begin
      qryAux.FieldByName('ITE_CODITE').DisplayLabel := 'Produto';
      qryAux.FieldByName('ITE_DESITE').DisplayLabel := 'Descrição';
      qryAux.FieldByName('PPF_DTAFIN').DisplayLabel := 'Validade';

      frmGrid.DataSet := qryAux;
      frmGrid.grdInfoDBTableView.OptionsView.ColumnAutoWidth := True;
      frmGrid.Caption := 'Produtos com Preço de Pauta Fiscal fora da Vigência';
      frmGrid.ShowModal;
    End;
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(frmGrid);
  End;
end;

end.
