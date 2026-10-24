unit untCadComFatVendDepart;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, EditFocus, Mask, DBCtrls,
  DBEditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  UniClientDataSet, Uni, BitBtnLockedIncrem, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadComFatVendDepart = class(TfrmPaiCad)
    pnl1: TPanel;
    pnlTopo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    dbeCodTab: TDBEditFocus;
    dbeDesTab: TDBEditFocus;
    dbeFatIni: TDBEditFocus;
    dbeFatFin: TDBEditFocus;
    pnlComDep: TPanel;
    lbl7: TLabel;
    edtPerCom: TEditFocus;
    lblCodDep: TLabel;
    edtDesDep: TEditFocus;
    grdComDep: TDBGridCitel;
    dtsComDep: TDataSource;
    dtsTabela: TDataSource;
    cdsComDep: TUniClientDataSet;
    cdsComDepAUTOIN: TStringField;
    cdsComDepSEQCOM: TStringField;
    cdsComDepNOMDEP: TStringField;
    cdsComDepPERCOM: TFloatField;
    cdsComDepCODDEP: TStringField;
    edtCodDep: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    lblDesIni: TLabel;
    lblDesFin: TLabel;
    dbeDesIni: TDBEditFocus;
    dbeDesFin: TDBEditFocus;
    lblMarIni: TLabel;
    lblMarFin: TLabel;
    dbeMarIni: TDBEditFocus;
    dbeMarFin: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure grdComDepKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    qryComFat: TUniQuery;
    procedure pCarregaGrid;
    procedure pLimparPanelComDep;
    procedure pFormatarCampos(Dataset: TDataSet);

    function fInserirComDep: Boolean;
    function fGravarComDep(strSeqCom: String): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

uses SysUtils, Forms, untConstantes, untFuncoesSimples, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadComFatVendDepart.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;
  If fInserirComDep Then
    pLimparPanelComDep;
end;

procedure TfrmCadComFatVendDepart.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTab, dbeDesTab, False);
end;

procedure TfrmCadComFatVendDepart.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.Active Then
    pCarregaGrid;
end;

procedure TfrmCadComFatVendDepart.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    cdsComDep.EmptyDataSet;
    fCommit
  End
  Else
    fRollBack;
end;

procedure TfrmCadComFatVendDepart.btnGravarClick(Sender: TObject);
  Var
    strAutoIn: String;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If cdsComDep.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum departamento foi informado!', ['&Ok']);
    pSetFocus(edtCodDep);
  End
  Else
  Begin
    Try
      inherited;
      If blnGravou Then
      Begin
        strAutoIn := qryTabela.FieldByName('AUTOINCREM').AsString;
        fGravarComDep(strAutoIn);
        fCommit;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;
  End;
end;

procedure TfrmCadComFatVendDepart.btnIncluirClick(Sender: TObject);
begin
  inherited;
  cdsComDep.EmptyDataSet;

  if blnUsaProCodigo then
    pHabilitaCodigo(dbeCodTab, dbeDesTab, False)
  Else
    pHabilitaCodigo(dbeCodTab, dbeCodTab, True);
end;

procedure TfrmCadComFatVendDepart.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqComissaoFatVendDepart(conSimples,
                                Self,
                                nil,
                                nil,
                                qryTabela,
                                chrKey,
                                arrSel) Then
  Begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  End;
  If qryTabela.Active Then
    pCarregaGrid;
end;

procedure TfrmCadComFatVendDepart.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFatVendDepart.FormCreate(Sender: TObject);
begin
  inherited;
  qryComFat           := fCriaQuery(Self);
  strNomeTabela       := 'COMDEPG';
  strNomeCampo        := 'COM_CODTAB';
  qryTabela           := qryComFat;
  dtsTabela.DataSet   := qryTabela;
  qryTabela.AfterOpen := pFormatarCampos;
  cdsComDep.CreateDataSet;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0]   := dbeCodTab;

  if not fCfgSis('DFFGVD', varBoolean) then
  begin
    lblDesIni.Visible := False;
    lblDesFin.Visible := False;
    dbeDesIni.Visible := False;
    dbeDesFin.Visible := False;
    pnlTopo.Height := pnlTopo.Height - 24;
  end;

  if not fCfgSis('MFFGVD', varBoolean) then
  begin
    lblMarIni.Visible := False;
    lblMarFin.Visible := False;
    dbeMarIni.Visible := False;
    dbeMarFin.Visible := False;
    pnlTopo.Height := pnlTopo.Height - 24;
  end
  else
  begin
    lblMarIni.Top := IIF(fCfgSis('DFFGVD', varBoolean), lblMarIni.Top, lblMarIni.Top - 24);
    lblMarFin.Top := IIF(fCfgSis('DFFGVD', varBoolean), lblMarFin.Top, lblMarFin.Top - 24);
    dbeMarIni.Top := IIF(fCfgSis('DFFGVD', varBoolean), dbeMarIni.Top, dbeMarIni.Top - 24);
    dbeMarFin.Top := IIF(fCfgSis('DFFGVD', varBoolean), dbeMarFin.Top, dbeMarFin.Top - 24);
  end;
end;

function TfrmCadComFatVendDepart.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  strAux:String;
begin
  Result := True;
  Try

    If Sender = dbeCodTab Then
    Begin
      If fEmptyStr(dbeCodTab.Text) And (dbeCodTab.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDesTab Then
    Begin
      If fEmptyStr(dbeDesTab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeFatIni) or (Sender = dbeDesIni) or (Sender = dbeMarIni) Then
    Begin
      if (Sender = dbeFatIni) then
      begin
        If fEmptyStr(dbeFatIni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Inicial deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeFatIni.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Inicial não pode ser negativo!', ['&Ok']);
          Result := False;
        End;
      end
      else if (Sender = dbeDesIni) and fCfgSis('DFFGVD', varBoolean) then
      begin
        If fEmptyStr(dbeDesIni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto Inicial deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeDesIni.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto Inicial não pode ser negativo!', ['&Ok']);
          Result := False;
        End;
      end
      else if (Sender = dbeMarIni) and fCfgSis('MFFGVD', varBoolean) then
      begin
        If fEmptyStr(dbeMarIni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem Inicial deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeMarIni.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem Inicial não pode ser negativa!', ['&Ok']);
          Result := False;
        End;
      end;

      If Result Then
      Begin
        if (not fCfgSis('DFFGVD', varBoolean)) and (not fCfgSis('MFFGVD', varBoolean)) then
          strAux:= fRetFaixasPorValor('COMDEPG',
                                        fStrToFloat(dbeFatIni.Text),
                                        'COM_FATINI',
                                        'COM_FATFIN',
                                        'COM_DESCRI',
                                        'COM_CODTAB',
                                        dbeCodTab.Text)
        else
          strAux:= fRetFaixasPorValor('COMDEPG',
                                        fStrToFloat(dbeFatIni.Text),
                                        fStrToFloat(dbeDesIni.Text),
                                        fStrToFloat(dbeMarIni.Text),
                                        'COM_FATINI',
                                        'COM_FATFIN',
                                        'COM_DESINI',
                                        'COM_DESFIN',
                                        'COM_MARINI',
                                        'COM_MARFIN',
                                        'COM_DESCRI',
                                        'COM_CODTAB',
                                        dbeCodTab.Text);
        If Not fEmptyStr(strAux) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Faturamento Inicial já consta nas seguinte(s) faixa(s): '+strAux, ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeFatFin) or (Sender = dbeDesFin) or (Sender = dbeMarFin) Then
    Begin
      if (Sender = dbeFatFin) then
      begin
        If fEmptyStr(dbeFatFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeFatFin.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Final não pode ser negativo!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeFatIni.Text) > fStrToFloat(dbeFatFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior que o Inicial!', ['&Ok']);
          Result := False;
        End;
      end
      else if (Sender = dbeDesFin) and fCfgSis('DFFGVD', varBoolean) then
      begin
        If fEmptyStr(dbeDesFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto Final deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeDesFin.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto Final não pode ser negativo!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeDesIni.Text) > fStrToFloat(dbeDesFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto Final deve ser maior que o Inicial!', ['&Ok']);
          Result := False;
        End;
      end
      else if (Sender = dbeMarFin) and fCfgSis('MFFGVD', varBoolean) then
      begin
        If fEmptyStr(dbeMarFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem Final deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeMarFin.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem Final não pode ser negativa!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeMarIni.Text) > fStrToFloat(dbeMarFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem Final deve ser maior que a Inicial!', ['&Ok']);
          Result := False;
        End;
      end;

      If Result Then
      Begin
        if (not fCfgSis('DFFGVD', varBoolean)) and (not fCfgSis('MFFGVD', varBoolean)) then
          strAux:= fRetFaixasPorValor('COMDEPG',
                                      fStrToFloat(dbeFatFin.Text),
                                      'COM_FATINI',
                                      'COM_FATFIN',
                                      'COM_DESCRI',
                                      'COM_CODTAB',
                                      dbeCodTab.Text)
        else
          strAux:= fRetFaixasPorValor('COMDEPG',
                                      fStrToFloat(dbeFatFin.Text),
                                      fStrToFloat(dbeDesFin.Text),
                                      fStrToFloat(dbeMarFin.Text),
                                      'COM_FATINI',
                                      'COM_FATFIN',
                                      'COM_DESINI',
                                      'COM_DESFIN',
                                      'COM_MARINI',
                                      'COM_MARFIN',
                                      'COM_DESCRI',
                                      'COM_CODTAB',
                                      dbeCodTab.Text);
        If Not fEmptyStr(strAux) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Faturamento Final já consta nas seguinte(s) faixa(s): '+strAux, ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodDep) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodDep.Text) Then
      Begin
        edtDesDep.Clear;
        pSetFocus(btnGravar);
        blnMudarFoco := False;
      End
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [edtCodDep.Text]);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPerCom) And blnBuscaPorChave And (Not fEmptyStr(edtCodDep.Text)) Then
    Begin
      If fEmptyStr(edtPerCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de comissão deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadComFatVendDepart.grdComDepKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: If btnGravar.Enabled Then grdComDep.DataSource.DataSet.Delete;
  End;

end;

procedure TfrmCadComFatVendDepart.pCarregaGrid;
  Var
    strSQL   : String;
    qryComDep: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT          ';
    strSQL := strSQL + '  C.AUTOINCREM, ';
    strSQL := strSQL + '  C.COM_SEQCOM, ';
    strSQL := strSQL + '  C.COM_CODDEP, ';
    strSQL := strSQL + '  D.DEP_DESCRI, ';
    strSQL := strSQL + '  C.COM_PERCOM  ';
    strSQL := strSQL + 'FROM            ';
    strSQL := strSQL + '  COMDEPD C     ';
    strSQL := strSQL + '  INNER JOIN CADDEP D ON DEP_CODIGO = COM_CODDEP ';
    strSQL := strSQL + 'WHERE           ';
    strSQL := strSQL + '  C.COM_SEQCOM = :AUTOIN ';

    qryComDep := fCriaQuery(Self);
    With qryComDep Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;
      cdsComDep.EmptyDataSet;
      While Not Eof Do
      Begin
        cdsComDep.Append;
        cdsComDepAUTOIN.AsString := FieldByName('AUTOINCREM').AsString;
        cdsComDepSEQCOM.AsString := FieldByName('COM_SEQCOM').AsString;
        cdsComDepCODDEP.AsString := FieldByName('COM_CODDEP').AsString;
        cdsComDepNOMDEP.AsString := FieldByName('DEP_DESCRI').AsString;
        cdsComDepPERCOM.AsFloat  := FieldByName('COM_PERCOM').AsFloat;
        cdsComDep.Post;
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryComDep);
  End;
end;

procedure TfrmCadComFatVendDepart.pFormatarCampos(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_FATINI')).DisplayFormat := ',0.000';
  TFloatField(Dataset.FieldByName('COM_FATFIN')).DisplayFormat := ',0.000';
  TFloatField(Dataset.FieldbyName('COM_DESINI')).DisplayFormat := ',0.00';
  TFloatField(Dataset.FieldbyName('COM_DESFIN')).DisplayFormat := ',0.00';
  TFloatField(Dataset.FieldbyName('COM_MARINI')).DisplayFormat := ',0.00';
  TFloatField(Dataset.FieldbyName('COM_MARFIN')).DisplayFormat := ',0.00';
end;

procedure TfrmCadComFatVendDepart.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_FATINI');
  stlCampos.Add('COM_FATFIN');

  if fCfgSis('DFFGVD', varBoolean) then
  begin
    stlCampos.Add('COM_DESINI');
    stlCampos.Add('COM_DESFIN');
  end;

  if fCfgSis('MFFGVD', varBoolean) then
  begin
    stlCampos.Add('COM_MARINI');
    stlCampos.Add('COM_MARFIN');
  end;

  stlCampos.Add('AUTOINCREM');

  if fCfgSis('DFFGVD', varBoolean) then
  begin
    if fCfgSis('MFFGVD', varBoolean) then
      stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN+COM_DESINI+COM_DESFIN+COM_MARINI+COM_MARFIN')
    else
      stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN+COM_DESINI+COM_DESFIN');
  end
  else
  begin
    if fCfgSis('MFFGVD', varBoolean) then
      stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN+COM_MARINI+COM_MARFIN')
    else
      stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN');
  end;
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  if fCfgSis('DFFGVD', varBoolean) then
  begin
    if fCfgSis('MFFGVD', varBoolean) then
      stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final/Desconto Inicial/Desconto Final/Margem Inicial/Margem Final')
    else
      stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final/Desconto Inicial/Desconto Final');
  end
  else
  begin
    if fCfgSis('MFFGVD', varBoolean) then
      stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final/Margem Inicial/Margem Final')
    else
      stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final');
  end;
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadComFatVendDepart.fGravarComDep(strSeqCom: String): Boolean;
  Var
    strSQL   : String;
    qryComDep: TUniQuery;
begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  COMDEPD   ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  COM_SEQCOM = :AUTOIN ';
    qryComDep := fCriaQuery(Self);
    With qryComDep Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := strSeqCom;
      ExecSQL;
    End;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO   ';
    strSQL := strSQL + '  COMDEPD    (';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  COM_SEQCOM, ';
    strSQL := strSQL + '  COM_CODDEP, ';
    strSQL := strSQL + '  COM_PERCOM) ';
    strSQL := strSQL + 'VALUES       (';
    strSQL := strSQL + '  :AUTOIN,    ';
    strSQL := strSQL + '  :SEQCOM,    ';
    strSQL := strSQL + '  :CODDEP,    ';
    strSQL := strSQL + '  :PERCOM)    ';

    With qryComDep Do
    Begin
      cdsComDep.First;
      While Not cdsComDep.Eof Do
      Begin
        Close;
        SQL.Text := strSQL;
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('COMDEPD',VS_strCodEmp);
        ParamByName('SEQCOM').AsString := strSeqCom;
        ParamByName('CODDEP').AsString := cdsComDepCODDEP.AsString;
        ParamByName('PERCOM').AsFloat  := cdsComDepPERCOM.AsFloat;
        ExecSQL;
        cdsComDep.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmCadComFatVendDepart.fInserirComDep: Boolean;
begin
  If fEmptyStr(edtCodDep.Text) Then
  Begin
    Result := True;
    Exit;
  End;
  Result := True;
  With qryTabela Do
  Begin
    If cdsComDep.Locate('CODDEP', edtCodDep.Text, []) Then
    Begin
      fMensagem('ATENÇÃO!', 'Departamento já cadastrado para esta Faixa!', ['&Ok']);
      pLimparPanelComDep;
      Result := False;
    End
    Else
    Begin
      cdsComDep.Append;
      cdsComDepSEQCOM.AsString := FieldByName('AUTOINCREM').AsString;
      cdsComDepCODDEP.AsString := edtCodDep.Text;
      cdsComDepNOMDEP.AsString := edtDesDep.Text;
      cdsComDepPERCOM.AsFloat  := fStrToFloat(edtPerCom.Text);
      cdsComDep.Post;
    End;
  End;
end;

procedure TfrmCadComFatVendDepart.pLimparPanelComDep;
begin
  edtCodDep.Clear;
  edtDesDep.Clear;
  edtPerCom.Text := '0,00';
  pSetFocus(edtCodDep);
end;

end.

