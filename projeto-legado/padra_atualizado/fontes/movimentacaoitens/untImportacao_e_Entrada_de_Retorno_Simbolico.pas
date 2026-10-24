unit untImportacao_e_Entrada_de_Retorno_Simbolico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untFrameDirectoryEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untZClient, untEntImportacaoNotaEletronica, untTypesSistema,
  Datasnap.DBClient, cxCheckBox, cxButtonEdit, ShellAPI, UniClientDataSet,
  cxContainer, cxProgressBar, MemDS, DBAccess, Uni, Vcl.Mask, MaskEditFocus;

type
  TfrmImportacao_e_Entrada_de_Retorno_Simbolico = class(TfrmPai)
    Panel1: TPanel;
    fraPathXml: TfraDirectoryEditFocus;
    dtsArquivos: TDataSource;
    Label1: TLabel;
    Memo1: TMemo;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column5: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column6: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column7: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column8: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column9: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    btnMarcarTodos: TSpeedButton;
    btnDesmarcarTodos: TSpeedButton;
    btnRealizarEntrada: TSpeedButton;
    UniQuery1: TUniQuery;
    Label12: TLabel;
    Label13: TLabel;
    mskDtaEntIni: TMaskEditFocus;
    mskDtaEntFin: TMaskEditFocus;
    cxgProgresso_bw2: TcxProgressBar;
    btnImportaXML: TBitBtnLocked;
    btnCarregaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnImportaXMLClick(Sender: TObject);
    procedure cdsXMLAfterScroll(DataSet: TDataSet);
    procedure cxGridCitel1DBTableViewCitel1Column2PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure pTrataDiretorio(strDir: String);
    procedure cdsXMLAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnRealizarEntradaClick(Sender: TObject);
    procedure btnCarregaDadosClick(Sender: TObject);
  private
    cdsXML : TZclient;
    procedure pMarcaDesMarca(blnMarca: Boolean);
    procedure pInitEntradas();
    function fProcessaEntradas(prgProgresso: TcxProgressBar): Boolean;
    function fProcessaEntrada(): Boolean;
    procedure pAbrirConsulta(blnApenasImportacao: Boolean = False);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;




    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportacao_e_Entrada_de_Retorno_Simbolico: TfrmImportacao_e_Entrada_de_Retorno_Simbolico;

implementation

uses
  untFuncoesSimples, untGravando, untEntradaAutomatizada, untFuncoes,
  untEntMercadorias, untConsultas;

{$R *.dfm}

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesMarca(False);
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.btnImportaXMLClick(
  Sender: TObject);
begin
  inherited;


  If fEmptyStr(fraPathXml.edtDirectory.Text) Then
  Begin
    pMensagemOk('O Caminho do XML deve ser definido!');
    pSetFocus(fraPathXml.edtDirectory);
    Exit;
  End;
  If not Assigned(cdsXML) Then
    pAbrirConsulta(True);
  cdsXML.AfterPost := Nil;
  cdsXML.AfterScroll := nil;
  Try
    cdsXML.DisableControls;
    TfrmEntImportacaoNotaEletronica.fImportar(xmlRetornoSimbolico, '', False, fraPathXml.edtDirectory.Text, cdsXML, cxgProgresso_bw2);
  Finally
    cdsXML.EnableControls;
    cdsXML.AfterPost := cdsXMLAfterPost;
    cdsXML.AfterScroll := cdsXMLAfterScroll;
    cdsXML.First;
  End;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.cdsXMLAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Memo1.Visible := Not(fEmptyStr(cdsXML.FieldByName('ERRO_STATUS_XML').AsString));
  Memo1.Text := cdsXML.FieldByName('ERRO_STATUS_XML').AsString;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.btnMarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesMarca(True);

end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.btnRealizarEntradaClick(
  Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  cdsXML.Next;
  cdsXML.prior;
  cdsXML.AfterPost := Nil;

  Try
    cdsXML.Filtered := False;
    cdsXML.Filter := 'MARCADO = 1';
    cdsXML.Filtered := True;
    pInitEntradas;
  Finally
    cdsXML.Filtered := False;
    cdsXML.EnableControls;
  End;
  cdsXML.DisableControls;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.btnCarregaDadosClick(
  Sender: TObject);
begin
  inherited;
  pAbrirConsulta
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.pAbrirConsulta(blnApenasImportacao: Boolean = False);
begin
  dtsArquivos.DataSet := nil;

  If Assigned(cdsXML) Then
    FreeAndNil(cdsXML);

  cdsXML := TZClient.Create(nil);
  cdsXML.qryQuery.SQL.Add('SELECT 0 AS MARCADO,');
  cdsXML.qryQuery.SQL.Add('       GERELE.AUTOINCREM,');
  cdsXML.qryQuery.SQL.Add('       GERELE.GER_CODEMP,');
  cdsXML.qryQuery.SQL.Add('       B2W_ARQNAM AS ARQUIVO,');
  cdsXML.qryQuery.SQL.Add('       PR07_CHNFE AS CHAVE,');
  cdsXML.qryQuery.SQL.Add('       B09_DEMI AS DTAEMI,');
  cdsXML.qryQuery.SQL.Add('       B08_NNF  AS NUMDOC,');
  cdsXML.qryQuery.SQL.Add('       CAST(CONCAT(FOR_CODFOR, " - ",FOR_NOMFOR) AS CHAR(100)) AS FORNEC,');
  cdsXML.qryQuery.SQL.Add('       W16_VNF               AS VALDOC,');
  cdsXML.qryQuery.SQL.Add('       CAST(IF(IFNULL(B2W_SEQGER, "") = "", "", "XML Importado Com Sucesso!") AS CHAR(100)) AS STATUS_XML,  ');
  cdsXML.qryQuery.SQL.Add('       CAST("" AS CHAR(100))                   AS ERRO_STATUS_XML, ');
  cdsXML.qryQuery.SQL.Add('      CAST(IF(IFNULL(B2W_SEQGER, "") <> "" AND IFNULL(GER_DOCENT, "") = "" AND CADFIS.FIS_NUMDOC IS NOT NULL, "Entrada realizada manualmente", ');
  cdsXML.qryQuery.SQL.Add('      IF(IFNULL(B2W_SEQGER, "") <> "" AND IFNULL(GER_DOCENT, "") = "", "Aguardando confirmação da entrada",');
  cdsXML.qryQuery.SQL.Add('      IF(IFNULL(B2W_SEQGER, "") <> "" AND IFNULL(GER_DOCENT, "") <> "", "Entrada realizada", ""))) AS CHAR(100))  STATUS_ENT,');

  cdsXML.qryQuery.SQL.Add('       B2W_ARQUIV,');
  cdsXML.qryQuery.SQL.Add('       0 AS NOVOREG');
  cdsXML.qryQuery.SQL.Add('  FROM GERELE');
  cdsXML.qryQuery.SQL.Add(' INNER JOIN CADFOR ON FOR_C_G_C_ = C02_CNPJ');
  cdsXML.qryQuery.SQL.Add(' LEFT JOIN CADFIS ON FIS_NUMDOC = B08_NNF');
  cdsXML.qryQuery.SQL.Add('               AND FIS_CODEMP = GER_CODEMP');
  cdsXML.qryQuery.SQL.Add('               AND FIS_FORCLI = FOR_CODFOR');
  cdsXML.qryQuery.SQL.Add('               AND FIS_ESPDOC = "NF"');
  cdsXML.qryQuery.SQL.Add('               AND FIS_SERIE_ = B07_SERIE');

  cdsXML.qryQuery.SQL.Add('  LEFT JOIN NFEB2W ON B2W_SEQGER = GERELE.AUTOINCREM');
  If blnApenasImportacao Then
    cdsXML.qryQuery.SQL.Add(' WHERE FALSE')
  Else
  Begin
    cdsXML.qryQuery.SQL.Add(' WHERE GERELE.GER_TIPXML = 6');
    If (Not fEmptyDate(mskDtaEntIni.Text)) And (not fEmptyDate(mskDtaEntFin.Text)) Then
      cdsXML.qryQuery.SQL.Add('   AND GERELE.GER_DTAIMP BETWEEN :DTAINI AND :DTAFIN')
    Else
      cdsXML.qryQuery.SQL.Add('   AND GERELE.GER_DTAIMP BETWEEN CURDATE() AND CURDATE() - 7');

    If (Not fEmptyDate(mskDtaEntIni.Text)) And (not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      cdsXML.qryQuery.ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
      cdsXML.qryQuery.ParamByName('DTAFIN').AsDate := strToDate(mskDtaEntFin.Text);
    End;
  End;

  cdsXML.fAbreClient(True,'[TfrmImportacao_e_Entrada_de_Retorno_SimbolicofrmPai.FormCreate]');


  dtsArquivos.DataSet := cdsXML;

  cdsXML.AfterScroll := cdsXMLAfterScroll;
  cdsXML.AfterPost := cdsXMLAfterPost;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.pInitEntradas();
var frmAguarde: TFrmGravando;
Begin
  pCriarFormularios(TfrmGravando, frmAguarde);
  frmAguarde.lblGravando.Caption := 'Carregando notas, aguarde...';
  frmAguarde.fExecutarAcao := fProcessaEntradas;
  frmAguarde.ShowModal;
End;

function TfrmImportacao_e_Entrada_de_Retorno_Simbolico.fProcessaEntradas(prgProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  prgProgresso.Properties.Max := cdsXML.RecordCount;
  While not cdsXML.Eof Do
  Begin
    If fProcessaEntrada Then
    Begin
     cdsXML.Edit;
     cdsXML.FieldByName('STATUS_ENT').AsString := 'Entrada realizada';
     cdsXML.Post;
    End;
    cdsXML.Next;
    prgProgresso.Position := cdsXML.RecNo;
    Application.ProcessMessages;
  End;
End;

function TfrmImportacao_e_Entrada_de_Retorno_Simbolico.fValidaCampos(
  Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    if (Sender = mskDtaEntIni) And (not fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntIni.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Inicial Inválida!');
        Result := False;
      End;
    End
    Else
    if (Sender = mskDtaEntFin) And (not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntFin.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Final Inválida!');
        Result := False;
      End;
      If Result Then
      Begin
        If StrToDateDef(mskDtaEntFin.Text, 0) < StrToDateDef(mskDtaEntIni.Text, 0) Then
        Begin
          pMensagemOk('A Data Final deve ser Maior ou Igual a Inicial!');
          Result := False;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmImportacao_e_Entrada_de_Retorno_Simbolico.fProcessaEntrada(): Boolean;
  var frmEntMer: TfrmEntMercadorias;
  qryEntMer: TUniQuery;
  recNotEle : TRecInfoNotaEletronica;
  fltValFre,
  fltDesAce: Double;
begin
  qryEntMer := fCriaQuery;
  Try
    fltValFre := 0;
    fltDesAce := 0;

    qryEntMer.SQL.Text := 'SELECT GERELE.*, ' + fSQLDescontoNotaXML + ' AS DESCONTO FROM GERELE WHERE GERELE.AUTOINCREM = "'+ cdsXML.FieldByName('AUTOINCREM').AsString +'"';
    qryEntMer.Open;

    pCarregaCabecalhoNota(qryEntMer, recNotEle);

    pCriarFormularios(TfrmEntMercadorias, frmEntMer);
    Try

      frmEntMer.recNotEle := recNotEle;
      frmEntMer.blnAutomatico := True;

      frmEntMer.blnDevolu := False;
      frmEntMer.blnPresencial := False;
      frmEntMer.blnConEqu := False;

      If Not fEmptyStr(recNotEle.strAutInc) Then
      Begin
        fltValFre := recNotEle.fltValFre;
        fltDesAce := 0;
      End;

      frmEntMer.blnSemInc      := False;
      frmEntMer.fltValFre      := fltValFre;
      frmEntMer.fltDesAce      := fltDesAce;

      frmEntMer.pshow;
      frmEntMer.btnConfirma.Click;
      Result := frmEntMer.blnConfirma;



    Finally
      pFreeAndNil(frmEntMer);
    End

  Finally
    FreeAndNil(qryEntMer);
  End;
end;


procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.pMarcaDesMarca(blnMarca: Boolean);
Begin
  cdsXML.First;
  cdsXML.DisableControls;
  Try
    While Not cdsXML.Eof Do
    begin
      cdsXML.Edit;
      cdsXML.FieldByName('MARCADO').AsInteger := IIF(blnMarca, 1, 0);
      cdsXML.Post;
      cdsXML.Next;
    End;
  Finally
    cdsXML.EnableControls;
  End;
End;





procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.cdsXMLAfterPost(DataSet: TDataSet);
begin
  inherited;
  If cdsXML.FieldByName('MARCADO').AsInteger = 1 Then
    If cdsXML.FieldByName('STATUS_ENT').AsString <> 'Aguardando confirmação da entrada' Then
    Begin
      cdsXML.Edit;
      cdsXML.FieldByName('MARCADO').AsInteger := 0;
      cdsXML.Post;
    End;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.cxGridCitel1DBTableViewCitel1Column2PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var strFile: String;
begin
  inherited;
  strFile := fraPathXml.edtDirectory.Text;
  If Not (strFile[Length(strFile)] = '\') Then
    strFile := strFile +'\';
  If cdsXML.qryQuery.FieldByName('B2W_ARQUIV').AsString <> '' Then
  begin
    strFile := strFile + 'Visualidos\';
    pTrataDiretorio(strFile);
    strFile := strFile + cdsXML.FieldByName('ARQUIVO').AsString;
    DeleteFile(strFile);
    (cdsXML.FieldByName('B2W_ARQUIV') as TBlobField).SaveToFile(strFile);
  End
  Else
    strFile := strFile + cdsXML.FieldByName('ARQUIVO').AsString;

  ShellExecute(Application.Handle, 'open', PChar(strFile), '', '', SW_SHOW);

end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.FormCreate(
  Sender: TObject);
begin
  inherited;
  fraPathXml.edtDirectory.Text := fCfgSisL('PATB2W');
  mskDtaEntIni.Text := DateToStr(fNow - 7);
  mskDtaEntFin.Text := DateToStr(fNow);
//  pAbrirConsulta;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5 : btnMarcarTodos.Click;
    VK_F6 : btnDesmarcarTodos.Click;
    VK_F10: btnRealizarEntrada.Click;
  End;
end;

procedure TfrmImportacao_e_Entrada_de_Retorno_Simbolico.pTrataDiretorio(
  strDir: String);
begin
  if Not DirectoryExists(strDir) then
    CreateDir(strDir);
end;

end.
