unit untRelCtpReimpBordero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untTypesSistema,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,
  MemDS, DBAccess, StrUtils,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmRelCtpReimpBordero = class(TfrmPaiOrdena)
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label12: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtSeqCon: TEditFocus;
    Label27: TLabel;
    edtNumDoc: TEditFocus;
    edtParcel: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnImprimir: TBitBtnLocked;
    Label6: TLabel;
    edtSerie: TEditFocus;
    Label7: TLabel;
    edtPorBai: TEditFocus;
    edtDesPorBai: TEditFocus;
    chkImpHis: TCheckBox;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    chkImpDet: TCheckBox;
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
  private
    { Private declarations }
//    strEmpBai: String;
//    intSeqCon: Longint;
    blnTemSeqConDif: Boolean;

    procedure pFechaConsulta;
    procedure pImprimeBordero;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  end;

implementation

uses untFuncoesSimples, untConstantes, untQckCtpBordero, untConsultas;

{$R *.dfm}

function TfrmRelCtpReimpBordero.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;

        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodFornecedor) Then
    Begin

      If fEmptyStr(edtCodFornecedor.Text) Then
      Begin
        edtDesFornecedor.Text := 'TODOS';
      End Else
      Begin
        edtDesFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);
        If fEmptyStr(edtDesFornecedor.Text) Then
        Begin
          Result := False;
          pMensagemOk('Fornecedor não encontrado!');
        End;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          Result := False;
          pMensagemOk('Empresa não encontrada!');
        End

        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtPorBai) Then
    Begin

      If fEmptyStr(edtPorBai.Text) Then
      Begin
        edtDesPorBai.Text := 'TODOS';
      End Else
      Begin
        edtDesPorBai.Text := fRetNomPortador(edtPorBai.Text);

        If fEmptyStr(edtDesPorBai.Text) Then
        Begin
          Result := False;
          pMensagemOk('Portador não encontrado!');
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text, edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End;

    End
    Else
    Begin
      If not fEmptyStr(mskDtaIni.Text) and fEmptyDate(mskDtaFin.Text) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        mskDtaFin.Enabled := True;
        Result := False;
        exit;
      End Else
      If not fEmptyStr(mskDtaFin.Text) and fEmptyDate(mskDtaIni.Text) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        exit;
      End;

      If not ( fEmptyDate(mskDtaIni.Text) and fEmptyStr(mskDtaFin.Text) ) Then
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
          exit;
        End;

      If fEmptyStr(edtCodFornecedor.Text) Then
      Begin
        edtDesFornecedor.Text := 'TODOS';
      End Else
      Begin
        edtDesFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);
        If fEmptyStr(edtDesFornecedor.Text) Then
        Begin
          pMensagemOk('Fornecedor não encontrado!');
          Result := False;
          exit;
        End;
      End;

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          pMensagemOk('Empresa não encontrada!');
          Result := False;
          exit;
        End

        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
          exit;
        End;
      End;

      If fEmptyStr(edtPorBai.Text) Then
      Begin
        edtDesPorBai.Text := 'TODOS';
      End Else
      Begin
        edtDesPorBai.Text := fRetNomPortador(edtPorBai.Text);

        If fEmptyStr(edtDesPorBai.Text) Then
        Begin
          pMensagemOk('Portador não encontrado!');
          Result := False;
          exit;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
          Exit;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
            exit;
          End;
        End;
      End;

      If fEmptyDate(mskDtaIni.Text) And fEmptyDate(mskDtaFin.Text) And fEmptyStr(edtSeqCon.Text) And fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o período, sequencial de baixa ou o número do documento!', ['&O k']);
        Result := False;
        If Not (Sender = mskDtaIni) And Not (Sender = mskDtaFin) And
           Not (Sender = edtSeqCon) And Not (Sender = edtNumDoc) Then
        Begin
          pSetFocus(mskDtaIni);
        End;

        exit;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCtpReimpBordero.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    fValidaCampos(edtCodFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpReimpBordero.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPor: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtPorBai,
                   edtDesPorBai,
                   Nil,
                   Key,
                   arrPor,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmpresa.Text) Then
  Begin
    if fValidaCampos(edtPorBai,False) then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtpReimpBordero.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpReimpBordero.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco   := False;
  blnSelecionaComEspaco := True;
  blnQuoteLista         := False;

  lflLastField.intIndCol := 1;
  lflLastField.strNomCam := dbgConsulta.Columns[lflLastField.intIndCol].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[lflLastField.intIndCol].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

end;

function TfrmRelCtpReimpBordero.fGetSql(blnLike: Boolean): String;
  Var
    strSql: String;
    strEmp: String;
Begin

  If (fEmptyStr(edtCodEmpresa.Text)) Then
    strEmp := QuotedStr('XXX')
  Else
    strEmp := 'CTP_CODEMP';

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   CONCAT(CTP_EMPBAI, ' + strEmp + ', CTP_SEQCON) AS AUTOINCREM, ';
  strSQL := strSQL + '   CTP_SEQCON, ';
  strSQL := strSQL + '   CTP_EMPBAI, ';
  strSQL := strSQL + '   CTP_PORBAI, ';
  strSQL := strSQL + '   CTP_DTAPAG, ';
  strSQL := strSQL + '   CONCAT(CTP_NUMDUP, CTP_PARCEL) AS CTP_NUMDUP,';
  strSQL := strSQL + '   CTP_SERIE_, ';
  strSQL := strSQL + '   CTP_CODEMP, ';
  strSQL := strSQL + '   CTP_CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS CTP_NOMFOR, ';
  strSQL := strSQL + '   CTP_VALPAG, ';
  strSQL := strSQL +     QuotedStr('CADPAG') + ' AS TABELA ';
  strSQL := strSQL + ' FROM CADPAG ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ';
  strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyDate(mskDtaIni.Text) Then
    strSQL := strSQL + '  AND CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND CTP_CODEMP = :CODEMP';

  If Not fEmptyStr(edtCodFornecedor.Text) Then
    strSQL := strSQL + '  AND CTP_CODFOR = :CODFOR';

  If Not fEmptyStr(edtSeqCon.Text) Then
    strSQL := strSQL + '  AND CTP_SEQCON = :SEQCON';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND CTP_NUMDUP = :NUMDUP';

  If Not fEmptyStr(edtParcel.Text) Then
    strSQL := strSQL + '  AND CTP_PARCEL = :PARCEL';

  If Not fEmptyStr(edtSerie.Text) Then
    strSQL := strSQL + '  AND CTP_SERIE_ = :SERIE_';

  If Not fEmptyStr(edtPorBai.Text) Then
    strSQL := strSQL + '  AND CTP_PORBAI = :PORBAI'
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTP_PORBAI, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  Result := strSQL;
End;

function TfrmRelCtpReimpBordero.fSetParametros: Boolean;
Begin
  If (Not fEmptyStr(edtCodEmpresa.Text)) Then
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    qryConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryConsulta.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  End;

  If Not fEmptyStr(edtCodFornecedor.Text) Then
    qryConsulta.ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

  If Not fEmptyStr(edtSeqCon.Text) Then
    qryConsulta.ParamByName('SEQCON').AsInteger := StrToIntDef(edtSeqCon.Text, -1);

  If Not fEmptyStr(edtNumDoc.Text) Then
    qryConsulta.ParamByName('NUMDUP').AsString := edtNumDoc.Text;

  If Not fEmptyStr(edtParcel.Text) Then
    qryConsulta.ParamByName('PARCEL').AsString := edtParcel.Text;

  If Not fEmptyStr(edtSerie.Text) Then
    qryConsulta.ParamByName('SERIE_').AsString := edtSerie.Text;

  If Not fEmptyStr(edtPorBai.Text) Then
    qryConsulta.ParamByName('PORBAI').AsString := edtPorBai.Text;

  Result := True;
End;

procedure TfrmRelCtpReimpBordero.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F10   : btnImprimir.Click;

    VK_ESCAPE: If pnlPesquisa.Visible Or
                 (mskDtaIni.Focused And (Not cdsConsulta.Active)) Then
                 inherited
               Else
                 pFechaConsulta;

    Else       inherited;
  End;

end;

procedure TfrmRelCtpReimpBordero.pFechaConsulta;
Begin
  cdsConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodFornecedor.Clear;
  edtDesFornecedor.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtSeqCon.Clear;
  edtNumDoc.Clear;
  edtParcel.Clear;
  edtSerie.Clear;

  pSetFocus(mskDtaIni);
End;

procedure TfrmRelCtpReimpBordero.pImprimeBordero;
  Var
    frmQckCtpBordero : TfrmQckCtpBordero;
begin

  pCriarFormularios(TfrmQckCtpBordero, frmQckCtpBordero);

  if Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) and
     Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
     frmQckCtpBordero.strDtaIni := mskDtaIni.Text;
     frmQckCtpBordero.strDtaFin := mskDtaFin.Text;
  End;

  If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
    frmQckCtpBordero.pImprimeBordero(stlListSelecao, 'V', chkImpHis.Checked, True, chkImpDet.Checked, blnTemSeqConDif)
  Else
    frmQckCtpBordero.pImprimeBordero(stlListSelecao, 'I', chkImpHis.Checked, True, chkImpDet.Checked, blnTemSeqConDif);

  pFreeAndNil(frmQckCtpBordero);

end;

procedure TfrmRelCtpReimpBordero.btnConsultarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  stlListSelecao.Clear;
  dtsConsulta.DataSet.close;
  If fValidaCampos(btnConsultar,False) then
  Begin
    fAbreConsulta;
    If cdsConsulta.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há duplicatas para Reimprimir !', ['&O k']);
      cdsConsulta.Close;
      pSetFocus(mskDtaIni);
    End;
  End;
end;

procedure TfrmRelCtpReimpBordero.btnImprimirClick(Sender: TObject);
  Var
    intContador    : Integer;
    strSeqCon      : String;
    strEmpBai      : String;
begin
  inherited;
  if stlListSelecao.Count = 0 then
  begin
   fMensagem('ATENÇÃO!', 'Você deve ao menos selecionar uma duplicata!', ['&O k']);
   exit ;
  end;

  strEmpBai := LeftStr(stlListSelecao[0], 3);
  strSeqCon := Copy(stlListSelecao[0], 7, Length(stlListSelecao[0]) - 6);
  blnTemSeqConDif := False;

  For intContador := 0 To stlListSelecao.Count - 1 Do
  Begin
    If (Copy(stlListSelecao[intContador], 7, Length(stlListSelecao[intContador]) - 6) <> strSeqCon) Or
       (LeftStr(stlListSelecao[intContador], 3) <> strEmpBai)                                       Then
    Begin
      blnTemSeqConDif := True;
      Break;
    End
    Else
      blnTemSeqConDif := False;
  End;

  If Not(dtsConsulta.DataSet.IsEmpty) Then
  Begin
    if dtsConsulta.DataSet.FieldByName('CTP_DTAPAG').IsNull then
    Begin
    	pMensagemOk('Duplicata ' + dtsConsulta.DataSet.FieldByName('CTP_NUMDUP').AsString +
      ' está em aberto' + #13#10 + 'e só poderá ser impressa pela tela de "Baixa de Contas a Pagar"');
      pFechaConsulta;
    End
    Else
    Begin
      If (stlListSelecao.Count > 0) And fPergunta('Confirma a reimpressão dos borderôs?') Then
      Begin
        If blnTemSeqConDif Then
          fMensagem('', 'Foram selecionados documentos com sequenciais ou empresas (baixa) diferentes, portanto será impresso um borderô por sequencial/empresa de baixa!', ['&Ok']);

        pImprimeBordero;
      End;
    End;
  End;
end;

procedure TfrmRelCtpReimpBordero.btnMudaOrdemClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve ao menos carregar uma duplicata!', ['&O k']);
    pSetFocus(mskDtaIni);
  End
  Else
  inherited;
end;

procedure TfrmRelCtpReimpBordero.btnPesquisarClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve ao menos carregar uma duplicata!', ['&O k']);
    pSetFocus(mskDtaIni);
  End
  Else
  inherited;
end;

end.
