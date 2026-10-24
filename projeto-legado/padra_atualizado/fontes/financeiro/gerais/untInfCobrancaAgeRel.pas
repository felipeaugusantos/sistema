unit untInfCobrancaAgeRel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  Mask, DBCtrls, DBEditFocus, EditFocus, AppEvnts, DB, UniClientDataSet, UniDataSetProvider,
  Uni, BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, DBMemoFocus, Datasnap.DBClient, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, cxLabel, MaskUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, System.StrUtils, Vcl.OleCtrls,
  SHDocVw;

type
  TfrmInfCobrancaAgeRel = class(TfrmPai)
    pnlDados: TPanel;
    pnlHistorico: TPanel;
    Label4: TLabel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    btnBaixar: TBitBtnLocked;
    mdbHisCob: TDBMemoFocus;
    grdDadosLevel1: TcxGridLevel;
    grdDadosTableView1: TcxGridDBTableViewCitel;
    grdDados: TcxGridCitel;
    grdDadosCODCLI: TcxGridDBColumn;
    grdDadosFONES: TcxGridDBColumn;
    grdDadosAGEREL: TcxGridDBColumn;
    grdDadosDATA: TcxGridDBColumn;
    pnlRodape: TPanel;
    Label1: TLabel;
    grdDadosCOB_MARDES: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnBaixarReagendar: TBitBtnLocked;
    grdDadosFONE01: TcxGridDBColumn;
    grdDadosFONE02: TcxGridDBColumn;
    grdDadosCELULA: TcxGridDBColumn;
    grdDadosTableCOB_CODOPE: TcxGridDBColumn;
    grdDadosTableCOB_OPEBAI: TcxGridDBColumn;
    btnResFin: TBitBtnLocked;
	grdDadosDTALAN: TcxGridDBColumn;
    btnDesmarcarTodos: TBitBtnLocked;
    grdDadosTableNOM_OPECAD: TcxGridDBColumn;
    grdDadosTableNOM_OPEBAI: TcxGridDBColumn;
    pnlOpcoes: TPanel;
    rdgVisAgend: TRadioGroup;
    grdDadosCOB_CODCLI: TcxGridDBColumn;
    grdDadosNOMCLI: TcxGridDBColumn;
    WebBrowser: TWebBrowser;

    procedure pCriaTabela;
    procedure pDeletaTabela;

    procedure pSelecionaCliente;
    procedure pMarcaCliente(blnMarcar: Boolean);
    procedure pBaixaMarcados;

    function  fBaixaCliente: Boolean;
    function  fMarcados : Integer;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBaixarClick(Sender: TObject);
    procedure grdDadosTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdDadosTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBaixarReagendarClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure grdDadosAGERELGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdDadosFONESGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnResFinClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure rdgVisAgendClick(Sender: TObject);
    procedure grdDadosCOB_CODCLIGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);

  private
    Doc: Variant;

    function fGravaDupCob_Baixa: Boolean;
    procedure pDesmarcar;
    procedure pMarcar;
    procedure pBaixa;
    function fRetornaUltimaEscolhaExibicaoAgendamento(
      strCodOPE: String): Integer;
    procedure pGravaUltimaEscolhaExibicaoAgendamento(strCodOPE: String;
      intOpc: Integer);
    procedure pAlteraExibicaoAgendamentos(iOpc : integer);

    { Private declarations }
  public
    cdsInfCob        : TUniClientDataSet;
    cdsInfDuplicatas : TUniClientDataSet;

    strCodCli : String;
    iOpcao    : integer;
    { Public declarations }
  End;


implementation

uses untFuncoesGenerica, untfuncoesSimples, System.UITypes,
  untInfCobrancaAgeRelHist, untResFinanceiro, untTypesSistema,
  untCadCob, untGravando;

{$R *.dfm}

procedure TfrmInfCobrancaAgeRel.pCriaTabela;
  Var
    strSQL: String;

  function fRetornaFiltroCliente: string;
  var
    prcScroll: TprcScroll;
  begin
    Result := '';

    pDisableControls(cdsInfCob, prcScroll);
    try
      if not cdsinfcob.isempty then
      begin
         cdsinfcob.first;
         result := ' AND COB_CODCLI IN ( ';
         while not cdsinfcob.eof do
         begin
           if iOpcao = 2 then
           Begin
              if cdsinfcob.fieldbyname('MARDES').asstring = 'M' then
                 Result := Result + '"' + cdsinfcob.fieldbyname('CLI_CODCLI').asstring + '",';
           End
           Else
              Result := Result + '"' + cdsinfcob.fieldbyname('CLI_CODCLI').asstring + '",';
           cdsinfcob.next;
         end;

         Result := LeftStr(Result, Result.Length - 1) + ')';
      end;
    finally
      pEnableControls(cdsInfCob, prcScroll);
    end;
  end;

begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADCOB.AUTOINCREM, ';
  strSQL := strSQL + '  COB_CODCLI, ';
  strSQL := strSQL + '  COB_CODCLI AS CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  COB_BAIXAD, ';
  strSQL := strSQL + '  COB_CODOPE, ';
  strSQL := strSQL + '  OPC.OPE_NOMOPE NOM_OPECAD, ';
  strSQL := strSQL + '  COB_OPEBAI, ';
  strSQL := strSQL + '  OPB.OPE_NOMOPE NOM_OPEBAI, ';
  strSQL := strSQL + '  CONCAT(COB_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
  strSQL := strSQL + '  TRIM(CLI_FONE01) AS FONE01, ';
  strSQL := strSQL + '  TRIM(CLI_FONE02) AS FONE02, ';
  strSQL := strSQL + '  TRIM(CLI_CELULA) AS CELULA, ';
  strSQL := strSQL + '  CONCAT(CLI_FONE01,CLI_FONE02,CLI_CELULA) AS FONES, ';
  strSQL := strSQL + '  IF(COB_DTAAGE IS NOT NULL, "A", "R") AS AGEREL,';
  strSQL := strSQL + '  COB_DTALAN AS DTALAN, ';
  strSQL := strSQL + '  COALESCE(COB_DTAAGE,COB_DTAREL) AS DTA, ';
  strSQL := strSQL + '  COB_HISCOB AS HISCOB,  ';
  strSQL := strSQL + '  CADCOB.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '  " "        AS COB_MARDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCOB ';
  strSQL := strSQL + '  JOIN CADCLI ON  COB_CODCLI = CLI_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CADOPE OPC ';
  strSQL := strSQL + '    ON COB_CODOPE = OPC.OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OPB ';
  strSQL := strSQL + '    ON COB_OPEBAI = OPB.OPE_CODOPE ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COB_BAIXAD = "N" ';

  If Not fEmptyStr(strCodCli) Then
     strSQL := strSQL + ' AND COB_CODCLI =' + QuotedStr(strCodCli);

  strSQL := strSQL + fRetornaFiltroCliente;

  strSQL := strSQL + ' ORDER BY';
  strSQL := strSQL + '  CLI_NOMCLI, DTA, CADCOB.AUTOINCREM';

  Doc := WebBrowser.Document;
  Doc.Clear;
  Doc.Write('');
  Doc.Close;

  With qryConsulta Do
  Begin
    Close;
    cdsConsulta.Close;

    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    pSetaClient(qryConsulta);
    qryConsulta.First;

    cdsConsulta.DisableControls;
    cdsConsulta.SetProvider(nil);
    cdsConsulta := fCriaClientDatset(qryConsulta);
    dtsConsulta := fCriaDataSource(cdsConsulta);
    cdsConsulta.Open;

    cdsConsulta.First;
    cdsConsultaAfterScroll(cdsConsulta);

    grdDadosTableView1.DataController.DataSource := dtsConsulta;

    cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmInfCobrancaAgeRel.FormShow(Sender: TObject);
  Var
      opcOpe : integer;
begin
  inherited;

  {********************************}
  {* CRIA E ATUALIZA A TEMPORARIA *}
  {*****************************LB*}
  TfrmGravando.fExecutarModal(pCriaTabela,'Aguarde... Carregando Registros','');

  opcOpe := fRetornaUltimaEscolhaExibicaoAgendamento(strLoginUsuarioLogado);
  rdgvisAgend.itemindex := opcOpe;
  rdgVisAgendClick(rdgvisAgend);
end;

procedure TfrmInfCobrancaAgeRel.grdDadosAGERELGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If (AText = 'A') Then
    AText := 'Agend.'
  Else
    AText := 'Relig.';
end;

procedure TfrmInfCobrancaAgeRel.grdDadosCOB_CODCLIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If TcxGridDBColumn( grdDadosCOB_CODCLI ).GroupIndex = 0 Then
     AText := AText + ' - ' + VarToStr(GrdDadosTableView1.DataController.Values[ARecord.RecordIndex,grdDadosNOMCLI.Index]);

end;

procedure TfrmInfCobrancaAgeRel.grdDadosFONESGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  strFone01 : String;
  strFone02 : String;
  strCelula : String;
  strFones  : String;
begin
  inherited;
  If not (ARecord is TcxGridGroupRow) Then
  Begin
    strFones  := '';
    strFone01 := '';
    strFone02 := '';
    strCelula := '';

    If Not VarIsNull(ARecord.Values[grdDadosFONE01.Index]) then
      strFone01 := ARecord.Values[grdDadosFONE01.Index];

    If Not VarIsNull(ARecord.Values[grdDadosFONE02.Index]) then
      strFone02 := ARecord.Values[grdDadosFONE02.Index];

    If Not VarIsNull(ARecord.Values[grdDadosCELULA.Index]) then
      strCelula := ARecord.Values[grdDadosCELULA.Index];


    If strFone01 <> '' Then
      strFones := FormatMaskText(fRetMascaraFonePais, strFone01);

    If strFone02 <> '' Then
    Begin
      strFone02 := FormatMaskText(fRetMascaraFonePais, strFone02);
      If strFones = '' Then
        strFones := strFone02
      Else
        strFones := strFones + ' / ' + strFone02;
    End;

    If strCelula <> '' Then
    Begin
      strCelula := FormatMaskText(fRetMascaraFonePais, strCelula);
      If strFones = '' Then
        strFones := strCelula
      Else
        strFones := strFones + ' / ' + strCelula;
    End;

    AText := strFones;
  End;

end;

procedure TfrmInfCobrancaAgeRel.grdDadosTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsConsulta Do
  Begin

    If Not Active Then
      Exit;

    If (AViewInfo.GridRecord.Values[grdDadosCOB_MARDES.Index] = 'M') Then
    Begin
      If ACanvas.Brush.Color = clhighlight Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End
    Else If ACanvas.Brush.Color = clhighlight Then
      ACanvas.Font.Color := clYellow

  End;
end;

procedure TfrmInfCobrancaAgeRel.grdDadosTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_Return:
    Begin
    {********************************}
    {* MARCA O CLIENTE SELECIONADO  *}
    {*****************************LB*}
    pSelecionaCliente;
    pSetFocus(Self);
    End;
    VK_Escape: Self.Close;
  End;

end;

procedure TfrmInfCobrancaAgeRel.pDeletaTabela;
begin
  FreeAndNil(cdsConsulta);
  FreeAndNil(qryConsulta);
end;

procedure TfrmInfCobrancaAgeRel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  {********************************}
  {* DELETA A TABELA TEMPORARIA   *}
  {*****************************LB*}
  pDeletaTabela;
end;

procedure TfrmInfCobrancaAgeRel.FormCreate(Sender: TObject);
begin
  inherited;
  cdsInfDuplicatas := TUniClientDataSet.Create(Self);
  strCodcli := '';
  If not Assigned(WebBrowser.Document) then
     WebBrowser.Navigate('about:blank');
end;

procedure TfrmInfCobrancaAgeRel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_Escape: Self.Close;
     VK_F7:  btnResFin.Click;
     VK_F8:  btnMarcarTodos.Click;
     VK_F9:  btnDesmarcarTodos.Click;
     VK_F10: btnBaixar.Click;
     VK_F11: btnBaixarReagendar.Click;
  End;

end;

procedure TfrmInfCobrancaAgeRel.pSelecionaCliente;
  Var
    intRecNo: Integer;
begin
  If (Not cdsConsulta.Active) Or
     (cdsConsulta.IsEmpty)    Then
      Exit;

  intRecNo := cdsConsulta.RecNo;
  pMarcaCliente(cdsConsulta.FieldByName('COB_MARDES').AsString <> 'M');

  cdsConsulta.RecNo := intRecNo;

end;

procedure TfrmInfCobrancaAgeRel.rdgVisAgendClick(Sender: TObject);
begin
  inherited;
  pAlteraExibicaoAgendamentos(rdgVisAgend.ItemIndex);
end;

Procedure TfrmInfCobrancaAgeRel.pAlteraExibicaoAgendamentos(iOpc : integer);
Begin
  cdsConsulta.AfterScroll := Nil;
  If iOpc = 0 Then
  Begin
     grdDadosTableView1.ViewData.Expand(False);
     grdDadosTableView1.ViewData.Collapse(True);
  End
  Else
  Begin
     grdDadosTableView1.ViewData.Expand(True);
     grdDadosTableView1.ViewData.Collapse(False);
     grdDadosTableView1.DataController.Groups.FullExpand;
  End;
  cdsConsultaAfterScroll(cdsConsulta);
  cdsConsulta.AfterScroll := cdsConsultaAfterScroll;

  pGravaUltimaEscolhaExibicaoAgendamento(strLoginUsuarioLogado, iOpc);

End;

procedure TfrmInfCobrancaAgeRel.pMarcaCliente(blnMarcar: Boolean);
begin
  cdsConsulta.DisableControls;
  cdsConsulta.AfterScroll := Nil;

  cdsConsulta.Edit;

  cdsConsulta.FieldByName('COB_MARDES').AsString := 'D';
  If blnMarcar Then
    cdsConsulta.FieldByName('COB_MARDES').AsString := 'M';

  cdsConsulta.Post;
  cdsConsulta.EnableControls;
  cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
end;

procedure TfrmInfCobrancaAgeRel.btnBaixarClick(Sender: TObject);
begin
  inherited;

  If fMarcados <= 0 Then
  Begin
    fMensagem('ATENÇÃO!','PARA PROSSEGUIR, SELECIONE O REGISTRO DE UM CLIENTE',['&OK']);
    pSetFocus(grdDados);
    Exit;
  End;

  //MF: 288445 - 24/05/23
  If fMensagem('','Deseja confirmar a baixa?' +#13#10 +
                  IntToStr(fMarcados) + ' registro(s) selecionado(s)',['&Sim','&Não'])=2 Then
    Exit;

  TfrmGravando.fExecutarModal(pBaixa,'Aguarde... Baixando Registros','');

  Self.Close;
end;

Procedure TfrmInfCobrancaAgeRel.pBaixa;
Begin

  If fGravaDupCob_Baixa Then
     pBaixaMarcados;

End;

procedure TfrmInfCobrancaAgeRel.pBaixaMarcados;
Var
  blnRetorno: Boolean;
Begin
   fStartTransaction;

  {*************************************}
  {* REALIZA O UPDATE NA TABELA CADCOB *}
  {**********************************LB*}
  blnRetorno := fBaixaCliente;

  If (Not blnRetorno) Then
    fRollBack
  Else
    fCommit;
End;

procedure TfrmInfCobrancaAgeRel.btnBaixarReagendarClick(Sender: TObject);
  procedure pLimpaFilter;
  Begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.EnableControls;
  End;

Var
  strCodCli   : String;
  intMarcados : Integer;
  frmInfCobrancaAgeRelHist : TfrmInfCobrancaAgeRelHist;
  cdsConsultaFiltrada : TUniClientDataSet;
  cdsInfDups    : TUniClientDataSet;
  opcOpe : integer;
begin
  inherited;
  Try
    intMarcados := fMarcados;

    If intMarcados <= 0 Then
    Begin
      fMensagem('ATENÇÃO!','PARA PROSSEGUIR, SELECIONE O REGISTRO DE UM CLIENTE',['&OK']);
      pSetFocus(grdDados);
      Exit;
    End;

    pCriarFormularios(TfrmInfCobrancaAgeRelHist, frmInfCobrancaAgeRelHist);

    cdsConsultaFiltrada := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsConsultaFiltrada, cdsConsulta);

    cdsInfDups := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsInfDups, cdsInfDuplicatas);

    cdsConsultaFiltrada.Filtered := False;
    cdsConsultaFiltrada.Filter   := 'COB_MARDES = ' + QuotedStr('M');
    cdsConsultaFiltrada.Filtered := True;

    frmInfCobrancaAgeRelHist.cdsInfCob          := cdsConsultaFiltrada; //cdsConsulta;
    frmInfCobrancaAgeRelHist.cdsDuplicatas      := cdsInfDups; // cds das duplicatas de todos os clientes do filtro;
    frmInfCobrancaAgeRelHist.strCodCli          := strCodCli;
    frmInfCobrancaAgeRelHist.strCodEmp          := VS_strCodEmp;
    frmInfCobrancaAgeRelHist.blnBaixarReagendar := True;
    frmInfCobrancaAgeRelHist.blnAgendamento     := False;
    frmInfCobrancaAgeRelHist.ShowModal;

    FreeAndNil(cdsConsultaFiltrada);

    //Se a data estiver vazia não é um Agendamento
    If Not fEmptyStr(fTiraCaracEspeciais(frmInfCobrancaAgeRelHist.mskAgeRel.Text)) Then
    Begin
      If frmInfCobrancaAgeRelHist.blnRetorno And
        (StrToDate(frmInfCobrancaAgeRelHist.mskAgeRel.Text) = VS_Date) Then
      Begin
          cdsInfCob.Edit;
          cdsInfCob.FieldByName('AGELIG').AsString := 'S';
          cdsInfCob.Post;
      End;
    End;

    //baixa os andamentos selecionados
    If frmInfCobrancaAgeRelHist.blnRetorno Then
    Begin
      TfrmGravando.fExecutarModal(pBaixaMarcados,'Aguarde... Baixando / Reagendando Registros','');
      cdsConsulta.AfterScroll := Nil;
      TfrmGravando.fExecutarModal(pCriaTabela,'Aguarde... Carregando Registros','');

      opcOpe := fRetornaUltimaEscolhaExibicaoAgendamento(strLoginUsuarioLogado);
      rdgvisAgend.itemindex := opcOpe;
      rdgVisAgendClick(rdgvisAgend);

      cdsConsultaAfterScroll(cdsConsulta);
      cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmInfCobrancaAgeRel.btnBaixaReagendarClick]');
    End;
  End;

  pFreeAndNil(frmInfCobrancaAgeRelHist);
end;

procedure TfrmInfCobrancaAgeRel.btnDesmarcarTodosClick(Sender: TObject);
begin
   TfrmGravando.fExecutarModal(pDesmarcar,'Aguarde... Desmarcando Todos Registros','');
end;

procedure TfrmInfCobrancaAgeRel.btnMarcarTodosClick(Sender: TObject);
begin
   TfrmGravando.fExecutarModal(pMarcar,'Aguarde... Marcando Todos Registros','');
end;

Procedure TfrmInfCobrancaAgeRel.pMarcar;
  var
    prcScroll: TprcScroll;
    iRecno : Integer;
begin

  Try

    iRecno := cdsConsulta.Recno;
    pDisableControls(cdsConsulta, prcScroll);

    If Not cdsConsulta.isEmpty Then
    Begin
      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('COB_MARDES').asString := 'M';
        cdsConsulta.Post;
        cdsConsulta.Next;
      End;
    End;
    cdsConsulta.Recno := iRecno;

  Finally
    pEnableControls(cdsConsulta, prcScroll);
  End;

end;

Procedure TfrmInfCobrancaAgeRel.pDesmarcar;
  var
    prcScroll: TprcScroll;
    iRecno   : Integer;
begin

  Try

    iRecno := cdsConsulta.Recno;
    pDisableControls(cdsConsulta, prcScroll);
     If Not cdsConsulta.isEmpty Then
     Begin
       cdsConsulta.First;
       While Not cdsConsulta.Eof Do
       Begin
         cdsConsulta.Edit;
         cdsConsulta.FieldByName('COB_MARDES').asString := 'D';
         cdsConsulta.Post;
         cdsConsulta.Next;
       End;
     End;
     cdsConsulta.Recno := iRecno;

  Finally
    pEnableControls(cdsConsulta, prcScroll);
  End;
end;

procedure TfrmInfCobrancaAgeRel.btnResFinClick(Sender: TObject);
begin
  inherited;
  Try
    If Not cdsConsulta.IsEmpty Then
    Begin
      pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
      frmResFinanceiro.strCodCli := cdsConsulta.FieldByName('COB_CODCLI').asString;
      frmResFinanceiro.pSetaAjusteData( fMensagem('Ajuste de Datas',
                                         'Ajusta vencimentos considerando Sábado/Domingo/Feriados?',
                                         ['&Sim','&Não'],2) = 1 );
      frmResFinanceiro.ShowModal;
      pFreeAndNil(frmResFinanceiro);
    End
    Else
      fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmInfCobrancaAgeRel.btnResFinClick]');
    End;
  End;
end;

procedure TfrmInfCobrancaAgeRel.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If cdsConsulta.Active Then
  Begin

    If Not Assigned(WebBrowser.Document) Then
       WebBrowser.Navigate('about:blank');

    Doc := WebBrowser.Document;
    Doc.Clear;
    Doc.Write('<font name="arial" size="2">'+
              AnsiReplaceStr(cdsConsulta.FieldByName('HISCOB').AsString,'<<csq>>',' ')+
              '</font>');
    Doc.Close;

  End
  Else
  Begin
    If Not Assigned(WebBrowser.Document) Then
       WebBrowser.Navigate('about:blank');
  End;
end;

function TfrmInfCobrancaAgeRel.fBaixaCliente: Boolean;
  Var
    strSQL: String;
    qryCadCob: TUniQuery;
begin
  Result := True;

  Try
    Try
      With cdsConsulta Do
      Begin
        DisableControls;
        cdsConsulta.AfterScroll := Nil;
        Filtered := False;
        Filter   := 'COB_MARDES = ' + QuotedStr('M');
        Filtered := True;

        qryCadCob := fCriaQuery(Self);

        First;
        While Not Eof Do
        Begin
          strSQL := '';
          strSQL := strSQL + 'UPDATE ';
          strSQL := strSQL + '  CADCOB ';
          strSQL := strSQL + 'SET ';
          strSQL := strSQL + '  COB_BAIXAD = "S", ';
          strSQL := strSQL + '  COB_OPEBAI = "' + strLoginUsuarioLogado + '"';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

          With qryCadCob Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
            ExecSQL;
            Close;
          End;
          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fBaixaCliente]');
        Result := False;
      End;
    End;
  Finally
    If Assigned(qryCadCob) Then FreeAndNil(qryCadCob);
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.EnableControls;
    cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
  End;
end;

function TfrmInfCobrancaAgeRel.fMarcados : Integer;
Var
  cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsClone, cdsConsulta);

  With cdsClone Do
  Begin
    Filtered := False;
    Filter := 'COB_MARDES = ' + QuotedStr('M');
    Filtered := True;

    Result := RecordCount;
  End;

  FreeAndNil(cdsClone);
End;


Function TfrmInfCobrancaAgeRel.fGravaDupCob_Baixa : Boolean;
  Var
    dtaDtaAtu: TDateTime;
    tmrHorAtu: TDateTime;
    dtaDtaAge: TDateTime;
    dtaDtaRel: TDateTime;
    strBaixad: String;
    strAutInc: String;
    strHiscob: String;

    cdsConsultaFiltrada : TUniClientDataSet;
    cdsInfDups    : TUniClientDataSet;

begin

  Result := False;

  Try
    strAutInc := '';
    strHisCob := '';
    dtaDtaAtu := Date;
    tmrHorAtu := StrToDateTime( FormatDateTime('hh:mm:ss', fTime()) );

    dtaDtaAge := 0;
    dtaDtaRel := 0;
    strBaixad := 'S';


    cdsConsultaFiltrada := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsConsultaFiltrada, cdsConsulta);

    cdsInfDups := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsInfDups, cdsInfDuplicatas);

    cdsConsultaFiltrada.Filtered := False;
    cdsConsultaFiltrada.Filter   := 'COB_MARDES = ' + QuotedStr('M');
    cdsConsultaFiltrada.Filtered := True;

    With cdsInfCob Do
    Begin
      {*************************************}
      {* ABRE A TRANSACAO E GRAVA NO BANCO *}
      {**********************************LB*}
      fStartTransaction;

      Result := fGravaCadCob(strAutInc,
                             VS_strCodEmp,//strCodEmp,
                             dtaDtaAtu,
                             tmrHorAtu,
                             dtaDtaAge,
                             dtaDtaRel,
                             strBaixad,
                             strCodCli,
                             strHisCob,
                             cdsConsultaFiltrada,
                             False, //blnVeioMostraDebCtrChq2,
                             cdsInfDups);

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End
      Else
        fCommit;
    End;

    freeAndnil(cdsConsultaFiltrada);
    freeAndnil(cdsInfDups);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[frmInfCobrancaAgeRel.fGravaDupCob]');
    End;

  End;
end;

procedure TfrmInfCobrancaAgeRel.pGravaUltimaEscolhaExibicaoAgendamento(strCodOPE: String; intOpc: Integer);
Var
  qryTemp: TUniquery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('UPDATE CADOPE SET OPE_EXIAGE = :EXIAGE WHERE OPE_CODOPE = :CODOPE ');
    qryTemp.ParamByName('CODOPE').AsString  := strCodOPE;
    qryTemp.ParamByName('EXIAGE').AsInteger := intOpc;
    qryTemp.ExecSQL;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmInfCobrancaAgeRel.fRetornaUltimaEscolhaExibicaoAgendamento(strCodOPE: String): Integer;
Var
  qryTemp: TUniquery;
Begin

  qryTemp := fCriaQuery;
  Try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT OPE_EXIAGE FROM CADOPE WHERE OPE_CODOPE = :CODOPE ');
    qryTemp.ParamByName('CODOPE').AsString := strCodOPE;
    qryTemp.Open;

    If qryTemp.FieldByName('OPE_EXIAGE').AsInteger > 0 Then
      result:= qryTemp.FieldByName('OPE_EXIAGE').AsInteger
    Else
      result:= 0;

  Finally
    FreeAndNil(qryTemp);
  End;
End;

end.

