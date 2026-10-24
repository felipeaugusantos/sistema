unit untRelCadPositivacaoClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus, DBCtrls,
  DBComboBoxFocus, Uni, UniClientDataSet, UniDataSetProvider, DB, ComCtrls,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelCadPositivacaoClientes = class(TfrmPaiRelatorio)
    Label3: TLabel;
    edtBairro: TEditFocus;
    Label4: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    Label7: TLabel;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    Label8: TLabel;
    edtCodAti: TEditFocus;
    edtNomAti: TEditFocus;
    Label10: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label11: TLabel;
    gpbStatus: TGroupBox;
    ColorLabel2: TColorLabel;
    edtStatus: TEditFocus;
    Label12: TLabel;
    edtNomIni: TEditFocus;
    Label13: TLabel;
    edtNomFin: TEditFocus;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    lbldta2: TLabel;
    cbxCatego: TComboBox;
    frxPaginaM: TfrxReport;
    frxPaginaJ: TfrxReport;
    pgbGerArq: TProgressBar;
    chkLimExc: TCheckBox;
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pGeraExcel(cdsRelato: TUniClientDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untModuloSPR,  untExcel, untPai, untTypesSistema, untFuncFat,
  untConsultas, untConstantes;

{$R *.dfm}

{ TfrmRelCadPositivacaoClientes }

function TfrmRelCadPositivacaoClientes.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If (fEmptyDate(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser preenchida!',['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If (fEmptyDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data final deve ser preenchida!',['&O k']);
        Result := False;
      End

      Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data final deve ser maior ou igual a data inicial!',['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtNomIni) Then
    Begin
      If Length(Trim(edtNomIni.Text)) > 0 Then
        edtNomFin.Enabled := True
      Else
      Begin
        edtNomFin.Enabled := False;
        edtNomFin.Clear;
      End;
    End

    Else If (Sender = edtNomFin) Then
    Begin
      If edtNomFin.Text < edtNomIni.Text Then
      Begin
        fMensagem('AVISO', 'O nome final não pode conter uma letra menor que a inicial.', ['&O K']);
        edtNomFin.Clear;
        pSetFocus(edtNomIni);
      End;
    End

    Else If (Sender = edtCodCid) Then
    Begin
      If (fEmptyStr(edtCodCid.Text)) Then
        edtNomCid.Text := 'TODAS'
      Else
      Begin
        edtNomCid.Text := fRetNomCidade(edtCodCid.Text);
  
        If (fEmptyStr(edtNomCid.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Essa cidade não está cadastrada!', ['&O k']);
          Result := False;
          edtNomCid.Clear;
        End;
      End;
    End
  
    Else If (Sender = edtEstado) And (Not fEmptyStr(edtEstado.Text)) Then
    Begin
      If (Not fValidaEstado(edtEstado.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O estado informado não é válido!', ['&O k']);
        Result := False;
      End;
    End
  
    Else If (Sender = edtCodVen) Then
    Begin
      If (fEmptyStr(edtCodVen.Text)) Then
        edtNomVen.Text := 'TODOS'
      Else
      Begin
        edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
  
        If (fEmptyStr(edtNomVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
          Result := False;
          edtNomVen.Clear;
        End;
      End;
    End
  
    Else If (Sender = edtCodRep) Then
    Begin
      If (fEmptyStr(edtCodRep.Text)) Then
        edtNomRep.Text := 'TODOS'
      Else
      Begin
        edtNomRep.Text := fRetNomeOperador(edtCodRep.Text);
  
        If (fEmptyStr(edtNomRep.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse representante não está cadastrado!',['&O k']);
          Result := False;
          edtNomRep.Clear;
        End;
      End;
    End
  
    Else If (Sender = edtCodAti) Then
    Begin
      If (fEmptyStr(edtCodAti.Text)) Then
        edtNomAti.Text := 'TODAS'
      Else
      Begin
        edtNomAti.Text := fRetNomAtividade(edtCodAti.Text);
  
        If (fEmptyStr(edtNomAti.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa atividade não está cadastrada!', ['&O k']);
          Result := False;
          edtNomAti.Clear;
        End;
      End;
    End
  
    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
        edtNomEmp.Text := 'TODAS'
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
          edtNomEmp.Clear
        End;
      End;
    End
  
    Else If (Sender = edtStatus) Then
    Begin
      If (fEmptyStr(edtStatus.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O status deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtStatus.Text, 'A_I_T_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O statatus deve ser  A, I ou T!', ['&O k']);
        Result := False;
      End;
    End
  
    Else If (Sender = edtDestino) Then
    Begin
      If (fEmptyStr(edtDestino.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O destino deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O destino deve ser V, I ou E!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCadPositivacaoClientes.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    //stlCamIndCid, stlDesIndCid: TStringList;
    //strSQL: String;
    qryCid: TUniQuery;
    arrSel: TConsultasArray;

begin
  inherited;

  Try
    qryCid := fCriaQuery(Self);

    If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, qryCid, Key, arrSel) Then
    Begin
      If (fValidaCampos(edtCodCid, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryCid);
  End;

end;

procedure TfrmRelCadPositivacaoClientes.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('DD/MM/YYYY', VS_Date);
  mskDtaFin.Text := FormatDateTime('DD/MM/YYYY', VS_Date);
  pSetFocus(mskDtaIni);
end;


procedure TfrmRelCadPositivacaoClientes.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCadPositivacaoClientes.FormCreate(Sender: TObject);
begin
  inherited;

  pPreencheCombo(TCustomComboBox(cbxCatego), arrCtgCli);
end;

procedure TfrmRelCadPositivacaoClientes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (ActiveControl Is TComboBox) And (Key = VK_RETURN) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRelCadPositivacaoClientes.btnImprimirClick(Sender: TObject);
Var
  strSQL: String;
  frxRel: TfrxReport;
  fatVenda : TFatVenda;
  cdsRelato: TUniClientDataSet;
  dspRelato: TUniDataSetProvider;
  varMaiAtr: Variant;
begin
  inherited;

  Try

    cdsRelato := TUniClientDataSet.Create(Self);
    dspRelato := TUniDataSetProvider.Create(Self);
    dspRelato.DataSet := frmModuloSPR.qryRelatorio;
    cdsRelato.SetProvider(dspRelato);

    fatVenda := TFatVenda.CreateInstance('');

    If blnImprime Then
    Begin

      btnImprimir.Enabled := False;
      pnlInfo.Caption := 'Gerando Relatório...';
      pnlInfo.Repaint;
      Application.ProcessMessages;

      strSQL := '';
      strSQL := strSQL + 'SELECT      ';
      strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';
      strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
      strSQL := strSQL + '  CLI_LIMCRE AS CREOFE, ';
      strSQL := strSQL + '  0.00       AS CREDIS, ';
      strSQL := strSQL + '  0.00       AS CHQABE, ';
      strSQL := strSQL + '  0.00       AS TOTCTR, ';
      strSQL := strSQL + '  0.00       AS CTRABE, ';
      strSQL := strSQL + '  0.00       AS CTRVEN, ';
      strSQL := strSQL + '  "000000"   AS MAIATR  ';
      strSQL := strSQL + 'FROM        ';
      strSQL := strSQL + '  CADCLI    ';
      strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  CLI_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

      If (Not fEmptyStr(edtNomIni.Text)) Then
        strSQL := strSQL + '  AND LEFT(CLI_NOMCLI, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';

      If (Not fEmptyStr(edtBairro.Text)) Then
        strSQL := strSQL + '  AND CLI_BAIRRO = :BAIRRO ';

      If (Not fEmptyStr(edtCodCid.Text)) Then
        strSQL := strSQL + '  AND CLI_CODCID = :CODCID ';

      If (Not fEmptyStr(edtEstado.Text)) Then
        strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

      If (Not fEmptyStr(edtCodVen.Text)) Then
        strSQL := strSQL + '  AND CLI_CODVEN = :CODVEN ';

      If (Not fEmptyStr(edtCodRep.Text)) Then
        strSQL := strSQL + '  AND CLI_CODREP = :CODREP ';

      If (Not fEmptyStr(edtCodAti.Text)) Then
        strSQL := strSQL + '  AND CLI_CODATI = :CODATI ';

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        strSQL := strSQL + '  AND CLI_CODEMP = :CODEMP ';

      If (Not fEmptyStr(cbxCatego.Text)) Then
        strSQL := strSQL + '  AND CLI_CATEGO = :CATEGO ';

      If (Not fEmptyStr(edtStatus.Text)) And (edtStatus.Text <> 'T') Then
        strSQL := strSQL + '  AND CLI_STATUS = :STATUS ';

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  CLI_NOMCLI ';

      With frmModuloSPR.qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtNomIni.Text) Then
        Begin
          If Length(edtNomIni.Text) > Length(edtNomFin.Text) Then
            ParamByName('MAIOR').AsString := edtNomIni.Text
          Else
            ParamByName('MAIOR').AsString := edtNomFin.Text;

          ParamByName('NOMINI').AsString := edtNomIni.Text;
          ParamByName('NOMFIN').AsString := edtNomFin.Text;
        End;

        If (Not fEmptyStr(edtBairro.Text)) Then
          ParamByName('BAIRRO').AsString := edtBairro.Text;

        If (Not fEmptyStr(edtCodCid.Text)) Then
          ParamByName('CODCID').AsString := edtCodCid.Text;

        If (Not fEmptyStr(edtEstado.Text)) Then
          ParamByName('ESTADO').AsString := edtEstado.Text;

        If (Not fEmptyStr(edtCodVen.Text)) Then
          ParamByName('CODVEN').AsString := edtCodVen.Text;

        If (Not fEmptyStr(edtCodRep.Text)) Then
          ParamByName('CODREP').AsString := edtCodRep.Text;

        If (Not fEmptyStr(edtCodAti.Text)) Then
          ParamByName('CODATI').AsString := edtCodAti.Text;

        If (Not fEmptyStr(edtCodEmp.Text)) Then
          ParamByName('CODEMP').AsString := edtCodEmp.Text;

        If (Not fEmptyStr(cbxCatego.Text)) Then
          ParamByName('CATEGO').AsString := cbxCatego.Text;

        If (Not fEmptyStr(edtStatus.Text)) And (edtStatus.Text <> 'T') Then
          ParamByName('STATUS').AsString := edtStatus.Text;

        Open;
        pSetaClient(frmModuloSPR.qryRelatorio);

        cdsRelato.Open;
        pSetaClient(cdsRelato);
      End;

      If Not cdsRelato.IsEmpty Then
      Begin

        With cdsRelato Do
        Begin
          First;

          While Not Eof Do
          Begin
            Edit;

            fatVenda.strCodCli := cdsRelato.FieldByName('CODCLI').AsString;
            fatVenda.fDebitoCliente('','',0);

            FieldByName('CREDIS').AsFloat  := FieldByName('CREOFE').AsFloat - fatVenda.fltTotDeb;
            FieldByName('CTRABE').AsFloat  := fatVenda.fltCtrAbe;
            FieldByName('CTRVEN').AsFloat  := fatVenda.fltCtrVen;
            FieldByName('TOTCTR').AsFloat  := fatVenda.fltCtrAbe + fatVenda.fltCtrVen;
            FieldByName('CHQABE').AsFloat  := fatVenda.fltChqAbe;

            varMaiAtr := (VS_Date - fatVenda.dtaMaiAtr);
            FieldByName('MAIATR').AsString := varMaiAtr;
            Post;
            Next;
          End
        End;

        If (chkLimExc.Checked) Then
        Begin
          cdsRelato.Filter := 'CREDIS < 0';
          cdsRelato.Filtered := True;
        End;

        If (Not cdsRelato.IsEmpty) Then
        Begin

          If (edtDestino.Text = 'E') Then
            pGeraExcel(cdsRelato)
          Else
          Begin
            frxRelatorio.DataSet := cdsRelato;

            If (strTipImp = 'M') Then
              frxRel := frxPaginaM
            Else
            Begin
              frxRel := frxPaginaJ;
              frxRel.DotMatrixReport           := False;
              frxRel.PrintOptions.PrintMode    := pmScale;
              frxRel.PrintOptions.PrintOnSheet := 9; //A4
            End;

            frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE POSITIVACAO DE CLIENTES';
            frxRel.Script.Variables['PERIOD'] := 'REFERENTE AO PERIODO DE ' + FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaIni.Text)) + ' A '
                                                                            + FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaFin.Text));

            If (fEmptyStr(edtNomIni.Text)) Then
              frxRel.Script.Variables['FILNOM'] := 'NOME: TODOS'
            Else
              frxRel.Script.Variables['FILNOM'] := 'NOME: ' + edtNomIni.Text + ' A ' + edtNomFin.Text;

            If (fEmptyStr(edtBairro.Text)) Then
              frxRel.Script.Variables['FILBAI'] := 'BAIRRO: TODOS'
            Else
              frxRel.Script.Variables['FILBAI'] := 'BAIRRO: ' + edtBairro.Text;

            If (fEmptyStr(edtCodCid.Text)) Then
              frxRel.Script.Variables['FILCID'] := 'CIDADE: TODAS'
            Else
              frxRel.Script.Variables['FILCID'] := 'CIDADE: ' + edtCodCid.Text + '-' + edtNomCid.Text;

            If (fEmptyStr(edtEstado.Text)) Then
              frxRel.Script.Variables['FILEST'] := 'ESTADO: TODOS'
            Else
              frxRel.Script.Variables['FILEST'] := 'ESTADO: ' + edtEstado.Text;

            If (fEmptyStr(edtCodVen.Text)) Then
              frxRel.Script.Variables['FILVEN'] := 'VENDEDOR: TODOS'
            Else
              frxRel.Script.Variables['FILVEN'] := 'VENDEDOR: ' + edtCodVen.Text + '-' + edtNomVen.Text;

            If (fEmptyStr(edtCodRep.Text)) Then
              frxRel.Script.Variables['FILREP'] := 'REPRESENTANTE: TODAS'
            Else
              frxRel.Script.Variables['FILREP'] := 'REPRESENTANTE: ' + edtCodRep.Text + '-' + edtNomRep.Text;

            If (fEmptyStr(edtCodAti.Text)) Then
              frxRel.Script.Variables['FILATI'] := 'ATIVIDADE: TODAS'
            Else
              frxRel.Script.Variables['FILATI'] := 'ATIVIDADE: ' + edtCodAti.Text + '-' + edtNomAti.Text;

            If (fEmptyStr(edtCodEmp.Text)) Then
              frxRel.Script.Variables['FILEMP'] := 'EMPRESA: TODAS'
            Else
              frxRel.Script.Variables['FILEMP'] := 'EMPRESA: ' + edtCodEmp.Text + '-' + edtNomEmp.Text;

            If (Not fEmptyStr(cbxCatego.Text)) Then
              frxRel.Script.Variables['FILCAT'] := 'CATEGORIA: ' + cbxCatego.Text
            Else
              frxRel.Script.Variables['FILCAT'] := 'CATEGORIA: TODAS';

            frxRel.Script.Variables['FILSTA'] := 'STATUS: ' + IIF(edtStatus.Text = 'A', 'ATIVO', IIF(edtStatus.Text = 'I', 'INATIVO', 'TODOS'));

            frxRel.Script.Variables['FILLIM'] := 'SOMENTE CLIENTES COM LIMITE DE CREDITO EXCEDIDO: ' + IIF(chkLimExc.Checked, 'SIM', 'NAO');

            If edtDestino.Text = 'V' Then
               pPreviewReport(Self.Name, Self.Caption, frxRel)
            Else
            Begin
              If frxRel.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
            End;

          End;

        End
        Else
          pTabelaVazia;

      End
      Else
        pTabelaVazia;
    End;

  Finally
    pnlInfo.Caption     := '';
    btnImprimir.Enabled := True;
    pSetFocus(mskDtaIni);

    FreeAndNil(fatVenda);
    FreeAndNil(cdsRelato);
    FreeAndNil(dspRelato);
  End;

end;

procedure TfrmRelCadPositivacaoClientes.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryOpe: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;

  Try
    qryOpe       := fCriaQuery(Self);

    If fEntraCons(Key) Then
    Begin
      if fPesqOperador(Self, edtCodVen, edtNomVen, qryOpe, Key, arrSel) then
      Begin
        If (fValidaCampos(edtCodVen, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    FreeAndNil(qryOpe);
  End;

end;

procedure TfrmRelCadPositivacaoClientes.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryOpe: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;

  Try
    qryOpe := fCriaQuery(nil);

    If fEntraCons(Key) Then
    Begin
      if fPesqOperador(Self, edtCodRep, edtNomRep, qryOpe, Key, arrSel) then
      Begin
        If (fValidaCampos(edtCodRep, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    FreeAndNil(qryOpe);
  End;

end;

procedure TfrmRelCadPositivacaoClientes.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryAti: TUniQuery;
    arrSel: TConsultasArray;

begin
  inherited;

  Try
    qryAti := fCriaQuery(Self);

    If fPesqAtividade(Self, edtCodAti, edtNomAti, qryAti, Key, arrSel) Then
    Begin
      If (fValidaCampos(edtCodAti, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryAti);
  End;

end;

procedure TfrmRelCadPositivacaoClientes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryEmp: TUniQuery;
    arrSel: TConsultasArray;

begin
  inherited;

  Try
    qryEmp := fCriaQuery(Self);

    If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, qryEmp, Key, arrSel) Then
    Begin
      If (fValidaCampos(edtCodEmp, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryEmp);
  End;

end;

procedure TfrmRelCadPositivacaoClientes.pGeraExcel(
  cdsRelato: TUniClientDataSet);
Var
  objExcel : TExcel;
  intQtdCol: Integer;
  intCont  : Integer;
  strUltCol: String;
  arrSintetico: Array [1..8] Of Array [1..2] Of String;
begin

  Try

    objExcel := TExcel.fCriarExcel(Self);

    arrSintetico[01][01] := 'CLIENTE';
    arrSintetico[02][01] := 'LIM.CRED.OFERT';
    arrSintetico[03][01] := 'LIM.CRED.DISP';
    arrSintetico[04][01] := 'CHQ.ABERTO';
    arrSintetico[05][01] := 'TOTAL CTR';
    arrSintetico[06][01] := 'CTR.ABERTO';
    arrSintetico[07][01] := 'CTR.VENCIDO';
    arrSintetico[08][01] := 'MAIOR ATR(DIAS)';

    arrSintetico[01][02] := 'CODCLI';
    arrSintetico[02][02] := 'CREOFE';
    arrSintetico[03][02] := 'CREDIS';
    arrSintetico[04][02] := 'CHQABE';
    arrSintetico[05][02] := 'TOTCTR';
    arrSintetico[06][02] := 'CTRABE';
    arrSintetico[07][02] := 'CTRVEN';
    arrSintetico[08][02] := 'MAIATR';

    If Not objExcel.CriarArquivo Then
    begin
      FreeAndNil(objExcel);
      Exit;
    End;

    With objExcel Do
    Begin

      pnlInfo.Caption       := 'Aguarde... Gerando Arquivo!';
      pnlInfo.Repaint;
      Application.ProcessMessages;

      PintarTudo(Branco);
      DefinirFonte(CourierNew, 10);

      LinhaAtual := 1;
      intQtdCol  := Length(arrSintetico);
      strUltCol  := fGetLetraAlfa(intQtdCol);

      Escrever(ProximaLinha, 01, fRetNomeEmpresa);
      Escrever(ProximaLinha, 01, 'RELATORIO DE POSITIVACAO DE CLIENTES');
      Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaFin.Text)));
      Escrever(ProximaLinha, 01, 'NOME: '          + IIF(fEmptyStr(edtNomIni.Text), 'TODOS',  edtNomIni.Text + ' A ' + edtNomFin.Text));
      Escrever(ProximaLinha, 01, 'BAIRRO: '        + IIF(fEmptyStr(edtBairro.Text), 'TODOS',  edtBairro.Text));
      Escrever(ProximaLinha, 01, 'CIDADE: '        + IIF(fEmptyStr(edtCodCid.Text), 'TODAS',  edtCodCid.Text + '-' + edtNomCid.Text));
      Escrever(ProximaLinha, 01, 'ESTADO: '        + IIF(fEmptyStr(edtEstado.Text), 'TODOS',  edtEstado.Text));
      Escrever(ProximaLinha, 01, 'VENDEDOR: '      + IIF(fEmptyStr(edtCodVen.Text), 'TODOS',  edtCodVen.Text + '-' + edtNomVen.Text));
      Escrever(ProximaLinha, 01, 'REPRESENTANTE: ' + IIF(fEmptyStr(edtCodRep.Text), 'TODOS',  edtCodRep.Text + '-' + edtNomRep.Text));
      Escrever(ProximaLinha, 01, 'ATIVIDADE: '     + IIF(fEmptyStr(edtCodAti.Text), 'TODAS',  edtCodAti.Text + '-' + edtNomAti.Text));
      Escrever(ProximaLinha, 01, 'EMPRESA: '       + IIF(fEmptyStr(edtCodEmp.Text), 'TODAS',  edtCodEmp.Text + '-' + edtNomEmp.Text));
      Escrever(ProximaLinha, 01, 'CATEGORIA: '     + IIF(fEmptyStr(cbxCatego.Text), 'TODAS',  cbxCatego.Text));
      Escrever(ProximaLinha, 01, 'STATUS: '        + IIF(edtStatus.Text = 'A', 'ATIVO', IIF(edtStatus.Text = 'I', 'INATIVO', 'TODOS')));
      Escrever(ProximaLinha, 01, 'SOMENTE CLIENTES COM LIMITE DE CREDITO EXCEDIDO: ' + IIF(chkLimExc.Checked, 'SIM', 'NAO'));

      For intCont := 1 To LinhaAtual Do
      Begin
        Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
        Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
        Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
      End;

      CorFundo('A2', strUltCol + '3', Cinza);
      Bordas('A2', strUltCol + '3',True,True,True,True);

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrSintetico[intCont, 01]);
        Negrito(LinhaAtual, intCont, True);
      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      With cdsRelato Do
      Begin
        First;
        pgbGerArq.Visible  := True;
        pgbGerArq.Max      := cdsRelato.RecordCount;

        While Not Eof Do
        Begin
          pgbGerArq.Position := RecNo;
          Application.ProcessMessages;

          ProximaLinha;
          Escrever(LinhaAtual, 1, FieldByName('NOMCLI').AsString);

          Escrever(LinhaAtual, 2, FieldByName('CREOFE').AsFloat);
          FormatoNumerico(LinhaAtual, 2);

          Escrever(LinhaAtual, 3, FieldByName('CREDIS').AsFloat);
          FormatoNumerico(LinhaAtual, 3);

          Escrever(LinhaAtual, 4, FieldByName('CHQABE').AsFloat);
          FormatoNumerico(LinhaAtual, 4);

          Escrever(LinhaAtual, 5, FieldByName('TOTCTR').AsFloat);
          FormatoNumerico(LinhaAtual, 5);

          Escrever(LinhaAtual, 6, FieldByName('CTRABE').AsFloat);
          FormatoNumerico(LinhaAtual, 6);

          Escrever(LinhaAtual, 7, FieldByName('CTRVEN').AsFloat);
          FormatoNumerico(LinhaAtual, 7);

          Escrever(LinhaAtual, 8, FieldByName('MAIATR').AsString);

          Next;
        End;
      End;

      //OrientacaoPagina(Retrato);

      CongelarPaines('A17');
      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    End;

  Finally
    FreeAndNil(objExcel);
    pnlInfo.Caption   := '';
    pgbGerArq.Visible := False;
  End;

end;

procedure TfrmRelCadPositivacaoClientes.edtDestinoExit(Sender: TObject);
begin
//  inherited;

end;

end.
