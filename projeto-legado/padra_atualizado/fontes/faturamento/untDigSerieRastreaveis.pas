unit untDigSerieRastreaveis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, Data.DB, MemDS,
  DBAccess, Uni, strUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untZClient, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmDigSerieRastreaveis = class(TfrmPai)
    pnlDocumento: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    pnlDadosDoc: TPanel;
    edtDtEmissao: TEditFocus;
    Label1: TLabel;
    edtNomVen: TEditFocus;
    Label2: TLabel;
    edtCodCnd: TEditFocus;
    Label6: TLabel;
    edtDesCnd: TEditFocus;
    Label7: TLabel;
    edtCodFpg: TEditFocus;
    edtDesFpg: TEditFocus;
    Label8: TLabel;
    edtVlrDoc: TEditFocus;
    edtCodVen: TEditFocus;
    edtConPag: TMaskEditFocus;
    cxgItensLvl1: TcxGridLevel;
    cxgItensTV1: TcxGridDBTableViewCitel;
    cxgItens: TcxGridCitel;
    cxgItensTV1DET_CODITE: TcxGridDBColumn;
    cxgItensTV1DET_DESCRI: TcxGridDBColumn;
    cxgItensTV1DET_UNIDAD: TcxGridDBColumn;
    cxgItensTV1SEQUEN: TcxGridDBColumn;
    cxgItensTV1NUMSERIE: TcxGridDBColumn;
    cxgItensTV1ITEM: TcxGridDBColumn;
    btnGravar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgItensTV1EditKeyUp(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensTV1FocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
  private
    cdsItens : TZClient;
    strTabSer: String;
    procedure pCarregaDados;
    procedure pLimpaDadosBusca;
    procedure pLimpaDadosDet;
    procedure pLimpaDados;
    { Private declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples;

procedure TfrmDigSerieRastreaveis.pCarregaDados;
  Var
    qryConsulta : TUniQuery;

  function fSQLDocs(strTabela, strTabelaDet: String): String;
  Begin
    Result := '';
    Result := Result + ' SELECT                                                ';
    Result := Result + '   GER_NUMDOC,                                         ';
    Result := Result + '   GER_ESPDOC,                                         ';
    Result := Result + '   GER_CODEMP,                                         ';
    Result := Result + '   GER_DTAENT,                                         ';
    Result := Result + '   GER_TOTPRO,                                         ';
    Result := Result + '   CND_DESCRI,                                         ';
    Result := Result + '   FPG_DESCRI,                                         ';
    Result := Result + '   CLI_NOMCLI,                                         ';
    Result := Result + '   OPE_NOMOPE,                                         ';
    Result := Result + '   G.GER_CODCND,                                       ';
    Result := Result + '   G.GER_CODFPG,                                       ';
    Result := Result + '   G.GER_CONPAG,                                       ';
    Result := Result + '   G.GER_CODVEN,                                       ';
    Result := Result + '   G.AUTOINCREM,                                       ';
    Result := Result + '   ' + QuotedStr(strTabelaDet) + ' AS TABDET           ';
    Result := Result + ' FROM                                                  ';
    Result := Result + '   ' + strTabela + ' G                                 ';
    Result := Result + '    INNER JOIN CADCLI C ON G.GER_CODCLI = C.CLI_CODCLI ';
    Result := Result + '    LEFT  JOIN CADOPE V ON G.GER_CODVEN = V.OPE_CODOPE ';
    Result := Result + '    LEFT  JOIN CADCND P ON G.GER_CODCND = P.CND_CODIGO ';
    Result := Result + '    LEFT  JOIN CADFPG F ON G.GER_CODFPG = F.FPG_CODIGO ';
    Result := Result + ' WHERE                                                 ';
    Result := Result + '       G.GER_ESPDOC IN ("NF","IF", "NV", "IV")         ';
    Result := Result + '   AND G.GER_TIP_FC = "C"                              ';
    Result := Result + '   AND G.GER_ORIDOC = "V"                              ';
    Result := Result + '   AND G.GER_NUMDOC = :NUMDOC                          ';
    Result := Result + '   AND G.GER_ESPDOC = :ESPDOC                          ';
    Result := Result + '   AND G.GER_CODEMP = :CODEMP                          ';
  End;


  function fSQLItens(strTabela : String): String;
  Begin
    Result := '';
    Result := Result + ' SELECT                                                                                          ';
    Result := Result + '   AUTOINCREM,                                                                                   ';
    Result := Result + '   DET_CODITE,                                                                                   ';
    Result := Result + '   DET_DESCRI,                                                                                   ';
    Result := Result + '   CONCAT(DET_CODITE, " - ", DET_DESCRI) AS ITEM,                                                ';
    Result := Result + '   DET_UNIDAD,                                                                                   ';
    Result := Result + '   SEQUEN,                                                                                       ';
    Result := Result + '   S.SER_NUMSER AS NUMSERIE                                                                      ';
    Result := Result + ' FROM                                                                                            ';
    Result := Result + '   ' + strTabela                                                                                  ;
    Result := Result + '    INNER JOIN (' + fRetSQLTabSequencial(4) + ') TABSEQ ON TABSEQ.SEQUEN <= CEILING(DET_QTDITE)  ';
    Result := Result + '    LEFT JOIN ' + strTabSer + ' S ON SER_SEQDET = AUTOINCREM AND SER_SEQUEN = TABSEQ.SEQUEN      ';
    Result := Result + ' WHERE                                                                                           ';
    Result := Result + '       DET_SEQGER = :SEQGER                                                                      ';
    Result := Result + '   AND DET_CODITE IN (SELECT GMT_CODITE FROM GERMAT)                                             ';
    Result := Result + 'ORDER BY                                                                                         ';
    Result := Result + '   DET_CODITE, SEQUEN                                                                            ';
  End;
begin
  inherited;
  pLimpaDadosDet;
  qryConsulta := fCriaQuery(nil);
  try
    qryConsulta.SQL.Add('SELECT *                                  ');
    qryConsulta.SQL.Add('FROM (                                    ');
    qryConsulta.SQL.Add(   fSQLDocs('MOVGER','MOVDET')              );
    qryConsulta.SQL.Add('UNION ALL                                 ');
    qryConsulta.SQL.Add(   fSQLDocs('NOTGER','NOTDET') + ') AS GER ');

    qryConsulta.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryConsulta.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    qryConsulta.Open;

    if not qryConsulta.isEmpty then
    begin
      edtDtEmissao.Text := DateToStr(qryConsulta.FieldByName('GER_DTAENT').AsDateTime);
      edtCodVen.Text    := qryConsulta.FieldByName('GER_CODVEN').AsString;
      edtNomVen.Text    := qryConsulta.FieldByName('OPE_NOMOPE').AsString;
      edtCodCnd.Text    := qryConsulta.FieldByName('GER_CODCND').AsString;
      edtDesCnd.Text    := qryConsulta.FieldByName('CND_DESCRI').AsString;
      edtConPag.Text    := qryConsulta.FieldByName('GER_CONPAG').AsString;
      edtCodFpg.Text    := qryConsulta.FieldByName('GER_CODFPG').AsString;
      edtDesFpg.Text    := qryConsulta.FieldByName('FPG_DESCRI').AsString;
      edtVlrDoc.Text    := FormatFloat('R$ #,##0.00', qryConsulta.FieldByName('GER_TOTPRO').AsFloat);
      strTabSer         := IIF(qryConsulta.FieldByName('TABDET').AsString = 'MOVDET', 'MOVSER', 'NOTSER');

      cdsItens.Close;
      cdsItens.qryQuery.Close;
      cdsItens.qryQuery.SQL.Clear;
      cdsItens.qryQuery.SQL.Text := fSQLItens(qryConsulta.FieldByName('TABDET').AsString);
      cdsItens.qryQuery.ParamByName('SEQGER').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsItens.fAbreClient(True, 'TfrmDigSerieRastreaveis.pCarregaDados');

      if not (cdsItens.isEmpty) then
      begin
        cxgItensTV1.ViewData.Expand(True);
        pnlDocumento.Enabled := False;
        btnCancelar.Visible := True;
      end
      else
      begin
        blnMudarFoco := False;
        pSetFocus(edtNumDoc);
      end;
    end
    else begin
      pMensagemOk('Documento de venda não encontrado!');
      blnMudarFoco := False;
      pSetFocus(edtNumDoc);
      exit;
    end;

  finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  end;

end;


procedure TfrmDigSerieRastreaveis.pLimpaDados;
begin
  pLimpaDadosBusca;
  pLimpaDadosDet;
end;

procedure TfrmDigSerieRastreaveis.pLimpaDadosBusca;
begin
  edtNumDoc.Text  := '';
  edtEspDoc.Text  := '';
  edtCodEmp.Text  := VS_strCodemp;

  pnlDocumento.Enabled := True;
  pSetFocus(edtNumDoc);
end;

procedure TfrmDigSerieRastreaveis.pLimpaDadosDet;
begin
  edtDtEmissao.Text := '';
  edtCodVen.Text    := '';
  edtNomVen.Text    := '';
  edtCodCnd.Text    := '';
  edtDesCnd.Text    := '';
  edtConPag.Text    := '';
  edtCodFpg.Text    := '';
  edtDesFpg.Text    := '';
  edtVlrDoc.Text    := '';
  strTabSer         := '';

  cdsItens.Close;
  cdsItens.qryQuery.Close;

  btnCancelar.Visible := False;
end;

procedure TfrmDigSerieRastreaveis.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if btnCancelar.Visible then
  begin
    if (not cdsItens.isEmpty) and (fMensagem('','Deseja cancelar a edição?', ['&SIM', '&NÃO']) = 2) then
      exit;

    pLimpaDados;
  end;
end;

procedure TfrmDigSerieRastreaveis.btnGravarClick(Sender: TObject);
var
  qrySerie : TUniQuery;


begin
  inherited;

  pSetFocus(btnGravar);

  if cdsItens.isEmpty then
  begin
    pMensagemOK('Não há itens para gravar!');
    exit;
  end;

  qrySerie := fCriaQuery(nil);
  try
    qrySerie.SQL.ADD('REPLACE INTO ' + strTabSer + ' ');
    qrySerie.SQL.ADD('(SER_SEQDET, SER_SEQUEN, SER_NUMSER)');
    qrySerie.SQL.ADD('VALUES ');

    cdsItens.DisableControls;
    cdsItens.First;
    //monta um insert único com todas as séries
    while not cdsItens.Eof do
    begin
      //valida se todos os números estão preenchidos
      if fEmptyStr(cdsItens.FieldByName('NUMSERIE').AsString) then
      begin
        pMensagemOk('É obrigatório informar o Número de Série de todos os itens!');
        pSetFocus(cxgItens);
        exit;
      end;

      qrySerie.SQL.ADD('( ' + QuotedStr(cdsItens.FieldByName('AUTOINCREM').AsString));
      qrySerie.SQL.ADD(' ,' + IntToStr(cdsItens.FieldByName('SEQUEN').AsInteger));
      qrySerie.SQL.ADD(' ,' + QuotedStr(cdsItens.FieldByName('NUMSERIE').AsString) + ')');
      if not (cdsItens.RecNo = cdsItens.RecordCount) then
        qrySerie.SQL.ADD(',');

      cdsItens.Next;
    end;

    qrySerie.ExecSQL;
    pMensagemOk('Números de série lançados com sucesso!');
    pLimpaDados;
  finally
    cdsItens.EnableControls;
    FreeAndNil(qrySerie);
  end;
end;

procedure TfrmDigSerieRastreaveis.cxgItensTV1EditKeyUp(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  Case Key of
  VK_RETURN: if cxgItensTV1NUMSERIE.Focused then
             begin
               Sender.Controller.FocusNextRecord(Sender.Controller.FocusedRecordIndex, not (ssShift in Shift), true, false, false);
               Key := 0;
             end;
  end;
end;

procedure TfrmDigSerieRastreaveis.cxgItensTV1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  //ao entrar em uma separação de grupo por item, pula pra primeira linha do item.
  if (AFocusedRecord = nil) or AFocusedRecord.IsData then
    exit;

  cxgItensTV1.DataController.ClearSelection;
  AFocusedRecord.Expand(FALSE);
  cxgItensTV1.DataController.FocusedRecordIndex := cxgItensTV1.DataController.FocusedRecordIndex;
  cxgItensTV1.Controller.FocusedRow.Selected := TRUE;
end;

procedure TfrmDigSerieRastreaveis.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens := TZClient.Create(Self);
  cxgItensTV1.DataController.DataSource := cdsItens.dtsSource;
end;

procedure TfrmDigSerieRastreaveis.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsItens);
  inherited;
end;

procedure TfrmDigSerieRastreaveis.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    VK_ESCAPE : begin
                  if (not cdsItens.isEmpty) or (not fEmptyStr(edtNumDoc.Text)) then
                  begin
                    Key := 0;
                    btnCancelar.Click;
                  end;
                end;

    VK_F10 : btnGravar.Click;
  end;

  inherited;
end;

procedure TfrmDigSerieRastreaveis.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;

  pLimpaDados;
end;

function TfrmDigSerieRastreaveis.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if Sender = edtNumDoc then
  begin
    if fEmptyStr(edtNumDoc.Text) then
    begin
      pMensagemOk('O número do documento deve ser informado!');
      Result := False;
      exit;
    end;
  end

  else if Sender = edtEspDoc then
  begin
    if fEmptyStr(edtEspDoc.Text) then
    begin
      pMensagemOk('A espécie do documento deve ser informada!');
      Result := False;
      exit;
    end;

    if not MatchStr(edtEspDoc.Text, ['NF','IF','NV','IV']) then
    begin
      pMensagemOk('A espécie do documento deve ser igual a NF, IF, NV OU IV!');
      Result := False;
      exit;
    end;
  end

  else if Sender = edtCodEmp then
  begin
    if fEmptyStr(edtCodEmp.Text) then
    begin
      pMensagemOk('O código da empresa deve ser informado!');
      Result := False;
      exit;
    end;

    if (not fEmptyStr(edtNumDoc.Text)) and (not fEmptyStr(edtEspDoc.Text)) then
      pCarregaDados;

  end;

  if not Result then
    pSetFocus(Sender);
end;

end.
