unit untRelEstPrecosNaoAlt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, CheckLst, StrUtils, Uni,
  RLReport, untFuncoesFactory, BitBtnLockedIncrem, untTypesSistema,
  frxExportCSVTestabilidade, untIFuncoes;

type
  TfrmRelEstPrecosNaoAlt = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label6: TLabel;
    lblDescricao: TLabel;
    edtDescri: TEditFocus;
    lbl1: TLabel;
    edtRefere: TEditFocus;
    Label12: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    Label1: TLabel;
    chkLisPre: TCheckListBox;
    rdgOrdena: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

    arrFornec: TConsultasArray;
    arrProAlt: TConsultasArray;
    procedure pCarregaPrecos;
    function fGetMarcado: Integer;
    function fQtdMarcados(chkList : TCheckListBox): Integer;
    procedure pProdAlterados;
    procedure pMontaWhere(Var strSQL: String);
    procedure pAjustaRel;
    procedure pSetaComponente(blnVisible: Boolean; intIndex: Integer);

    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelEstPrecosNaoAlt: TfrmRelEstPrecosNaoAlt;

implementation

uses untQckLstPreAlt, Data.DB;

{$R *.dfm}

{ TfrmRelEstPrecosNaoAlt }

procedure TfrmRelEstPrecosNaoAlt.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strFornec: String;
    strProdut: String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Application.ProcessMessages;
  inherited;
  If blnImprime Then
  Begin
    pProdAlterados;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DTACAD AS DTAALT, ';
    strSQL := strSQL + '  "00:00:00"   AS HORALT, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  ""           AS CODOPE, ';
    strSQL := strSQL + '  0.0000       AS CUSANT, ';
    strSQL := strSQL + '  G.ITE_PRECUS AS CUSATU, ';
    strSQL := strSQL + '  0.0000       AS VE1ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS VE1ATU, ';
    strSQL := strSQL + '  0.0000       AS MA1ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR1 AS MA1ATU, ';
    strSQL := strSQL + '  0.0000       AS VE2ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS VE2ATU, ';
    strSQL := strSQL + '  0.0000       AS MA2ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR2 AS MA2ATU, ';
    strSQL := strSQL + '  0.0000       AS VE3ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS VE3ATU, ';
    strSQL := strSQL + '  0.00000      AS MA3ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR3 AS MA3ATU, ';
    strSQL := strSQL + '  0.0000       AS VE4ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS VE4ATU, ';
    strSQL := strSQL + '  0.00000      AS MA4ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR4 AS MA4ATU, ';
    strSQL := strSQL + '  0.0000       AS VE5ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS VE5ATU, ';
    strSQL := strSQL + '  0.00000      AS MA5ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR5 AS MA5ATU, ';
    strSQL := strSQL + '  0.0000       AS VE6ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS VE6ATU, ';
    strSQL := strSQL + '  0.00000      AS MA6ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR6 AS MA6ATU, ';
    strSQL := strSQL + '  0.0000       AS VE7ANT, ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS VE7ATU, ';
    strSQL := strSQL + '  0.00000      AS MA7ANT, ';
    strSQL := strSQL + '  G.ITE_MARBR7 AS MA7ATU, ';
    strSQL := strSQL + '  UNI_DESUNI   AS DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  CONCAT(ITE_CODFOR, "-", FOR_NOMFOR) AS NOMFOR, ';
    strSQL := strSQL + '  CONCAT(ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';
    strSQL := strSQL + '  "" AS NOMFRM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN ITEGER G    ON G.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON ITE_CODUNI   = UNI_CODUNI   ';
    strSQL := strSQL + '  LEFT JOIN CADFOR ON ITE_CODFOR   = FOR_CODFOR   ';
    strSQL := strSQL + '  LEFT JOIN CADMAR ON ITE_CODMAR   = MAR_CODMAR   ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';

    If Not fEmptyStr(edtDescri.Text) Then
      strSQL := strSQL + '  I.ITE_DESITE LIKE :DESITE AND ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  I.ITE_REFERE LIKE :REFERE AND ';

    strSQL := strSQL + fStrLocate(Nil, arrProAlt, 'I.ITE_CODITE', 'CODITE', True, True, 'CODITE');
    strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'ITE_CODFOR', 'CODFOR');

    strSQL := strSQL + 'ORDER BY ';

    If (rdgOrdena.ItemIndex = 0) Then
      strSQL := strSQL + '  ITE_DESITE'
    Else If (rdgOrdena.ItemIndex = 1) Then
      strSQL := strSQL + '  ITE_CODFOR, ITE_DESITE'
    Else If (rdgOrdena.ItemIndex = 2) Then
      strSQL := strSQL + '  ITE_CODGRU, ITE_DESITE'
    Else If (rdgOrdena.ItemIndex = 3) Then
      strSQL := strSQL + '  ITE_CODMAR, ITE_DESITE';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If Not fEmptyStr(edtDescri.Text) Then
        ParamByName('DESITE').AsString := edtDescri.Text + '%';
      If Not fEmptyStr(edtRefere.Text) Then
        ParamByName('REFERE').AsString := edtRefere.Text + '%';
      pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryRelatorio);
      pSetaParam(fStrZero('0', fTamCodIte), arrProAlt, strProdut, 'CODITE', qryRelatorio);
      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try

        pCriarFormularios(TfrmQckLstPreAlt,frmQckLstPreAlt);

        frmQckLstPreAlt.dtsRelatorio.DataSet := qryRelatorio;

        frmQckLstPreAlt.rlbGrupo.Visible          := False;
        frmQckLstPreAlt.rlbDetalhe.Visible        := True;
        frmQckLstPreAlt.rlbTitulo.Visible         := False;
        frmQckLstPreAlt.rlbTituloResumido.Visible := True;

        frmQckLstPreAlt.rllRefTitulo.Visible := False;
        frmQckLstPreAlt.rllRefTitFor.Visible := False;
        frmQckLstPreAlt.rllRefTitRes.Visible := False;

        frmQckLstPreAlt.rlbRefDetGru.Visible := False;
        frmQckLstPreAlt.rlbRefDetFor.Visible := False;
        frmQckLstPreAlt.rlbRefDet.Visible    := False;

        frmQckLstPreAlt.rlbTitulo.Height         := 27;
        frmQckLstPreAlt.rlbTituloFor.Height      := 27;
        frmQckLstPreAlt.rlbTituloResumido.Height := 13;

        frmQckLstPreAlt.rlbDetalhe.Height      := 15;
        frmQckLstPreAlt.rlbDetalheFor.Height   := 15;
        frmQckLstPreAlt.rlbDetalheGrupo.Height := 15;

        frmQckLstPreAlt.rllNomeRelatorio.Caption := 'RELATORIO DE PRODUTOS SEM ALTERACAO DE PRECO';

        If strTipImp = 'M' Then
          frmQckLstPreAlt.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckLstPreAlt.qckPagina.DefaultFilter := Nil;

        frmQckLstPreAlt.intPreUsa := fGetMarcado;

        frmQckLstPreAlt.rllProduto.Visible := False;
        frmQckLstPreAlt.rllFornec.Visible  := True;
        frmQckLstPreAlt.rdbFornec.Visible  := True;
        frmQckLstPreAlt.rllMarca.Visible   := True;
        frmQckLstPreAlt.rdbMarca.Visible   := True;

        frmQckLstPreAlt.rllDescricao.Caption := 'DESCRIÇÃO: ';
        If (fEmptyStr(edtDescri.Text)) Then
          frmQckLstPreAlt.rllDescricao.Caption := frmQckLstPreAlt.rllDescricao.Caption + 'TODOS'
        Else
          frmQckLstPreAlt.rllDescricao.Caption := frmQckLstPreAlt.rllDescricao.Caption + edtDescri.Text + '%';

        frmQckLstPreAlt.rllRefere.Caption := 'REFERÊNCIA: ';
        If (fEmptyStr(edtRefere.Text)) Then
          frmQckLstPreAlt.rllRefere.Caption := frmQckLstPreAlt.rllRefere.Caption + 'TODOS'
        Else
          frmQckLstPreAlt.rllRefere.Caption := frmQckLstPreAlt.rllRefere.Caption + edtRefere.Text + '%';

        frmQckLstPreAlt.rllOrdem.Caption := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        frmQckLstPreAlt.rllFornecedor.Caption := fStrTitulo(edtCodFor.Text,edtDesFor,arrFornec,strFornec,'FORNECEDOR');

        pAjustaRel;

        If edtDestino.Text = 'V' Then
          frmQckLstPreAlt.qckPagina.PreviewModal
        Else If edtDestino.Text = 'I' Then
          frmQckLstPreAlt.qckPagina.Print;
        //Else If edtDestino.Text = 'E' Then
        //  pGeraExcel;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckLstPreAlt);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pSetFocus(mskDtaIni);
  pnlInfo.Caption := '';
end;

procedure TfrmRelEstPrecosNaoAlt.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtDesFor, arrFornec,
                    fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmRelEstPrecosNaoAlt.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec) Then
  Begin
    fValidaCampos(edtCodFor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelEstPrecosNaoAlt.fGetMarcado: Integer;
  Var
    intIndex: Integer;
Begin
  Result := 0;
  For intIndex := 0 To chkLisPre.Count - 1 Do
  Begin
    If chkLisPre.Checked[intIndex] Then
    Begin
      Result := intIndex;
      Exit;
    End;
  End;
end;

procedure TfrmRelEstPrecosNaoAlt.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstPrecosNaoAlt.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstPrecosNaoAlt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE : Close;
    VK_RETURN : If (ActiveControl Is TRadioButton) Or
                   (ActiveControl Is TComboBox) Or
                   (ActiveControl Is TCheckListBox) Then
                  Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstPrecosNaoAlt.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  pCarregaPrecos;
end;

function TfrmRelEstPrecosNaoAlt.fQtdMarcados(chkList: TCheckListBox): Integer;
  Var
    intIndex: Integer;
Begin
  Result := 0;
  For intIndex := 0 To chkList.Count - 1 Do
  Begin
    If chkList.Checked[intIndex] Then
      Inc(Result);
  End;
end;

procedure TfrmRelEstPrecosNaoAlt.pProdAlterados;
  Var
    strSQL: String;
    strFornec: String;
    intCont: Integer;
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE    ';
    strSQL := strSQL + '  ALT_CODITE AS CODITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PREALT ';
    strSQL := strSQL + '  JOIN CADITE      ON ITE_CODITE = ALT_CODITE ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
    strSQL := strSQL + 'WHERE ';
    If (Not fEmptyStr(edtDescri.Text)) Then
      strSQL := strSQL + '  ITE_DESITE LIKE :DESITE AND ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  ITE_REFERE LIKE :REFERE AND ';

    strSQL := strSQL + '  ALT_DTAALT BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'ITE_CODFOR', 'CODFOR');

    pMontaWhere(strSQL);

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtDescri.Text) Then
        ParamByName('DESITE').AsString := edtDescri.Text + '%';

      If Not fEmptyStr(edtRefere.Text) Then
        ParamByName('REFERE').AsString := edtRefere.Text + '%';

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryAux);

      Open;
      If Not IsEmpty Then
      Begin
        SetLength(arrProAlt, RecordCount);
        intCont := 0;

        While Not Eof Do
        Begin
          arrProAlt[intCont].strCodigo := FieldByName('CODITE').AsString;
          Inc(intCont);
          Next;
        End;
      End;

    End;
    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmRelEstPrecosNaoAlt.pSetaComponente(blnVisible: Boolean;
  intIndex: Integer);
begin
  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBr' + IntToStr(intIndex))).Visible    := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAnt' + IntToStr(intIndex))).Visible      := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAtu' + IntToStr(intIndex))).Visible      := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAnt' + IntToStr(intIndex))).Visible     := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtu' + IntToStr(intIndex))).Visible     := blnVisible;

  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVe' + IntToStr(intIndex))).Visible    := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAnt' + IntToStr(intIndex))).Visible      := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAtu' + IntToStr(intIndex))).Visible      := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAnt' + IntToStr(intIndex))).Visible     := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtu' + IntToStr(intIndex))).Visible     := blnVisible;

  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBrFor' + IntToStr(intIndex))).Visible := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAntFor' + IntToStr(intIndex))).Visible   := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAtuFor' + IntToStr(intIndex))).Visible   := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAntFor' + IntToStr(intIndex))).Visible  := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtuFor' + IntToStr(intIndex))).Visible  := blnVisible;

  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVeFor' + IntToStr(intIndex))).Visible := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAntFor' + IntToStr(intIndex))).Visible   := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAtuFor' + IntToStr(intIndex))).Visible   := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAntFor' + IntToStr(intIndex))).Visible  := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtuFor' + IntToStr(intIndex))).Visible  := blnVisible;
end;

function TfrmRelEstPrecosNaoAlt.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
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

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFornec);
    End

    Else If (Sender = chkLisPre) Then
    Begin

      If (fQtdMarcados(chkLisPre) = 0) Then
      Begin
        fMensagem('','Selecione uma Tabela de Preço!',['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEstPrecosNaoAlt.pAjustaRel;
  Var
    intIndex: Integer;
    intUsado: Integer;
    strPreco: String;
Begin
  With frmQckLstPreAlt Do
  Begin

    For intIndex := 1 To 3 Do
      pSetaComponente(FALSE,intIndex);

    intUsado := 0;

    For intIndex := 0 To chkLisPre.Count - 1 Do
      If chkLisPre.Checked[intIndex] Then
      Begin
        inc(intUsado);

        strPreco := RightStr(chkLisPre.Items[intIndex],1);

        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBr' + IntToStr(intUsado))).Caption := 'MARG. BRUTA' + strPreco;
        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVe' + IntToStr(intUsado))).Caption := 'PR. VENDA' + strPreco;

        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAnt' + IntToStr(intUsado))).DataFormula := 'MA' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtu' + IntToStr(intUsado))).DataFormula := 'MA' + strPreco + 'ATU';

        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAnt' + IntToStr(intUsado))).DataFormula := 'VE' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtu' + IntToStr(intUsado))).DataFormula := 'VE' + strPreco + 'ATU';

        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBrFor' + IntToStr(intUsado))).Caption := 'MARG. BRUTA' + strPreco;
        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVeFor' + IntToStr(intUsado))).Caption := 'PR. VENDA' + strPreco;

        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAntFor' + IntToStr(intUsado))).DataFormula := 'MA' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtuFor' + IntToStr(intUsado))).DataFormula := 'MA' + strPreco + 'ATU';

        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAntFor' + IntToStr(intUsado))).DataFormula := 'VE' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtuFor' + IntToStr(intUsado))).DataFormula := 'VE' + strPreco + 'ATU';

        pSetaComponente(TRUE,intUsado);
      End;

  End;
end;

procedure TfrmRelEstPrecosNaoAlt.pCarregaPrecos;
  Var
    intIndex: Integer;
    intMarcados: Integer;
Begin
  intMarcados := 0;
  chkLisPre.Items.Clear;
  For intIndex := 1 To Length(VS_strTabPrc) Do
  Begin
    If (VS_strTabPrc[intIndex] = 'S') Then
    Begin
      chkLisPre.Items.Add('Tabela ' + IntToStr(intIndex));
      If (IntMarcados < 3) Then
        chkLisPre.Checked[intMarcados] := True;
      Inc(intMarcados);
    End;
  End;
end;

procedure TfrmRelEstPrecosNaoAlt.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstPrecosNaoAlt.pMontaWhere(var strSQL: String);
  Var
    strTabPr: String;
    intIndex: Integer;
begin
  strSQL := strSQL + '  AND ( ';

  strSQL := strSQL + ' (ALT_CUSANT <> ALT_CUSATU) OR ';

  For intIndex := 0 To chkLisPre.Count - 1 Do
  Begin
    If chkLisPre.Checked[intIndex] Then
    Begin
      strTabPr := RightStr(chkLisPre.Items[IntIndex], 1);
      strSQL := strSQL + ' (ALT_MA' + strTabPr + 'ANT <> ALT_MA' + strTabPr + 'ATU) OR ';
    End;
  End;

  For intIndex := 0 To chkLisPre.Count - 1 Do
  Begin
    If chkLisPre.Checked[intIndex] Then
    Begin
      strTabPr := RightStr(chkLisPre.Items[IntIndex], 1);
      strSQL := strSQL + ' (ALT_VE' + strTabPr + 'ANT <> ALT_VE' + strTabPr + 'ATU) OR ';
    End;
  End;

  If AnsiEndsStr('OR ', strSQL) Then
    strSQL := Copy(strSQL, 0, Length(strSQL) - 3);

  strSQL := strSQL + '  )  ';
end;

end.
