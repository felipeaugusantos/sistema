unit untOutrasDespesasAposEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untEntDadosOutrasDespesas, untEntOutrasDespesas, untPaiConfirma,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni, cxMemo,
  cxCurrencyEdit, Datasnap.DBClient, UniClientDataSet;

type
  TfrmOutrasDespesasAposEntrada = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    lblTip_fc: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtNomFor: TEditFocus;
    edtNumDoc: TEditFocus;
    edtForCli: TEditFocus;
    edtEspDoc: TEditFocus;
    edtSerie: TEditFocus;
    pnlOutrasDespesas: TPanel;
    cxvDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxvDadosColumn1: TcxGridDBColumn;
    cxvDadosColumn2: TcxGridDBColumn;
    cxvDadosColumn3: TcxGridDBColumn;
    cxvDadosColumn4: TcxGridDBColumn;
    cxvDadosColumn5: TcxGridDBColumn;
    btnEfetivaOutrasDespesas: TBitBtnLocked;
    cxvdadosOUT_EFETIV: TcxGridDBColumn;
    Panel1: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    btnManutencao: TBitBtnLocked;
    btnGuardar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtForCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnManutencaoClick(Sender: TObject);
    procedure cxvDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEfetivaOutrasDespesasClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    EntOutrasDespesas: TEntOutrasDespesas;
    qryConsulta : TUniQuery;
    cdsDados: TUniClientDataSet;
    intLimiteDias: Integer;
    arrDuplicata: TarrDuplicata;
    procedure pSetSQLConsultaEntrada;

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaCarregamento: Boolean;
    procedure pExcluiRegistroVazioCds;

  public
    { Public declarations }
  end;

var
  frmOutrasDespesasAposEntrada: TfrmOutrasDespesasAposEntrada;

implementation

uses
  untFuncoesSimples, untConsultas, untFuncoes;


{$R *.dfm}

procedure TfrmOutrasDespesasAposEntrada.btnGuardarClick(Sender: TObject);
begin
  inherited;
  If Not btnGuardar.Enabled Then
    Exit;

  EntOutrasDespesas.fAutoIncrem(qryConsulta.FieldByName('AUTOINCREM').AsString).pGravarOutDes('A', False);
  qryConsulta.Close;
  qryConsulta.Open;
  EntOutrasDespesas.pPrencheDados(qryConsulta, cdsDados);
  pMensagemOk('Gravado com sucesso!');
end;

procedure TfrmOutrasDespesasAposEntrada.btnManutencaoClick(Sender: TObject);
begin
  inherited;
  If Not btnManutencao.Enabled Then
    Exit;
  EntOutrasDespesas.fInformaOutrasDespesas(arrDuplicata, edtForCli.Text, fNow);
end;

procedure TfrmOutrasDespesasAposEntrada.btnEfetivaOutrasDespesasClick(Sender: TObject);
  var blnConferenciaDepoisDaEntrada: Boolean;
      strTipFor,
      strCompet: String;
      intCtpCon: integer;
      dtaDtaEnt: TDate;
      blnConfirma: Boolean;
begin
  inherited;
  If Not btnEfetivaOutrasDespesas.Enabled Then
    Exit;


  blnConferenciaDepoisDaEntrada := (qryConsulta.FieldByName('GER_DTAENT').AsFloat = 0);
  strTipFor := qryConsulta.FieldByName('MATREV').AsString;
  dtaDtaEnt := fNow;
  strCompet := '';
  intCtpCon := 0;
  fStartTransaction;
  try
    blnConfirma := False;
    If EntOutrasDespesas.fTemRegistroNaoEfetivado Then
    Begin
      EntOutrasDespesas.fAutoIncrem(qryConsulta.FieldByName('AUTOINCREM').AsString);
      If EntOutrasDespesas.fAtualizaDocumento Then
        If EntOutrasDespesas.fGravaContasAPagar(edtForCli.Text,
                                                edtNumDoc.Text,
                                                edtEspDoc.Text,
                                                VS_StrCodEmp,
                                                edtSerie.Text,
                                                strTipFor,
                                                strCompet,
                                                intCtpCon,
                                                dtaDtaEnt,
                                                False,
                                                blnConferenciaDepoisDaEntrada) Then
        begin
          fCommit;
          qryConsulta.Close;
          qryConsulta.Open;
          blnConfirma := True;
          EntOutrasDespesas.pPrencheDados(qryConsulta, cdsDados);
          pMensagemOk('Gravado com sucesso!');
        End;

      If Not blnConfirma Then
        fRollback;
    End;
  except
    on e: Exception do
    Begin
      fRollback;
      pMensagensErro(e.message, 'TfrmOutrasDespesasAposEntrada.btnEfetivaOutrasDespesasClick');
    End;
  End;


end;

procedure TfrmOutrasDespesasAposEntrada.cxvDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvdadosOUT_EFETIV.Index]) = 'S') then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clGreen;
end;

procedure TfrmOutrasDespesasAposEntrada.edtForCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtForCli, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmOutrasDespesasAposEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If fTabelaExiste('TMP_ENTMER') Then
    pDeletaTabelaEntradaMercadorias;

  fDropTable('TMP_ENTTMP');
  inherited;

end;

procedure TfrmOutrasDespesasAposEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  pZeraDigDuplic(arrDuplicata);
  qryConsulta := fCriaQuery;
  EntOutrasDespesas := TEntOutrasDespesas.Create(nil);
  EntOutrasDespesas.blnDigAposEntrada := True;
  intLimiteDias := fCfgSis('HODAEM', varInteger);
end;


procedure TfrmOutrasDespesasAposEntrada.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);
  inherited;

end;

procedure TfrmOutrasDespesasAposEntrada.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10: btnEfetivaOutrasDespesas.Click;
    VK_F9 : btnManutencao.Click;
    VK_F8 : btnGuardar.Click;
  End;
end;

function TfrmOutrasDespesasAposEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtForCli) Then
    Begin
      edtNomFor.Text := fRetNomFornecedor(edtForCli.Text);
      if fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Código do Fornecedor não Encontrado!', ['&OK']);
        Result := False;
      End;

      If Result Then
      Begin
        Result := fValidaCarregamento;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmOutrasDespesasAposEntrada.fValidaCarregamento: Boolean;
begin
  Result := True;
  pSetSQLConsultaEntrada;
  qryConsulta.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
  qryConsulta.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
  qryConsulta.ParamByName('SERIE_').AsString := edtSerie.Text;
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConsulta.ParamByName('FORCLI').AsString := edtForCli.Text;

  qryConsulta.Open;


  if qryConsulta.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Documento não Encontrado!', ['&OK']);
    Result := False;
  End
  Else If qryConsulta.FieldByname('DIAS').AsInteger > intLimiteDias Then
  Begin
    fMensagem('ATENÇÃO', 'Este documento já passou do prazo configurado' + #$A#$D +
                         'CFG_HODAEM - Quantidade de Dias Permitidos para lançamento de Outras Despesas Após Entrada de Mercadoria = ' + intLimiteDias.ToString + #$A#$D +
                         'Data de Entrada do Documento ' + qryConsulta.FieldByName('GER_DTAENT').AsString, ['&OK']);
    Result := False;
  End
  Else
  Begin
    btnEfetivaOutrasDespesas.Enabled := True;
    btnManutencao.Enabled := True;
    btnGuardar.Enabled := True;

    EntOutrasDespesas.pPrencheDados(qryConsulta, cdsDados);
    pExcluiRegistroVazioCds;

    dtsDados.DataSet := cdsDados;
  End;

  If Result Then
  Begin
    blnMudarFoco := False;
    pnlGeral.Enabled := False;
  End;
End;

procedure TfrmOutrasDespesasAposEntrada.pExcluiRegistroVazioCds;
begin

  cdsDados.DisableControls;
  try
    cdsDados.Filtered := False;
    cdsDados.Filter := ' EFETIV = ' +QuotedStr('Pendente')+ ' AND CODFOR = ' +QuotedStr('');
    cdsDados.Filtered := True;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Delete;
    End;

  finally
    cdsDados.Filtered := False;;
    cdsDados.EnableControls;
  end;
end;

procedure TfrmOutrasDespesasAposEntrada.pSetSQLConsultaEntrada;
begin
  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT MOVGER.AUTOINCREM,');
  qryConsulta.SQL.Add('       MOVGER.GER_DTAENT,');
  qryConsulta.SQL.Add('       TIMESTAMPDIFF(DAY, MOVGER.GER_DTAENT, CURDATE()) AS DIAS, ');
  qryConsulta.SQL.Add('       CONCAT(OUT_CODFOR, "-",FOR_NOMFOR) FORNEC,');
  qryConsulta.SQL.Add('       OUT_VALOUT,');
  qryConsulta.SQL.Add('       OUT_HISTOR,');
  qryConsulta.SQL.Add('       OUT_CODFOR AS CODFOR,');
  qryConsulta.SQL.Add('       FOR_NOMFOR AS NOMFOR,');
  qryConsulta.SQL.Add('       OUT_CODCTA AS CODCTA,');
  qryConsulta.SQL.Add('       CTA_DESCTA AS DESCTA,');
  qryConsulta.SQL.Add('       OUT_CODPOR AS CODPOR,');
  qryConsulta.SQL.Add('       POR_NOMPOR AS NOMPOR,');
  qryConsulta.SQL.Add('       OUT_VEIONF AS VEIONF,');
  qryConsulta.SQL.Add('       OUT_VEIOBO AS VEIOBO,');
  qryConsulta.SQL.Add('       OUT_DEPOSI AS DEPOSI,');
  qryConsulta.SQL.Add('       OUT_BCOFOR AS BCOFOR,');
  qryConsulta.SQL.Add('       OUT_CODEVE AS CODEVE,');
  qryConsulta.SQL.Add('       OUT_CNDPAG AS CNDPAG,');
  qryConsulta.SQL.Add('       OUT_VALOUT AS VALOUT,');
  qryConsulta.SQL.Add('       OUT_DUPLIC AS DUPLIC,');
  qryConsulta.SQL.Add('       OUT_HISTOR AS HISTOR,');
  qryConsulta.SQL.Add('       OUT_GERFIN AS GERFIN,');
  qryConsulta.SQL.Add('       OUT_RPAFRE AS RPAFRE,');
  qryConsulta.SQL.Add('       OUT_EFETIV,');
  qryConsulta.SQL.Add('       OUT_TIPRAT,');
  qryConsulta.SQL.Add('       CAST(IF(IFNULL(OUT_ORIGEM, "I") = "I", "Não Definido",  IF(OUT_ORIGEM = "E", "Entrada de Mercadoria", "Após Entrada")) AS CHAR(21)) ORIGEM,');
  qryConsulta.SQL.Add('       CAST(IF(OUT_EFETIV = "S", "Efetivado", "Pendente") AS CHAR(10)) AS EFETIV, ');
  qryConsulta.SQL.Add('       IFNULL(AUX_MATREV, FOR_MATREV) AS MATREV ');
  qryConsulta.SQL.Add('  FROM MOVGER');
  qryConsulta.SQL.Add('  LEFT JOIN OUTDES ON OUTDES.DET_SEQGER = MOVGER.AUTOINCREM');
  qryConsulta.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = OUT_CODFOR');
  qryConsulta.SQL.Add('  LEFT JOIN CADCTA ON CTA_CODCTA = OUT_CODCTA');
  qryConsulta.SQL.Add('  LEFT JOIN CADPOR ON POR_CODPOR = OUT_CODPOR');
  qryConsulta.SQL.Add('  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ');

  qryConsulta.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
  qryConsulta.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
  qryConsulta.SQL.Add('   AND GER_SERIE_ = :SERIE_');
  qryConsulta.SQL.Add('   AND GER_CODEMP = :CODEMP');
  qryConsulta.SQL.Add('   AND GER_CODFOR = :FORCLI');
  qryConsulta.SQL.Add('   AND GER_CLAFIS < "5000"');
end;

end.
