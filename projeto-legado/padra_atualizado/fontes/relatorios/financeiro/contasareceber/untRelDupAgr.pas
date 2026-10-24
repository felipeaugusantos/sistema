unit untRelDupAgr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untFuncoesFactory, untTypesSistema,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, untIFuncoes, untClassPanelCx,
  ComboBoxFocus;

type
  TfrmRelDupAgr = class(TfrmPaiRelatorio)
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    grpPeriodoVencimento: TGroupBox;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label5: TLabel;
    grpPeriodoCadastro: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    mskDtaCadIni: TMaskEditFocus;
    mskDtaCadFin: TMaskEditFocus;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    gpbDocAgr: TGroupBox;
    edtEmpAgr: TEditFocus;
    Label3: TLabel;
    edtDesEmpAgr: TEditFocus;
    edtNumAgr: TEditFocus;
    Label4: TLabel;
    gpbDupAgr: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtNumDup: TEditFocus;
    edtEspDoc: TEditFocus;
    Label9: TLabel;
    lblVendedor: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtDesPortador: TEditFocus;
    lbl1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    gpbConPag: TGroupBox;
    lbl6: TLabel;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    cmbTipFor: TComboBoxFocus;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);

    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtCodClienteExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtEmpAgrKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpAgrExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    arrLinCli : TConsultasArray;
    arrRede   : TConsultasArray;
    arrPortad : TConsultasArray;
    arrEvento : TConsultasArray;
    arrOper   : TConsultasArray;
    arrCndPag : TConsultasArray;

    qryRelatorio: TUniQuery;

    procedure pCriaQryRelatorio;

    protected
      function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }
  end;

var
  frmRelDupAgr: TfrmRelDupAgr;

implementation

uses untQckDupAgr, Data.DB;

{$R *.dfm}

{*****************}
{* VALIDA CAMPOS *}
{**************ED*}
function TfrmRelDupAgr.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}

    If (Sender = mskDtaIni) And grpPeriodoVencimento.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
        mskDtaFin.Clear;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaCadIni) And grpPeriodoCadastro.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        mskDtaCadFin.Enabled := False;
        mskDtaCadFin.Clear;
      End
      Else If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
             Result := False;
        If (Sender = mskDtaCadIni) Then
            Sender := mskDtaIni;
      End
      Else
      Begin
        mskDtaCadFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) And grpPeriodoVencimento.Enabled Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else If ((Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))))
           And (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaCadFin) And grpPeriodoCadastro.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))
                  And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'O campos Data Final e Inicial devem ser preenchidos!', ['&O k']);
        Result := False;
        Sender := mskDtaCadIni;
      End
      Else If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text))) Then
      Begin
        If (StrToDate(mskDtaCadIni.Text) > StrToDate(mskDtaCadFin.Text)) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End
      Else If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        mskDtaCadFin.Enabled := False;
        mskDtaCadFin.Clear;
      End
      Else
      Begin
        mskDtaCadFin.Enabled := True;
      End;
    End

    Else If Sender = edtNumAgr Then
    Begin

      If Not fEmptyStr(edtNumAgr.Text) Then
      Begin
        gpbDupAgr.Enabled := False;
        edtNumDup.Clear;
        edtEspDoc.Clear;
        edtCodEmp.Clear;
        edtDesEmp.Clear;
        grpPeriodoVencimento.Enabled := False;
        mskDtaIni.Clear;
        mskDtaFin.Clear;
        grpPeriodoCadastro.Enabled := False;
        mskDtaCadIni.Clear;
        mskDtaCadFin.Clear;
      End
      Else
      Begin
        gpbDupAgr.Enabled := True;
        grpPeriodoVencimento.Enabled := fEmptyStr(edtNumDup.Text);
        grpPeriodoCadastro.Enabled := fEmptyStr(edtNumDup.Text);
      End;

    End
    Else If Sender = edtEmpAgr Then
    Begin
      If Not fEmptyStr(edtEmpAgr.Text) Then
      Begin
        If Pos(edtEmpAgr.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End
      Else If Not fEmptyStr(edtNumAgr.Text) Then
      Begin
        fMensagem('', 'Quando o campo agrupamento estiver preenchido o campo empresa também deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If Sender = edtNumDup Then
    Begin
      If Not fEmptyStr(edtNumDup.Text) Then
      Begin
        edtEspDoc.Enabled := True;
        edtCodEmp.Enabled := True;
        grpPeriodoVencimento.Enabled := False;
        mskDtaIni.Clear;
        mskDtaFin.Clear;
        grpPeriodoCadastro.Enabled := False;
        mskDtaCadIni.Clear;
        mskDtaCadFin.Clear;
      End
      Else
      Begin
        edtEspDoc.Enabled := False;
        edtCodEmp.Enabled := False;
        edtEspDoc.Clear;
        edtCodEmp.Clear;
        edtDesEmp.Clear;
        grpPeriodoVencimento.Enabled := fEmptyStr(edtNumAgr.Text);
        grpPeriodoCadastro.Enabled := fEmptyStr(edtNumAgr.Text);
      End;
    End
    Else If Sender = edtEspDoc Then
    Begin
      If edtEspDoc.Enabled Then
      Begin
        If fEmptyStr(edtEspDoc.Text) Then
        Begin
          fMensagem('', 'Quando o campo duplicata estiver preenchido o campo espécie também deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If Sender = edtCodEmp Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End
      Else If Not fEmptyStr(edtNumDup.Text) Then
      Begin
        fMensagem('', 'Quando o campo duplicata estiver preenchido o campo empresa também deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelDupAgr.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrLinCli, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCnd, arrCndPag, fRetDesConPag, Nil, 'da Condição de Pagamento');
end;

procedure TfrmRelDupAgr.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not fCfgSis('USACND', varBoolean) Then
    Exit;

  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCndPag, False) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmp, fRetNomeEmpresa, nil, 'da empressa');
end;

procedure TfrmRelDupAgr.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.edtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEve, edtDesEve, arrEvento, fRetNomEvento, Nil, 'do evento');
end;

procedure TfrmRelDupAgr.edtCodEveKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.edtEmpAgrExit(Sender: TObject);
  Var
    arrEmpAgr: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtEmpAgr, edtDesEmpAgr, arrEmpAgr, fRetNomeEmpresa, nil, 'da empressa');
end;

procedure TfrmRelDupAgr.edtEmpAgrKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmpAgr: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtEmpAgr, edtDesEmpAgr, nil, Key, arrEmpAgr) Then
  Begin
    If fValidaCampos(edtEmpAgr, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelDupAgr.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede, edtDesRede, arrRede, nil, fRetNomeRedeLoja, 'da rede');
end;

procedure TfrmRelDupAgr.edtCodRedeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOpe, edtNomOpe, arrOper, fRetNomeOperador, nil, 'do operador');
end;

procedure TfrmRelDupAgr.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodOpe, edtNomOpe, Nil, Key, arrOper, False) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortad, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmRelDupAgr.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortad, False) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelDupAgr.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;

procedure TfrmRelDupAgr.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelDupAgr.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrLinCli, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede, edtDesRede, arrRede, nil, fRetNomeRedeLoja, 'da rede');
    pSetFocus(edtCodPor);
  End
  Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelDupAgr.btnImprimirClick(Sender: TObject);
  Var
    strSQL : String;
    strCliente : String;
    strRede    : String;
    strPortad  : String;
    strEvento  : String;
    strCndPag  : String;
    strOpeLog  : String;

begin
  inherited;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  AGR.CTR_NUMAGR, ';
    strSQL := strSQL + '  AGR.CTR_NUMDUP, ';
    strSQL := strSQL + '  AGR.CTR_PARCEL, ';
    strSQL := strSQL + '  AGR.CTR_ESPDOC, ';
    strSQL := strSQL + '  AGR.CTR_DTACAD, ';
    strSQL := strSQL + '  AGR.CTR_CODEMP, ';
    strSQL := strSQL + '  AGR.CTR_CODVEN, ';
    strSQL := strSQL + '  AGR.CTR_CODCLI, ';
    strSQL := strSQL + '  AGR.CTR_DTAVEN, ';
    strSQL := strSQL + '  AGR.CTR_EMPAGR, ';
    strSQL := strSQL + '  AGR.CTR_VALDUP AS CTR_VALORI, ';
    strSQL := strSQL + '  CLI_NOMCLI,  ';
    strSQL := strSQL + '  CTR_OPELOG   ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DUPAGR AGR ';
    strSQL := strSQL + 'LEFT JOIN CADCLI  ON ';
    strSQL := strSQL + '  CLI_CODCLI = AGR.CTR_CODCLI ';
    strSQL := strSQL + 'LEFT JOIN LOGCTR LG ON ';
    strSQL := strSQL + '  LG.CTR_NUMDUP = AGR.CTR_NUMAGR AND ';
    strSQL := strSQL + '  LG.CTR_CODEMP = AGR.CTR_EMPAGR AND ';
    strSQL := strSQL + '  LG.CTR_PARCEL = "A" AND ';
    strSQL := strSQL + '  LG.CTR_ESPDOC = "AG" AND ';
    strSQL := strSQL + '  LG.CTR_CODCLI = AGR.CTR_CODCLI AND ';
    strSQL := strSQL + '  LG.CTR_DESCRI = "INCLUSÃO" AND ';
    strSQL := strSQL + '  LG.CTR_SEQBAI = 0 ';
    strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = AGR.CTR_CODCND ';
    strSQL := strSQL + 'WHERE ';

    If Not fEmptyStr(edtEmpAgr.Text) Then
      strSQL := strSQL + '  AGR.CTR_EMPAGR = :EMPAGR AND '
    Else
      strSQL := strSQL + '  LOCATE(AGR.CTR_EMPAGR, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') AND ';

    If Not fEmptyStr(edtNumAgr.Text) Then
    Begin
      strSQL := strSQL + '  AGR.CTR_NUMAGR = :NUMAGR ';
    End
    Else
    Begin

      If (fEmptyStr(edtNumDup.Text)) And
         (fEmptyStr(edtEspDoc.Text)) And
         (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        strSQL := strSQL + '  (AGR.CTR_NUMAGR, AGR.CTR_EMPAGR) IN (SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '                   CTR_NUMDUP, CTR_CODEMP ';
        strSQL := strSQL + '                 FROM  ';
        strSQL := strSQL + '                   CADREC ';
        strSQL := strSQL + '                 WHERE ';
        strSQL := strSQL + '                   CTR_ESPDOC = "AG" ';
        strSQL := strSQL + '                   )                 ';
      End
      Else
      Begin
        strSQL := strSQL + '  (AGR.CTR_NUMAGR, AGR.CTR_EMPAGR) IN (SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '                      CTR_NUMAGR, CTR_EMPAGR  ';
        strSQL := strSQL + '                    FROM  ';
        strSQL := strSQL + '                      DUPAGR ';
        strSQL := strSQL + '                 WHERE ';
        If Not (fEmptyStr(edtNumDup.Text)) Then
        Begin
          strSQL := strSQL + '                   CTR_NUMDUP = :NUMDUP ';
          strSQL := strSQL + '                   AND CTR_ESPDOC = :ESPDOC ';
          strSQL := strSQL + '                   AND CTR_CODEMP = :CODEMP ';
        End
        Else
        Begin
          If Not fEmptyStr(edtEspDoc.Text) Then
          Begin
            strSQL := strSQL + '                     CTR_ESPDOC = :ESPDOC ';

            If Not fEmptyStr(edtCodEmp.Text) Then
              strSQL := strSQL + '                   AND CTR_CODEMP = :CODEMP ';
          End
          Else
          Begin
            If Not fEmptyStr(edtCodEmp.Text) Then
              strSQL := strSQL + '                   CTR_CODEMP = :CODEMP ';
          End;
        End;
        strSQL := strSQL + '                   )                 ';
      End;
    End;

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      strSQL := strSQL + ' AND AGR.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
      strSQL := strSQL + ' AND AGR.CTR_DTACAD BETWEEN :CADINI AND :CADFIN ';

    strSQL := strSQL + fStrLocate(edtCodCliente, arrLinCli, 'AGR.CTR_CODCLI', 'CODCLI');
    strSQL := strSQL + fStrLocate(edtCodRede, arrRede, 'CLI_CODRED', 'CODRED');
    strSQL := strSQL + fStrLocate(edtCodPor, arrPortad, 'AGR.CTR_CODPOR', 'CODPOR');
    strSQL := strSQL + fStrLocate(edtCodEve, arrEvento, 'AGR.CTR_CODEVE', 'CODEVE');
    strSQL := strSQL + fStrLocate(edtCodOpe, arrOper, 'CTR_OPELOG', 'OPELOG');
    strSQL := strSQL + fStrLocate(edtCodCnd, arrCndPag, 'AGR.CTR_CODCND', 'CODCND');

    Case cmbTipFor.ItemIndex Of
      1, 2, 3, 4, 5, 6, 7: strSQL := strSQL + ' AND CND_TIPFOR = :TIPFOR';
    End;

    strSQL := strSQL + ' GROUP BY AGR.AUTOINCREM ';

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '  AGR.CTR_NUMAGR, AGR.CTR_NUMDUP, ';
    strSQL := strSQL + '  AGR.CTR_PARCEL ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtEmpAgr.Text) Then
        ParamByName('EMPAGR').AsString := edtEmpAgr.Text;

      If Not fEmptyStr(edtNumAgr.Text) Then
        ParamByName('NUMAGR').AsString := edtNumAgr.Text
      Else
      Begin
        If Not (fEmptyStr(edtNumDup.Text)) Then
          ParamByName('NUMDUP').AsString := edtNumDup.Text;

        If Not (fEmptyStr(edtEspDoc.Text)) Then
          ParamByName('ESPDOC').AsString := edtEspDoc.Text;

        If Not (fEmptyStr(edtCodEmp.Text)) Then
          ParamByName('CODEMP').AsString := edtCodEmp.Text;

      End;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
      Begin
        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
        ParamByName('CADINI').AsDate   := StrToDate(mskDtaCadIni.Text);
        ParamByName('CADFIN').AsDate   := StrToDate(mskDtaCadFin.Text);
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
      Begin
        ParamByName('CADINI').AsDate   := StrToDate(mskDtaCadIni.Text);
        ParamByName('CADFIN').AsDate   := StrToDate(mskDtaCadFin.Text);
      End;

      pSetaParam(edtCodCliente.Text, arrLinCli, strCliente, 'CODCLI', qryRelatorio);
      pSetaParam(edtCodRede.Text, arrRede, strRede, 'CODRED', qryRelatorio);
      pSetaParam(edtCodPor.Text, arrPortad, strPortad, 'CODPOR', qryRelatorio);
      pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryRelatorio);
      pSetaParam(edtCodOpe.Text, arrOper, strOpeLog, 'OPELOG', qryRelatorio);
      pSetaParam(edtCodCnd.Text, arrCndPag, strCndPag, 'CODCND', qryRelatorio);
      Case cmbTipFor.ItemIndex Of
        1, 2, 3, 4, 5, 6, 7: ParamByName('TIPFOR').AsString := cmbTipFor.Text;
      End;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckDupAgr,frmQckDupAgr);

        frmQckDupAgr.dtsRelatorio.DataSet := qryRelatorio;

        If strTipImp = 'M' Then
          frmQckDupAgr.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckDupAgr.qckPagina.DefaultFilter := Nil;

        If fEmptyStr(edtNumAgr.Text) Then
          frmQckDupAgr.rllNumAgr.Caption := 'AGRUPAMENTO: TODOS'
        Else
          frmQckDupAgr.rllNumAgr.Caption := 'AGRUPAMENTO: ' + edtNumAgr.Text;

        If fEmptyStr(edtEmpAgr.Text) Then
          frmQckDupAgr.rllEmpAgr.Caption := 'EMPRESA AGRUPAMENTO: TODAS'
        Else
          frmQckDupAgr.rllEmpAgr.Caption := 'EMPRESA AGRUPAMENTO: ' + edtEmpAgr.Text + ' - ' + edtDesEmpAgr.Text;

        If fEmptyStr(edtNumDup.Text) Then
          frmQckDupAgr.rllNumDup.Caption := 'DUPLICATA: TODAS'
        Else
          frmQckDupAgr.rllNumDup.Caption := 'DUPLICATA: ' + edtNumDup.Text;

        If fEmptyStr(edtCodEmp.Text) Then
          frmQckDupAgr.rllEmpDup.Caption := 'EMPRESA DUPLICATA: TODAS'
        Else
          frmQckDupAgr.rllEmpDup.Caption := 'EMPRESA DUPLICATA: ' + edtCodEmp.Text + ' - ' + edtDesEmp.Text;

        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
        Begin
          frmQckDupAgr.strOrdem := 'REFERENTE AO PERIODO DE VENCIMENTO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text + ' E CADASTRO DE ' +
                                    mskDtaCadIni.Text + ' A ' + mskDtaCadFin.Text;
        End
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
          frmQckDupAgr.strOrdem := 'REFERENTE AO PERIODO DE CADASTRO DE ' + mskDtaCadIni.Text + ' A ' + mskDtaCadFin.Text
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          frmQckDupAgr.strOrdem := 'REFERENTE AO PERIODO DE VENCIMENTO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
        Else
          frmQckDupAgr.strOrdem := '';

        frmQckDupAgr.rllCliente.Caption  := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrLinCli, strCliente, 'CLIENTE', False, False);
        frmQckDupAgr.rllRedeLoja.Caption := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS', True, False);
        frmQckDupAgr.rllPortad.Caption   := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortad, strPortad, 'PORTADOR', False, False);
        frmQckDupAgr.rllEvento.Caption   := fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'EVENTO', False, False);
        frmQckDupAgr.rllOpeAgr.Caption   := fStrTitulo(edtCodOpe.Text, edtNomOpe, arrOper, strOpeLog, 'OPERADOR', False, False);
        frmQckDupAgr.rllCndPag.Caption   := fStrTitulo(edtCodCnd.Text, edtDesCnd, arrCndPag, strCndPag, 'CONDIÇÃO PAGTO', True, False);
        frmQckDupAgr.rllTipFor.Caption   := 'FORA: ' + cmbTipFor.Text;

        frmQckDupAgr.rllNomeRelatorio.Caption := 'RELATORIO DE DUPLICATAS AGRUPADAS - CONTAS A RECEBER';

        If edtDestino.Text = 'V' Then
          frmQckDupAgr.qckPagina.PreviewModal
        Else
          frmQckDupAgr.qckPagina.Print;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckDupAgr);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;

  btnImprimir.Enabled := True;
  pSetFocus(edtNumAgr);
end;

procedure TfrmRelDupAgr.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumAgr);
end;

procedure TfrmRelDupAgr.FormCreate(Sender: TObject);
begin
  inherited;
  gpbConPag.Visible := fCfgSis('USACND', varBoolean);
  If Not gpbConPag.Visible Then
  Begin
    gpbDestino.Left := gpbConPag.Left;
    Height := Height - gpbConPag.Height + gpbDestino.Height;
  End;
end;

procedure TfrmRelDupAgr.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelDupAgr.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
end;

end.

