unit untFatRomManutEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, QColorLabel, DB,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, ComboBoxFocus,
  untTurnoEntrega;

type
  TfrmFatRomManutEntrega = class(TfrmPaiEdit)
    pnlDigDoc: TPanel;
    Label1: TLabel;
    lblCodEmp: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label4: TLabel;
    edtEspDoc: TEditFocus;
    btnGravar: TBitBtnLocked;
    Label6: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    mskDtaEmi: TMaskEditFocus;
    edtValDoc: TEditFocus;
    Label5: TLabel;
    Label3: TLabel;
    mskCndPag: TMaskEditFocus;
    Label7: TLabel;
    edtNomVen: TEditFocus;
    edtCodVen: TEditFocus;
    Label12: TLabel;
    edtEntFat: TEditFocus;
    ColorLabel1: TColorLabel;
    lbl1: TLabel;
    mskDtaPre: TMaskEditFocus;
    pnlMotivoDaAlteracao: TPanel;
    lblMotivoDaAlteracao: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    btnAlteracoes: TBitBtnLocked;
    cmbTurEnt: TComboBoxFocus;
    lblTurno: TLabel;
    chkUrgente: TCheckBox;
    lblCliBus: TLabel;
    cmbCliBus: TComboBoxFocus;
    lblLocRet: TLabel;
    cmbLocRet: TComboBoxFocus;
    procedure edtNumDocEnter(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodOcoExit(Sender: TObject);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlteracoesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private

    qryCadEmp: TUniQuery;
    qryConEmp: TUniQuery;
    strDtaPre: String;
    qryConOco: TUniQuery;
    objTurno: TTurnoEntrega;

    function fBuscaDocum(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    procedure pLimpaTela;
    procedure pGravaEntFat;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    strAutInc : String;
    strTabela : String;
    blnConfirma: Boolean;
    blnChamouPeloManutencaoDeEntregas: Boolean;
    blnChamouPeloRomaneioInclusao: Boolean;
    procedure pCarregaOcorrencia;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, StrUtils, untPai, untConsultas, untTypesSistema,
  untTSituacaoPedidoVenda, untConstantes, untFatGor, untPesqAux, untFatRomManutEntrega_Alteracoes,
  untEnderecoEntrega;

function TfrmFatRomManutEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodOco) And (pnlMotivoDaAlteracao.Visible) Then
    Begin
      If fEmptyStr(edtCodOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A ocorrência deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaOcorrencia;
        If qryConOco.FieldByName('OCO_CODOCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa ocorrência não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('', 'Digite o Número do Documento !', ['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('', 'Digite a Espécie do Documento !', ['&O K']);
        Result := False;
      End
      Else If Pos(edtEspDoc.Text, 'NF_EL_IF_IV_D1_MI_FF_TE_BR_TR_DV_PD_') <= 0 Then
      Begin
        fMensagem('', 'Informe uma espécie de documento válida !', ['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('', 'Digite o código da Empresa !', ['&O K']);
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('', 'Empresa não cadastrada !', ['&O K']);
          Result := False;
        End
        Else If (edtEspDoc.Text = 'PD') And (fPedidoFaturado(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) then
        Begin
          fMensagem('', 'Pedido já faturado !', ['&O K']);
          Result := False;
        End
        Else If Not fBuscaDocum(edtNumDoc.Text, edtEspDoc.Text,edtCodEmp.Text) Then
        Begin
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtEntFat) Then
    Begin
      If fEmptyStr(edtEntFat.Text) Then
      Begin
        fMensagem('', 'Informe um valor (S ou N) !', ['&O K']);
        Result := False;
      End
      Else If (edtEntFat.Text <> 'N') And (edtEntFat.Text <> 'S') Then
      Begin
        fMensagem('', 'Valores permitidos (S ou N) !', ['&O K']);
        Result := False;
      End;

      If (cmbLocRet.Visible) Then
      Begin
        cmbLocRet.Enabled := (edtEntFat.Text <> 'S');

        If (cmbLocRet.Enabled) Then
        Begin
          If (cmbLocRet.ItemIndex = -1) Then
            cmbLocRet.ItemIndex := fSugestaoLocalRetira;
        End
        Else
          cmbLocRet.ItemIndex := -1;
      End;

      mskDtaPre.Enabled := edtEntFat.Text = 'S';
      If not mskDtaPre.Enabled Then
        mskDtaPre.Clear
      Else If fEmptyStr(fTiraCaracEspeciais(mskDtaPre.Text)) and
        (StrToDateDef(strDtaPre, 0) > 0) Then
        mskDtaPre.Text := strDtaPre;
    End
    Else If (Sender = cmbLocRet) Then
    Begin
      If (cmbLocRet.Visible) And (cmbLocRet.Enabled) Then
      Begin
        If (cmbLocRet.ItemIndex = -1) Then
        Begin
          fMensagem('', 'Informe um local de retira valido!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = mskDtaPre) Then
    Begin
      If mskDtaPre.Enabled Then
      Begin
        If StrToDateDef(mskDtaPre.Text, 0) = 0 Then
        Begin
          fMensagem('', 'Informe uma data de previsão válida!', ['&O k']);
          Result := False;
        End
        Else If StrToDate(mskDtaPre.Text) < VS_Date Then
        Begin
          fMensagem('', 'Data de previsão precisa ser maior ou igual a ' +
            FormatDateTime('dd/mm/yyyy', VS_Date), ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatRomManutEntrega.pLimpaTela;
begin
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  mskDtaEmi.Clear;
  edtValDoc.Clear;
  mskCndPag.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtEntFat.Clear;
  mskDtaPre.Clear;
  edtCodOco.Clear;
  edtDesOco.Clear;
  edtEspDoc.Enabled := True;
  edtCodEmp.Enabled := True;
  btnGravar.Enabled := False;
  edtEntFat.Enabled := False;
  mskDtaPre.Enabled := False;
  edtCodOco.Enabled := False;
  chkUrgente.Checked := False;
  chkUrgente.Enabled := False;
  btnAlteracoes.Enabled := False;
  cmbCliBus.ItemIndex := -1;
  cmbCliBus.Visible := False;
  lblCliBus.Visible := False;
  cmbLocRet.Enabled := False;
  cmbLocRet.ItemIndex := -1;
  pSetFocus(edtNumDoc);
end;

procedure TfrmFatRomManutEntrega.edtNumDocEnter(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmFatRomManutEntrega.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  { ******************************* }
  { * NOVA CONSULTA DE EMPRESAS   * }
  { ****************************RV* }
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key,
    arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomManutEntrega.edtCodOcoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodOco);
end;

procedure TfrmFatRomManutEntrega.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
Var
  arrOcor: TConsultasArray;
begin
  inherited;
  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOcor) Then
    pCarregaOcorrencia;
end;

function TfrmFatRomManutEntrega.fBuscaDocum(strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
Var
  qryDoc: TUniQuery;
  strTabela_,
  strPrefixo,
  strPrefixoEnt,
  strSql,
  strSqlUnion: String;
  blnClienteBuscaEntrega: Boolean;
begin
  if strEspDoc = 'PD' then
  begin
    strPrefixo := 'FGO';
    strTabela_ := 'FATGOR';
    strPrefixoEnt := 'FGO';
  end
  else
  begin
    strPrefixo := 'GER';
    strTabela_ := 'MOVGER';
    strPrefixoEnt := 'AUX';
  end;

  Result := True;

  strSql := '';

  strSql := strSql + '	SELECT                                  ';
  strSql := strSql + '		'+strPrefixo+'_NUMDOC     AS NUMDOC,  ';
  strSql := strSql + '		'+strPrefixo+'_ESPDOC     AS ESPDOC,  ';
  strSql := strSql + '		'+strPrefixo+'_CODCLI     AS CODCLI,  ';
  strSql := strSql + '		'+strPrefixo+'_CODVEN     AS CODVEN,  ';
  strSql := strSql + '		'+strPrefixo+'_CONPAG     AS CONPAG,  ';
  strSql := strSql + '		'+strPrefixo+'_DTAENT     AS DTAENT,  ';
  strSql := strSql + '		'+strPrefixo+'_VLRCON     AS VLRCON,  ';
  strSql := strSql + '		'+strPrefixo+'_ENTFAT     AS ENTFAT,  ';
  strSql := strSql + '		'+strPrefixo+'_NUMROM     AS NUMROM,  ';
  strSql := strSql + '		'+strPrefixo+'_DTENTR     AS DTENTR,  ';
  strSql := strSql + '    '+strPrefixoEnt+'_ENTURG     AS ENTURG,  ';
  If fCfgSis('EXITUR', varBoolean) then
  begin
    if strEspDoc = 'PD' then
      strSql := strSql + ' E.FDO_TURENT AS TURENT, '
    else
      strSql := strSql + ' T.DET_TURENT AS TURENT, ';
  end;

  If strEspDoc = 'PD' Then
  Begin
    strSql := strSql + ' E.FDO_CLIBUS AS CLIBUS, ';
    strSql := strSql + ' IF(IFNULL(E.FDO_INCFUT, "") = "", "", E.FDO_INCFUT) AS INCFUT, ';

    If (cmbLocRet.Visible) Then
      strSQL := strSql + ' IFNULL(E.FDO_LOCRET, "") AS LOCRET, ';
  End
  Else
  Begin
    strSql := strSql + ' T.DET_CLIBUS AS CLIBUS, ';
    strSql := strSql + ' IF(IFNULL(T.DET_INCFUT, "") = "", "", T.DET_INCFUT) AS INCFUT, ';

    If (cmbLocRet.Visible) Then
      strSQL := strSql + ' "" AS LOCRET, ';
  End;

  strSql := strSql + '		"'+strTabela_+'"           AS TABELA, ';
  strSql := strSql + '	   '+strTabela_+'.AUTOINCREM AS AUTINC  ';
  strSql := strSql + '	FROM                                    ';
  strSql := strSql + '		'+strTabela_+'                        ';

  if strEspDoc = 'PD' then
  begin
    strSql := strSql + ' LEFT JOIN EXTGOR EG ON EG.FGO_SEQFGO = '+strTabela_+'.AUTOINCREM ';
    strSql := strSql + ' LEFT JOIN FATDOR D ON D.FDO_SEQGER = '+strTabela_+'.AUTOINCREM ';
    strSql := strSql + ' LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM  ';
  end
  else
  begin
    strSql := strSql + ' LEFT JOIN AUXMOV A ON A.AUX_SEQGER = ' + strTabela_ + '.AUTOINCREM ';
    strSql := strSql + ' LEFT JOIN MOVDET D ON D.DET_SEQGER = ' + strTabela_ + '.AUTOINCREM ';
    strSql := strSql + ' LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  end;

  strSql := strSql + '	WHERE                                   ';
  strSql := strSql + '		'+strPrefixo+'_NUMDOC =:NUMDOC AND    ';
  strSql := strSql + '		'+strPrefixo+'_ESPDOC =:ESPDOC AND    ';
  strSql := strSql + '		'+strPrefixo+'_CODEMP =:CODEMP AND    ';

  If Not strEspDoc.Equals('PD') Then
    strSql := strSql + ' ' + strPrefixo + '_MEN001 NOT LIKE "%FULFILLMENT%" AND ';

  if strEspDoc = 'PD' then
  begin
    strSql := strSql + '		FGO_JAFATU = 0        ';
  end
  else
  begin
    strSql := strSql + '		MOVGER.GER_TIP_FC = "C"		';
    strSqlUnion := strSql;
    strSqlUnion := AnsiReplaceStr(strSqlUnion, 'IF(IFNULL(T.DET_INCFUT, "") = "", "", T.DET_INCFUT) AS INCFUT,', 'NULL AS INCFUT,');
    strSqlUnion := AnsiReplaceStr(strSqlUnion, 'MOVGER', 'NOTGER');
    strSqlUnion := AnsiReplaceStr(strSqlUnion, 'MOVDET', 'NOTDET');
    strSqlUnion := AnsiReplaceStr(strSqlUnion, 'MOVTRI', 'NOTTRI');
    strSqlUnion := AnsiReplaceStr(strSqlUnion, 'AUXMOV', 'AUXNOT');
    strSql      := strSql + ' UNION ALL ' + strSqlUnion;
  end;

  qryDoc := fCriaQuery(Nil);

  With qryDoc Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    Open;

    strAutInc := '';
    strTabela := '';

    If Not IsEmpty Then
    Begin
      If Not fEmptyStr(FieldByName('NUMROM').AsString) Then
      Begin
        fMensagem('', ' Este documento já possui Romaneio ( ' +
          FieldByName('NUMROM').AsString + ' )', ['&O K']);
        Result := False;
      End
      Else
      Begin
        blnMudarFoco := False;
        edtCodCli.Text := FieldByName('CODCLI').AsString;
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        mskDtaEmi.Text := DateToStr(FieldByName('DTAENT').AsDateTime);
        edtValDoc.Text := FormatFloat('#,##0.00',
          FieldByName('VLRCON').AsFloat);
        mskCndPag.Text := FieldByName('CONPAG').AsString;
        edtCodVen.Text := FieldByName('CODVEN').AsString;
        edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
        edtEntFat.Text := FieldByName('ENTFAT').AsString;
        if (FindField('TURENT') <> nil) then
          cmbTurEnt.ItemIndex := objTurno.fTurnoStrToInt(FieldByName('TURENT').AsString);
        strDtaPre := DateToStr(FieldByName('DTENTR').AsDateTime);
        If edtEntFat.Text = 'S' Then
        Begin
          mskDtaPre.Text := strDtaPre;
          mskDtaPre.Enabled := True;
        End
        Else If (cmbLocRet.Visible) Then
        Begin
          cmbLocRet.Enabled   := True;
          cmbLocRet.ItemIndex := fRetIndexLocalRetira(FieldByName('LOCRET').AsString, cmbLocRet.Items);
        End;
        btnGravar.Enabled := True;
        edtEntFat.Enabled := True;
        edtEspDoc.Enabled := False;
        edtCodEmp.Enabled := False;
        chkUrgente.Enabled := True;

        edtCodOco.Enabled     := True;
        btnAlteracoes.Enabled := True;
        strAutInc := FieldByName('AUTINC').AsString;
        strTabela := FieldByName('TABELA').AsString;
        chkUrgente.Checked := FieldByName('ENTURG').AsString = 'S';

        blnClienteBuscaEntrega := (fCfgSis('ENTFUT', varBoolean, edtCodEmp.Text)) And
                                  (fCfgSis('CLBUEF', varBoolean, edtCodEmp.Text)) And
                                  (Not fEmptyStr(FieldByName('INCFUT').AsString));
        cmbCliBus.Visible   := blnClienteBuscaEntrega;
        lblCliBus.Visible   := blnClienteBuscaEntrega;
        cmbCliBus.ItemIndex := IIF(FieldByName('CLIBUS').AsString = 'S', 1, 0);

        pSetFocus(edtEntFat);
      End;
    End
    Else
    Begin
      fMensagem('', ' Documento não encontrado !', ['&O K']);
      Result := False;
    End;

  End;

  FreeAndNil(qryDoc);

end;

procedure TfrmFatRomManutEntrega.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConOco);
end;

procedure TfrmFatRomManutEntrega.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo := fTamDocCadRec();
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  objTurno  := TTurnoEntrega.Create(Self);

  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.SQL.Add('SELECT ');
  qryCadEmp.SQL.Add('  *    ');
  qryCadEmp.SQL.Add('FROM ');
  qryCadEmp.SQL.Add('  CADEMP ');

  qryCadEmp.Open;
  qryConEmp := qryCadEmp;
  mskCndPag.EditMask := MASK_CONPAG;

  qryConOco := fCriaQuery(Self);

  pnlMotivoDaAlteracao.Visible := fCfgSis('OCOMAN', varBoolean);
  lblTurno.Visible := fCfgSis('EXITUR', varBoolean);
  cmbTurEnt.Visible := fCfgSis('EXITUR', varBoolean);

  strAutInc := '';
  strTabela := '';
  blnConfirma := False;
  blnChamouPeloManutencaoDeEntregas := False;
  blnChamouPeloRomaneioInclusao := False;

  If fCfgSis('LOCRET', VarBoolean) Then
  Begin
    pCarregaLocalRetira(cmbLocRet.Items);

    cmbLocRet.Visible := True;
    lblLocRet.Visible := True;
  End;
end;

procedure TfrmFatRomManutEntrega.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objTurno) Then
    FreeAndNil(objTurno);
end;

procedure TfrmFatRomManutEntrega.FormShow(Sender: TObject);
begin
  inherited;
  if blnChamouPeloManutencaoDeEntregas or blnChamouPeloRomaneioInclusao then
  begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  end
  else
  begin
    pSetFocus(edtNumDoc);
  end;
end;

procedure TfrmFatRomManutEntrega.btnAlteracoesClick(Sender: TObject);
begin

  inherited;

  If strTabela.IsEmpty Then
    Exit;

  If strAutInc.IsEmpty Then
    Exit;

  TfrmFatRomManutEntrega_Alteracoes.pMostrarRegistrosDeAlteracaoDaManutencaoDeEntrada(strAutInc, strTabela);

end;

procedure TfrmFatRomManutEntrega.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;

  If fValidaCampos(edtEntFat) and (fValidaCampos(mskDtaPre)) Then
  Begin
    pGravaEntFat;

    blnConfirma := True;

    If blnChamouPeloManutencaoDeEntregas or blnChamouPeloRomaneioInclusao Then
      Close;
  End;

end;

procedure TfrmFatRomManutEntrega.pCarregaOcorrencia;
begin
  pPesquisaCadOco(Nil, qryConOco, edtCodOco.Text);
  With qryConOco Do
  Begin
    edtDesOco.Text := FieldByName('OCO_DESOCO').AsString;
  End;
end;

procedure TfrmFatRomManutEntrega.pGravaEntFat;
Var
  qryUpd     : TUniQuery;
  strSql     : String;
  stlDocs    : TStringList;
  intIdx     : Integer;
  strPrefixo : String;
  objEndEnt : TEnderecoEntrega;
  strAutEnt: String;

  function fRetornaLocRet():String;
  begin
    Result := '';

    If (cmbLocRet.Visible) And (cmbLocRet.Enabled) Then
      Result := fRetSiglaLocalRetira(cmbLocRet.Text);
  end;

  procedure pExecutaUpdate;
  Begin
    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSql);

      ParamByName('ENTFAT').AsString := edtEntFat.Text;

      if not fEmptyStr(strAutEnt) then
        ParamByName('ENTGER').AsString := strAutEnt;

      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If edtEntFat.Text = 'S' Then
        ParamByName('DTAPRE').AsDateTime := StrToDate(mskDtaPre.Text);

      ExecSQL;
    End;
  End;

  procedure pExecutaUpdateDocumento;
  Begin
    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSql);

      If (Assigned(FindParam('ENTRET'))) Then
        ParamByName('ENTRET').AsString := IIF(edtEntFat.Text = 'S', 'E', 'R');
      If (Assigned(FindParam('ENTFAT'))) Then
        ParamByName('ENTFAT').AsString := edtEntFat.Text;
      If (Assigned(FindParam('NUMDOC'))) Then
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      If (Assigned(FindParam('ESPDOC'))) Then
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      If (Assigned(FindParam('CODEMP'))) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
      If (Assigned(FindParam('DTENTR'))) Then
        ParamByName('DTENTR').AsDateTime := StrToDate(mskDtaPre.Text);
      If (Assigned(FindParam('TURENT'))) Then
        ParamByName('TURENT').AsString := objTurno.fTurnoIntToStr(cmbTurEnt.ItemIndex);
      If (Assigned(FindParam('ENTURG'))) Then
        ParamByName('ENTURG').AsString := IIF(chkUrgente.Checked, 'S', 'N');
      If (Assigned(FindParam('CLIBUS'))) Then
        ParamByName('CLIBUS').AsString := IIF(cmbCliBus.ItemIndex = 1, 'S', 'N');
      If (Assigned(FindParam('LOCRET'))) Then
        ParamByName('LOCRET').AsString := fRetornaLocRet;

      ExecSQL;
    End;
  End;

  procedure pInserirOcorrencia;
  var
    strOco_AutInc : String;
    strTab_Ocorre : String;
  Begin

    If strTabela.IsEmpty Then
      Exit;

    If strAutInc.IsEmpty Then
      Exit;

    If (strTabela = 'FATGOR') Then
    Begin
      strOco_AutInc := 'OCO_INCPED';
      strTab_Ocorre := 'OCOPED';
    End
    Else
    Begin
      strOco_AutInc := IIF(strTabela = 'MOVGER', 'OCO_INCGER', 'OCO_INCNOT');
      strTab_Ocorre := IIF(strTabela = 'MOVGER', 'OCOGER'    , 'OCONOT');
    End;

    qryUpd.Close;
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM ' + strTab_Ocorre + ' WHERE FALSE');
    qryUpd.Open;

    qryUpd.Append;
    qryUpd.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem(strTab_Ocorre, VS_strCodEmp);
    qryUpd.FieldByName(strOco_AutInc).AsString  := strAutInc;
    qryUpd.FieldByName('OCO_DTAHOR').AsDateTime := fRetDtaHraServidor;
    qryUpd.FieldByName('OCO_CODOPE').AsString   := strLoginUsuarioLogado;
    qryUpd.FieldByName('OCO_CODOCO').AsString   := edtCodOco.Text;
    qryUpd.Post;

  End;

begin
  strAutEnt := EmptyStr;
  if edtEntFat.Text = 'S' then
  begin
    objEndEnt := TEnderecoEntrega.Create(Self);
    try
      objEndEnt.recEndere.strCodCli := edtCodCli.Text;

      if not objEndEnt.fSelecionaEnderecoEntrega(edtCodCli.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Se a opção "Entregar no faturamento" '+
                              'estiver "S" o endereço de entrega deve ser selecionado para continuar!', ['&Ok']);
        Exit;
      end;

      strAutEnt := objEndEnt.recEndere.strIncrem;
    finally
      FreeAndNil(objEndEnt);
    end;
  end;

  qryUpd := fCriaQuery(Nil);
  stlDocs:= TStringList.Create;

  strPrefixo := IIF(edtEspDoc.Text = 'PD', 'FGO', 'GER');

  Try

    Try

      fStartTransaction;

      strSql := '';
      strSql := strSql + ' UPDATE                    ';
      strSql := strSql + '   '+strTabela+'                  ';
      strSql := strSql + ' JOIN '+IIF(strTabela = 'FATGOR', 'AUXGOR', 'AUXMOV')+' ON ';
      strSql := strSql + '   '+strTabela+'.AUTOINCREM = AUX_SEQGER ';
      strSql := strSql + ' SET                       ';
      strSql := strSql + ' 	'+strPrefixo+'_ENTFAT = :ENTFAT     ';
      strSql := strSql + ' ,AUX_ENTGER = '+IIF(not fEmptyStr(strAutEnt), ':ENTGER', 'NULL');

      If edtEntFat.Text = 'S' Then
        strSql := strSql + ' 	, '+strPrefixo+'_DTENTR = :DTAPRE ';

      strSql := strSql + ' WHERE                     ';
      strSql := strSql + '   '+strPrefixo+'_NUMDOC =:NUMDOC AND ';
      strSql := strSql + '   '+strPrefixo+'_ESPDOC =:ESPDOC AND ';
      strSql := strSql + '   '+strPrefixo+'_CODEMP =:CODEMP     ';

      pExecutaUpdate;

      if edtEspDoc.Text <> 'PD' then
      begin
        strSql := AnsiReplaceStr(strSql, 'MOVGER', 'NOTGER');
        strSql := AnsiReplaceStr(strSql, 'AUXMOV', 'AUXNOT');
        pExecutaUpdate;
      end;

      {EXECUTA UPDATE NA EXTDOR}
      strSql := '';
      if edtEspDoc.Text = 'PD' then
      begin
        strSql := strSql + ' UPDATE FATDOR D                                      ';
        strSql := strSql + ' INNER JOIN  EXTDOR E  ON D.AUTOINCREM = E.FDO_SEQFDO ';
        strSql := strSql + ' INNER JOIN  FATGOR F  ON D.FDO_SEQGER = F.AUTOINCREM ';
        strSql := strSql + ' SET E.FDO_ENTRET   = :ENTRET, ';
        strSql := strSql + '     F.FGO_ENTFAT   = :ENTFAT  ';

        If (cmbLocRet.Visible) Then
          strSql := strSql + '    , E.FDO_LOCRET   = :LOCRET   ';

        If edtEntFat.Text = 'S' Then
          strSql := strSql + '    , E.FDO_DTENTR   = :DTENTR   ';

        If fCfgSis('EXITUR', varBoolean) then
          strSql := strSql + '    , E.FDO_TURENT   = :TURENT   ';

        If cmbCliBus.Visible Then
          strSql := strSql + '    , E.FDO_CLIBUS   = :CLIBUS   ';

        strSql := strSql + ' WHERE D.FDO_NUMDOC = :NUMDOC   ';
        strSql := strSql + '   AND D.FDO_ESPDOC = :ESPDOC   ';
        strSql := strSql + '   AND D.FDO_CODEMP = :CODEMP   ';
        pExecutaUpdateDocumento();
      end
      else
      begin
        strSql := strSql + 'UPDATE MOVDET M                               ';
        strSql := strSql + '  JOIN FATDOR D ON D.FDO_NUMDOC = M.DET_NUM_PD';
        strSql := strSql + '               AND D.FDO_ESPDOC = M.DET_ESP_PD';
        strSql := strSql + '               AND D.FDO_CODEMP = M.DET_EMP_PD';
        strSql := strSql + '               AND D.FDO_CODITE = M.DET_CODITE';
        strSql := strSql + '               AND D.FDO_SEQIND = M.DET_IND_PD';
        strSql := strSql + '  JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM';
        strSql := strSql + '  JOIN FATGOR F ON D.FDO_SEQGER = F.AUTOINCREM ';
        strSql := strSql + ' SET E.FDO_ENTRET = :ENTRET,                   ';
        strSql := strSql + '     F.FGO_ENTFAT = :ENTFAT                    ';

        If (cmbLocRet.Visible) Then
          strSql := strSql + '    , E.FDO_LOCRET   = :LOCRET   ';

        If edtEntFat.Text = 'S' Then
          strSql := strSql + '    , E.FDO_DTENTR   = :DTENTR   ';

        If cmbCliBus.Visible Then
          strSql := strSql + '    , E.FDO_CLIBUS   = :CLIBUS   ';
        strSql := strSql + 'WHERE M.DET_NUMDOC = :NUMDOC                  ';
        strSql := strSql + '  AND M.DET_ESPDOC = :ESPDOC                  ';
        strSql := strSql + '  AND M.DET_CODEMP = :CODEMP                  ';
        pExecutaUpdateDocumento();

        If fCfgSis('EXITUR', varBoolean) then
        begin
          strSql := '';
          strSql := strSql + 'UPDATE MOVDET D   ';
          strSql := strSql + '   JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM';
          strSql := strSql + ' SET T.DET_TURENT   = :TURENT   ';
          strSql := strSql + 'WHERE D.DET_NUMDOC = :NUMDOC    ';
          strSql := strSql + '  AND D.DET_ESPDOC = :ESPDOC    ';
          strSql := strSql + '  AND D.DET_CODEMP = :CODEMP    ';
          pExecutaUpdateDocumento();

          strSql := AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET');
          strSql := AnsiReplaceStr(strSql, 'MOVTRI', 'NOTTRI');
          pExecutaUpdateDocumento();
        end;
      end;

      strSql := '';
      if edtEspDoc.Text = 'PD' then
      begin
        strSql := strSql + ' UPDATE EXTGOR E                                         ';
        strSql := strSql + ' INNER JOIN  FATGOR D  ON D.AUTOINCREM = E.FGO_SEQFGO    ';
        strSql := strSql + ' SET E.FGO_ENTURG   = :ENTURG                            ';
        strSql := strSql + ' WHERE D.FGO_NUMDOC = :NUMDOC   ';
        strSql := strSql + '   AND D.FGO_ESPDOC = :ESPDOC   ';
        strSql := strSql + '   AND D.FGO_CODEMP = :CODEMP   ';
        pExecutaUpdateDocumento();
      end
      else
      begin
        strSql := strSql + 'UPDATE AUXMOV A                                ';
        strSql := strSql + '  JOIN MOVDET M ON M.DET_SEQGER = A.AUX_SEQGER ';
        strSql := strSql + '  SET A.AUX_ENTURG = :ENTURG                   ';
        strSql := strSql + 'WHERE M.DET_NUMDOC = :NUMDOC                   ';
        strSql := strSql + '  AND M.DET_ESPDOC = :ESPDOC                   ';
        strSql := strSql + '  AND M.DET_CODEMP = :CODEMP                   ';
        pExecutaUpdateDocumento();

        If cmbCliBus.Visible Then
        Begin
          strSql := '';
          strSql := strSql + 'UPDATE MOVTRI T                                ';
          strSql := strSql + '  JOIN MOVDET M ON M.AUTOINCREM = T.DET_SEQGER ';
          strSql := strSql + '  SET T.DET_CLIBUS = :CLIBUS                   ';
          strSql := strSql + 'WHERE M.DET_NUMDOC = :NUMDOC                   ';
          strSql := strSql + '  AND M.DET_ESPDOC = :ESPDOC                   ';
          strSql := strSql + '  AND M.DET_CODEMP = :CODEMP                   ';
          pExecutaUpdateDocumento();
        End;
      end;

      If fCfgSis('OCOMAN', varBoolean) Then
        pInserirOcorrencia;

      {DISPARA ATUALIZAÇÃO STATUS}
      if edtEspDoc.Text = 'PD' then
      begin
        stlDocs.CommaText := fCampoTabela('GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP))',
                                          'FATDOR',
                                          ['FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP'],
                                          [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);
      end
      else
      begin
        stlDocs.CommaText := fCampoTabela('GROUP_CONCAT(DISTINCT CONCAT(DET_NUM_PD, "-", DET_ESP_PD, "-", DET_EMP_PD))',
                                          'MOVDET',
                                          ['DET_NUMDOC', 'DET_ESPDOC', 'DET_CODEMP'],
                                          [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);
      end;

      For intIdx := 0 To Pred(stlDocs.Count) Do
      Begin
        TUpdateStatus.New(
          TParamStatus.New()
            .NumDoc(LeftStr(stlDocs[intIdx], 12))
            .EspDoc(Copy(stlDocs[intIdx], 14, 2))
            .CodEmp(RightStr(stlDocs[intIdx], 3))
          ).pExecute();
      End;

      fCommit;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatRomManutEntrega.pGravaEntFat]');
    End;

  Finally
    FreeAndNil(qryUpd);
    stlDocs.Free;
    pLimpaTela;
  End;

end;

end.
