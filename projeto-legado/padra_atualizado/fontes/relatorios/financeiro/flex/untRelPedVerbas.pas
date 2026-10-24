unit untRelPedVerbas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons,ExtCtrls,frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, frxExportTXT, Uni, AppEvnts, ComboBoxFocus,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmRelPedVerbas = class(TfrmPaiRelatorio)
    lblEmpresa     : TLabel;
    edtNomEmp: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2         : TLabel;
    edtCodEmp: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    lblNumLot      : TLabel;
    Label4         : TLabel;
    rdgTipPed: TRadioGroup;
    pnlData        : TPanel;
    Label5         : TLabel;
    Label6         : TLabel;
    mskDtaIni      : TMaskEditFocus;
    mskDtaFin      : TMaskEditFocus;
    lblRegiao      : TLabel;
    edtCodSup: TEditFocus;
    edtNomSup: TEditFocus;
    chkUtiVba: TCheckBox;
    lbl1: TLabel;
    frxVerbasJ: TfrxReport;
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodSupKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodSupExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    arrCli : TConsultasArray;
    arrVen : TConsultasArray;
    arrSup : TConsultasArray;
    arrEmp : TConsultasArray;
    arrFor : TConsultasArray;
    strCabLinVen : String;
    strCabLinEmp : String;
    strCabLinCli : String;
    strCabLinSup : String;
    strCabLinFor : String;
    procedure pSetaParametros(qryData: TUniQuery);
  public
  protected
    function fValidaCampos(Sender: TWinControl;
      blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoesSimples, untModuloSPR, StrUtils, untConsultas, Data.Db,
     untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelPedVerbas.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  inherited;
end;

procedure TfrmRelPedVerbas.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCli, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmRelPedVerbas.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmRelPedVerbas.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVen, fRetNomeOperador, nil, 'do Vendedor');
end;

procedure TfrmRelPedVerbas.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVen, False) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedVerbas.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 3);
end;

procedure TfrmRelPedVerbas.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedVerbas.btnImprimirClick(Sender: TObject);
  Var
    strSQL : String;
    frxRel : TfrxReport;
    qryRelat : TUniQuery;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '        UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '        FDO_DTAENT AS DTAENT, ';
    strSQL := strSQL + '        CONCAT(FDO_CODITE,"-",FDO_DESCRI) AS PRODUT, ';
    strSQL := strSQL + '        CONCAT(FDO_CODVEN,"-",OPE_NOMOPE) AS VENDED, ';
    strSQL := strSQL + '        CONCAT(FDO_CODCLI,"-",CLI_NOMCLI) AS CLIENT, ';
    strSQL := strSQL + '        CONCAT(FDO_FORITE,"-",FOR_NOMFOR) AS FORNEC, ';
    strSQL := strSQL + '        SUM(FDO_QTDITE) AS QUANTI, ';
    strSQL := strSQL + '        SUM((FDO_TOTITE-FDO_DESESP)/FDO_QTDITE) AS VLRPRA, ';
    strSQL := strSQL + '        SUM(FDO_UNIORI) AS VLRORI, ';
    strSQL := strSQL + '        SUM(FDO_TOTITE-FDO_DESESP) AS TOTPRA, ';
    strSQL := strSQL + '        SUM(FDO_UNIORI*FDO_QTDITE) AS TOTORI, ';

    strSQL := strSQL + '        SUM(IF(((FDO_UNIORI*FDO_QTDITE)-(FDO_TOTITE-FDO_DESESP)) > 0, ';
    strSQL := strSQL + '            ((FDO_UNIORI*FDO_QTDITE)-(FDO_TOTITE-FDO_DESESP)), ';
    strSQL := strSQL + '            0.00)) AS DESTOT, ';
    
    strSQL := strSQL + '        IFNULL(VBA_VALVBA,0.00) AS VBASOL, ';
    strSQL := strSQL + '        0.00 AS VBAUTI, ';

    strSQL := strSQL + '        SUM(IF(((FDO_UNIORI*FDO_QTDITE)-(FDO_TOTITE-FDO_DESESP)) > 0, ';
    strSQL := strSQL + '            IFNULL((((FDO_UNIORI*FDO_QTDITE)-(FDO_TOTITE-FDO_DESESP))/IFNULL(VBA_VALVBA,0.00))*100,0.00), ';
    strSQL := strSQL + '            0.00)) AS PERVBA, ';

    strSQL := strSQL + '        FDO_CODCLI AS CODCLI, ';
    strSQL := strSQL + '        FDO_FORITE AS CODFOR, ';
    strSQL := strSQL + '        FDO_CODVEN AS CODVEN, ';        
    strSQL := strSQL + '        CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC,"-",FDO_CODEMP) AS DOCUME ';
    strSQL := strSQL + '   FROM FATDOR  ';
    strSQL := strSQL + '  INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
    strSQL := strSQL + '  INNER JOIN CADFOR ON FOR_CODFOR = FDO_FORITE ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODClI = FDO_CODCLI ';
    strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = FDO_CODVEN ';
    strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = FDO_UNIDAD ';
    strSQL := strSQL + ' ' + IIF(chkUtiVba.Checked, 'INNER', 'LEFT');
    strSQL := strSQL + '        JOIN CADVBA ON VBA_CODVEN = FDO_CODVEN ';
    strSQL := strSQL + '                   AND VBA_CODCLI = FDO_CODCLI ';
    strSQL := strSQL + '                   AND VBA_DTALAN = FDO_DTAENT ';
    strSQL := strSQL + '                   AND VBA_CODFOR = FDO_FORITE ';
    strSQL := strSQL + '   LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    // VENDEDOR + CLIENTE + DATA EMISSAO PEDIDO + FORNECEDOR
    strSQL := strSQL + '  WHERE FDO_ESPDOC = "PD" ';
    strSQL := strSQL + '    AND FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodFor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodFor, arrFor, 'FDO_FORITE', 'CODFOR');

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'FDO_CODCLI', 'CODCLI');

    If Not fEmptyStr(edtCodSup.Text) Then
      strSQL := strSQL + fStrLocate(edtCodSup, arrSup, 'FGO_CODSUP', 'CODSUP');

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVen, 'FDO_CODVEN', 'CODVEN');

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'FDO_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + ' AND LOCATE(FDO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If (rdgTipPed.ItemIndex > 0) Then
      strSQL := strSQL + '  AND FDO_JAFATU = ' + IIF(rdgTipPed.ItemIndex = 1, '1', '0');

    strSQL := strSQL + ' GROUP BY VENDED, CLIENT, FDO_DTAENT, FORNEC, PRODUT ';
    strSQL := strSQL + ' ORDER BY VENDED, CLIENT, FDO_DTAENT, FORNEC, PRODUT ';

    qryRelat := fCriaQuery(Self);

    With qryRelat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametros(qryRelat);
      Open;
    End;

    If Not qryRelat.IsEmpty Then
    Begin
      frxRelatorio.DataSet := qryRelat;

      frxRel := frxVerbasJ;
      frxRel.DotMatrixReport           := False;
      frxRel.PrintOptions.PrintMode    := pmScale;
      frxRel.PrintOptions.PrintOnSheet := 9; //A4

      TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
      TfrxMemoView(frxRel.FindObject('rllZebra2')).Highlight.Color := fCfgSis('CORZEB');

      frxRel.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
      frxRel.PrintOptions.ShowDialog := fEmptyStr(frxRel.PrintOptions.Printer);

      frxRel.Script.Variables['NOMREL'] := 'RELATÓRIO DE VERBAS';

      frxRel.Script.Variables['CODVEN'] := fStrTitulo(edtCodVen.Text, edtNomVen, arrVen, strCabLinVen, 'VENDEDOR');
      frxRel.Script.Variables['CODEMP'] := IIF(fEmptyStr(edtCodEmp.Text), 'EMPRESA: ' + strEmpAcessoUsuarioLogado, fStrTitulo(edtCodEmp.Text, edtNomEmp, arrEmp, strCabLinEmp, 'EMPRESA'));
      frxRel.Script.Variables['CODSUP'] := fStrTitulo(edtCodSup.Text, edtNomSup, arrSup, strCabLinSup, 'SUPERVISOR');
      frxRel.Script.Variables['CODFOR'] := fStrTitulo(edtCodFor.Text, edtNomFor, arrFor, strCabLinFor, 'FORNECEDOR');
      frxRel.Script.Variables['CODCLI'] := fStrTitulo(edtCodCli.Text, edtNomCli, arrCli, strCabLinCli, 'CLIENTE');
      frxRel.Script.Variables['TIPPED'] := 'PEDIDOS: ' + AnsiUpperCase(rdgTipPed.Items[rdgTipPed.ItemIndex]);
      frxRel.Script.Variables['PERIOD'] := 'REFERENTE AO PERÍODO DE: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
        
      If chkUtiVba.Checked Then
        frxRel.Script.Variables['UTIVBA'] := 'SOMENTE PEDIDOS COM UTILIZAÇÃO DE VERBA: SIM'
      Else
        frxRel.Script.Variables['UTIVBA'] := '';

      If (edtDestino.Text = 'V') Then
        pPreviewReport(Self.Name, Self.Caption, frxRel)
      Else If frxRel.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
    End
    Else
      pTabelaVazia;
  End;

  If Assigned(qryRelat) Then
    FreeAndNil(qryRelat);

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

function TfrmRelPedVerbas.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intCnt : Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&OK']);
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
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&OK']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!', ['&OK']);
              Result := False;
            End;
          End;
        End
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFor);
    End

    Else If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli, arrCli);
    End

    Else If (Sender = edtCodVen) Then
    Begin
      pDesmarcaLista(edtCodVen, arrVen);
    End

    Else If (Sender = edtCodSup) Then
    Begin
      pDesmarcaLista(edtCodSup, arrSup);
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp, arrEmp);
      If High(arrEmp) >= 0 Then
      Begin
        For IntCnt := 0 To High(arrEmp) Do
        Begin
          If Not fEmptyStr(arrEmp[intCnt].strCodigo) Then
          Begin
            If (Pos(arrEmp[intCnt].strCodigo, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
              Result := False;
              Break;
            End;
          End;
        End
      End
      Else
      Begin
        If Not fEmptyStr(edtCodEmp.Text) Then
        Begin
          If (Pos(edtCodEmp.Text, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
            Result := False;
          End;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelPedVerbas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelPedVerbas.FormCreate(Sender: TObject);
begin
  inherited;
  shpMultSel.Visible := True;
end;

procedure TfrmRelPedVerbas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedVerbas.edtCodSupExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSup, edtNomSup, arrSup, fRetNomeOperador, nil, 'do Supervisor');
end;

procedure TfrmRelPedVerbas.edtCodSupKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqOperador(Self, edtCodSup, edtNomSup, Nil, Key, arrSup, False) Then
  Begin
    If fValidaCampos(edtCodSup, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedVerbas.pSetaParametros(qryData: TUniQuery);
begin
  With qryData Do
  Begin
    ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

    If Not fEmptyStr(edtCodFor.Text) Then
      pSetaParam(edtCodFor.Text, arrFor, strCabLinFor, 'CODFOR', qryData);

    If Not fEmptyStr(edtCodCli.Text) Then
      pSetaParam(edtCodCli.Text, arrCli, strCabLinCli, 'CODCLI', qryData);

    If Not fEmptyStr(edtCodSup.Text) Then
      pSetaParam(edtCodSup.Text, arrSup, strCabLinSup, 'CODSUP', qryData);

    If Not fEmptyStr(edtCodVen.Text) Then
      pSetaParam(edtCodVen.Text, arrVen, strCabLinVen, 'CODVEN', qryData);

    If Not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text, arrEmp, strCabLinEmp, 'CODEMP', qryData);
  End;
end;

procedure TfrmRelPedVerbas.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmRelPedVerbas.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

