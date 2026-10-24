unit untRelPedLiberacaoCargas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untClassPanelCX,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelPedLiberacaoCargas = class(TfrmPaiRelatorio)
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtCodVendedor: TEditFocus;
    Label1: TLabel;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    rdgCargas: TRadioGroup;
    Label3: TLabel;
    mskPreIni: TMaskEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    mskPreFin: TMaskEditFocus;
    Label6: TLabel;
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelPedLiberacaoCargas: TfrmRelPedLiberacaoCargas;

implementation

uses untFuncoesFactory, untTypesSistema, untIFuncoes,
     untQckPedLiberacaoCargas, Data.DB;

{$R *.dfm}

{ TfrmRelPedLiberacaoCargas }

function TfrmRelPedLiberacaoCargas.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := FALSE;
      End

      Else mskDtaFin.Enabled := TRUE;

    End

    Else If (Sender = mskDtaFin) And mskDtaFin.Enabled Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO','O CAMPO DATA FINAL DEVE SER PREENCHIDO ',['&O K']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = mskPreIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskPreIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO','O CAMPO DATA INICIAL DE ENTRADA OU PREVISDAO DEVE SER PREENCHIDO ',['&O K']);
        Result := False;
      End

      Else If fEmptyStr(fTiraCaracEspeciais(mskPreIni.Text)) Then
      Begin
        mskPreFin.Clear;
        mskPreFin.Enabled := FALSE;
      End

      Else mskPreFin.Enabled := TRUE;

    End

    Else If (Sender = mskPreFin) And mskPreFin.Enabled Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskPreFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskPreIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO','O CAMPO DATA FINAL DA PREVISAO DEVE SER PREENCHIDO ',['&O K']);
        Result := False;
      End
      Else
      If StrToDate(mskPreIni.Text) > StrToDate(mskPreFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial de previsão deve ser menor que a data final!',['&O K']);
        Result := False;
      End;

    End;


  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelPedLiberacaoCargas.pCarregaCliente(Var qryCadCli: TUniQuery);
begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
end;

procedure TfrmRelPedLiberacaoCargas.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelPedLiberacaoCargas.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedLiberacaoCargas.edtCodClienteExit(Sender: TObject);
begin
  inherited;

   If fEmptyStr(edtCodCliente.Text) Then
    edtDesCliente.Text := 'TODOS '
  Else
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);


  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text)) Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodCliente.Clear;
    pSetFocus(edtCodCliente);
  End;
end;

procedure TfrmRelPedLiberacaoCargas.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedLiberacaoCargas.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodVendedor.Text) Then
    edtDesVendedor.Text := 'TODOS'
  Else
    edtDesVendedor.Text := fRetNomVendRep(edtCodVendedor.Text);

  If fEmptyStr(edtDesVendedor.Text) And (Not fEmptyStr(edtCodVendedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
    edtCodVendedor.Clear;
    pSetFocus(edtCodVendedor);
  End;
end;

procedure TfrmRelPedLiberacaoCargas.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedLiberacaoCargas.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

   If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;
end;

procedure TfrmRelPedLiberacaoCargas.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  F.FGO_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  F.FGO_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  CONCAT(F.FGO_CODCLI,"-",C.CLI_NOMCLI) AS NOMCLI, ';
    strSQL := strSQL + '  CONCAT(F.FGO_CODVEN,"-",O.OPE_NOMOPE) AS NOMVEN, ';
    strSQL := strSQL + '  F.FGO_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  F.FGO_VLRCON AS VLRCON, ';
    strSQL := strSQL + '  IF(LOCATE("S", F.FGO_NTRAVA) > 0, "NAO LIBERADO", "LIBERADO") AS LIBERA, ';
    strSQL := strSQL + '  F.FGO_NTRAVA AS NTRAVA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR F, ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  CADOPE O ';
    strSQL := strSQL + 'WHERE ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQl := strSQl + '  F.FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskPreIni.Text)) Then
      strSQl := strSQl + '  F.FGO_PREVIS BETWEEN :PREINI AND :PREFIN AND ';

    strSQl := strSQl + '  F.FGO_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  F.FGO_CODCLI = C.CLI_CODCLI AND ';
    strSQL := strSQL + '  F.FGO_CODVEN = O.OPE_CODOPE AND ';
    strSQL := strSQL + '  F.FGO_JAFATU = 0 ';

    If rdgCargas.ItemIndex = 0 Then
      strSQL := strSQL + '  AND (LOCATE("S", F.FGO_NTRAVA) = 0 OR  F.FGO_NTRAVA IS NULL)'
    Else If rdgCargas.ItemIndex = 1 Then
      strSQL := strSQL + '  AND LOCATE("S", F.FGO_NTRAVA) > 0 ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + '  AND C.CLI_CODCLI = :CODCLI ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + '  AND O.OPE_CODOPE = :CODVEN ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND F.FGO_CODEMP = :CODEMP ';

    strSQL := strSQL + ' AND F.FGO_VLRCON <> 0 ';

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  DTAENT, NUMDOC ';


    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQl);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskPreIni.Text)) Then
      Begin
        ParamByName('PREINI').AsDate := StrToDate(mskPreIni.Text);
        ParamByName('PREFIN').AsDate := StrToDate(mskPreFin.Text);
      End;

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODVEN').AsString := edtCodVendedor.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckPedLiberacaoCargas,frmQckPedLiberacaoCargas);

        frmQckPedLiberacaoCargas.dtsRelatorio.DataSet := qryRelatorio;


        If strTipImp = 'M' Then
          frmQckPedLiberacaoCargas.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckPedLiberacaoCargas.qckPagina.DefaultFilter := Nil;


        {********************}
        {* CABEÇALHO DO QCK *}
        {*****************RL*}

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          frmQckPedLiberacaoCargas.rllOrdem.Caption := 'REFERENTE AO PERIODO DE EMISSAO: TODOS'
        Else
          frmQckPedLiberacaoCargas.rllOrdem.Caption := 'REFERENTE AO PERIODO DE EMISSAO ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        If fEmptyStr(fTiraCaracEspeciais(mskPreIni.Text)) Then
          frmQckPedLiberacaoCargas.rllPrevisao.Caption := 'REFERENTE AO PERIODO DE PREVISAO: TODOS'
        Else
          frmQckPedLiberacaoCargas.rllPrevisao.Caption := 'REFERENTE AO PERIODO DE PREVISAO ' + mskPreIni.Text + ' A ' + mskPreFin.Text;

        If Not fEmptyStr(edtCodCliente.Text) Then
          frmQckPedLiberacaoCargas.rllCliente.Caption := 'CLIENTE: ' + edtCodCliente.Text + '-' + edtDesCliente.Text
        Else
          frmQckPedLiberacaoCargas.rllCliente.Caption := 'CLIENTE: TODOS ';

        If Not fEmptyStr(edtCodVendedor.Text) Then
          frmQckPedLiberacaoCargas.rllVendedor.Caption := 'VENDEDOR: ' + edtCodVendedor.Text + '-' + edtDesVendedor.Text
        Else
          frmQckPedLiberacaoCargas.rllVendedor.Caption := 'VENDEDOR: TODOS ';

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          frmQckPedLiberacaoCargas.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text
        Else
          frmQckPedLiberacaoCargas.rllEmpresa.Caption := 'EMPRESA: TODOS ';

        frmQckPedLiberacaoCargas.rllNomeRelatorio.Caption := 'RELATORIO DE LIBERACAO DE CARGAS';

        If edtDestino.Text = 'V' Then
          frmQckPedLiberacaoCargas.qckPagina.PreviewModal
        Else
          frmQckPedLiberacaoCargas.qckPagina.Print;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

      pFreeAndNil(frmQckPedLiberacaoCargas);
      
    End
    Else
      pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelPedLiberacaoCargas.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
end;

procedure TfrmRelPedLiberacaoCargas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelPedLiberacaoCargas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

end.
