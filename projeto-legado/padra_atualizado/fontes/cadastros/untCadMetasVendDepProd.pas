unit untCadMetasVendDepProd;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, DB, UniDataSetProvider, Uni,
  AppEvnts, Menus, StdCtrls, EditFocus, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons,
  BitBtnLockedIncrem, ExtCtrls, MemDS, DBAccess, UniClientDataSet, Provider, Mask,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, Vcl.DBCtrls,
  DBEditFocus;

type
  TfrmCadMetasVendDepProd = class(TfrmPaiOrdena)
    pnlFiltro: TPanel;
    pnlDados: TPanel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    Label3: TLabel;
    mskDtaAtual: TMaskEditFocus;
    Label2: TLabel;
    Label1: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    pnlMesAnoOrigem: TPanel;
    Label4: TLabel;
    mskDtaOrigem: TMaskEditFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblDepVen: TLabel;
    edtPraMed: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtMarLiq: TEditFocus;
    edtFatura: TEditFocus;
    Label12: TLabel;
    btnConfirmar: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaVDE_CODVEN: TStringField;
    cdsConsultaVDE_CODEMP: TStringField;
    cdsConsultaVDE_MESANO: TStringField;
    cdsConsultaVDE_CODDEP: TStringField;
    cdsConsultaVDE_PRZMED: TFloatField;
    cdsConsultaVDE_VALFAT: TFloatField;
    cdsConsultaVDE_MARLIQ: TFloatField;
    qryConsultaAUTOINCREM: TStringField;
    qryConsultaVDE_CODVEN: TStringField;
    qryConsultaVDE_CODEMP: TStringField;
    qryConsultaVDE_MESANO: TStringField;
    qryConsultaVDE_CODDEP: TStringField;
    qryConsultaVDE_PRZMED: TFloatField;
    qryConsultaVDE_VALFAT: TFloatField;
    qryConsultaVDE_MARLIQ: TFloatField;
    qryCadDep: TUniQuery;
    qryCadDepDEP_CODIGO: TStringField;
    qryCadDepDEP_DESCRI: TStringField;
    cdsConsultaDEPARTAMENTO: TStringField;
    qryConsultaDEPARTAMENTO: TStringField;
    lblTipOpe: TLabel;
    cdsConsultaVDE_TOTFAT: TAggregateField;
    pnlTotalizacoes: TPanel;
    lblTotFat: TLabel;
    edtTotFat: TDBEditFocus;
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryCadOpe: TUniQuery;
    qryConEmp: TUniQuery;
    strMesAno: String;
    strMesAnoOri: String;
    procedure pCarregaVendedor(strCodVen: String);
    procedure pCarregaEmpresa;
    procedure pCopiaMeta;
    procedure pCopiaMetaMetVde;
    procedure pAdicionaRegistro;
    procedure pLimpaRegistro;
    procedure pAbreCadDep;
    procedure pCarregaRegistro;
    procedure pLimpaFiltro;
    procedure pDeletaRegistro;
    procedure pLimparEdits(Panel: TPanel);
    procedure pHabilitaDigitacaoDeptos;
    procedure pCarregaCabecalho;
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;  
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  end;

implementation

uses SysUtils, Variants, strUtils, untConsultas, untPesqAux, untFuncoesSimples,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadMetasVendDepProd.btnConfirmarClick(Sender: TObject);
  Var
    intNroErr: Integer;
begin
  inherited;

  If (Not btnConfirmar.Visible) Or (Not btnConfirmar.Enabled) Or (pnlFiltro.Enabled) Then
    Exit;

  If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
    Exit;

  Try

    fStartTransaction;

    intNroErr := cdsConsulta.ApplyUpdates(-1);

   If intNroErr = 0 Then
    Begin
      fCommit;
      fMensagem('INFORMAÇÃO','Registros gravados com sucesso !',['&Ok']);
      pLimpaRegistro;
      pLimpaFiltro;
      btnCopiarMetas.Enabled := False;
      pnlDados.Enabled       := False;
      cdsConsulta.Close;
    End
    Else
      fRollBack;

  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pGravarMetas]');
    End;
  End;

  pnlMesAnoOrigem.Visible := False;
  pnlFiltro.Enabled := True;
  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasVendDepProd.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  If (Not btnCopiarMetas.Visible) Or (Not btnCopiarMetas.Enabled) Then
    Exit;

  pnlMesAnoOrigem.Visible := True;
  pSetFocus(mskDtaOrigem);
end;

procedure TfrmCadMetasVendDepProd.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cdsConsulta.FieldByName('VDE_PRZMED')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('VDE_VALFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('VDE_MARLIQ')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadMetasVendDepProd.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN: Begin
                 pCarregaRegistro;
                 pSetFocus(edtCodDep);
               End;
    VK_DELETE: pDeletaRegistro;
    VK_ESCAPE: Begin
                 pLimparEdits(pnlDados);
                 pSetFocus(edtCodDep);
               End;
    Else Inherited;
  End;
end;

procedure TfrmCadMetasVendDepProd.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasVendDepProd.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasVendDepProd.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVen: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVen) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMetasVendDepProd.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT METVDE.AUTOINCREM, ';
  Result := Result + '        VDE_CODVEN, ';
  Result := Result + '        VDE_CODEMP, ';
  Result := Result + '        VDE_MESANO, ';
  Result := Result + '	      VDE_CODDEP, ';
  Result := Result + '	      VDE_PRZMED, ';
  Result := Result + '	      VDE_VALFAT, ';
  Result := Result + '	      VDE_MARLIQ  ';
  Result := Result + '   FROM METVDE ';
  Result := Result + '  WHERE VDE_CODVEN = :CODVEN ';
  Result := Result + '    AND VDE_CODEMP = :CODEMP ';
  Result := Result + '    AND VDE_MESANO = :MESANO ';
end;

procedure TfrmCadMetasVendDepProd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryCadOpe) Then
    FreeAndNil(qryCadOpe);
  If Assigned(qryConEmp) Then
    FreeAndNil(qryConEmp);
  qryCadDep.Close;
end;

procedure TfrmCadMetasVendDepProd.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadOpe := fCriaQuery(Self);
  qryConEmp := fCriaQuery(Self);
end;

procedure TfrmCadMetasVendDepProd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And
     (((ActiveControl) = dbgConsulta) Or (ActiveControl.Parent = pnlDados) And
     (Not fEmptyStr(edtCodDep.Text))) Then
  Begin
    pLimparEdits(pnlDados);
    pSetFocus(edtCodDep);
  End
  Else If (Key = VK_ESCAPE) And (pnlDados.Enabled) Then
  Begin
    If fMensagem('','Deseja cancelar a operação?',['&Sim','&Não']) = 1 Then
    Begin
      pLimparEdits(pnlDados);
      pHabilitaDigitacaoDeptos;

      pLimparEdits(pnlFiltro);
      lblTipOpe.Visible := False;
      cdsConsulta.Close;
      mskDtaOrigem.Clear;
      pCarregaCabecalho;
      pSetFocus(edtCodVen);
    End
    Else
      pSetFocus(edtCodDep);
  End
  Else If (Key = VK_ESCAPE) And ((ActiveControl) <> dbgConsulta) Then
  begin
    Close;
  End
  Else If (Key = VK_F10) Then
  Begin
    If btnConfirmar.Visible Then
      btnConfirmar.Click;
  End
  Else If (Key = VK_F11) Then
  Begin
    btnCopiarMetas.Click;
  End
  Else
    Inherited;
end;

procedure TfrmCadMetasVendDepProd.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaCabecalho;
  pAbreCadDep;
  pSetFocus(edtCodVen);
  btnPesquisar.Visible := False;
  btnMudaOrdem.Visible := False;
  btnCopiarMetas.Enabled := False;
  pnlDados.Enabled       := False;
  blnFecharComEscape := False;
end;

function TfrmCadMetasVendDepProd.fSetParametros: Boolean;
begin
  Result := true;

  try
    qryConsulta.ParamByName('CODVEN').AsString := edtCodVen.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text
    Else
      qryConsulta.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

    qryConsulta.ParamByName('MESANO').AsString := strMesAno;

  except
    Result := false;
  end;
end;

function TfrmCadMetasVendDepProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O código do vendedor deve ser preenchido!',['&O K']);
        edtNomVen.Clear;
        lblTipOpe.Visible := False;
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor(edtCodVen.Text);
        If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','O código da empresa deve ser preenchido!',['&OK']);
        edtNomEmp.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(qryConEmp.FieldByName('EMP_CODEMP').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodDep) And (blnBuscaPorChave) Then
    Begin
      If (fEmptyStr(edtCodDep.Text)) Then
      Begin
        pSetFocus(dbgConsulta);
        blnMudarFoco := False;
      End
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[edtCodDep.Text]);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPraMed) And (blnBuscaPorChave) Then
    Begin
      If (fStrToFloat(edtPraMed.Text) <= 0) Then
      Begin
        fMensagem('', 'O Prazo Médio deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtFatura) And (blnBuscaPorChave) Then
    Begin
      If (fStrToFloat(edtFatura.Text) <= 0) Then
      Begin
        fMensagem('', 'O Faturamento deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtMarLiq) And (blnBuscaPorChave) Then
    Begin
      If (fStrToFloat(edtMarLiq.Text) <= 0) Then
      Begin
        fMensagem('', 'A Margem Liquida deve ser maior que zero!', ['&Ok']);
        Result := False;
      End
      Else
        pAdicionaRegistro;
    End

    Else If (Sender = mskDtaAtual) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyDate(mskDtaAtual.Text)) And (Not fValidaDataStr('01/' + mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'O mês / ano atual informado é inválido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaAtual.Text := FormatDateTime('MM/YYYY', strToDate('01/' + mskDtaAtual.Text));

        If Not fEmptyStr(edtCodVen.Text) Then
        Begin
          If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno) Then
          Begin
            strMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);
            cdsConsulta.Close;
          End;

          If fAbreConsulta Then
            pHabilitaDigitacaoDeptos
          Else
            Result := False;
        End;
      End;
    End
    Else If (Sender = mskDtaOrigem) And (blnBuscaPorChave) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyDate(mskDtaOrigem.Text)) And (Not fValidaDataStr('01/' + mskDtaOrigem.Text)) Then
      Begin
        fMensagem('', 'O mês / ano de origem informado é inválido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaOrigem.Text := FormatDateTime('MM/YYYY', strToDate('01/' + mskDtaOrigem.Text));
        strMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/','');
        pCopiaMeta;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasVendDepProd.pLimparEdits(Panel: TPanel);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Panel.ControlCount -1 Do
  Begin
    If (Panel.Controls[intCnt] Is TEditFocus) Then
      TEditFocus(Panel.Controls[intCnt]).Clear;
    If (Panel.Controls[intCnt] Is TMaskEditFocus) Then
      TMaskEditFocus(Panel.Controls[intCnt]).Clear;
  End;
end;

procedure TfrmCadMetasVendDepProd.pAbreCadDep;
begin
  With qryCadDep Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT DEP_CODIGO, DEP_DESCRI FROM CADDEP ');
    Open;
  End;
end;

procedure TfrmCadMetasVendDepProd.pAdicionaRegistro;
begin
  if not (cdsConsulta.Active) then
    cdsConsulta.open;

  With cdsConsulta Do
  If Locate('VDE_CODEMP;VDE_CODVEN;VDE_MESANO;VDE_CODDEP', VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),edtCodDep.Text]), []) Then
  Begin
    Edit;
    FieldByName('VDE_PRZMED').AsFloat := fStrToFloat(edtPraMed.Text);
    FieldByName('VDE_VALFAT').AsFloat := fStrToFloat(edtFatura.Text);
    FieldByName('VDE_MARLIQ').AsFloat := fStrToFloat(edtMarLiq.Text);
    Post;
  End
  Else
  Begin
    blnPodeIncluir := True;
    Insert;
    FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('METVDE', VS_strCodEmp);
    FieldByName('VDE_CODVEN').AsString  := edtCodVen.Text;
    FieldByName('VDE_CODEMP').AsString  := edtCodEmp.Text;
    FieldByName('VDE_MESANO').AsString  := strMesAno;
    FieldByName('VDE_CODDEP').AsString  := edtCodDep.Text;
    FieldByName('VDE_PRZMED').AsFloat   := fStrToFloat(edtPraMed.Text);
    FieldByName('VDE_VALFAT').AsFloat   := fStrToFloat(edtFatura.Text);
    FieldByName('VDE_MARLIQ').AsFloat   := fStrToFloat(edtMarLiq.Text);
    Post;
    blnPodeIncluir := False;
  End;

  pLimpaRegistro;
  pSetFocus(pnlDados);
end;

procedure TfrmCadMetasVendDepProd.pCarregaCabecalho;
begin
  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;
  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  strMesAno        := AnsiReplaceStr(mskDtaAtual.Text, '/', '');
end;

procedure TfrmCadMetasVendDepProd.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadMetasVendDepProd.pCarregaRegistro;
begin
  With cdsConsulta Do
  Begin
    edtCodDep.Text := FieldByName('VDE_CODDEP').AsString;
    edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[edtCodDep.Text]);
    edtPraMed.Text := FloatToStr(FieldByName('VDE_PRZMED').AsFloat);
    edtFatura.Text := FloatToStr(FieldByName('VDE_VALFAT').AsFloat);
    edtMarLiq.Text := FloatToStr(FieldByName('VDE_MARLIQ').AsFloat);    
  End;
end;

procedure TfrmCadMetasVendDepProd.pCarregaVendedor(strCodVen: String);
begin
  pPesquisaCadOpe(Nil, qryCadOpe, edtCodVen.Text);
  edtNomVen.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;

  lblTipOpe.Visible := True;
  If qryCadOpe.FieldByName('OPE_INTEXT').AsString = 'G' Then
    lblTipOpe.Caption := 'Gerente'
  Else If qryCadOpe.FieldByName('OPE_INTEXT').AsString = 'S' Then
    lblTipOpe.Caption := 'Sub-gerente'
  Else
    lblTipOpe.Visible := False;
end;

procedure TfrmCadMetasVendDepProd.pCopiaMeta;
begin
  Try
    cdsConsulta.DisableControls;
    Try

      //Copia os departamentos de um determinado periodo
      pCopiaMetaMetVde;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[pCopiaMeta]');
      End;
    End;
    cdsConsulta.First;
  Finally
   cdsConsulta.EnableControls;
  End;
end;

procedure TfrmCadMetasVendDepProd.pCopiaMetaMetVde;
  Var
    qryMetVde: TUniQuery;
Begin

  Try
    qryMetVde := fCriaQuery;
    With qryMetVde, SQL Do
    Begin
      Clear;
      Add(' SELECT VDE_CODVEN, ');
      Add('        VDE_CODEMP, ');
      Add('        VDE_MESANO, ');
      Add('        VDE_CODDEP, ');
      Add('        VDE_PRZMED, ');
      Add('        VDE_VALFAT, ');
      Add('        VDE_MARLIQ  ');
      Add('   FROM METVDE ');
      Add('  WHERE VDE_MESANO = :MESANO AND ');
      Add('        VDE_CODEMP = :CODEMP AND ');
      Add('        VDE_CODVEN = :CODVEN     ');

      ParamByName('MESANO').AsString := strMesAnoOri;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('CODVEN').AsString := edtCodVen.Text;

      Open;
    End;

    If Not qryMetVde.IsEmpty Then
    Begin
      With cdsConsulta Do
      Begin
        DisableControls;
        Tag := 1;

        Filtered := False;

        First;
        While Not Eof Do
          Delete;

        Filtered := True;

        While Not qryMetVde.Eof Do
        Begin

          Insert;
          FieldByName('VDE_CODVEN').AsString := qryMetVde.FieldByName('VDE_CODVEN').AsString;
          FieldByName('VDE_CODEMP').AsString := qryMetVde.FieldByName('VDE_CODEMP').AsString;
          FieldByName('VDE_CODDEP').AsString := qryMetVde.FieldByName('VDE_CODDEP').AsString;
          FieldByName('VDE_PRZMED').AsString := qryMetVde.FieldByName('VDE_PRZMED').AsString;
          FieldByName('VDE_VALFAT').AsString := qryMetVde.FieldByName('VDE_VALFAT').AsString;
          FieldByName('VDE_MARLIQ').AsString := qryMetVde.FieldByName('VDE_MARLIQ').AsString;
          FieldByName('VDE_MESANO').AsString := strMesAno;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METVDE', VS_strCodEmp);
          Post;

          qryMetVde.Next;
        End;

        Tag := 0;

        EnableControls;
        mskDtaOrigem.Clear;
        pnlMesAnoOrigem.Visible := False;
        pSetFocus(dbgConsulta);

        pMensagemOk('Metas copiadas com sucesso!');
      End;
    End
    Else
    Begin
      fMensagem('INFORMAÇÃO','Não existem metas para esse vendedor para esse período de origem: ' + LeftStr(strMesAnoOri, 2) + '/' + RightStr(strMesAnoOri, 4),['&Ok']);
      pSetFocus(mskDtaOrigem);
      blnMudarFoco := False;
    End;
  Finally
    FreeAndNil(qryMetVde);
  End;
end;

procedure TfrmCadMetasVendDepProd.pDeletaRegistro;
begin
  With cdsConsulta Do
  Begin
    If Not IsEmpty Then
      If RecordCount >= 1 Then
      Begin
        If fMensagem('QUESTÃO','Deseja realmente excluir esse registro ?',['&Sim','&Não']) = 1 Then
        Begin
          Delete;
        End;
      End;
  End;
end;

procedure TfrmCadMetasVendDepProd.pHabilitaDigitacaoDeptos;
Var
  blnCabecalhoPreenchido: Boolean;
begin
  blnCabecalhoPreenchido := (Not fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text))) And
                            (Not fEmptyStr(edtNomVen.Text)) And
                            (Not fEmptyStr(edtNomEmp.Text));

  pnlDados.Enabled        := blnCabecalhoPreenchido;
  pnlFiltro.Enabled       := Not blnCabecalhoPreenchido;
  btnCopiarMetas.Enabled  := blnCabecalhoPreenchido;

  If blnCabecalhoPreenchido Then
    pSetFocus(edtCodDep);
end;

procedure TfrmCadMetasVendDepProd.pLimpaFiltro;
begin
  edtCodVen.Clear;
  edtNomVen.Clear;
  lblTipOpe.Visible := False;
  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasVendDepProd.pLimpaRegistro;
begin
  edtCodDep.Clear;
  edtDesDep.Clear;
  edtPraMed.Clear;
  edtFatura.Clear;
  edtMarLiq.Clear;
  pSetFocus(edtCodDep);
end;

end.
