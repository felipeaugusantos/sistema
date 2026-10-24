unit untFatBaixaRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, EditFocus, UniDataSetProvider, DB, UniClientDataSet,
  untAtualizaOcorrenciasCRM, Uni, Mask, DBCtrls, DBEditFocus, MaskEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, untFuncFatImp, untFuncFatTypes, StrUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, cxImageComboBox,
  System.ImageList, Vcl.ImgList,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untRomaneioTarefasFusion;

type
  TDataHora = (opcData, opcHora, opcGeral);

type
  TDataHoraBaixa = (opcAutomatica, opcDocumento, opcFinal);

type
  TfrmFatBaixaRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    edtNomMot: TEditFocus;
    lblMotorista: TLabel;
    dtsDocumentos: TDataSource;
    cdsDocumentos: TUniClientDataSet;
    dspDocumentos: TUniDataSetProvider;
    qryDocumentos: TUniQuery;
    btnConfirma: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnObservacoes: TBitBtnLocked;
    btnMarcarTudo: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    edtCodMot: TEditFocus;
    pnlRecPor: TPanel;
    Label1: TLabel;
    edtNomRec: TEditFocus;
    btnRemoverItem: TBitBtnLocked;
    qryItens: TUniQuery;
    dspItens: TUniDataSetProvider;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    pnlDtaBai: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaBai: TMaskEditFocus;
    mskHorBai: TMaskEditFocus;
    lblRecPor: TLabel;
    cxgDocumentosLevel: TcxGridLevel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosGER_ROMIMP: TcxGridDBColumn;
    cxgDocumentosGER_DTAROM: TcxGridDBColumn;
    cxgDocumentosGER_HORROM: TcxGridDBColumn;
    cxgDocumentosGER_DTAENT: TcxGridDBColumn;
    cxgDocumentosGER_NUMDOC: TcxGridDBColumn;
    cxgDocumentosGER_CODEMP: TcxGridDBColumn;
    cxgDocumentosGER_NOMCLI: TcxGridDBColumn;
    cxgDocumentosCID_NOMCID: TcxGridDBColumn;
    cxgDocumentosGER_CODVEN: TcxGridDBColumn;
    cxgDocumentosTRA_NOMTRA: TcxGridDBColumn;
    cxgDocumentosGER_VLRCON: TcxGridDBColumn;
    cxgDocumentosGER_DTABAI: TcxGridDBColumn;
    cxgDocumentosGER_HORBAI: TcxGridDBColumn;
    cxgDocumentosGER_NOMREC: TcxGridDBColumn;
    cxgDocumentosGER_MARDES: TcxGridDBColumn;
    imgLista: TImageList;
    cxgDocumentosDESTACAR: TcxGridDBColumn;
    lblRecebidoPorObrig: TLabel;
    Label4: TLabel;
    edtKMInicial: TEditFocus;
    Label5: TLabel;
    edtKMFinal: TEditFocus;
    cxgDocumentosGER_KMINI: TcxGridDBColumn;
    cxgDocumentosGER_KMFIM: TcxGridDBColumn;
    pnlAjudantes: TPanel;
    lbl1: TLabel;
    edtNomAj1: TEditFocus;
    edtNomAj2: TEditFocus;
    edtNomAj4: TEditFocus;
    edtNomAj3: TEditFocus;
    pnlEntPen: TPanel;
    Label8: TLabel;
    chkEntPen: TCheckBox;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure btnRemoverClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnMarcarTudoClick(Sender: TObject);
    procedure btnObservacoesClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtNomRecExit(Sender: TObject);
    procedure edtNomRecEnter(Sender: TObject);
    procedure cxgDocumentosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure cxgDocumentosTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNumRomKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    FDtaHorBai: TDataHoraBaixa;
    objOcoCrm: TAtuOcoCrm;
    strTipRom: String;
    blnFocaData, blnRecebidoPorObrig: Boolean;

    dtaUltDtaBai: TDatetime;
    horUltHorBai: TDatetime;
    strUltRecPor: String;
    strUltCodCli: String;

    objRomFusTarefas: TRomaneioTarefasFusion;

    procedure pAfterScroll(DataSet: TDataSet);

    procedure pCarregaDocumentos;
    procedure pCarregaDocumentosMotorista;
    Function fDigitaObservacao(strObsAtu: String; blnObrigatorio: Boolean): Boolean;
    procedure pCancelarBaixa;
    procedure pCarregaCadMot;
    procedure pCarregaCadEmp;
    procedure pCarregaItens(strNumRom: String);
    procedure pLimpaDataHora;
    function  fGravaDataGeral(opcDtaHor: TDataHora; dtaDatBai: TDate; timHorBai: TTime): Boolean;
    function  fTodasDataHoraDigitada: Boolean;
    function  fGetMaiorDataRomaneio(blnDelAftScroll: Boolean = True): TDate;
    function  fGetMaiorHoraRomaneio: TTime;

    function fGerarNovoPreRomaneio(Var strRomNov: String; strNumRom,
      strEmpRom, strNumDoc, strEspDoc,  strCodEmp: String): Boolean;

    function fRemoveuTodosOsItens(cdsItens: TUniClientDataSet): Boolean;
    function fPodeRemoverDocumento: Boolean;
    procedure pMarcaDocumentoRemocao;
    procedure pVoltaQuantidadeEntrega(strAutoIncrem: String);
    procedure pZeraQuantidadeEntrega(strAutoIncrem: String);

    function fHaDocumentosSemInformarRecebidoPor: Boolean;

    function fConfirmaBaixa: Boolean;

    procedure pImprimeSeparacao(strNumRomNov, strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
    procedure pLimpaCamposDaBaixa;
    procedure pRetornaDataHoraOriginal;
    procedure pChkEntPenClick(Sender: TObject);
    function fMarcouEntregaPendente: Boolean;
    function fRetEmpresa: String;
    function fDeveGerarNovoPreRomaneioNaBaixa(Const strCodEmp: String = ''): Boolean;
    function fValidaRomaneio: Boolean;

    function fRomaneioComEntregaIniciada(strNumRom: String): Boolean;
  protected
    function fGetMaiorData(cdsClone: TUniClientDataSet; blnDelAftScroll: Boolean = True): TDate;
    function fGetMaiorHora(cdsClone: TUniClientDataSet): TTime;
    procedure pCarregaDataHoraSugestao;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmFatBaixaRomaneio: TfrmFatBaixaRomaneio;

implementation

uses untFuncoesSimples, untFatBaixaRomaneioObs, untHisPed, untConsultas,
     untRomGer, untFuncoesCRM, untFatItensBaixaRomaneio, untDigDataHora,
     System.UITypes, untTypesSistema, untFuncoes, untTSituacaoPedidoVenda,
     untTypesCRM, untLiberacao, untTRomaneioRepository;

{$R *.dfm}

{ TfrmFatBaixaRomaneio }

function TfrmFatBaixaRomaneio.fPodeRemoverDocumento: Boolean;
  Var
    strMensagem : String;
begin
  Result := True;

  If (TRomaneioRepository.fRomaneioVinculadoComDespesa(cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                                       Copy(cdsDocumentos.FieldByName('GER_NUMDOC').AsString, 1,
                                                       Pos('-', cdsDocumentos.FieldByName('GER_NUMDOC').AsString)-1),
                                                       cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                                       strMensagem)) Then
  Begin
    fMensagem('ATENÇÃO!', strMensagem, ['&Ok']);
    Result := False;
  End
  Else If (Not fDigitaObservacao(cdsDocumentos.FieldByName('GER_OBSERV').AsString, True)) Then
  Begin
    Result := False;
  End;

end;

procedure TfrmFatBaixaRomaneio.pMarcaDocumentoRemocao;
begin
  cdsDocumentos.Edit;
  cdsDocumentos.FieldByName('GER_MARDES').AsString := 'D';
  cdsDocumentos.FieldByName('GER_NOMREC').Clear;
  cdsDocumentos.FieldByName('GER_DTABAI').Clear;
  cdsDocumentos.FieldByName('GER_HORBAI').Clear;
  cdsDocumentos.FieldByName('GER_KMINI').Clear;
  cdsDocumentos.FieldByName('GER_KMFIM').Clear;
  cdsDocumentos.Post;

  pZeraQuantidadeEntrega(cdsDocumentos.FieldByName('AUTOINCREM').AsString);

  edtNomRec.Clear;
  edtKMInicial.Clear;
  edtKMFinal.Clear;
  pLimpaDataHora;
  edtNomRec.Enabled := False;
  pnlDtaBai.Enabled := False;
end;

procedure TfrmFatBaixaRomaneio.pRetornaDataHoraOriginal;
begin
  if (not Assigned(cdsDocumentos)) then
    exit;

  if (not cdsDocumentos.Active) then
    exit;

  if (cdsDocumentos.RecNo <= 0) then
    exit;

  cdsDocumentos.Edit;
  cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime := dtaUltDtaBai;
  cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime := horUltHorBai;
  cdsDocumentos.FieldByName('ENTPEN').AsString := 'N';

  if (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') and
     (cdsDocumentos.FieldByName('GER_NOMREC').AsString = EmptyStr) then
  begin
    cdsDocumentos.FieldByName('DESTACAR').AsString := 'S';
  end;

  blnRecebidoPorObrig := ((fCfgSis('RPBXRM', varBoolean)) and (cdsDocumentos.FieldByName('ENTPEN').AsString = 'N'));

  cdsDocumentos.Post;

end;

procedure TfrmFatBaixaRomaneio.pVoltaQuantidadeEntrega(strAutoIncrem: String);
  Var
    blnFilter: Boolean;
    strFilter: String;
begin
  strFilter := cdsItens.Filter;
  blnFilter := cdsItens.Filtered;

  cdsItens.Filtered := False;
  cdsItens.Filter   := 'DET_SEQGER = ' + QuotedStr(strAutoIncrem);
  cdsItens.Filtered := True;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('DET_QTDBAI').AsFloat := cdsItens.FieldByName('DET_QTDITE').AsFloat;
      cdsItens.Post;

      cdsItens.Next;
    End;
  Finally
    cdsItens.Filter   := strFilter;
    cdsItens.Filtered := blnFilter;
  End;
end;

procedure TfrmFatBaixaRomaneio.pZeraQuantidadeEntrega(strAutoIncrem: String);
  Var
    blnFilter: Boolean;
    strFilter: String;
begin
  strFilter := cdsItens.Filter;
  blnFilter := cdsItens.Filtered;

  cdsItens.Filtered := False;
  cdsItens.Filter   := 'DET_SEQGER = ' + QuotedStr(strAutoIncrem);
  cdsItens.Filtered := True;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('DET_QTDBAI').AsFloat := 0;
      cdsItens.Post;

      cdsItens.Next;
    End;
  Finally
    cdsItens.Filter   := strFilter;
    cdsItens.Filtered := blnFilter;
  End;
end;

function TfrmFatBaixaRomaneio.fRemoveuTodosOsItens(cdsItens: TUniClientDataSet): Boolean;
begin
  Result := True;

  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If (cdsItens.FieldByName('DET_QTDBAI').AsFloat > 0) Then
    Begin
      Result := False;
      Break;
    End;

    cdsItens.Next;
  End;
end;

function TfrmFatBaixaRomaneio.fRetEmpresa: String;
begin
  If edtCodEmp.Visible Then
    Result := edtCodEmp.Text
  Else
    Result := VS_strCodEmp;
end;

function TfrmFatBaixaRomaneio.fRomaneioComEntregaIniciada(strNumRom: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  try
    qryAux.SQL.Add('SELECT COUNT(1) QTDE ');
    qryAux.SQL.Add('FROM ROMGERX ');
    qryAux.SQL.Add('WHERE GER_NUMROM = :NUMROM ');
    qryAux.SQL.Add('  AND GER_EMPROM = :EMPROM ');
    qryAux.SQL.Add('  AND GER_DTAINI IS NOT NULL ');
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryAux.Open;

    Result := (qryAux.FieldByName('QTDE').AsInteger > 0);
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmFatBaixaRomaneio.fTodasDataHoraDigitada: Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;
  blnFocaData := False;

  If (cdsDocumentos.IsEmpty) Then
    Exit;

  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, cdsDocumentos);
  
  With cdsDocumentos Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      If (FieldByName('ENTPEN').AsString ='S') Then
      Begin
        Next;
        Continue;
      End;

      If ((FieldByName('GER_DTABAI').AsDateTime = 0 ) Or
          (FieldByName('GER_HORBAI').AsDateTime = 0 )) And (FieldByName('GER_MARDES').AsString  = 'M') Then
      Begin
        fMensagem('ATENÇÃO!', 'Há documentos sem data/hora da baixa!', ['&O k']);
        Result := False;
        Break;
      End
      Else If (FieldByName('GER_MARDES').AsString  = 'M') And
              (FieldByName('GER_DTABAI').AsDateTime < IIF(strTipRom = '1', FieldByName('GER_DTAROM').AsDateTime, fGetMaiorData(cdsClone))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Há documentos com a data da baixa menor que data do romaneio!', ['&O k']);
        blnFocaData := True;
        Result := False;
        Break;
      End
      Else If (FieldByName('GER_MARDES').AsString  = 'M') And
              (FieldByName('GER_DTABAI').AsDateTime = IIF(strTipRom = '1', FieldByName('GER_DTAROM').AsDateTime, fGetMaiorData(cdsClone))) And
              (FieldByName('GER_HORBAI').AsDateTime < IIF(strTipRom = '1', FieldByName('GER_HORROM').AsDateTime, fGetMaiorHora(cdsClone))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Há documentos com a hora da baixa menor que hora do romaneio!', ['&O k']);
        blnFocaData := False;
        Result := False;
        Break;
      End;

      Next;
    End;

    EnableControls;
  End;

  FreeAndNil(cdsClone);
end;

function TfrmFatBaixaRomaneio.fValidaRomaneio: Boolean;
begin
  Result := False;

  If (Not fRomaneioExiste(edtNumRom.Text, fRetEmpresa)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse romaneio não existe!', ['&Ok']);
    Exit;
  End;

  If (fRomaneioBaixado(edtNumRom.Text, torBaixaRomaneio, fRetEmpresa)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse romaneio já está baixado!', ['&Ok']);
    Exit;
  End;

  If (fRomaneioComEntregaIniciada(edtNumRom.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido baixar o romaneio pois o motorista já iniciou uma entrega ' +
                          'pelo APP Tá Entregue. Entre em contato com o motorista para verificar a situação da entrega. ' + #13 +
                          'Se for o caso, peça para o motorista baixar o documento como não entregue através do APP e libere ' +
                          'o documento pelo painel de entrega.', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

function TfrmFatBaixaRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumRom) And (fCfgSis('TIPROM') = '1') Then
  Begin
    If (Not edtCodEmp.Visible) Then
    Begin
      If (Not fValidaRomaneio) Then
        Result := False
      Else If blnBuscaPorChave Then
        pCarregaDocumentos;
    End;
  End;

  If (Sender = edtCodMot) And (fCfgSis('TIPROM') = '2') Then
  Begin
    If (Not fValidaCampos(edtCodEmp)) Then
    Begin
      Result := False;
      blnMudarFoco := False;
    End
    Else If fEmptyStr(edtCodMot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Motorista deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCadMot;
      If fEmptyStr(edtNomMot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
        pCarregaDocumentosMotorista;
    End;
  End;

  If (Sender = edtNomRec) Then
  Begin

    If blnBuscaPorChave Then
    Begin

      If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty) And
         (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
      Begin
        cdsDocumentos.Edit;
        cdsDocumentos.FieldByName('GER_NOMREC').AsString := edtNomRec.Text;

        if cdsDocumentos.FieldByName('GER_NOMREC').AsString <> EmptyStr then
          cdsDocumentos.FieldByName('DESTACAR').AsString := 'N';

        cdsDocumentos.Post;

        strUltRecPor := cdsDocumentos.FieldByName('GER_NOMREC').AsString;
        strUltCodCli := cdsDocumentos.FieldByName('GER_CLIORI').AsString;
      End
      Else
        edtNomRec.Clear;

      If (Not pnlDtaBai.Visible) and (Not edtKMInicial.Visible) and (Not edtKMFinal.Visible) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(cxgDocumentos);
      End;

    End;

  End

  Else If (Sender = edtCodEmp) And (edtCodEmp.Visible) Then
  Begin
    edtNomEmp.Clear;
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCadEmp;
      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not cdsDocumentos.IsEmpty) Then
        Begin
          //caso alterou a empresa, limpa a busca
          If edtCodEmp.Text <> cdsDocumentos.FieldByName('GER_EMPROM').AsString Then
            cdsDocumentos.Close;
        End;

        If edtNumRom.Visible Then
        Begin
          If (Not fValidaRomaneio) Then
          Begin
            Result := False;
            blnMudarFoco := False;
            pSetFocus(edtNumRom);
          End
          Else If blnBuscaPorChave Then
            pCarregaDocumentos;
        End;
      End;
    End;
  End

  Else If (Sender = mskDtaBai) Then
  Begin

    If blnBuscaPorChave Then
    Begin
      If (fEmptyDate(mskDtaBai.Text)) And (Not fMarcouEntregaPendente) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data da baixa deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaBai.Text, 0) = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (cdsDocumentos.Active) And
              (StrToDateDef(mskDtaBai.Text, 0) < cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data da baixa deve ser maior ou igual que a data do romaneio!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaBai.Text, 0) > VS_Date) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data da baixa não pode ser maior que a data atual!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (FDtaHorBai = opcFinal) Then
          fGravaDataGeral(opcData, StrToDate(mskDtaBai.Text), 0)
        Else
        Begin
          If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty)   And
             (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
          Begin
            cdsDocumentos.Edit;
            cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime := StrToDate(mskDtaBai.Text);
            cdsDocumentos.Post;

            dtaUltDtaBai := cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime;
          End
          Else
            mskDtaBai.Clear;
        End;
      End;
    End;

  End

  Else If (Sender = mskHorBai) Then
  Begin

    If blnBuscaPorChave Then
    Begin

      If (fEmptyTime(mskHorBai.Text)) And (Not fMarcouEntregaPendente) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora da baixa deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToTimeDef(mskHorBai.Text, -1) = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (cdsDocumentos.Active) And
              (StrToDateDef(mskDtaBai.Text, 0) = cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime)  And
              (StrToTimeDef(mskHorBai.Text, -1) < cdsDocumentos.FieldByName('GER_HORROM').AsDateTime) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora da baixa deve ser maior ou igual que a hora do romaneio!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaBai.Text, 0) = VS_Date)  And
              (StrToTimeDef(mskHorBai.Text, -1) > fTime()) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora da baixa deve ser menor ou igual que a hora atual!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (FDtaHorBai = opcFinal) Then
          fGravaDataGeral(opcHora, 0, StrToTime(mskHorBai.Text))
        Else
        Begin
          If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty)   And
             (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
          Begin
            cdsDocumentos.Edit;
            cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime := StrToTime(mskHorBai.Text);
            cdsDocumentos.Post;

            horUltHorBai := cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime;
          End
          Else
            mskHorBai.Clear;
        End;

        blnMudarFoco := False;

        pSetFocus(cxgDocumentos);

      End;

    End;

    If Result Then
      cxgDocumentosTableView.ApplyBestFit();

  End;

  If (Sender = edtKMInicial) Then
  Begin

    If blnBuscaPorChave Then
    Begin

      If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty) And
         (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
      Begin
        cdsDocumentos.Edit;
        cdsDocumentos.FieldByName('GER_KMINI').AsString := edtKMInicial.Text;
        cdsDocumentos.Post;
      End
      Else
        edtKMInicial.Clear;

    End;

  End;

  If (Sender = edtKMFinal) Then
  Begin

    If fEmptyStr(edtKMInicial.Text) And Not fEmptyStr(edtKMFinal.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível informar o KM Final sem informar o KM Inicial!', ['&O k']);
      Result := False;
    End;

    If Not fEmptyStr(edtKMInicial.Text) Then
    Begin

      If fEmptyStr(edtKMFinal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o KM Final!', ['&O k']);
        Result := False;
      End;

      If StrToInt(edtKMInicial.Text) > StrToInt(edtKMFinal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O KM Final deve ser maior que o KM Inicial!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If blnBuscaPorChave Then
        Begin
          If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty) And
             (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
          Begin
            cdsDocumentos.Edit;
            cdsDocumentos.FieldByName('GER_KMFIM').AsString := edtKMFinal.Text;
            cdsDocumentos.Post;
          End
          Else
            edtKMFinal.Clear;
        End;
      End;

    End;

    If (Not pnlDtaBai.Visible) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(cxgDocumentos);
    End;
  End;

  If (Not Result) And blnMudarFoco Then
    pSetFocus(Sender);

end;

procedure TfrmFatBaixaRomaneio.pCarregaDataHoraSugestao;
  Var
    cdsClone: TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, cdsDocumentos);
  cdsDocumentos.First;

  While (Not cdsDocumentos.Eof) Do
  Begin
    cdsDocumentos.Edit;
    cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime := fGetMaiorData(cdsClone);
    cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime := fGetMaiorHora(cdsClone);
    cdsDocumentos.Post;
    
    cdsDocumentos.Next;
  End;

  FreeAndNil(cdsClone);
end;

procedure TfrmFatBaixaRomaneio.pCarregaDocumentos;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  GER_CODMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_EMPROM, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_DTAROM, ';
  strSQL := strSQL + '  DATE_FORMAT(GER_HORROM, "%H:%i") AS GER_HORROM, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  "N" DESTACAR, ';
  strSQL := strSQL + '  "N" ENTPEN, ';
  strSQL := strSQL + '  ROMGERX.AUTOINCREM, ';
  strSQL := strSQL + '  REPEAT(" ", 10000) GER_OBSERV, ';
  strSQL := strSQL + '  GER_KMINI, ';
  strSQL := strSQL + '  GER_KMFIM, ';
  strSQL := strSQL + '  GER_NOMTAB, ';
  strSQL := strSQL + '  GER_DTAENT AS GER_DTADOC, ';
  strSQL := strSQL + '  GER_VOLUME, ';
  strSQL := strSQL + '  GER_INTFUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN ROMTRAX   ON ROMGERX.AUTOINCREM = ROMTRAX.TRA_SEQGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';

  If fCfgSis('USPRRO', varBoolean) Then
    strSQL := strSQL + '  GER_STATUS = "A" AND ';

  strSQL := strSQL + '  GER_DTABAI IS NULL       ';

  strSQL := strSQL + '  AND ROMTRAX.AUTOINCREM IS NULL ';

  cdsDocumentos.Close;
  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add(strSQL);
  qryDocumentos.ParamByName('NUMROM').AsString := edtNumRom.Text;
  qryDocumentos.ParamByName('EMPROM').AsString := fRetEmpresa;

  qryDocumentos.Open;
  pSetaClient(qryDocumentos);

  cdsDocumentos.Open;
  pSetaClient(cdsDocumentos);

  cdsDocumentos.DisableControls;

  While (Not cdsDocumentos.Eof) Do
  Begin
    cdsDocumentos.Edit;
    cdsDocumentos.FieldByName('GER_OBSERV').AsString := '';
    cdsDocumentos.Post;
    cdsDocumentos.Next;
  End;

  If (FDtaHorBai = opcDocumento) And fCfgSis('SGDTBR', VarBoolean) Then
    pCarregaDataHoraSugestao;

  cdsDocumentos.First;

  cdsDocumentos.EnableControls;

  edtNomMot.Text := cdsDocumentos.FieldByName('MOT_NOMMOT').AsString;

  cxgDocumentosTableView.ApplyBestFit();

  pCarregaItens(QuotedStr(edtNumRom.Text));

  objRomFusTarefas.pClearDataSets;
  objRomFusTarefas.pLogAdd('ROMGERX', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'],
      'GER_NUMROM = ' + QuotedStr(edtNumRom.Text) + ' AND GER_EMPROM = ' + QuotedStr(fRetEmpresa) +
      ' AND EXISTS (SELECT R.AUTOINCREM FROM ROMGERX R WHERE R.GER_NUMROM = ROMGERX.GER_NUMROM ' +
      ' AND R.GER_EMPROM = ROMGERX.GER_EMPROM AND R.GER_INTFUS <> "N")');
end;

procedure TfrmFatBaixaRomaneio.pCarregaDocumentosMotorista;
  Var
    strSQL,
    strNumRom: String;
begin
  strNumRom := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  GER_CODMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_EMPROM, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_DTAROM, ';
  strSQL := strSQL + '  DATE_FORMAT(GER_HORROM, "%H:%i") AS GER_HORROM, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  "N" DESTACAR, ';
  strSQL := strSQL + '  "N" ENTPEN, ';
  strSQL := strSQL + '  ROMGERX.AUTOINCREM, ';
  strSQL := strSQL + '  REPEAT(" ", 10000) GER_OBSERV, ';
  strSQL := strSQL + '  GER_KMINI, ';
  strSQL := strSQL + '  GER_KMFIM, ';
  strSQL := strSQL + '  GER_NOMTAB, ';
  strSQL := strSQL + '  GER_DTAENT AS GER_DTADOC, ';
  strSQL := strSQL + '  GER_VOLUME, ';
  strSQL := strSQL + '  GER_INTFUS  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_DTABAI IS NULL   AND ';
  strSQL := strSQL + '  GER_DTAINI IS NULL   AND ';
  strSQL := strSQL + '  GER_CODMOT = :CODMOT AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

  cdsDocumentos.Close;
  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add(strSQL);
  qryDocumentos.ParamByName('CODMOT').AsString := edtCodMot.Text;
  qryDocumentos.ParamByName('EMPROM').AsString := fRetEmpresa;

  qryDocumentos.Open;
  pSetaClient(qryDocumentos);

  cdsDocumentos.Open;
  pSetaClient(cdsDocumentos);

  cdsDocumentos.DisableControls;

  cdsDocumentos.First;

  While (Not cdsDocumentos.Eof) Do
  Begin
    strNumRom := IIF(fEmptyStr(strNumRom), '', strNumRom+',') + QuotedStr(cdsDocumentos.FieldByName('GER_NUMROM').AsString);

    cdsDocumentos.Edit;
    cdsDocumentos.FieldByName('GER_OBSERV').AsString := '';
    cdsDocumentos.Post;
    cdsDocumentos.Next;
  End;

  If (FDtaHorBai = opcDocumento) And fCfgSis('SGDTBR', VarBoolean) Then
    pCarregaDataHoraSugestao;

  cdsDocumentos.First;

  cdsDocumentos.EnableControls;

  If fEmptyStr(edtNomMot.Text) Then
    edtNomMot.Text := cdsDocumentos.FieldByName('MOT_NOMMOT').AsString;

  pCarregaItens(strNumRom);
end;

procedure TfrmFatBaixaRomaneio.pCarregaItens(strNumRom: String);

  Function fRetValSel : String;
  Begin
    Result := '(DET_QTDBAI * DET_UNITAR) - (DET_QTDBAI * (DET_DESESP / DET_QTDITE)) DET_VALSEL ';
  End;

  Var
    strSQL: String;
begin
  if fEmptyStr(strNumRom) then
    Exit;

  Try
    strSQL    := '';
    strSQL    := strSQL + ' SELECT SQL_NO_CACHE    ';
    strSQL    := strSQL + '          DET_SEQGER,   ';
    strSQL    := strSQL + '          DET_CODITE,   ';
    strSQL    := strSQL + '          DET_DESCRI,   ';
    strSQL    := strSQL + '          DET_NUMLOT,   ';
    strSQL    := strSQL + '          IF(DET_QTDBAI = 0, DET_QTDITE, DET_QTDBAI) AS DET_QTDITE, ';
    strSQL    := strSQL + '          DET_QTDBAI,   ';
    strSQL    := strSQL + '   "M" AS DET_MARDES,   ';
    strSQL    := strSQL + '          DET_NUMROM,   ';
    strSQL    := strSQL + '          DET_CODEMP,   ';
    strSQL    := strSQL + '  ROMDETX.AUTOINCREM,   ';
    strSQL    := strSQL + '          DET_AUTINC,   ';
    strSQL    := strSQL + '          DET_UNITAR,   ';
    strSQL    := strSQL + '          DET_DESESP,   ';
    strSQL    := strSQL + '      ' + fRetValSel;
    strSQL    := strSQL + ' FROM                   ';
    strSQL    := strSQL + '   ROMDETX              ';
    strSQL    := strSQL + ' INNER JOIN ROMGERX ON DET_SEQGER = ROMGERX.AUTOINCREM ';
    strSQL    := strSQL + ' WHERE GER_NUMROM IN ('+strNumRom+')';
    strSQL    := strSQL + '   AND GER_EMPROM = :EMPROM ';

    cdsItens.Close;
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add(strSQL);
    qryItens.ParamByName('EMPROM').AsString := fRetEmpresa;
    qryItens.Open;

    pSetaClient(qryItens);

    cdsItens.Open;
    pSetaClient(cdsItens);

    (cdsItens.FieldByName('DET_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItens.FieldByName('DET_QTDBAI') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmFatBaixaRomaneio.pChkEntPenClick(Sender: TObject);
begin
  if not pnlEntPen.Visible then
    exit;

  if chkEntPen.Checked then
    pLimpaCamposDaBaixa
  else
    pRetornaDataHoraOriginal;
end;

procedure TfrmFatBaixaRomaneio.pImprimeSeparacao(strNumRomNov, strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
  Var
    impPreRomaneio: TFatVendaImp;
    recSepara     : TDadosImpressaoVenda;
    qrySetores    : TUniQuery;

    Procedure pPreenchaMatItens(Var arrMatItens: TMatrizFechamento; strCodLse: String);
      Var
        i: Integer;
        qryAux: TUniQuery;
    Begin
      qryAux := fCriaQuery(Nil);
      SetLength(arrMatItens,0);

      With qryAux, SQL Do
      Begin
        Add('SELECT SQL_NO_CACHE          ');
        Add('  DISTINCT D.DET_CODITE      ');
        Add('FROM                         ');
        Add('  ROMDETX D                  ');
        Add('    INNER JOIN ITEGER G ON D.DET_CODITE = G.ITE_CODITE ');
        Add('WHERE                        ');
        Add('  D.DET_NUMROM = :NUMROM AND ');
        Add('  G.ITE_CODLSE = :CODLSE     ');
        Add('ORDER BY D.DET_CODITE        ');

        ParamByName('NUMROM').AsString := strNumRomNov;
        ParamByName('CODLSE').AsString := strCodLse;

        Open;
        First;
        While Not EOF Do
        Begin
          SetLength(arrMatItens, Length(arrMatItens) + 1);
          i := Length(arrMatItens) - 1;

          arrMatItens[i].strCodIte := FieldByName('DET_CODITE').AsString;
          Next;
        End;
      End;

      FreeAndNil(qryAux);
    End;

    Procedure pMarcaSeparacaoImpressaRomaneio(strCodLse: String);
    begin
      fExecutaSQL('UPDATE ROMDETX R ' +
                  '       INNER JOIN ITEGER I ON (R.DET_CODITE = I.ITE_CODITE) ' +
                  '                          AND (R.DET_CODEMP = I.ITE_CODEMP) ' +
                  '       INNER JOIN FATDOR F ON (R.DET_CODEMP = F.FDO_CODEMP) ' +
                  '                          AND (R.DET_NUMDOC = F.FDO_NUMDOC) ' +
                  '                          AND (R.DET_ESPDOC = F.FDO_ESPDOC) ' +
                  '                          AND (R.DET_CODCLI = F.FDO_CODCLI) ' +
                  '                          AND (I.ITE_CODITE = F.FDO_CODITE) ' +
                  '                          AND (I.ITE_CODEMP = F.FDO_CODEMP) ' +
                  '       INNER JOIN EXTDOR E ON (F.AUTOINCREM = E.FDO_SEQFDO) ' +
                  'SET    R.DET_SEPIMP = "S", ' +
                  '       E.FDO_SEPEXP = "S"  ' +
                  'WHERE  R.DET_NUMROM = "' + strNumRomNov + '"' +
                  '  AND  R.DET_EMPROM = "' + fRetEmpresa  + '"' +
                  '  AND  I.ITE_CODLSE = "' + strCodLse    + '"');
    end;

begin
  qrySetores := fCriaQuery(Nil);

  With qrySetores Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT ');
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      SQL.Add('   IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) AS ITE_CODLSE, ');
      SQL.Add('   IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LSE_DESCRI  ');
    end
    else
    begin
      SQL.Add('   I.ITE_CODLSE, ');
      SQL.Add('   L.LSE_DESCRI  ');
    end;
    SQL.Add('FROM ');
    SQL.Add('  ROMDETX D ');
    SQL.Add('    INNER JOIN ITEGER I ON (D.DET_CODITE = I.ITE_CODITE) ');
    SQL.Add('                       AND (D.DET_CODEMP = I.ITE_CODEMP) ');
    SQL.Add('    INNER JOIN FATDOR F ON (D.DET_CODEMP = F.FDO_CODEMP) ');
    SQL.Add('                       AND (D.DET_NUMDOC = F.FDO_NUMDOC) ');
    SQL.Add('                       AND (D.DET_ESPDOC = F.FDO_ESPDOC) ');
    SQL.Add('                       AND (D.DET_CODCLI = F.FDO_CODCLI) ');
    SQL.Add('                       AND (I.ITE_CODITE = F.FDO_CODITE) ');
    SQL.Add('                       AND (I.ITE_CODEMP = F.FDO_CODEMP) ');
    SQL.Add('    INNER JOIN EXTDOR E ON (F.AUTOINCREM = E.FDO_SEQFDO) ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      SQL.Add(' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = F.FDO_CODITE AND LT.LOT_CODEMP = F.FDO_CODEMP AND LT.LOT_NUMLOT = F.FDO_NUMLOT ');
      SQL.Add(' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
      SQL.Add(' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = I.ITE_LOCFIS AND CL2.LOC_CODEMP = I.ITE_CODEMP ');
      SQL.Add(' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
      SQL.Add(' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ');
    end
    else
      SQL.Add('    LEFT  JOIN CADLSE L ON (I.ITE_CODLSE = L.LSE_CODIGO) ');

    SQL.Add('WHERE ');
    SQL.Add('  D.DET_NUMROM = :NUMROM AND ');
    SQL.Add('  D.DET_EMPROM = :CODEMP     ');
    SQL.Add('ORDER BY ');
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      SQL.Add('  IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) ')
    else
      SQL.Add('  L.LSE_DESCRI ');

    ParamByName('NUMROM').AsString := strNumRomNov;
    ParamByName('CODEMP').AsString := fRetEmpresa;

    Open;
    First;

    While Not EOF Do
    Begin
      recSepara.strNumDoc := strNumDoc;
      recSepara.strEspDoc := strEspDoc;
      recSepara.strCodCli := strCodCLi;
      recSepara.strEmpDoc := strCodEmp;

      recSepara.strCodLse := FieldByName('ITE_CODLSE').AsString;

      impPreRomaneio := TFatVendaImp.Create;

      pPreenchaMatItens(recSepara.arrMatItens, FieldByName('ITE_CODLSE').AsString);

      impPreRomaneio.blnPreRomaneio   := True;
      impPreRomaneio.blnSomenteNaoImp := False;
      impPreRomaneio.opcAgrupaPor     := opcPedido;
      impPreRomaneio.Add(recSepara);

      If impPreRomaneio.fImprimeSeparacao(recSepara, '', '', False) Then
        pMarcaSeparacaoImpressaRomaneio(FieldByName('ITE_CODLSE').AsString);

      Next;
    End;
  End;
end;

procedure TfrmFatBaixaRomaneio.btnRemoverClick(Sender: TObject);
begin
  inherited;
  If Not cdsDocumentos.IsEmpty Then
  Begin
    If fPodeRemoverDocumento Then
      pMarcaDocumentoRemocao;
  End
  Else
    fMensagem('ATENÇÃO!', 'Não existem documentos para serem removidos!', ['&Ok']);
end;

procedure TfrmFatBaixaRomaneio.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Not cdsDocumentos.IsEmpty Then
  Begin

    If (Not fEmptyStr(cdsDocumentos.FieldByName('GER_OBSERV').AsString)) Then
      fDigitaObservacao(cdsDocumentos.FieldByName('GER_OBSERV').AsString, False);

    If (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'D') Then
      pVoltaQuantidadeEntrega(cdsDocumentos.FieldByName('AUTOINCREM').AsString);

    cdsDocumentos.Edit;
    cdsDocumentos.FieldByName('GER_MARDES').AsString := 'M';
    cdsDocumentos.Post;

    edtNomRec.Enabled := True;
    pnlDtaBai.Enabled := True;

    If strUltCodCli = cdsDocumentos.FieldByName('GER_CLIORI').AsString Then
    Begin
      If pnlDtaBai.Visible And cdsDocumentos.FieldByName('GER_DTABAI').IsNull And (dtaUltDtaBai > 0) Then
        mskDtaBai.Text := FormatDateTime('dd/MM/yyyy', dtaUltDtaBai);

      If pnlDtaBai.Visible And cdsDocumentos.FieldByName('GER_HORBAI').IsNull And (horUltHorBai > 0) Then
        mskHorBai.Text := FormatDateTime('hh:mm', horUltHorBai);

      If pnlDtaBai.Visible And cdsDocumentos.FieldByName('GER_NOMREC').IsNull And (strUltRecPor <> '') Then
        edtNomRec.Text := strUltRecPor;
    End;
  End;
end;

procedure TfrmFatBaixaRomaneio.btnRemoverItemClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
    frmFatItensBaixaRomaneio: TfrmFatItensBaixaRomaneio;
begin
  If cdsDocumentos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe nenhum documento selecionado para remoção!', ['&OK']);
    Exit;
  End;

  If (cdsDocumentos.FieldByName('GER_ESPORI').AsString = 'OX') Then
    Exit;

  inherited;

  Try
    pCriarFormularios(TfrmFatItensBaixaRomaneio, frmFatItensBaixaRomaneio);
    try
      pCloneDataSet(frmFatItensBaixaRomaneio.cdsItens, cdsItens, True);

      frmFatItensBaixaRomaneio.strSeqGer := cdsDocumentos.FieldByName('AUTOINCREM').AsString;

      frmFatItensBaixaRomaneio.edtNumDoc.Text := cdsDocumentos.FieldByName('GER_NUMDOC').AsString;
      frmFatItensBaixaRomaneio.edtNomCli.Text := cdsDocumentos.FieldByName('GER_NOMCLI').AsString;

      blnConfirma := (frmFatItensBaixaRomaneio.ShowModal = mrOk);
      If blnConfirma Then
      Begin
        If fRemoveuTodosOsItens(frmFatItensBaixaRomaneio.cdsItens) Then
        Begin
          If fPodeRemoverDocumento Then
          Begin
            pCloneDataSet(cdsItens, frmFatItensBaixaRomaneio.cdsItens, True);
            pMarcaDocumentoRemocao;
          End
          Else
          Begin
            If fEmptyStr(cdsDocumentos.FieldByName('GER_OBSERV').AsString) Then
            Begin
              fMensagem('ATENÇÃO!', 'Para remoção de todos os itens é necessário digitar uma observação. '+
                                    'A quantidade a entregar deste documento foi restaurada!', ['&OK']);
            End;
          End;
        End
        Else
        Begin
          pCloneDataSet(cdsItens, frmFatItensBaixaRomaneio.cdsItens, True);

          If (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'D') Then
          Begin
            cdsDocumentos.Edit;
            cdsDocumentos.FieldByName('GER_MARDES').AsString := 'M';
            cdsDocumentos.Post;
          End;
        End;
      End;
    finally
      pFreeAndNil(frmFatItensBaixaRomaneio);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TfrmFatBaixaRomaneio.btnSairClick(Sender: TObject);
begin
  if cdsDocumentos.IsEmpty then
    Close
  else if fMensagem('', 'Cancelar a baixa do romaneio ' + edtNumRom.Text + '?', ['&Sim', '&Não']) = 2 Then
    Exit
  else
  begin
    pCancelarBaixa;
    Close;
  end;
end;

procedure TfrmFatBaixaRomaneio.cxgDocumentosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  blnDestacar: Boolean;
begin
  inherited;

  blnDestacar := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosDESTACAR.Index]) = 'S';

  if blnRecebidoPorObrig and blnDestacar then
    ACanvas.Font.Color := clRed
  else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmFatBaixaRomaneio.cxgDocumentosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F9 Then
  Begin
    btnMarcarTudo.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    btnRemoverItem.Click;
  End
  Else If Key = VK_RETURN Then
  Begin
    Key := 0;
    btnMarcar.Click;

    pSetFocus(edtNomRec);

  End
  Else If Key = VK_SPACE Then
  Begin
    Key := 0;
    btnObservacoes.Click;
  End
  Else If Key = VK_DELETE Then
  Begin
    Key := 0;
    btnRemover.Click;
  End;
end;

procedure TfrmFatBaixaRomaneio.btnMarcarTudoClick(Sender: TObject);
begin
  inherited;
  If Not cdsDocumentos.IsEmpty Then
  Begin
    cdsDocumentos.DisableControls;
    cdsDocumentos.First;
    While (Not cdsDocumentos.Eof) Do
    Begin
      btnMarcar.Click;
      cdsDocumentos.Next;
    End;
    cdsDocumentos.EnableControls;
  End;
end;

Function TfrmFatBaixaRomaneio.fDigitaObservacao(strObsAtu: String;
  blnObrigatorio: Boolean): Boolean;
begin
  Try
    pCriarFormularios(TfrmFatBaixaRomaneioObs, frmFatBaixaRomaneioObs);
    frmFatBaixaRomaneioObs.blnObrigatorio := blnObrigatorio;
    frmFatBaixaRomaneioObs.Caption := frmFatBaixaRomaneioObs.Caption + ' < Documento: ' +
                                      cdsDocumentos.FieldByName('GER_NUMDOC').AsString + ' >';
    If (Not fEmptyStr(strObsAtu)) Then
      frmFatBaixaRomaneioObs.memObserv.Texto := strObsAtu;

    frmFatBaixaRomaneioObs.memObserv.SelStart := Length(strObsAtu);
    frmFatBaixaRomaneioObs.ShowModal;

    If frmFatBaixaRomaneioObs.ModalResult = mrOk Then
    Begin
      cdsDocumentos.Edit;
      cdsDocumentos.FieldByName('GER_OBSERV').AsString := frmFatBaixaRomaneioObs.memObserv.Text;
      cdsDocumentos.Post;
    End;

    Result := (frmFatBaixaRomaneioObs.ModalResult = mrOk) Or (Not blnObrigatorio) Or (Not fEmptyStr(cdsDocumentos.FieldByName('GER_OBSERV').AsString));

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatBaixaRomaneio.fDigitaObservacao]');
    End;
  End;
  pFreeAndNil(frmFatBaixaRomaneioObs);
end;

function TfrmFatBaixaRomaneio.fDeveGerarNovoPreRomaneioNaBaixa(Const strCodEmp: String = ''): Boolean;
begin
  Result := False;

  If Not fCfgSis('USPRRO', varBoolean, strCodEmp) Then
    Exit;

  If fCfgSis('ROMPAR', varBoolean, strCodEmp) Then
    Exit;

  If Not fCfgSis('GERPRO', varBoolean, strCodEmp) Then
    Exit;

  Result := True;
end;

function TfrmFatBaixaRomaneio.fGetMaiorData(cdsClone: TUniClientDataSet;
  blnDelAftScroll: Boolean): TDate;
  Var
    intRecNo: Integer;
begin
  Result := 0;

  If (cdsClone.IsEmpty) Then
    Exit;

  If blnDelAftScroll Then
    cdsClone.AfterScroll := Nil;

  With cdsClone Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;

    While Not Eof Do
    Begin
      If (FieldByName('GER_MARDES').AsString  = 'M') Then
      Begin
        If Result < FieldByName('GER_DTAROM').AsDateTime Then
          Result := FieldByName('GER_DTAROM').AsDateTime;
      End;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

  If blnDelAftScroll Then
    cdsClone.AfterScroll := pAfterScroll;
end;

function TfrmFatBaixaRomaneio.fGetMaiorDataRomaneio(blnDelAftScroll: Boolean = True): TDate;
  Var
    intRecNo: Integer;
begin
  Result := 0;

  If (cdsDocumentos.IsEmpty) Then
    Exit;

  If blnDelAftScroll Then
    cdsDocumentos.AfterScroll := Nil;

  With cdsDocumentos Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;

    While Not Eof Do
    Begin
      If (FieldByName('GER_MARDES').AsString  = 'M') Then
      Begin
        If Result < FieldByName('GER_DTAROM').AsDateTime Then
          Result := FieldByName('GER_DTAROM').AsDateTime;
      End;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

  If blnDelAftScroll Then
    cdsDocumentos.AfterScroll := pAfterScroll;
end;

function TfrmFatBaixaRomaneio.fGetMaiorHora(cdsClone: TUniClientDataSet): TTime;
  Var
    intRecNo: Integer;
begin
  Result := 0;

  If (Not cdsClone.Active) Then
    Exit;

  cdsClone.AfterScroll := Nil;

  With cdsClone Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    Filtered := False;
    Filter   := 'GER_DTAROM = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', fGetMaiorData(cdsClone, False))) + ' AND GER_MARDES = ' + QuotedStr('M');
    Filtered := True;

    First;

    While Not Eof Do
    Begin
      If Result < FieldByName('GER_HORROM').AsDateTime Then
        Result := FieldByName('GER_HORROM').AsDateTime;

      Next;
    End;

    Filtered := False;
    RecNo    := intRecNo;
    EnableControls;
  End;

  cdsClone.AfterScroll := pAfterScroll;
end;

function TfrmFatBaixaRomaneio.fGetMaiorHoraRomaneio: TTime;
  Var
    intRecNo: Integer;
begin
  Result := 0;

  If (Not cdsDocumentos.Active) Then
    Exit;

  cdsDocumentos.AfterScroll := Nil;

  With cdsDocumentos Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    Filtered := False;
    Filter   := 'GER_DTAROM = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', fGetMaiorDataRomaneio(False))) + ' AND GER_MARDES = ' + QuotedStr('M');
    Filtered := True;

    First;

    While Not Eof Do
    Begin
      If Result < FieldByName('GER_HORROM').AsDateTime Then
        Result := FieldByName('GER_HORROM').AsDateTime;

      Next;
    End;

    Filtered := False;
    RecNo    := intRecNo;
    EnableControls;
  End;

  cdsDocumentos.AfterScroll := pAfterScroll;
end;

function TfrmFatBaixaRomaneio.fGravaDataGeral(opcDtaHor: TDataHora; dtaDatBai: TDate; timHorBai: TTime): Boolean;
Var
  intRecNo: Integer;
begin
  Result := False;

  If (Not cdsDocumentos.Active) Then
    Exit;

  Try
    With cdsDocumentos Do
    Begin
      DisableControls;
      intRecNo := RecNo;
      First;

      While Not Eof Do
      Begin
        Edit;

        If (opcDtaHor = opcData)Then
          FieldByName('GER_DTABAI').AsDateTime := dtaDatBai
        Else If (opcDtaHor = opcHora)Then
          FieldByName('GER_HORBAI').AsDateTime := timHorBai
        Else
        Begin
          FieldByName('GER_DTABAI').AsDateTime := dtaDatBai;
          FieldByName('GER_HORBAI').AsDateTime := timHorBai;
        End;

        Post;

        Next;
      End;

      RecNo := intRecNo;
      EnableControls;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatBaixaRomaneio.fGravaDataGeral]');
  End;
end;

function TfrmFatBaixaRomaneio.fHaDocumentosSemInformarRecebidoPor: Boolean;
var
  intRecNo: Integer;
begin
  Result := False;

  intRecNo := cdsDocumentos.RecNo;
  cdsDocumentos.DisableControls;
  cdsDocumentos.First;

  while not cdsDocumentos.Eof do
  begin
    if (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') and
       (cdsDocumentos.FieldByName('GER_NOMREC').AsString = EmptyStr) then
    begin
      Result := True;

      cdsDocumentos.Edit;
      cdsDocumentos.FieldByName('DESTACAR').AsString := 'S';
      cdsDocumentos.Post;
    end;

    cdsDocumentos.Next;
  end;

  cdsDocumentos.RecNo := intRecNo;
  cdsDocumentos.EnableControls;
end;

function TfrmFatBaixaRomaneio.fMarcouEntregaPendente: Boolean;
begin
  Result := True;

  if (not pnlEntPen.Visible) then
    Exit(False);

  if (not chkEntPen.Checked) then
    Exit(False);
end;

procedure TfrmFatBaixaRomaneio.pLimpaCamposDaBaixa;
begin
  if (not Assigned(cdsDocumentos)) then
    exit;

  if (not cdsDocumentos.Active) then
    exit;

  if (cdsDocumentos.RecNo <= 0) then
    exit;

  dtaUltDtaBai := cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime;
  horUltHorBai := cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime;

  cdsDocumentos.Edit;
  cdsDocumentos.FieldByName('GER_NOMREC').Clear;
  cdsDocumentos.FieldByName('GER_KMINI').Clear;
  cdsDocumentos.FieldByName('GER_KMFIM').Clear;
  cdsDocumentos.FieldByName('GER_DTABAI').Clear;
  cdsDocumentos.FieldByName('GER_HORBAI').Clear;
  cdsDocumentos.FieldByName('ENTPEN').AsString := 'S';
  cdsDocumentos.FieldByName('DESTACAR').AsString := 'N';
  cdsDocumentos.Post;

  edtNomRec.Clear;
  edtKMInicial.Clear;
  edtKMFinal.Clear;
  mskDtaBai.Clear;
  mskHorBai.Clear;
  blnRecebidoPorObrig := False;
end;

procedure TfrmFatBaixaRomaneio.pLimpaDataHora;
begin
  mskDtaBai.Clear;
  mskHorBai.Clear;
end;

procedure TfrmFatBaixaRomaneio.btnObservacoesClick(Sender: TObject);
begin
  inherited;
  If Not cdsDocumentos.IsEmpty Then
    fDigitaObservacao(cdsDocumentos.FieldByName('GER_OBSERV').AsString, False);
end;

procedure TfrmFatBaixaRomaneio.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F9 Then
  Begin
    btnMarcarTudo.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    btnRemoverItem.Click;
  End
  Else If Key = VK_RETURN Then
  Begin
    Key := 0;
    btnMarcar.Click;

    pSetFocus(edtNomRec);

  End
  Else If Key = VK_SPACE Then
  Begin
    Key := 0;
    btnObservacoes.Click;
  End
  Else If Key = VK_DELETE Then
  Begin
    Key := 0;
    btnRemover.Click;
  End;
end;

procedure TfrmFatBaixaRomaneio.pAfterScroll(DataSet: TDataSet);
begin
  If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty) Then
  Begin
    edtNomRec.Text := cdsDocumentos.FieldByName('GER_NOMREC').AsString;

    edtKMInicial.Text := cdsDocumentos.FieldByName('GER_KMINI').AsString;
    edtKMFinal.Text := cdsDocumentos.FieldByName('GER_KMFIM').AsString;

    If (cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime <> 0) Then
      mskDtaBai.Text := FormatDateTime('DD/MM/YYYY', cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime)
    Else
      mskDtaBai.Clear;

    If (cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime <> 0) Then
      mskHorBai.Text := FormatDateTime('HH:MM', cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime)
    Else
      mskHorBai.Clear;

    edtNomAj1.Text := cdsDocumentos.FieldByName('AJU_NOMAJ1').AsString;
    edtNomAj2.Text := cdsDocumentos.FieldByName('AJU_NOMAJ2').AsString;
    edtNomAj3.Text := cdsDocumentos.FieldByName('AJU_NOMAJ3').AsString;
    edtNomAj4.Text := cdsDocumentos.FieldByName('AJU_NOMAJ4').AsString;

    if pnlEntPen.Visible then
    begin
      //Não deve chamar a função onClick
      chkEntPen.OnClick := Nil;
      try
        chkEntPen.Checked := IIF(cdsDocumentos.FieldByName('ENTPEN').AsString = 'S', True, False);
      finally
        chkEntPen.OnClick := pChkEntPenClick;
      end;
    end;
  End
  Else
  Begin
    edtNomRec.Text := '';
    edtKMInicial.Text := '';
    edtKMFinal.Text := '';
    pLimpaDataHora;
    edtNomAj1.Text := '';
    edtNomAj2.Text := '';
    edtNomAj3.Text := '';
    edtNomAj4.Text := '';

    if pnlEntPen.Visible then
      chkEntPen.Checked := False;
  End;

  edtNomRec.Enabled := cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M';
  edtKMInicial.Enabled := cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M';
  edtKMFinal.Enabled := cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M';
  pnlDtaBai.Enabled := cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M';

end;

procedure TfrmFatBaixaRomaneio.pCancelarBaixa;
begin
  cdsDocumentos.Close;
  If fCfgSis('TIPROM') = '1' Then
  Begin
    edtNomMot.Clear;
    edtNumRom.Clear;
    edtNomRec.Clear;
    edtKMInicial.Clear;
    edtKMFinal.Clear;
    pLimpaDataHora;
    pSetFocus(edtNumRom);
  End
  Else
  Begin
    edtCodMot.Clear;
    edtNomMot.Clear;
    edtNomRec.Clear;
    edtKMInicial.Clear;
    edtKMFinal.Clear;
    pLimpaDataHora;
    pSetFocus(edtCodMot);
  End;
  lblRecebidoPorObrig.Visible := False;
end;

function TfrmFatBaixaRomaneio.fConfirmaBaixa: Boolean;
  Var
    strEntreg: String;
    objHisPed: THisPed;
    qryRomObs: TUniQuery;
    qryPedido: TUniQuery;

    blnGerarNovoPreRomaneio: Boolean;
    strNumeroNovoPreRomaneio: String;

    strNumPedTmp: String;
    strEmpPedTmp: String;

    procedure pCancelar;
    begin
      FreeAndNil(objHisPed);
      FreeAndNil(qryRomObs);
      FreeAndNil(qryPedido);
      cdsDocumentos.EnableControls;
    End;

    procedure fAtualizaInformacoesCRMLocal(strNumDoc, strEspDoc, strCodEmp: String;
      blnExclusao: Boolean = False; strObserv: String = ''; strNumOrc: String = '';
      strEspOrc: String = '');
    begin
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                           strNumOrc,
                                           strEspOrc,
                                           strLoginUsuarioLogado,
                                           IIF(blnExclusao, afcRomaneioExclusao, afcRomaneioBaixa));

      If (blnExclusao) Then
        objOcoCrm.strInfAdc := strObserv
      Else
      Begin
        If (fEmptyDate(mskDtaBai.Text)) Then
          objOcoCrm.strDHBaix := DateTimeToStr(fNow)
        Else
          objOcoCrm.strDHBaix := mskDtaBai.Text + ' ' + mskHorBai.Text;
        objOcoCrm.strNomRec := edtNomRec.Text;
      End;
      objOcoCrm.strNumRom := cdsDocumentos.FieldByName('GER_NUMROM').AsString;

      TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
    end;

    function SQLWhereDocOPCROM: string;
    begin
      Result := '';

      If Pos(fCfgSis('OPCROM', varString),'2_3_4_') > 0 Then
      Begin
        Result := Result + ' WHERE FDO_NUMFAT = :NUMDOC';
        Result := Result + '   AND FDO_TIPFAT = :ESPDOC';
        Result := Result + '   AND FDO_EMPFAT = :CODEMP';
      End
      Else If Pos(fCfgSis('OPCROM', varString),'1_5_') > 0 Then
      Begin
        Result := Result + ' WHERE FDO_NUMDOC = :NUMDOC';
        Result := Result + '   AND FDO_ESPDOC = :ESPDOC';
        Result := Result + '   AND FDO_CODEMP = :CODEMP';
      End;
    end;

begin
  Result := False;

  strNumeroNovoPreRomaneio := '';
  blnGerarNovoPreRomaneio  := fDeveGerarNovoPreRomaneioNaBaixa;

  If fRetEmpresa <> VS_strCodEmp Then
  Begin
    If fCfgSis('OPCROM', varString, fRetEmpresa) <> fCfgSis('OPCROM') Then
    Begin
      pMensagemOk('A empresa do romaneio selecionado ('+ fRetEmpresa +') utiliza a CFG_OPCROM diferente da empresa logada. Operação não permitida!');
      Exit;
    End;

    If fDeveGerarNovoPreRomaneioNaBaixa(fRetEmpresa) Then
    Begin
      If Not fPergunta('O romaneio a ser baixado é de outra empresa, portanto não será gerado o pré-romaneio! Deseja prosseguir?', False) Then
        Exit;
      blnGerarNovoPreRomaneio := False;
    End;
  End;

  cdsDocumentos.DisableControls;
  objHisPed := THisPed.Create(Self);

  qryRomObs := fCriaQuery(Self);
  qryRomObs.Options.SetFieldsReadOnly := False;

  qryPedido := fCriaQuery(Self);
  qryPedido.SQL.Add('SELECT DISTINCT FDO_NUMDOC AS FGO_NUMDOC, FDO_ESPDOC AS FGO_ESPDOC, FDO_CODEMP AS FGO_CODEMP');
  qryPedido.SQL.Add('FROM FATDOR');
  qryPedido.SQL.Add(SQLWhereDocOPCROM);
  qryPedido.SQL.Add(fSQLPDRomaneioPeloDocConf);

  Try
    cdsDocumentos.First;
    fStartTransaction;

    While (Not cdsDocumentos.Eof) Do
    Begin

      If Not fEmptyStr(cdsDocumentos.FieldByName('GER_OBSERV').AsString) Then
      Begin
        If (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'D') Then
        Begin
          fGravaLogRom(cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                  '',
                  '',
                  '',
                  cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                  cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                  cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                  cdsDocumentos.FieldByName('GER_OBSERV').AsString,
                  False,
                  '',
                  cdsDocumentos.FieldByName('GER_EMPROM').AsString);
        End
        Else
        Begin
          qryRomObs.Close;
          qryRomObs.SQL.Clear;
          qryRomObs.SQL.Add(' SELECT * ');
          qryRomObs.SQL.Add('   FROM ROMOBSX ');
          qryRomObs.SQL.Add('  WHERE OBS_NUMROM = ' + Quotedstr(cdsDocumentos.FieldByName('GER_NUMROM').AsString));
          qryRomObs.SQL.Add('    AND OBS_NUMDOC = ' + Quotedstr(cdsDocumentos.FieldByName('GER_DOCORI').AsString));
          qryRomObs.SQL.Add('    AND OBS_ESPDOC = ' + Quotedstr(cdsDocumentos.FieldByName('GER_ESPORI').AsString));
          qryRomObs.SQL.Add('    AND OBS_EMPDOC = ' + Quotedstr(cdsDocumentos.FieldByName('GER_CODEMP').AsString));
          qryRomObs.SQL.Add('    AND OBS_CODCLI = ' + Quotedstr(cdsDocumentos.FieldByName('GER_CLIORI').AsString));
          qryRomObs.Open;

          If (qryRomObs.IsEmpty) Then
            qryRomObs.Append
          Else
            qryRomObs.Edit;

          qryRomObs.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ROMOBSX', VS_strCodEmp);
          qryRomObs.FieldByName('OBS_NUMROM').AsString := cdsDocumentos.FieldByName('GER_NUMROM').AsString;
          qryRomObs.FieldByName('OBS_EMPROM').AsString := cdsDocumentos.FieldByName('GER_EMPROM').AsString;
          qryRomObs.FieldByName('OBS_NUMDOC').AsString := cdsDocumentos.FieldByName('GER_DOCORI').AsString;
          qryRomObs.FieldByName('OBS_ESPDOC').AsString := cdsDocumentos.FieldByName('GER_ESPORI').AsString;
          qryRomObs.FieldByName('OBS_EMPDOC').AsString := cdsDocumentos.FieldByName('GER_CODEMP').AsString;
          qryRomObs.FieldByName('OBS_CODCLI').AsString := cdsDocumentos.FieldByName('GER_CLIORI').AsString;
          qryRomObs.FieldByName('OBS_OBSERV').AsString := cdsDocumentos.FieldByName('GER_OBSERV').AsString;
          qryRomObs.Post;
        End;
      End;

      If (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
        strEntreg := 'S'
      Else
        strEntreg := 'N';

      Result := objHisPed.fAtualizarHistorico(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                              cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                              cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                              cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                              cdsDocumentos.FieldByName('GER_NOMREC').AsString,
                                              IIF((cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime = 0) and (cdsDocumentos.FieldByName('ENTPEN').AsString = 'N'), VS_Date, cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime),
                                              IIF((cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime = 0) and (cdsDocumentos.FieldByName('ENTPEN').AsString = 'N'), fTime(), cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime),
                                              IIF(cdsDocumentos.FieldByName('ENTPEN').AsString = 'N', strEntreg, 'N'),
                                              cdsDocumentos.FieldByName('GER_OBSERV').AsString);

      If (Result) And (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      begin
        If fCfgSis('OPCROM', varInteger) = 1 Then
        Begin
          fAtualizaInformacoesCRMLocal(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                       cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                       cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                       (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'D'),
                                       cdsDocumentos.FieldByName('GER_OBSERV').AsString);
        End
        Else
        Begin
          qryPedido.Close;
          qryPedido.ParamByName('NUMDOC').AsString := cdsDocumentos.FieldByName('GER_DOCORI').AsString;
          qryPedido.ParamByName('ESPDOC').AsString := cdsDocumentos.FieldByName('GER_ESPORI').AsString;
          qryPedido.ParamByName('CODEMP').AsString := cdsDocumentos.FieldByName('GER_CODEMP').AsString;
          qryPedido.Open;

          If Not qryPedido.IsEmpty Then
          Begin
            qryPedido.First;
            While Not qryPedido.Eof Do
            Begin
              fAtualizaInformacoesCRMLocal(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                           cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                           qryPedido.FieldByName('FGO_CODEMP').AsString,
                                           (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'D'),
                                           cdsDocumentos.FieldByName('GER_OBSERV').AsString,
                                           qryPedido.FieldByName('FGO_NUMDOC').AsString,
                                           qryPedido.FieldByName('FGO_ESPDOC').AsString);


              qryPedido.Next;
            End;
          End;
        End;
      end;

      If (Not Result) Then
      Begin
        fRollback;
        Break;
      End;

      If (strEntreg = 'N') Then
      Begin
        If blnGerarNovoPreRomaneio Then
        Begin
          Result := fGerarNovoPreRomaneio(strNumeroNovoPreRomaneio,
                                          cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                          cdsDocumentos.FieldByName('GER_EMPROM').AsString,
                                          cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                          cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                          cdsDocumentos.FieldByName('GER_CODEMP').AsString);
        End
        Else
        Begin
          Result := fRemoverDocumento(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                      cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                      cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                      cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                      cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                      cdsDocumentos.FieldByName('GER_CODVEN').AsString,
                                      cdsDocumentos.FieldByName('GER_CODMOT').AsString,
                                      cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime,
                                      cdsDocumentos.FieldByName('GER_HORROM').AsDateTime,
                                      cdsDocumentos.FieldByName('GER_OBSERV').AsString,
                                      cdsDocumentos.FieldByName('GER_EMPROM').AsString,
                                      Self.Name);
        End;
      End
      Else
      Begin
        If (cdsItens.Active) Then
        Begin
          cdsItens.Filtered := False;
          cdsItens.Filter   := 'DET_SEQGER = ' + QuotedStr(cdsDocumentos.FieldByName('AUTOINCREM').AsString) + ' AND '+
                               'DET_QTDITE <> DET_QTDBAI ';
          cdsItens.Filtered := True;
          If (cdsItens.RecordCount > 0) Then
          Begin
            cdsItens.DisableControls;
            While Not cdsItens.Eof Do
            Begin
              Result := fRemoverItemDocto(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                          cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                          cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                          cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                          cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                          cdsItens.FieldByName('DET_CODITE').AsString,
                                          ((cdsItens.FieldByName('DET_QTDITE').AsFloat - cdsItens.FieldByName('DET_QTDBAI').AsFloat) *
                                          (cdsItens.FieldByName('DET_VALSEL').AsFloat / cdsItens.FieldByName('DET_QTDITE').AsFloat)),
                                          (cdsItens.FieldByName('DET_QTDITE').AsFloat - cdsItens.FieldByName('DET_QTDBAI').AsFloat),
                                          cdsItens.FieldByName('DET_AUTINC').AsString,
                                          cdsDocumentos.FieldByName('GER_NOMTAB').AsString);
         
              If (Result) Then
                Result := fRemoverRomDet(cdsItens.FieldByName('DET_NUMROM').AsString,
                                         cdsItens.FieldByName('DET_SEQGER').AsString,
                                         cdsItens.FieldByName('DET_CODEMP').AsString,
                                         cdsItens.FieldByName('AUTOINCREM').AsString,
                                         cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                         cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                         cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                         cdsDocumentos.FieldByName('GER_CODVEN').AsString,
                                         cdsDocumentos.FieldByName('GER_CODMOT').AsString,
                                         cdsDocumentos.FieldByName('GER_DTAENT').AsDateTime,
                                         cdsDocumentos.FieldByName('GER_HORENT').AsDateTime,
                                         cdsItens.FieldByName('DET_CODITE').AsString,
                                         cdsItens.FieldByName('DET_QTDITE').AsFloat,
                                         cdsItens.FieldByName('DET_QTDBAI').AsFloat,
                                         cdsItens.FieldByName('DET_AUTINC').AsString,
                                         cdsDocumentos.FieldByName('GER_EMPROM').AsString,
                                         Self.Name,
                                         cdsDocumentos.FieldByName('GER_DTADOC').AsDateTime,
                                         cdsDocumentos.FieldByName('GER_VOLUME').AsFloat);
 
              cdsItens.Next;
            End;
          End;
          cdsItens.Filtered := False;
          cdsItens.EnableControls;
        End;

        If (Result) Then
          Result := fBaixarDocumento(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                     cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                     cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                     cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                     cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                     cdsDocumentos.FieldByName('GER_NOMREC').AsString,
                                     IIF((cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime = 0) and (cdsDocumentos.FieldByName('ENTPEN').AsString = 'N'), VS_Date, cdsDocumentos.FieldByName('GER_DTABAI').AsDateTime),
                                     IIF((cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime = 0) and (cdsDocumentos.FieldByName('ENTPEN').AsString = 'N'), fRetHoraServidor, cdsDocumentos.FieldByName('GER_HORBAI').AsDateTime),
                                     IIF(cdsDocumentos.FieldByName('ENTPEN').AsString = 'N', strEntreg, 'N'),
                                     'N',
                                     cdsDocumentos.FieldByName('GER_KMINI').AsString,
                                     cdsDocumentos.FieldByName('GER_KMFIM').AsString,
                                     cdsDocumentos.FieldByName('GER_EMPROM').AsString,
                                     cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime,
                                     cdsDocumentos.FieldByName('GER_DTADOC').AsDateTime,
                                     cdsDocumentos.FieldByName('GER_VOLUME').AsFloat);

      End;

      If (Not Result) Then
      Begin
        fRollback;
        Break;
      End;

      cdsDocumentos.Next;
    End;

    If fCfgSis('EXISTA', varBoolean) And (Result) Then
    Begin
      cdsDocumentos.First;
      While Not cdsDocumentos.Eof Do
      Begin
        qryPedido.Close;
        qryPedido.ParamByName('NUMDOC').AsString := cdsDocumentos.FieldByName('GER_DOCORI').AsString;
        qryPedido.ParamByName('ESPDOC').AsString := cdsDocumentos.FieldByName('GER_ESPORI').AsString;
        qryPedido.ParamByName('CODEMP').AsString := cdsDocumentos.FieldByName('GER_CODEMP').AsString;
        qryPedido.Open;

        If Not qryPedido.IsEmpty Then
        Begin
          qryPedido.First;
          While (Not qryPedido.Eof) Do
          Begin
            TUpdateStatus.New(TParamStatus.New()
                                .NumDoc(qryPedido.FieldByName('FGO_NUMDOC').AsString)
                                .EspDoc(qryPedido.FieldByName('FGO_ESPDOC').AsString)
                                .CodEmp(qryPedido.FieldByName('FGO_CODEMP').AsString)).pExecute();
            qryPedido.Next;
          End;
        End;
        cdsDocumentos.Next;
      End;
    End;

    If (Result) Then
    Begin
      fCommit;

      if Assigned(objRomFusTarefas) then
        objRomFusTarefas.pProcessarTarefas;

      if cdsDocumentos.FieldByName('GER_INTFUS').AsString = 'S' then
        TRomaneioTarefasFusion.pInsereTarFus(edtNumRom.Text, fRetEmpresa, EmptyStr, EmptyStr, EmptyStr, 'F');

      Result := True;
    End
    Else
      fRollback;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fConfirmaBaixa]');
    End;
  End;

  If Result And Not fEmptyStr(strNumeroNovoPreRomaneio) Then
  Begin
    If blnGerarNovoPreRomaneio Then
    Begin
      If fMensagem('ATENÇÃO!','Foi gerado novo Romaneio Nº ' + strNumeroNovoPreRomaneio + ' com os documentos não entregues!'+#10#13+ 
                              'Deseja imprimir a separação deste documento?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        pImprimeSeparacao(strNumeroNovoPreRomaneio,
                          cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                          cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                          cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                          cdsDocumentos.FieldByName('GER_CLIORI').AsString);
      End;                  
    End
    Else
    Begin
      pMensagemOk('Foi gerado novo Romaneio Nº ' + strNumeroNovoPreRomaneio + ' com os documentos não entregues!');
    End;                    
  End;

  If (Result) Then
  Begin
    cdsDocumentos.First;

    While (Not cdsDocumentos.Eof) Do
    Begin
      pRetNumeroPedidoVenda(cdsDocumentos.FieldByName('GER_DOCORI').AsString, cdsDocumentos.FieldByName('GER_ESPORI').AsString, cdsDocumentos.FieldByName('GER_CODEMP').AsString, cdsDocumentos.FieldByName('GER_CLIORI').AsString, strNumPedTmp, strEmpPedTmp);

      If (Pos(fCfgSis('TIPEXP', varString), '2_3_4_') > 0) Then Begin
        fDisparaWhatsappAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'RB', cdsDocumentos.FieldByName('GER_ESPORI').AsString, strNumPedTmp, 'PD', strEmpPedTmp, cdsDocumentos.FieldByName('GER_CLIORI').AsString, '', True, '', Nil, '', '', '', Self.UnitName);
        fDisparaEmailAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'RB', cdsDocumentos.FieldByName('GER_ESPORI').AsString, strNumPedTmp, 'PD', strEmpPedTmp, cdsDocumentos.FieldByName('GER_CLIORI').AsString);
        fDisparaSMSAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'RB', cdsDocumentos.FieldByName('GER_ESPORI').AsString, strNumPedTmp, 'PD', strEmpPedTmp, cdsDocumentos.FieldByName('GER_CLIORI').AsString);
      End Else If (Pos(fCfgSis('TIPEXP', varString), '5_') > 0) Then Begin
        fDisparaWhatsappAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'E5', cdsDocumentos.FieldByName('GER_ESPORI').AsString, '', 'BX', '', cdsDocumentos.FieldByName('GER_CLIORI').AsString, '', True, '', Nil, '', '', '', Self.UnitName);
        fDisparaEmailAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'E5', cdsDocumentos.FieldByName('GER_ESPORI').AsString, '', 'BX', '', cdsDocumentos.FieldByName('GER_CLIORI').AsString);
        fDisparaSMSAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'E5', cdsDocumentos.FieldByName('GER_ESPORI').AsString, '', 'BX', '', cdsDocumentos.FieldByName('GER_CLIORI').AsString);
      End;

      cdsDocumentos.Next;
    End;
  End;

  pCancelar;
end;

procedure TfrmFatBaixaRomaneio.btnConfirmaClick(Sender: TObject);
  Var
    frmDigDataHora: TfrmDigDataHora;
    blnConfirma: Boolean;
    dtaDtaBai: TDate;
    timHorBai: TTime;
    strSenha, strMsgAdd: String;
    objLiberacao: TLiberacao;
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If Not cdsDocumentos.IsEmpty Then
  Begin
    blnConfirma := True;

    If (FDtaHorBai = opcFinal) Then
    Begin
      Try
        pCriarFormularios(TfrmDigDataHora, frmDigDataHora);

        If (cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime <> 0) Then
          frmDigDataHora.mskData__.Text := FormatDateTime('DD/MM/YYYY', IIF(strTipRom = '1', cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime, fGetMaiorDataRomaneio));

        If (cdsDocumentos.FieldByName('GER_HORROM').AsDateTime <> 0) Then
          frmDigDataHora.mskHora__.Text := FormatDateTime('HH:MM', IIF(strTipRom = '1', cdsDocumentos.FieldByName('GER_HORROM').AsDateTime, fGetMaiorHoraRomaneio));

        frmDigDataHora.ShowModal;
        blnConfirma := frmDigDataHora.blnConfirma;

        If (blnConfirma) Then
        Begin
          dtaDtaBai := StrToDate(frmDigDataHora.mskData__.Text);
          timHorBai := StrToTime(frmDigDataHora.mskHora__.Text);

          If (dtaDtaBai > 0) And
             (dtaDtaBai < IIF(strTipRom = '1', cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime, fGetMaiorDataRomaneio)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A data da baixa deve ser maior ou igual que a data do romaneio!', ['&O k']);
            blnConfirma := False;
          End;

          If (timHorBai > 0) And (blnConfirma) And
             (dtaDtaBai = IIF(strTipRom = '1', cdsDocumentos.FieldByName('GER_DTAROM').AsDateTime, fGetMaiorDataRomaneio)) And
             (timHorBai < IIF(strTipRom = '1', cdsDocumentos.FieldByName('GER_HORROM').AsDateTime, fGetMaiorHoraRomaneio)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A hora da baixa deve ser maior ou igual que a hora do romaneio!', ['&O k']);
            blnConfirma := False;
          End;

          If blnConfirma Then
            blnConfirma := fGravaDataGeral(opcGeral, dtaDtaBai, timHorBai)
          Else
          Begin
            pFreeAndNil(frmDigDataHora);
            btnConfirmaClick(btnConfirma);
            Exit;
          End;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmFatBaixaRomaneio.btnConfirmaClick]');
          blnConfirma := False;
        End;
      End;

      pFreeAndNil(frmDigDataHora);
    End
    Else If (FDtaHorBai = opcDocumento) Then
    Begin
      blnConfirma := fTodasDataHoraDigitada;

      If (Not blnConfirma) Then
      Begin
        If blnFocaData Then
          pSetFocus(mskDtaBai)
        Else
          pSetFocus(mskHorBai);
      End;
    End;

    // Quando o campo "Recebido por" é obrigatório
    if blnConfirma and blnRecebidoPorObrig and (fHaDocumentosSemInformarRecebidoPor) then
    begin
      lblRecebidoPorObrig.Visible := True;
      strMsgAdd := EmptyStr;

      if fPergunta('Há documento(s) que ainda não foram informados o campo ''Recebido por''. Deseja continuar?') then
      begin
        if ffrmSenha(strSenha) and (strSenha = fCfgSis('SNBXRM', varString)) then
        begin
          if not fVerificaAcessoSistema('RPNLBXRM') then
          begin
            try
              objLiberacao := TLiberacao.Create;
              objLiberacao.Clear;
              objLiberacao.strDirAce    := 'RPNLBXRM';
              objLiberacao.strCodOpe    := strLoginUsuarioLogado;
              objLiberacao.strCodDig    := strLoginUsuarioLogado;
              objLiberacao.objMsgLibera.pAddTexto('Informar "Recebido por" nulo na baixa de romaneio.');

              blnConfirma := objLiberacao.fLibera;
            finally
              FreeAndNil(objLiberacao);
            end;
          end;
        end
        else
        begin
          blnConfirma := False;
          strMsgAdd := 'Senha inválida.' + sLineBreak;
        end;
      end
      else
        blnConfirma := False;

      if not blnConfirma then
        fMensagem('ATENÇÃO!', strMsgAdd +'É obrigatório informar "Recebido por" nos romaneios marcados.', ['&O k']);
    end;
    //

    If (blnConfirma) Then
    Begin

      If fMensagem('', 'Confirma a baixa do romaneio ' + edtNumRom.Text + '?', ['&Sim', '&Não']) = 2 Then
        Exit;

      If fConfirmaBaixa Then
      Begin
        fMensagem('', 'Baixa concluída com sucesso!', ['&Ok']);
        pCancelarBaixa;
      End;
    End;
  End
  Else
    fMensagem('', 'Não existem documentos para serem baixados!', ['&Ok']);
end;

procedure TfrmFatBaixaRomaneio.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaRomaneio.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    pCarregaCadMot;
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaRomaneio.edtNomRecEnter(Sender: TObject);
begin
  inherited;

  lblRecPor.Visible := True;
  pnlRecPor.Height  := 45;
end;

procedure TfrmFatBaixaRomaneio.edtNomRecExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(edtNomRec, True);
  lblRecPor.Visible := False;
  pnlRecPor.Height  := 28;
end;

procedure TfrmFatBaixaRomaneio.edtNumRomKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen: TUniQuery;
    arrSel   : TConsultasArray;
begin
  inherited;

  If (edtNumRom.ReadOnly) Then
    Exit;

  qryConGen := fCriaQuery(Self);

  If fPesqRomaneio(Self, edtNumRom, qryConGen, Key, arrSel, '', True, True, 'Consulta de Romaneios', True, Not edtCodEmp.Visible) Then
  Begin
    If edtCodEmp.Visible Then
    Begin
      edtCodEmp.Text := qryConGen.FieldByName('GER_EMPROM').AsString;
      If fValidaCampos(edtCodEmp, True) Then
        pSetFocus(cxgDocumentos);
    End
    Else
    Begin
      If fValidaCampos(edtNumRom, True) Then
        pSetFocus(cxgDocumentos);
    End;
  End;

  FreeAndNil(qryConGen);
end;

procedure TfrmFatBaixaRomaneio.pCarregaCadEmp;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
    edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text)
  Else
    edtNomEmp.Clear;
end;

procedure TfrmFatBaixaRomaneio.pCarregaCadMot;
begin
  If Not fEmptyStr(edtCodMot.Text) Then
    edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text)
  Else
    edtNomMot.Clear;
end;

procedure TfrmFatBaixaRomaneio.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatBaixaRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (Not cdsDocumentos.IsEmpty) And (fMensagem('', 'Cancelar a baixa do romaneio ' + edtNumRom.Text + '?', ['&Sim', '&Não']) = 2) Then
  Begin
    Action := caNone;
    Exit;
  End;

  if Assigned(objRomFusTarefas) then
    FreeAndNil(objRomFusTarefas);
end;

procedure TfrmFatBaixaRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    If (Not cdsDocumentos.IsEmpty) And (fMensagem('', 'Cancelar a baixa do romaneio ' + edtNumRom.Text + '?', ['&Sim', '&Não']) = 2) Then
    Begin
      Abort;
    End;
    pCancelarBaixa;
  end
  else
  begin
    inherited;
    If Key = VK_F10 Then
    Begin
      Key := 0;
      btnConfirma.Click;
    End;
  end;
end;

procedure TfrmFatBaixaRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Visible := fCfgSis('BXROEM', varBoolean);
  lblCodEmp.Visible := edtCodEmp.Visible;
  edtNomEmp.Visible := edtCodEmp.Visible;

  If edtCodEmp.Visible Then
  Begin
    edtCodEmp.Text := VS_strCodEmp;
    pCarregaCadEmp;
  End;

  If fCfgSis('TIPROM') = '1' Then
  Begin
    edtNomMot.Left    := edtCodMot.Left;
    edtNomMot.Width   := edtNomMot.Width + edtCodMot.Width +2;
    edtCodMot.Visible := False;
    lblMotorista.Top  := 38;
    edtNomMot.Top     := 51;
    pSetFocus(edtNumRom);
  End
  Else
  Begin
    edtNumRom.Visible   := False;
    lblRomaneio.Visible := False;
    If edtCodEmp.Visible Then
    Begin
      lblCodEmp.Left  := lblMotorista.Left;
      edtCodEmp.Left  := edtCodMot.Left;
      edtNomEmp.Left  := edtNomMot.Left;
      edtNomEmp.Width := edtNomMot.Width;
    End
    Else
    Begin
      lblMotorista.Top  := 21;
      edtNomMot.Top     := 34;
      edtCodMot.Top     := 34;
    End;
    pSetFocus(edtCodMot);
  End;

  FDtaHorBai := TDataHoraBaixa(fCfgSis('DTBARO', varInteger) - 1);

  pnlDtaBai.Visible := (FDtaHorBai = opcDocumento);

  cxgDocumentosGER_DTABAI.Visible := (FDtaHorBai = opcDocumento);
  cxgDocumentosGER_HORBAI.Visible := (FDtaHorBai = opcDocumento);
  cxgDocumentosGER_NOMREC.Visible := (FDtaHorBai = opcDocumento);

  strTipRom := fCfgSis('TIPROM');
  blnFocaData := False;
  blnRecebidoPorObrig := fCfgSis('RPBXRM', varBoolean);

  cdsDocumentos.AfterScroll := pAfterScroll;
  pnlEntPen.Visible := ((fCfgSis('BAROPA', varBoolean)) And (strTipRom = '1'));
  chkEntPen.OnClick := pChkEntPenClick;

  objRomFusTarefas := TRomaneioTarefasFusion.Create(Self);
end;

function TfrmFatBaixaRomaneio.fGerarNovoPreRomaneio(Var strRomNov: String;
  strNumRom, strEmpRom, strNumDoc, strEspDoc,  strCodEmp: String): Boolean;
  Var
    qryUpd: TUniQuery;
    qryGer: TUniQuery;
    qryDet: TUniQuery;
    intCnt: Integer;
    strFieldName : String;

  procedure pSetaParametrosUpdate(qry: TUniQuery);
  begin
    If qry.FindParam('ROMNOV') <> Nil Then
      qry.ParamByName('ROMNOV').AsString := strRomNov;

    If qry.FindParam('NUMROM') <> Nil Then
      qry.ParamByName('NUMROM').AsString := strNumRom;

    If qry.FindParam('EMPROM') <> Nil Then
      qry.ParamByName('EMPROM').AsString := strEmpRom;

    If qry.FindParam('NUMDOC') <> Nil Then
      qry.ParamByName('NUMDOC').AsString := strNumDoc;

    If qry.FindParam('ESPDOC') <> Nil Then
      qry.ParamByName('ESPDOC').AsString := strEspDoc;

    If qry.FindParam('CODEMP') <> Nil Then
      qry.ParamByName('CODEMP').AsString := strCodEmp;
  end;

begin
  Result := True;

  If fEmptyStr(strRomNov) Then
    strRomNov := fAtualizaProCod('ROMGERX', 'GER_NUMROM');

  qryUpd := fCriaQuery(Self);
  qryGer := fCriaQuery(Self);
  qryDet := fCriaQuery(Self);
  fStartTransaction;
  Try
    Try
      With qryGer Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM ROMGERX ');
        SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
        SQL.Add('    AND GER_EMPROM = :EMPROM ');
        SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
        SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
        SQL.Add('    AND GER_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(qryGer);
        Open;
      end;

      With qryDet Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM ROMDETX ');
        SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
        SQL.Add('    AND DET_EMPROM = :EMPROM ');
        SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
        SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
        SQL.Add('    AND DET_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(qryDet);
        Open;
      end;

      qryUpd.Close;
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add(' DELETE ');
      qryUpd.SQL.Add('   FROM ROMGERX ');
      qryUpd.SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
      qryUpd.SQL.Add('    AND GER_EMPROM = :EMPROM ');
      qryUpd.SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
      qryUpd.SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
      qryUpd.SQL.Add('    AND GER_CODEMP = :CODEMP ');
      pSetaParametrosUpdate(qryUpd);
      qryUpd.ExecSQL;

      qryUpd.Close;
      qryUpd.SQL.Text := 'SELECT * FROM ROMGERX WHERE FALSE ';
      qryUpd.Open;

      qryUpd.Append;
      For intCnt := 0 To qryUpd.FieldCount-1 Do
      Begin
        strFieldName := qryUpd.Fields[intCnt].FieldName;
        If qryGer.FindField(  strFieldName ) <> Nil Then
          qryUpd.FieldByName( strFieldName ).Value := qryGer.FieldByName(  strFieldName ).Value;
      End;
      qryUpd.FieldByName('GER_NUMROM').AsString := strRomNov;
      qryUpd.FieldByName('GER_STATUS').AsString := 'P';
      qryUpd.FieldByName('GER_CODREG').Value := Null;
      qryUpd.FieldByName('GER_FRETE_').AsFloat := 0;
      qryUpd.FieldByName('GER_ADIFRE').AsFloat := 0;
      qryUpd.FieldByName('GER_PERFRE').AsFloat := 0;
      qryUpd.Post;

      qryUpd.Close;
      qryUpd.SQL.Text := 'SELECT * FROM ROMDETX WHERE FALSE ';
      qryUpd.Open;

      qryDet.First;
      While Not qryDet.Eof Do
      Begin
        qryUpd.Append;
        For intCnt := 0 To qryUpd.FieldCount-1 Do
        Begin
          strFieldName := qryUpd.Fields[intCnt].FieldName;
          If qryDet.FindField(  strFieldName ) <> Nil Then
            qryUpd.FieldByName( strFieldName ).Value := qryDet.FieldByName(  strFieldName ).Value;
        End;
        qryUpd.FieldByName('DET_NUMROM').AsString := strRomNov;
        qryUpd.Post;

        qryDet.Next;
      End;

      qryUpd.Close;
      qryUpd.SQL.Text := ' UPDATE FATGOR ' +
                         '   SET FGO_NUMROM = :ROMNOV ' +
                         ' WHERE FGO_NUMROM = :NUMROM AND ' +
                         '       FGO_NUMDOC = :NUMDOC AND ' +
                         '       FGO_ESPDOC = :ESPDOC AND ' +
                         '       FGO_CODEMP = :CODEMP     ' ;

      pSetaParametrosUpdate(qryUpd);
      qryUpd.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmFatBaixaRomaneio.fGerarNovoPreRomaneio]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryGer);
    FreeAndNil(qryDet);
  End;
end;

end.
