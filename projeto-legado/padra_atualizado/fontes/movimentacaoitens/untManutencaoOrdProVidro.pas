unit untManutencaoOrdProVidro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni, untConstantes, untFuncoesSimples, untTypesSistema,
  untConsultas, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untZClient,
  cxCurrencyEdit, cxContainer, cxProgressBar,  untGerarOrdemdeProducaoPorArquivoDeImportacao,
  Datasnap.DBClient, UniClientDataSet;

type
  TfrmManutencaoOrdProVidro = class(TfrmPai)
    pnlHeader: TPanel;
    edtDocumento: TEditFocus;
    Label6: TLabel;
    edtEspecie: TEditFocus;
    lblEspecie: TLabel;
    edtCodEmp: TEditFocus;
    lblEmpresa: TLabel;
    btnCarregar: TBitBtnLocked;
    rdgDocVendaOuPedVenda: TRadioGroup;
    edtSerie: TEditFocus;
    lblSerie: TLabel;
    Panel2: TPanel;
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxgDadosCODITE: TcxGridDBColumn;
    cxgDadosDESITE: TcxGridDBColumn;
    cxgDadosSIGUNI: TcxGridDBColumn;
    cxgDadosQTDITE: TcxGridDBColumn;
    cxgDadosQTDBAI: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    cxgDadosREFERE: TcxGridDBColumn;
    cxgDadosQTDARQ: TcxGridDBColumn;
    cxgDadosTOTBAI: TcxGridDBColumn;
    cxgDadosQTDRES: TcxGridDBColumn;
    cxgDadosCOD_RECEBEDOR: TcxGridDBColumn;
    cxgDadosNOM_RECEBEDOR: TcxGridDBColumn;
    dtsBaixa: TDataSource;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    Panel3: TPanel;
    lblBaixada: TLabel;
    btnIncluirItem: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    chkBaixarOrdemProducao: TCheckBox;
    cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn;
    Splitter1: TSplitter;
    procedure rdgDocVendaOuPedVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgDadosKeyPress(Sender: TObject; var Key: Char);
    procedure OnAfterScroll(DataSet: TDataSet);
    procedure edtDocumentoKeyPress(Sender: TObject; var Key: Char);
  private
    qryOrdPro: TZClient;
    qryOrdBai: TUniQuery;
    strMotivo: String;
    strSeqGer: String;
    strProjeto: String;
    strSeqMovProBkp: String;
    qryCommand: TUniQuery;
    ItensFatdor : TItensFatdor;
    strCodMovPro: String;
    strOrdPro: String;
    strNUMPED: String;
    strESPPED: String;
    strEMPPED: String;
    blnOpBaixada: Boolean;
    stlListOperadores : TStringList;
    stlListOperadoresLiberados : TStringList;
    blnPedirMotivo: Boolean;


    strUltimoCodOpeValido: String;
    strNomOpe: String;
    blnReplicaOperador: Boolean;
    blnReplicaOperadores : Boolean;

    procedure pLocalizaOrdemDeProducao(var strErro: String);
    procedure pMontaSQLLocalizaVenda;
    procedure pMontaSQLLocalizaFatDor;
    procedure pMontaSQLCampos;
    procedure pCarregaOperadoresBaixa;


    function fGeraOrdemDeProducao(prg: TcxProgressBar): Boolean;
    procedure pGeraLog;
    procedure pAtualizaOrdemDeProducaoOriginal;
    function fProcessaBaixaNovo: Boolean;
    function fBaixaOrdemProducaoNova: Boolean;
    function fProcessaBaixaOriginal: Boolean;
    function fAtualizaSaldoReservaBaixa: Boolean;

    function fProcessaBaixas: Boolean;
    function fBaixaOrdProOriginal: Boolean;


    function fGravaDETPRO(strSeqMovPro: String): boolean;
    procedure pHabilitaAltCampos(blnTemDados: Boolean);
    function fTemItemComQuantidadeSemBaixar: Boolean;


    function fProximoCodigo: String;
    procedure pReplicaOperadores;



    function fGravaMovPro(var strSeqMovPro: String): boolean;
    procedure pPreencheProdutoAcabado;
    procedure OnBeforePost(DataSet: TDataSet);
    procedure OnAfterPost(DataSet: TDataSet);
    procedure pReplicaOperador;
    function fReplicaOperador: Boolean;


    procedure pOnBeforePostTrataOperador;
    procedure pOnBeforePostTrataQTDBAI;
    function fValidaRegras: Boolean;
    function fLiberaItensComQuantidadeMaiorQueSaldoRestante: Boolean;
    function fTravaComQuantidadeMaiorQueSaldoRestante: Boolean;
    function fDefinirSenhaDeTodosRecebedores: Boolean;
    function fDefineSenhaOperador(strCodOpe: String): Boolean;
    procedure pPreencheListaTodosOperadores;
    procedure pGrava;
    procedure pAtualizaMotivo;

    function fAtualizaCustos: Boolean;
    function fTodosComQuantidadeDefinidaTemRecebedor: Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManutencaoOrdProVidro: TfrmManutencaoOrdProVidro;

implementation

uses
  untBaixaOrdProdAcabadoIncluiItens, untGravando, untOrdPro, untLiberacao, untMsgLiberacao,
  untRecebedorMaterialVidro, untDigMotivo;

{$R *.dfm}

procedure TfrmManutencaoOrdProVidro.btnCarregarClick(Sender: TObject);
var strErro: String;
begin
  inherited;
  strSeqGer := '';
  strProjeto := '';
  stlListOperadores.Clear;
  stlListOperadoresLiberados.Clear;

  pLocalizaOrdemDeProducao(strErro);
  If Not fEmptyStr(strErro) Then
    pMensagemOk(strErro)
  Else
  Begin
    pHabilitaAltCampos(True);
    qryOrdPro.BeforePost := OnBeforePost;
    qryOrdPro.AfterPost := OnAfterPost;

  End;

  dtsDados.DataSet := qryOrdPro;
end;

procedure TfrmManutencaoOrdProVidro.pHabilitaAltCampos(blnTemDados: Boolean);
Begin
  pnlHeader.Enabled := Not blnTemDados;
  btnIncluirItem.Enabled := blnTemDados and btnExcluir.Visible;
  btnExcluir.Enabled := blnTemDados and btnExcluir.Visible;
  btnConfirma.Enabled := blnTemDados;

  chkBaixarOrdemProducao.Checked := False;
  chkBaixarOrdemProducao.Visible := True;
  lblBaixada.Visible := False;
  If blnTemDados Then
  Begin
    If blnOpBaixada Then
    Begin
      chkBaixarOrdemProducao.Checked := True;
      chkBaixarOrdemProducao.Visible := False;
      lblBaixada.Visible := True;
    End;
    lblBaixada.Visible := Not chkBaixarOrdemProducao.Visible;

  End;

End;

function TfrmManutencaoOrdProVidro.fTemItemComQuantidadeSemBaixar: Boolean;
begin
  Result := False;
  If Not blnOpBaixada then
  begin
    If chkBaixarOrdemProducao.Checked Then
    Begin
      qryOrdPro.Filtered := False;
      qryOrdPro.Filter := '(QTDRES - QTDBAI) > 0';
      qryOrdPro.Filtered := True;
      Result := Not qryOrdPro.IsEmpty;
      qryOrdPro.Filtered := False;
      qryOrdPro.Filter := ''
    End;
  End;
End;

procedure TfrmManutencaoOrdProVidro.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  strSeqMovProBkp := '';
  If Not btnConfirma.Enabled then
    Exit;
  strCodMovPro := '';
  strMotivo := '';
  blnPedirMotivo := False;
  pPreencheProdutoAcabado;
  Try
    qryOrdPro.DisableControls;
    blnPedirMotivo := fTemItemComQuantidadeSemBaixar;

    qryOrdPro.Filtered := False;
    qryOrdPro.Filter := 'QTDBAI > 0 OR ITEMNOVO = '+ QuotedStr('S');
    qryOrdPro.Filtered := True;
    If fValidaRegras then
    begin

      If blnPedirMotivo then
        strMotivo := TfrmDigMotivo.fDigMotivo;

      qryOrdPro.Filtered := False;
      qryOrdPro.Filter := 'QTDBAI = 0 AND ITEMNOVO = '+ QuotedStr('S');
      qryOrdPro.Filtered := True;
      while not qryOrdPro.Eof Do
      Begin
        pAtualizaOrdemDeProducaoOriginal;
        qryOrdPro.Next;
      End;

      qryOrdPro.Filtered := False;
      qryOrdPro.Filter := 'QTDBAI > 0 ';
      qryOrdPro.Filtered := True;
      pGrava;
    End
  Finally
    qryOrdPro.Filtered := False;
    qryOrdPro.Filter := '';
    qryOrdPro.EnableControls;
  End;
end;

procedure TfrmManutencaoOrdProVidro.pAtualizaOrdemDeProducaoOriginal;
begin
  qryCommand.SQL.Clear;
  If qryOrdPro.FieldByName('AUTINC').AsString = '' then
  Begin
    qryCommand.SQL.Add('INSERT INTO DETPRO ( DOP_SEQGER,  DOP_SEQUEN,   DOP_CODEMP,   DOP_ITESUB,  DOP_QTDITE,  DOP_NUMLOT,  DOP_NUMFAS, AUTOINCREM, DOP_QTDBAI, DOP_QTDARQ)');
    qryCommand.SQL.Add('            VALUES (:DOP_SEQGER, :DOP_SEQUEN,  :DOP_CODEMP,  :DOP_ITESUB, :DOP_QTDITE, :DOP_NUMLOT, :DOP_NUMFAS, :AUTOINCREM, :DOP_QTDBAI, :DOP_QTDARQ)');
    qryCommand.ParamByName('DOP_SEQGER').AsString  := strSeqGer;
    qryCommand.ParamByName('DOP_SEQUEN').AsString  := fAtualizaProCod('DETPRO', 'DOP_SEQUEN');
    qryCommand.ParamByName('DOP_CODEMP').AsString  := VS_StrCodEmp;
    qryCommand.ParamByName('DOP_ITESUB').AsString  := qryOrdPro.FieldByName('CODITE').AsString;
    If SameText(qryOrdPro.FieldByName('ITEMNOVO').AsString, 'S') Then
    Begin
      qryCommand.ParamByName('DOP_QTDITE').AsFloat :=  qryOrdPro.FieldByName('QTDITE').AsFloat;
      qryCommand.ParamByName('DOP_QTDARQ').AsFloat :=  qryOrdPro.FieldByName('QTDITE').AsFloat;
    End
    Else
    Begin
      qryCommand.ParamByName('DOP_QTDITE').AsFloat :=  qryOrdPro.FieldByName('QTDBAI').AsFloat;
      qryCommand.ParamByName('DOP_QTDARQ').AsFloat   := 0;
    End;
    qryCommand.ParamByName('DOP_NUMFAS').AsInteger := qryOrdPro.RecNo;
    qryCommand.ParamByName('DOP_NUMLOT').Clear;
    qryCommand.ParamByName('DOP_QTDBAI').AsFloat   := qryOrdPro.FieldByName('QTDBAI').AsFloat;
    qryCommand.ParamByName('AUTOINCREM').AsString  := fRetAutoincrem('DETPRO', VS_StrCodEmp);
  End
  Else
  Begin
    qryCommand.SQL.Add('UPDATE DETPRO SET DOP_QTDBAI = IFNULL(DOP_QTDBAI,0)  + :DOP_QTDBAI');
    If qryOrdPro.FieldByName('QTDBAI').AsFloat > qryOrdPro.FieldByName('QTDRES').AsFloat Then
      qryCommand.SQL.Add('                  , DOP_QTDITE = :QTDTOT');
    qryCommand.SQL.Add( 'WHERE AUTOINCREM = :AUTINC');
    If qryOrdPro.FieldByName('QTDBAI').AsFloat > qryOrdPro.FieldByName('QTDRES').AsFloat Then
      qryCommand.ParamByName('QTDTOT').AsFloat := qryOrdPro.FieldByName('QTDBAI').AsFloat  +  qryOrdPro.FieldByName('TOTBAI').AsFloat;
    qryCommand.ParamByName('DOP_QTDBAI').AsFloat := qryOrdPro.FieldByName('QTDBAI').AsFloat;
    qryCommand.ParamByName('AUTINC').AsString := qryOrdPro.FieldByName('AUTINC').AsString;
  End;
  qryCommand.ExecSQL;

  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = "'+qryOrdPro.FieldByName('CODITE').AsString+'" AND ITE_CODEMP = "'+VS_StrCodEmp+'"');
  qryCommand.ExecSQL;

end;

function TfrmManutencaoOrdProVidro.fProcessaBaixaOriginal: Boolean;
  var
    objOrdPro : TOrdPro;
begin
  If Not fBaixaOrdProOriginal then
    Exit(True);

  Try
    objOrdPro := TOrdPro.Create(Self, False);
    result := objOrdPro.fOrdemProducaoProdutoAcabado(strOrdPro, True, True);
  Finally
    FreeAndNil(objOrdPro);
  End;
End;

function TfrmManutencaoOrdProVidro.fProcessaBaixaNovo: Boolean;
  var
    objOrdPro : TOrdPro;
begin
  if fEmptyStr(strCodMovPro) Then
    Exit(True);

  Try
    objOrdPro := TOrdPro.Create(Self, False);
    Result := objOrdPro.fOrdemProducaoProdutoAcabado(strCodMovPro, True);
    If Result Then
      Result := fBaixaOrdemProducaoNova;
  Finally
    FreeAndNil(objOrdPro);
  End;
End;

function TfrmManutencaoOrdProVidro.fProcessaBaixas: Boolean;
begin
  result := fProcessaBaixaOriginal;
  If Result Then
    Result := fProcessaBaixaNovo;
  If Result Then
    result := fAtualizaCustos;
  If Result Then
    Result := fAtualizaSaldoReservaBaixa;
End;

function TfrmManutencaoOrdProVidro.fAtualizaSaldoReservaBaixa: Boolean;
begin
  qryCommand.SQl.Clear;
  qryCommand.SQL.Add('UPDATE ITEGER G                   ');
  qryCommand.SQL.Add('  INNER JOIN DETPRO D             ');
  qryCommand.SQL.Add('   ON G.ITE_CODITE = D.DOP_ITESUB ');
  qryCommand.SQL.Add('  INNER JOIN MOVPRO M             ');
  qryCommand.SQL.Add('  ON M.AUTOINCREM = D.DOP_SEQGER  ');
  qryCommand.SQL.Add(' AND G.ITE_CODEMP = PRO_EMPPED    ');
  qryCommand.SQL.Add(' SET ITE_REPAUD = "S"             ');
  qryCommand.SQL.Add('WHERE PRO_NUMPED = ' + QuotedStr(strNUMPED));
  qryCommand.SQL.Add('  AND PRO_ESPPED = ' + QuotedStr(strESPPED));
  qryCommand.SQL.Add('  AND PRO_CODPRO = ' + QuotedStr(strOrdPro));
  qryCommand.SQL.Add('  AND PRO_EMPPED = ' + QuotedStr(strEMPPED));
  qryCommand.ExecSQL;
  Result := True;
end;

function TfrmManutencaoOrdProVidro.fBaixaOrdemProducaoNova: Boolean;
begin
  If strSeqMovProBkp =  '' Then
    Exit(True);
  qryCommand.SQl.Clear;
  qryCommand.SQL.Add('UPDATE MOVPRO SET PRO_DTABAI = CURDATE(), PRO_HORBAI = CURTIME() WHERE AUTOINCREM = "'+strSeqMovProBkp+'"');
  qryCommand.ExecSQL;
  Result := True;
end;

function TfrmManutencaoOrdProVidro.fBaixaOrdProOriginal: Boolean;
begin
  result := False;
  If chkBaixarOrdemProducao.Checked then
    If chkBaixarOrdemProducao.Visible then
      result := True;
End;

procedure TfrmManutencaoOrdProVidro.pGeraLog;
begin
  qryCommand.SQL.Clear;
  qryCommand.SQL.Add('INSERT INTO LOGVID(');
  qryCommand.SQL.Add('  AUTOINCREM,');
  qryCommand.SQL.Add('  LOG_CODREC,');
  qryCommand.SQL.Add('  LOG_QTDREC,');
  qryCommand.SQL.Add('  LOG_DTACAD,');
  qryCommand.SQL.Add('  LOG_CODEMP,');
  qryCommand.SQL.Add('  LOG_CODITE,');
  qryCommand.SQL.Add('  LOG_ORDORI,');
  qryCommand.SQL.Add('  LOG_ORDNOV)');
  qryCommand.SQL.Add('VALUES(');
  qryCommand.SQL.Add('  :AUTOINCREM,');
  qryCommand.SQL.Add('  :LOG_CODREC,');
  qryCommand.SQL.Add('  :LOG_QTDREC,');
  qryCommand.SQL.Add('  :LOG_DTACAD,');
  qryCommand.SQL.Add('  :LOG_CODEMP,');
  qryCommand.SQL.Add('  :LOG_CODITE,');
  qryCommand.SQL.Add('  :LOG_ORDORI,');
  qryCommand.SQL.Add('  :LOG_ORDNOV)');
  qryCommand.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('LOGVID', VS_StrCodEmp);

  If fEmptyStr(qryOrdPro.FieldByName('COD_RECEBEDOR').AsString) Then
    qryCommand.ParamByName('LOG_CODREC').AsString := strLoginUsuarioLogado
  Else
    qryCommand.ParamByName('LOG_CODREC').AsString := qryOrdPro.FieldByName('COD_RECEBEDOR').AsString;

  qryCommand.ParamByName('LOG_QTDREC').AsFloat  := qryOrdPro.FieldByName('QTDBAI').AsFloat;
  qryCommand.ParamByName('LOG_DTACAD').AsDateTime := fNow;
  qryCommand.ParamByName('LOG_CODEMP').AsString := strEMPPED;
  qryCommand.ParamByName('LOG_CODITE').AsString := qryOrdPro.FieldByName('CODITE').AsString;
  qryCommand.ParamByName('LOG_ORDORI').AsString := strOrdPro;
  qryCommand.ParamByName('LOG_ORDNOV').AsString := strCodMovPro;
  qryCommand.ExecSQL;
end;

procedure TfrmManutencaoOrdProVidro.pGrava;
var frmGravando: TFrmGravando;
    blnCommit: Boolean;
begin
  fStartTransaction;
  Try
    pCriarFormularios(TFrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Gerando Ordem de Produção';
      frmGravando.pgbStatus.Visible := False;
      frmGravando.fExecutarAcao := fGeraOrdemDeProducao;
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
      Begin
         blnCommit := fProcessaBaixas;
         pAtualizaMotivo;
      End
      Else
        blnCommit := True;

      If blnCommit Then
      Begin
        fCommit;
        pHabilitaAltCampos(False);
        pMensagemOk('Processo Concluído!');
        pSetFocus(edtDocumento);
        qryOrdPro.Close;
      End
      Else
        fRollBack;;
    Finally
      FreeAndNil(frmGravando);
    End;
  Except
    on E: Exception do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmManutencaoOrdProVidro.pGrava]');
    End;
  End;
end;

procedure TfrmManutencaoOrdProVidro.pAtualizaMotivo;
begin
 If strMotivo = '' Then
   Exit;
 qryCommand.SQL.Clear;
 qryCommand.SQL.Add('UPDATE MOVPRO SET PRO_OBS001 = "'+strMotivo+'"  WHERE PRO_CODPRO = "'+strOrdPro+'";');
 qryCommand.SQL.Add('UPDATE FATGOR SET FGO_MENEXP = "'+strMotivo+'" ');
 qryCommand.SQL.Add(' WHERE FGO_NUMDOC = "'+strNUMPED+'"');
 qryCommand.SQL.Add('   AND FGO_ESPDOC = "'+strESPPED+'"');
 qryCommand.SQL.Add('   AND FGO_CODEMP = "'+strEMPPED+'";');
 qryCommand.ExecSQL;

end;

function TfrmManutencaoOrdProVidro.fAtualizaCustos: Boolean;
  var qryConsulta: TUniQuery;
  fltTotCus, fltTotMed: Double;
  strTIPFAT,
  strNUMFAT,
  strEMPFAT,
  strCODITE: String;

begin

  qryConsulta := fCriaQuery;
  Try
    Try
      qryConsulta.SQL.Add('SELECT');
      qryConsulta.SQL.Add('SUM(PRECUS) TOTCUS,');
      qryConsulta.SQL.Add('SUM(PREMED) TOTMED');
      qryConsulta.SQL.Add('FROM');
      qryConsulta.SQL.Add('(SELECT');
      qryConsulta.SQL.Add('   DOP_QTDBAI * ITE_PRECUS AS PRECUS,');
      qryConsulta.SQL.Add('   DOP_QTDBAI * ITE_PREMED AS PREMED');
      qryConsulta.SQL.Add('FROM');
      qryConsulta.SQL.Add('  DETPRO D');
      qryConsulta.SQL.Add('  INNER JOIN MOVPRO');
      qryConsulta.SQL.Add('    ON MOVPRO.AUTOINCREM = DOP_SEQGER');
      qryConsulta.SQL.Add('  INNER JOIN CADITE C');
      qryConsulta.SQL.Add('    ON C.ITE_CODITE = DOP_ITESUB');
      qryConsulta.SQL.Add('  INNER JOIN ITEGER G');
      qryConsulta.SQL.Add('    ON G.ITE_CODITE = DOP_ITESUB');
      qryConsulta.SQL.Add('    AND G.ITE_CODEMP = PRO_EMPPED');
      qryConsulta.SQL.Add('  LEFT JOIN CADUNI');
      qryConsulta.SQL.Add('    ON CADUNI.UNI_CODUNI = ITE_CODUNI');
      qryConsulta.SQL.Add('WHERE PRO_NUMPED = "'+strNUMPED+'"');
      qryConsulta.SQL.Add('  AND PRO_ESPPED = "'+strESPPED+'"');
      qryConsulta.SQL.Add('  AND PRO_CODPRO = "'+strOrdPro+'"');
      qryConsulta.SQL.Add('  AND PRO_EMPPED = "'+strEMPPED+'") TMP');


      qryConsulta.Open;
      fltTotCus := qryConsulta.FieldByName('TOTCUS').AsFloat;
      fltTotMed := qryConsulta.FieldByName('TOTMED').AsFloat;

      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT FGO_TIPFAT,');
      qryConsulta.SQL.Add('       FGO_NUMFAT,');
      qryConsulta.SQL.Add('       FGO_EMPFAT,');

      qryConsulta.SQL.Add('       @FDOINC := (SELECT MIN(FATDOR.AUTOINCREM)');
      qryConsulta.SQL.Add('                     FROM FATDOR');
      qryConsulta.SQL.Add('                    WHERE FDO_SEQGER = FATGOR.AUTOINCREM) AS FDOINC,');
      qryConsulta.SQL.Add('       (SELECT FDO_CODITE FROM FATDOR');
      qryConsulta.SQL.Add('         WHERE FATDOR.AUTOINCREM = @FDOINC) AS FDOITE');

      qryConsulta.SQL.Add('  FROM FATGOR');
      qryConsulta.SQL.Add('WHERE FGO_NUMDOC = "'+strNUMPED+'"');
      qryConsulta.SQL.Add('  AND FGO_ESPDOC = "'+strESPPED+'"');
      qryConsulta.SQL.Add('  AND FGO_CODEMP = "'+strEMPPED+'"');
      qryConsulta.Open;

      qryCommand.SQL.Clear;
      qryCommand.SQL.Add('UPDATE FATDOR SET FDO_TOTCUS = :TOTCUS, FDO_TOTMED = :TOTMED WHERE AUTOINCREM = :AUTINC');
      qryCommand.ParamByName('TOTCUS').Value := fltTotCus;
      qryCommand.ParamByName('TOTMED').Value := fltTotMed;
      qryCommand.ParamByName('AUTINC').Value := qryConsulta.FieldByName('FDOINC').AsString;
      qryCommand.ExecSQL;

      If qryConsulta.FieldByName('FGO_NUMFAT').AsString <> '' Then
      Begin
        strTIPFAT := qryConsulta.FieldByName('FGO_TIPFAT').AsString;
        strNUMFAT := qryConsulta.FieldByName('FGO_NUMFAT').AsString;
        strEMPFAT := qryConsulta.FieldByName('FGO_EMPFAT').AsString;
        strCODITE := qryConsulta.FieldByName('FDOITE').AsString;

        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT MIN(AUTOINCREM) AUTINC FROM MOVDET');
        qryConsulta.SQL.Add(' WHERE DET_ESPDOC ="'+strTIPFAT+'"');
        qryConsulta.SQL.Add('   AND DET_CODEMP ="'+strEMPFAT+'"');
        qryConsulta.SQL.Add('   AND DET_NUMDOC ="'+strNUMFAT+'"');
        qryConsulta.SQL.Add('   AND DET_CODITE ="'+strCODITE+'"');

        qryConsulta.Open;

        qryCommand.SQL.Clear;
        qryCommand.SQL.Add('UPDATE MOVDET ');
        qryCommand.SQL.Add('   SET DET_TOTCUS = :TOTCUS,');
        qryCommand.SQL.Add('       DET_TOTMED = :TOTMED');
        qryCommand.SQL.Add(' WHERE AUTOINCREM = :AUTINC');

        qryCommand.ParamByName('TOTCUS').AsFloat := fltTotCus;
        qryCommand.ParamByName('TOTMED').AsFloat := fltTotMed;
        qryCommand.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTINC').AsString;
        qryCommand.ExecSQL;
      End;
      Result := True;
    Finally
      FreeAndNil(qryConsulta);
    End;
  Except
    raise;
  End;

end;

procedure TfrmManutencaoOrdProVidro.pPreencheListaTodosOperadores;
Begin
  stlListOperadores.Clear;
  qryOrdPro.First;
  While not qryOrdPro.Eof Do
  begin
    stlListOperadores.Add(qryOrdPro.FieldByName('COD_RECEBEDOR').AsString);
    qryOrdPro.Next;
  End;
End;

function TfrmManutencaoOrdProVidro.fDefineSenhaOperador(strCodOpe: String): Boolean;
var dts: TUniClientDataSet;
begin
  dts := TUniClientDataSet.Create(Self);
  Try
    dts.Data :=  qryOrdPro.Data;
    dts.Filtered := False;
    dts.Filter := 'COD_RECEBEDOR = ' + QuotedStr(strCodOpe);
    dts.Filtered := True;

    Result := TfrmRecebedorMaterialVidro.fPedeSenhaOperador(strCodOpe, dts);
    If Result then
      stlListOperadoresLiberados.Add(strCodOpe);
  Finally
    FreeAndNil(dts);
  End;

end;

function TfrmManutencaoOrdProVidro.fDefinirSenhaDeTodosRecebedores: Boolean;
var i: Integer;
    intIndex: Integer;
begin
  Result := False;
  pPreencheListaTodosOperadores;
  If stlListOperadores.Count = 0 Then
    Exit(True);
  For i := 0 To stlListOperadores.Count -1 Do
  Begin
    intIndex := 0;
    If not stlListOperadoresLiberados.Find(stlListOperadores[i], intIndex) Then
    Begin
      result := fDefineSenhaOperador(stlListOperadores[i]);
      If Not Result Then
        Exit;
    End;
  End;
end;


function TfrmManutencaoOrdProVidro.fGeraOrdemDeProducao(prg: TcxProgressBar): Boolean;
var strSeqMovPro: String;
begin
  Result := True;
  Try
    If Not qryOrdPro.IsEmpty Then
      fGravaMovPro(strSeqMovPro);
    prg.Properties.Max :=  qryOrdPro.RecordCount;
    qryOrdPro.First;
    while not qryOrdPro.Eof do
    begin
      fGravaDETPRO(strSeqMovPro);
      pAtualizaOrdemDeProducaoOriginal;
      pGeraLog;
      qryOrdPro.Next;
      prg.Position := qryOrdPro.RecNo;
      Application.ProcessMessages;
    End;
  Except
    on e: exception do
    Begin
      fRollBack;
      pMensagensErro(e.message, '[TfrmManutencaoOrdProVidro.fGeraOrdemDeProducao]');
      Result := False;
    End;
  End;
end;

function TfrmManutencaoOrdProVidro.fGravaDETPRO(strSeqMovPro: String): boolean;
begin
  qryCommand.SQl.Clear;
  qryCommand.SQL.Add('INSERT INTO DETPRO ( DOP_SEQGER,  DOP_SEQUEN,   DOP_CODEMP,   DOP_ITESUB,  DOP_QTDITE,  DOP_NUMLOT,  DOP_NUMFAS, AUTOINCREM,  DOP_QTDBAI)');
  qryCommand.SQL.Add('            VALUES (:DOP_SEQGER, :DOP_SEQUEN,  :DOP_CODEMP,  :DOP_ITESUB, :DOP_QTDITE, :DOP_NUMLOT, :DOP_NUMFAS, :AUTOINCREM, :DOP_QTDBAI)');

  qryCommand.ParamByName('DOP_SEQGER').AsString := strSeqMovPro;
  qryCommand.ParamByName('DOP_SEQUEN').AsString := fAtualizaProCod('DETPRO', 'DOP_SEQUEN');
  qryCommand.ParamByName('DOP_CODEMP').AsString := VS_StrCodEmp;
  qryCommand.ParamByName('DOP_ITESUB').AsString := qryOrdPro.FieldByName('CODITE').AsString;
  If SameText(qryOrdPro.FieldByName('ITEMNOVO').AsString, 'S') Then
    qryCommand.ParamByName('DOP_QTDITE').AsFloat :=  qryOrdPro.FieldByName('QTDITE').AsFloat
  Else
    qryCommand.ParamByName('DOP_QTDITE').AsFloat :=  qryOrdPro.FieldByName('QTDBAI').AsFloat;
  qryCommand.ParamByName('DOP_QTDBAI').AsFloat :=  qryOrdPro.FieldByName('QTDBAI').AsFloat;
  qryCommand.ParamByName('DOP_NUMFAS').AsInteger := qryOrdPro.RecNo;
  qryCommand.ParamByName('DOP_NUMLOT').Clear;
  qryCommand.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('DETPRO', VS_StrCodEmp);
  qryCommand.ExecSQL;

  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = "'+qryOrdPro.FieldByName('CODITE').AsString+'" AND ITE_CODEMP = "'+VS_StrCodEmp+'"');
  qryCommand.ExecSQL;

  Result := True;
end;

function TfrmManutencaoOrdProVidro.fProximoCodigo: String;
begin
  Result := fAtualizaProCod('MOVPRO', 'PRO_CODPRO');
end;

procedure TfrmManutencaoOrdProVidro.pReplicaOperadores;
var intRecNo: Integer;
begin
  If blnReplicaOperadores then
  begin
    qryOrdPro.BeforePost := nil;
    qryOrdPro.AfterPost := nil;
    intRecNo := qryOrdPro.RecNo;
    Try
      qryOrdPro.First;
      while not qryOrdPro.Eof Do
      begin
        If fReplicaOperador Then
        begin
          qryOrdPro.Edit;
          pReplicaOperador;
          qryOrdPro.Post;
        End;
        qryOrdPro.Next;
      End;
    Finally
      qryOrdPro.BeforePost := OnBeforePost;
      qryOrdPro.AfterPost := OnAfterPost;
      qryOrdPro.RecNo := intRecNo;
    End;
  End;
end;

procedure TfrmManutencaoOrdProVidro.OnAfterPost(DataSet: TDataSet);
begin
  pReplicaOperadores;

end;

procedure TfrmManutencaoOrdProVidro.OnBeforePost(DataSet: TDataSet);
begin
  If cxgDadosCOD_RECEBEDOR.Focused Then
    pOnBeforePostTrataOperador
  Else If cxgDadosQTDBAI.Focused Then
    pOnBeforePostTrataQTDBAI
end;

procedure TfrmManutencaoOrdProVidro.pOnBeforePostTrataQTDBAI;
Begin
  pReplicaOperador
End;

procedure TfrmManutencaoOrdProVidro.pReplicaOperador;
begin
  If fReplicaOperador Then
    Begin
      qryOrdPro.FieldByName('NOM_RECEBEDOR').AsString := strNomOpe;
      qryOrdPro.FieldByName('COD_RECEBEDOR').AsString := strUltimoCodOpeValido;
    End;
End;

function TfrmManutencaoOrdProVidro.fReplicaOperador: Boolean;
begin
  Result := False;
  If qryOrdPro.FieldByName('QTDBAI').AsFloat > 0 then
    If qryOrdPro.FieldByName('COD_RECEBEDOR').AsString = '' Then
      If strUltimoCodOpeValido <> '' Then
        Result := True;
End;


function TfrmManutencaoOrdProVidro.fTodosComQuantidadeDefinidaTemRecebedor: Boolean;
begin
  qryOrdPro.First;
  Result := True;
  While not qryOrdPro.Eof Do
  Begin
    If qryOrdPro.FieldByName('QTDBAI').AsFloat > 0 then
      If qryOrdPro.FieldByName('COD_RECEBEDOR').AsString = '' Then
      Begin
        pMensagemOk('É preciso definir todos os recebedores, para itens com quantidade para baixar!');
        exit(false);
      End;
    qryOrdPro.Next;
  End;
end;


function TfrmManutencaoOrdProVidro.fTravaComQuantidadeMaiorQueSaldoRestante: Boolean;
  Var
    objLiberacao : TLiberacao;
  	objLinha  : TLinhaMsgLibera;
    objTabela : TRegistroMsgLiberaTabela;
begin
  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.objMsgLibera.pAddTexto('Itens com quantida para baixar maior do que o necessário', alCentro, teAmbos, '', 70);

    objLiberacao.objMsgLibera.pAddSeparador(70);
    objLiberacao.objMsgLibera.pAddTextoCaption('Projeto: '          , strProjeto, 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Produção: ' , strOrdPro , 16);
    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'ITEM'          , 8 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DESCRIÇÃO'     , 30 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'REFERENCIA'    , 30 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'QTD. RESTANTE' , 20 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'QTD. BAIXA'  , 20 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
    qryOrdPro.First;
    while not qryOrdPro.Eof Do
    Begin
      If qryOrdPro.FieldByName('QTDBAI').AsFloat > qryOrdPro.FieldByName('QTDRES').AsFloat Then
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('ITEM'          , qryOrdPro.FieldByName('CODITE').AsString , 8 , alEsquerda , teAutcom);
        objLinha.pAddColuna('DESCRIÇÃO'     , qryOrdPro.FieldByName('DESITE').AsString , 30 , alEsquerda , teAutcom);
        objLinha.pAddColuna('REFERENCIA'    , qryOrdPro.FieldByName('REFERE').AsString , 30 , alEsquerda , teAutcom);
        objLinha.pAddColuna('QTD. RESTANTE' , FormatFloat('#,##0.00', qryOrdPro.FieldByName('QTDRES').AsFloat)  , 20 , alDireita  , teAutcom);
        objLinha.pAddColuna('QTD. BAIXA'  , FormatFloat('#,##0.00', qryOrdPro.FieldByName('QTDBAI').AsFloat)  , 20 , alDireita  , teAutcom);

        objTabela.lstLinhas.Add(objLinha);
      End;
      qryOrdPro.Next;
    End;
    qryOrdPro.First;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


    objLiberacao.strDirAce := 'OPVLQM';
    objLiberacao.strMsgSen := 'Liberação para baixa de O.P. com quantidade maior do que a solicitada.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;

end;

function TfrmManutencaoOrdProVidro.fValidaRegras: Boolean;
begin
  Result := False;
  If fTodosComQuantidadeDefinidaTemRecebedor Then
    If fLiberaItensComQuantidadeMaiorQueSaldoRestante Then
      If fDefinirSenhaDeTodosRecebedores then
        Result :=  True;
end;

procedure TfrmManutencaoOrdProVidro.pOnBeforePostTrataOperador;
Begin
  blnReplicaOperador    := False;
  blnReplicaOperadores := False;

  If qryOrdPro.FieldByName('COD_RECEBEDOR').AsString <> '' Then
  Begin
     qryOrdPro.FieldByName('NOM_RECEBEDOR').AsString := fRetNomeOperador(qryOrdPro.FieldByName('COD_RECEBEDOR').AsString);
     If qryOrdPro.FieldByName('NOM_RECEBEDOR').AsString = '' Then
     Begin
       pMensagemOk('Operador inválido!');
       qryOrdPro.FieldByName('COD_RECEBEDOR').AsString := '';
     End
     Else If strUltimoCodOpeValido <> qryOrdPro.FieldByName('COD_RECEBEDOR').AsString Then
     Begin
       strUltimoCodOpeValido :=  '';
       strNomOpe  :=  '';
       blnReplicaOperador    := fPergunta('Deseja replicar este operador para todos os itens com quantidade de baixa sem recebedor? ');
       If blnReplicaOperador Then
       Begin
         blnReplicaOperadores := True;
         strUltimoCodOpeValido :=  qryOrdPro.FieldByName('COD_RECEBEDOR').AsString;
         strNomOpe  :=  qryOrdPro.FieldByName('NOM_RECEBEDOR').AsString;
       End;
     End;
  End
  Else
    qryOrdPro.FieldByName('NOM_RECEBEDOR').AsString := '';

End;

function TfrmManutencaoOrdProVidro.fGravaMovPro(var strSeqMovPro: String): boolean;
begin

  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('INSERT INTO MOVPRO ( AUTOINCREM,  PRO_CODEMP,  PRO_CODPRO,  PRO_CODITE,  PRO_QTDAPR,  PRO_DTAPRO, PRO_DTACAD,   PRO_NUMPED,  PRO_ESPPED,  PRO_EMPPED,  PRO_CODCLI,  PRO_PROJEC, PRO_IMPDEF,  PRO_ORIGEM)  VALUES');
  qryCommand.SQl.Add('                   (:AUTOINCREM, :PRO_CODEMP, :PRO_CODPRO, :PRO_CODITE, :PRO_QTDAPR, :PRO_DTAPRO, :PRO_DTACAD, :PRO_NUMPED, :PRO_ESPPED, :PRO_EMPPED, :PRO_CODCLI, :PRO_PROJEC, :PRO_IMPDEF, :PRO_ORIGEM)');


  strSeqMovPro := fRetAutoIncrem('MOVPRO', VS_StrCodemp);
  strSeqMovProBkp := strSeqMovPro;
  strCodMovPro := fProximoCodigo;
  qryCommand.ParamByName('AUTOINCREM').AsString := strSeqMovPro;
  qryCommand.ParamByName('PRO_CODEMP').AsString := VS_StrCodEmp;
  qryCommand.ParamByName('PRO_CODPRO').AsString := strCodMovPro;
  qryCommand.ParamByName('PRO_CODITE').AsString := ItensFatdor.ItemCodite;
  qryCommand.ParamByName('PRO_QTDAPR').AsFloat := 1;
  qryCommand.ParamByName('PRO_DTAPRO').AsDateTime := fNow;
  qryCommand.ParamByName('PRO_DTACAD').AsDateTime := fNow;
  qryCommand.ParamByName('PRO_NUMPED').AsString := strNUMPED;
  qryCommand.ParamByName('PRO_ESPPED').AsString := strESPPED;
  qryCommand.ParamByName('PRO_EMPPED').AsString := strEMPPED;
  qryCommand.ParamByName('PRO_CODCLI').AsString := ItensFatdor.strCodCli;
  qryCommand.ParamByName('PRO_PROJEC').AsString := strProjeto;
  qryCommand.ParamByName('PRO_IMPDEF').AsString := 'S';
  qryCommand.ParamByName('PRO_ORIGEM').AsString := strOrdPro;


  qryCommand.ExecSQL;
  Result := True;
end;

function TfrmManutencaoOrdProVidro.fLiberaItensComQuantidadeMaiorQueSaldoRestante: Boolean;
  Var
    blnPrecisaTravar: Boolean;
begin
  Result := True;
  qryOrdPro.First;
  blnPrecisaTravar := False;
  While not qryOrdPro.Eof Do
  Begin
    If qryOrdPro.FieldByName('QTDBAI').AsFloat > qryOrdPro.FieldByName('QTDRES').AsFloat Then
    Begin
      blnPrecisaTravar := True;
      break;
    End;
    qryOrdPro.Next;
  End;

  If blnPrecisaTravar then
    Result := fTravaComQuantidadeMaiorQueSaldoRestante;
end;

procedure TfrmManutencaoOrdProVidro.pPreencheProdutoAcabado;
var qryConsulta : TUniQuery;
    strIORPRO: String;
begin
  strIORPRO := fCfgSis('IORPRO', varString);
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT CONCAT(ITE_CODITE,"-", ITE_DESITE) AS ITEM, ' +
      'ITE_CODITE AS CODITE, ITE_DESITE AS DESITE, SUM(FDO_QTDITE) AS QTDITE, FDO_CODCLI AS CODCLI FROM FATDOR, CADITE ');

    qryConsulta.SQL.Add(' WHERE FDO_NUMDOC = "'+strNUMPED+'"');
    qryConsulta.SQL.Add('   AND FDO_ESPDOC = "PD"');
    qryConsulta.SQL.Add('   AND FDO_CODEMP = "'+VS_StrCodEmp+'"');
    qryConsulta.SQL.Add('   AND ITE_CODITE = "'+ strIORPRO+ '"');
    qryConsulta.SQL.Add('   GROUP BY ITE_CODITE');

    qryConsulta.Open;
    ItensFatdor:= TItensFatdor.Create;
    ItensFatdor.ItemCodite := qryConsulta.FieldByName('CODITE').AsString;
    ItensFatdor.ItemDescricao := qryConsulta.FieldByName('DESITE').AsString;
    ItensFatdor.ItemQuantidade := qryConsulta.FieldByName('QTDITE').AsFloat;
    ItensFatdor.strCodCli := qryConsulta.FieldByName('CODCLI').AsString;

  finally
    freeAndNil(qryConsulta);
  End;

end;


procedure TfrmManutencaoOrdProVidro.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If Not btnExcluir.Enabled then
   Exit;
  If qryOrdPro.FieldByName('AUTINC').AsString  <> '' Then
  Begin
    pMensagemOk('Itens adicionados pela importação de arquivo não podem ser deletados!');
    Exit;
  End
  Else
  If fPergunta('Excluir o item ' + qryOrdPro.FieldByName('CODITE').AsString) Then
    qryOrdPro.Delete;

end;

procedure TfrmManutencaoOrdProVidro.btnIncluirItemClick(Sender: TObject);
begin
  inherited;
  If Not btnIncluirItem.Enabled then
    Exit;

  pCriarFormularios(TfrmBaixaOrdProdAcabadoIncluiItens, frmBaixaOrdProdAcabadoIncluiItens);
  Try
    frmBaixaOrdProdAcabadoIncluiItens.cdsItens := qryOrdPro;
    frmBaixaOrdProdAcabadoIncluiItens.strSeqGer := strSeqGer;
    frmBaixaOrdProdAcabadoIncluiItens.blnManutencao := True;
    frmBaixaOrdProdAcabadoIncluiItens.ShowModal;
  Finally
    FreeAndNil(frmBaixaOrdProdAcabadoIncluiItens);
  End;

end;

procedure TfrmManutencaoOrdProVidro.cxgDadosKeyPress(Sender: TObject;
  var Key: Char);
  var qryConsulta: TUniQuery;
      arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    qryConsulta := fCriaQuery;
    Try

      If cxgDadosCOD_RECEBEDOR.Focused then
      Begin
        If fPesqOperador(Self, nil, nil, qryConsulta, Key, arrSel) then
        begin
          qryOrdPro.Edit;
          qryOrdPro.FieldByName('COD_RECEBEDOR').ASString := qryConsulta.FieldByName('OPE_CODOPE').AsString;
          qryOrdPro.Post;
        End;
      End;
    Finally
      FreeAndNil(qryConsulta);

    End
  End;
end;

procedure TfrmManutencaoOrdProVidro.edtDocumentoKeyPress(Sender: TObject;  var Key: Char);
  Var
  qryPedido : TUniQuery;
  arrDoc : TConsultasArray;
begin
  inherited;
  qryPedido := fCriaQuery(Self);
  If fPesqPedOrc(conPedOrdPro, Self, edtEspecie.Text, edtEspecie.Text, VS_strCodEmp, edtDocumento, edtEspecie, Nil, qryPedido, Key, arrDoc) Then
  Begin
    If fValidaCampos(edtDocumento, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  FreeAndNil(qryPedido);
end;

procedure TfrmManutencaoOrdProVidro.FormCreate(Sender: TObject);
begin
  inherited;
  rdgDocVendaOuPedVenda.ItemIndex := 0;
  strSeqGer := '';
  strProjeto := '';
  qryOrdPro := TZClient.Create(Self, '');
  qryCommand := fCriaQuery;
  strNUMPED := '';
  strESPPED := '';
  strEMPPED := '';
  strOrdPro := '';
  pHabilitaAltCampos(False);
  lblBaixada.Visible := False;
  btnIncluirItem.Visible := fVerificaAcessoSistema('AIEOPV', strLoginUsuarioLogado);
  btnExcluir.Visible := btnIncluirItem.Visible;
  stlListOperadores := TStringList.Create;
  stlListOperadores.Sorted := True;
  stlListOperadores.Duplicates := dupIgnore;

  stlListOperadoresLiberados := TStringList.Create;
  stlListOperadoresLiberados.Sorted := True;
  stlListOperadoresLiberados.Duplicates := dupIgnore;
  qryOrdPro.AfterScroll := OnAfterScroll;
  qryOrdBai := fCriaQuery;
end;

procedure TfrmManutencaoOrdProVidro.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryOrdBai);
  FreeAndNil(stlListOperadoresLiberados);
  FreeAndNil(stlListOperadores);
  FreeAndNil(qryCommand);
  FreeAndNil(qryOrdPro);
end;

procedure TfrmManutencaoOrdProVidro.pLocalizaOrdemDeProducao(var strErro: String);
begin
  strErro := '';
  strNUMPED := '';
  strESPPED := '';
  strEMPPED := '';
  strOrdPro := '';
  qryOrdPro.qryQuery.SQL.Clear;
  If (rdgDocVendaOuPedVenda.ItemIndex = 0) then
    pMontaSQLLocalizaFatDor
  Else
    pMontaSQLLocalizaVenda;

  strErro := '';
  If qryOrdPro.IsEmpty Then
    strErro := 'Não foi encontrado ordem de produção vinculada a este pedido!'
  Else If qryOrdPro.FieldByName('PRO_IMPDEF').AsString = 'N' Then
    strErro := 'A ordem de produção não foi feito a importação definitiva!';

  If strErro <> '' Then
    qryOrdPro.Close
  Else
  Begin
    strSeqGer    := qryOrdPro.FieldByName('SEQGER').AsString;
    strProjeto   := qryOrdPro.FieldByName('PRO_PROJEC').AsString;
    strNUMPED    := qryOrdPro.FieldByName('NUMPED').AsString;
    strESPPED    := qryOrdPro.FieldByName('ESPPED').AsString;
    strEMPPED    := qryOrdPro.FieldByName('EMPPED').AsString;
    strOrdPro    := qryOrdPro.FieldByName('PRO_CODPRO').AsString;
    blnOpBaixada := qryOrdPro.FieldByName('BAIXADO').AsString = 'S';

    pCarregaOperadoresBaixa;
  End;

end;

procedure TfrmManutencaoOrdProVidro.pCarregaOperadoresBaixa;
begin
  qryOrdBai.SQL.Clear;
  qryOrdBai.SQL.Add('SELECT CONCAT(OPE_CODOPE, " - " , OPE_NOMOPE) AS OPERADOR,');
  qryOrdBai.SQL.Add('       SUM(LOGVID.LOG_QTDREC) AS QTD,');
  qryOrdBai.SQL.Add('       LOG_CODITE,');
  qryOrdBai.SQL.Add('       DATE(LOG_DTACAD) AS DTABAI');
  qryOrdBai.SQL.Add('  FROM LOGVID');
  qryOrdBai.SQL.Add(' INNER JOIN CADOPE ON OPE_CODOPE = LOG_CODREC');
  qryOrdBai.SQL.Add(' WHERE LOG_ORDORI = "'+strOrdPro+'"');
  qryOrdBai.SQL.Add('   AND LOG_CODEMP = "'+strEMPPED+'"');
  qryOrdBai.SQL.Add(' GROUP BY LOG_CODITE, LOG_CODREC, DATE(LOG_DTACAD)');
  qryOrdBai.Open;
  dtsBaixa.DataSet := qryOrdBai;
end;

procedure TfrmManutencaoOrdProVidro.pMontaSQLCampos;
begin
  qryOrdPro.qryQuery.SQL.Add('       MOVPRO.PRO_CODPRO,');
  qryOrdPro.qryQuery.SQL.Add('       MOVPRO.PRO_IMPDEF,');
  qryOrdPro.qryQuery.SQL.Add('       MOVPRO.PRO_PROJEC,');
  qryOrdPro.qryQuery.SQL.Add('       D.AUTOINCREM AS AUTINC,');
  qryOrdPro.qryQuery.SQL.Add('       D.DOP_SEQGER AS SEQGER,');
  qryOrdPro.qryQuery.SQL.Add('       IF(IFNULL(MOVPRO.PRO_DTABAI, "N") = "N", "N", "S") AS BAIXADO,');
  qryOrdPro.qryQuery.SQL.Add('       DOP_ITESUB AS CODITE,');
  qryOrdPro.qryQuery.SQL.Add('       ITE_DESITE AS DESITE,');
  qryOrdPro.qryQuery.SQL.Add('       UNI_SIGUNI AS SIGUNI,');
  qryOrdPro.qryQuery.SQL.Add('       DOP_QTDITE AS QTDITE,');
  qryOrdPro.qryQuery.SQL.Add('       IFNULL(DOP_QTDBAI, 0) AS TOTBAI,');
  qryOrdPro.qryQuery.SQL.Add('       IFNULL(DOP_QTDARQ,0) - IFNULL(DOP_QTDBAI, 0) AS QTDRES, ');
  qryOrdPro.qryQuery.SQL.Add('       0.0000 AS QTDBAI,');
  qryOrdPro.qryQuery.SQL.Add('       DOP_QTDARQ AS QTDARQ,');
  qryOrdPro.qryQuery.SQL.Add('       PRO_NUMPED AS NUMPED,');
  qryOrdPro.qryQuery.SQL.Add('       PRO_ESPPED AS ESPPED,');
  qryOrdPro.qryQuery.SQL.Add('       PRO_EMPPED AS EMPPED,');
  qryOrdPro.qryQuery.SQL.Add('       ITE_REFERE AS REFERE,');
  qryOrdPro.qryQuery.SQL.Add('       ITE_PREMED AS PREMED,');
  qryOrdPro.qryQuery.SQL.Add('       ITE_PRECUS AS PRECUS,');
  qryOrdPro.qryQuery.SQL.Add('       CAST("" AS CHAR(3))AS COD_RECEBEDOR,');
  qryOrdPro.qryQuery.SQL.Add('       CAST("" AS CHAR(30))AS NOM_RECEBEDOR,');
  qryOrdPro.qryQuery.SQL.Add('       CAST("N" AS CHAR(1))AS ITEMNOVO');

End;

procedure TfrmManutencaoOrdProVidro.pMontaSQLLocalizaFatDor;
begin
  qryOrdPro.qryQuery.SQL.Add('SELECT ');
  pMontaSQLCampos;
  qryOrdPro.qryQuery.SQL.Add('  FROM DETPRO D');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN MOVPRO ON MOVPRO.AUTOINCREM = DOP_SEQGER');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = DOP_ITESUB');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = DOP_ITESUB AND G.ITE_CODEMP = PRO_EMPPED');
  qryOrdPro.qryQuery.SQL.Add('  LEFT JOIN CADUNI ON  CADUNI.UNI_CODUNI = ITE_CODUNI');
  qryOrdPro.qryQuery.SQL.Add(' WHERE PRO_NUMPED = "'+edtDocumento.Text+'"');
  qryOrdPro.qryQuery.SQL.Add('   AND PRO_ESPPED = "PD"');
  qryOrdPro.qryQuery.SQL.Add('   AND PRO_EMPPED = "' + edtCodEmp.Text + '"');
  qryOrdPro.qryQuery.SQL.Add('   AND PRO_PRINCI = "S"');
  qryOrdPro.fAbreClient(True, 'TfrmManutencaoOrdProVidro.pMontaSQLLocalizaFatDor');
end;

procedure TfrmManutencaoOrdProVidro.pMontaSQLLocalizaVenda;
begin
  qryOrdPro.qryQuery.SQL.Add('SELECT ');
  pMontaSQLCampos;
  qryOrdPro.qryQuery.SQL.Add('  FROM FATGOR');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN MOVPRO ON PRO_NUMPED = FGO_NUMDOC AND PRO_ESPPED = FGO_ESPDOC AND PRO_EMPPED = FGO_CODEMP');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN DETPRO D ON DOP_SEQGER = MOVPRO.AUTOINCREM');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = DOP_ITESUB');
  qryOrdPro.qryQuery.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = DOP_ITESUB AND G.ITE_CODEMP = PRO_EMPPED');
  qryOrdPro.qryQuery.SQL.Add('  LEFT JOIN CADUNI ON  CADUNI.UNI_CODUNI = ITE_CODUNI');
  qryOrdPro.qryQuery.SQL.Add(' WHERE FGO_TIPFAT = "'+edtEspecie.Text+'"');
  qryOrdPro.qryQuery.SQL.Add('   AND FGO_NUMFAT = "'+edtDocumento.Text+'"');
  qryOrdPro.qryQuery.SQL.Add('   AND FGO_EMPFAT = "'+edtCodEmp.Text+'"');
  qryOrdPro.qryQuery.SQL.Add('   AND PRO_PRINCI = "S"');
  qryOrdPro.fAbreClient(True, 'TfrmManutencaoOrdProVidro.pMontaSQLLocalizaVenda');

end;

procedure TfrmManutencaoOrdProVidro.rdgDocVendaOuPedVendaClick(Sender: TObject);
var blnPedidoVenda: Boolean;
begin
  inherited;
  blnPedidoVenda := rdgDocVendaOuPedVenda.ItemIndex = 0;
  edtSerie.Visible := Not blnPedidoVenda;
  lblSerie.Visible := Not blnPedidoVenda;
  edtCodEmp.Text := VS_StrCodEmp;
  edtDocumento.Clear;

  If blnPedidoVenda Then
  Begin
    edtEspecie.Text := 'PD';
    btnCarregar.Left := edtSerie.Left;
  End
  Else
  Begin
    edtEspecie.Text := 'NF';
    btnCarregar.Left := 352;
  End;
end;

procedure TfrmManutencaoOrdProVidro.OnAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  qryOrdBai.Filtered := False;
  qryOrdBai.Filter := 'LOG_CODITE= ' + QuotedSTr(DataSet.FieldByName('CODITE').AsString);
  qryOrdBai.Filtered := True;

end;

end.
