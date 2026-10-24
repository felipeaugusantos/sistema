unit untEntradaAutomatizadaImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untEntradaAutomatizada;

type
  TfrmEntradaAutomatizadaImportacao = class(TfrmPai)
    cxNotas: TcxGridDBTableView;
    cxLNotas: TcxGridLevel;
    cxgNotas: TcxGrid;
    dtsNotas: TDataSource;
    cxNotaCODEMP: TcxGridDBColumn;
    cxNotasNUMDOC: TcxGridDBColumn;
    cxNotasESPDOC: TcxGridDBColumn;
    cxNotasSERIE_: TcxGridDBColumn;
    cxNotasCODFOR: TcxGridDBColumn;
    cxNotasNUMFOR: TcxGridDBColumn;
    cxNotasDTAENT: TcxGridDBColumn;
    cxNotasSITPRE: TcxGridDBColumn;
    cxNotasSITNOT: TcxGridDBColumn;
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    shpPreNota: TShape;
    lblLegendaPrenota: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    cxNotasCONFER: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure pAbreQuery;
    procedure cxNotasCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    blnUsaPreNota : Boolean;
    blnUsaConferencia: Boolean;
    const cOk = 'OK';
          cSemPreNota = 'SEM PRÉNOTA';
          cSemNota =  'SEM XML';
          cSemConferencia = 'SEM CONFERÊNCIA';

    function fUsaPreNota: Boolean;
    function fRegistroOk(var strMensagem: string): Boolean;
    function fValidaNotaXML: Boolean;
    function fValidaConferencia: Boolean;
    function fValidaPreNota: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  var frmEntradaAutomatizadaImportacao: TfrmEntradaAutomatizadaImportacao;

implementation

uses
  untFuncoesSimples, untEntDigPedido;

{$R *.dfm}

procedure TfrmEntradaAutomatizadaImportacao.btnConfirmaClick(Sender: TObject);
var strMensagem: String;
begin
  inherited;

  If Not fRegistroOk(strMensagem) Then
  Begin
    pMensagemOk(strMensagem);
    Exit;
  End;
  {}

  pCriarFormularios(TfrmEntDigPedido, frmEntDigPedido);

  frmEntDigPedido.pCarregaNotaImportacao(qryTabela.FieldByName('AUTINC_GERELE').AsString);

  If frmEntDigPedido.blnEntradaEfetivada Then
    pAbreQuery;


  //TEntradaAutomatizada.pCarregaNotas(qryTabela.FieldByName('AUTINC_GERELE').AsString);

end;

procedure TfrmEntradaAutomatizadaImportacao.cxNotasCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clGreen;
  If blnUsaConferencia Then
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxNotasCONFER.Index]) = cSemConferencia Then
      ACanvas.Font.Color := clMaroon;
  If blnUsaPreNota Then
  begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxNotasSITPRE.Index]) = cSemPreNota Then
      ACanvas.Font.Color := clFuchsia
  End;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxNotasSITNOT.Index]) = cSemNota Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmEntradaAutomatizadaImportacao.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := fCriaQuery;
  dtsNotas.DataSet := qryTabela;
end;

procedure TfrmEntradaAutomatizadaImportacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabela);
end;

procedure TfrmEntradaAutomatizadaImportacao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;

end;

procedure TfrmEntradaAutomatizadaImportacao.FormShow(Sender: TObject);
begin
  inherited;
  pAbreQuery;
  If qryTabela.IsEmpty Then
  begin
    pMensagemOk('Não exite Nota de Importação com pendencias.');
    Close;
  end;
  cxNotasSITPRE.Visible := fUsaPreNota;
  lblLegendaPrenota.Visible := blnUsaPreNota;
  shpPreNota.Visible := blnUsaPreNota;
  blnUsaConferencia :=  qryTabela.FieldByname('VALCON').AsString = 'S';
  cxNotasCONFER.Visible := blnUsaConferencia;
end;

function TfrmEntradaAutomatizadaImportacao.fValidaNotaXML: Boolean;
Begin
  Result := True;
  If qryTabela.FieldByName('SITNOT').AsString =  cSemNota Then
    Exit(False);
End;

function TfrmEntradaAutomatizadaImportacao.fValidaConferencia: Boolean;
Begin
  Result := True;
  If Not blnUsaConferencia Then
    Exit;
  If qryTabela.FieldByName('CONFER').AsString = cSemConferencia Then
    Result := False;
End;

function TfrmEntradaAutomatizadaImportacao.fValidaPreNota: Boolean;
Begin
  Result := True;
  If Not blnUsaPreNota Then
    Exit;
  If qryTabela.FieldByName('SITPRE').AsString = cSemPreNota Then
    Result := False;
End;

function TfrmEntradaAutomatizadaImportacao.fRegistroOk(var strMensagem: string): Boolean;
begin
  Result := False;
  strMensagem := '';

  If Not fValidaNotaXML Then
  Begin
    strMensagem := 'Não foi encontrado o XML deste documento, não será possível prosseguir.';
    Exit;
  End;

  If Not fValidaConferencia Then
  Begin
    strMensagem := 'Não foi encontrado a conferência da Pré-Nota, não será possivel continuar.';
    Exit;
  End;

  If Not fValidaPreNota then
  Begin
    strMensagem := 'Não foi encontrado a Pré-Nota, não será possivel continuar.';
    Exit;
  End;

  Result := True;
end;

function TfrmEntradaAutomatizadaImportacao.fUsaPreNota: Boolean;
begin
  Result := True;
  If qryTabela.FieldByName('USACON').AsString = 'N' Then
    Result := False
  Else If qryTabela.FieldByName('CONFME').AsInteger = 2 Then
    Result := False;

  blnUsaPreNota := Result;
end;

procedure TfrmEntradaAutomatizadaImportacao.pAbreQuery;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT NOTGER.GER_CODEMP,');
  qryTabela.SQL.Add('       GER_NUMDOC,');
  qryTabela.SQL.Add('       GER_ESPDOC,');
  qryTabela.SQL.Add('       GER_SERIE_,');
  qryTabela.SQL.Add('       NOTGER.GER_CODFOR,');
  qryTabela.SQL.Add('       FOR_NOMFOR,');
  qryTabela.SQL.Add('       PCMGER.AUTOINCREM AS PEDIDO,');
  qryTabela.SQL.Add('       NOTGER.AUTOINCREM,');
  qryTabela.SQL.Add('       GER_DTAENT,');
  qryTabela.SQL.Add('       IF(IFNULL(GERELE.AUTOINCREM, "") = "", "'+cSemNota+'", "'+cOk+'") AS SITNOT,');
  qryTabela.SQL.Add('       GERELE.AUTOINCREM AS AUTINC_GERELE,');
  qryTabela.SQL.Add('       IF(CONFME.SIS_VALCFG IN(1,3), IF(USACON.SIS_VALCFG = "S", IF(IFNULL(PEDELE.AUTOINCREM, "") = "", "'+cSemPreNota+'", "'+cOk+'"), "'+cOk+'") , "'+cOk+'") AS SITPRE,');
  qryTabela.SQL.Add('       PEDELE.AUTOINCREM,');
  qryTabela.SQL.Add('       CONFME.SIS_VALCFG AS CONFME,');
  qryTabela.SQL.Add('       USACON.SIS_VALCFG AS USACON,');
  qryTabela.SQL.Add('       TIPPNT.SIS_VALCFG AS TIPPNT,');
  qryTabela.SQL.Add('       IF((TIPPNT.SIS_VALCFG = "A")  AND (USACON.SIS_VALCFG = "S") AND (CONFME.SIS_VALCFG IN(1,3)), "S", "N") AS VALCON,');
  qryTabela.SQL.Add('       IF((USACON.SIS_VALCFG = "S") AND (CONFME.SIS_VALCFG IN (1, 3)), IF(IFNULL(GER_DTACON, "") = "", "'+cSemConferencia+'", "'+cOk+'"), "'+cOk+'") AS CONFER');
  qryTabela.SQL.Add('  FROM DOCIMP');
  qryTabela.SQL.Add(' INNER JOIN NOTDET ON NOTDET.AUTOINCREM = IMP_SEQDET');
  qryTabela.SQL.Add(' INNER JOIN NOTGER ON NOTGER.AUTOINCREM = NOTDET.DET_SEQGER');
  qryTabela.SQL.Add('  LEFT JOIN GERELE ON B08_NNF = GER_NUMDOC');
  qryTabela.SQL.Add('                 AND GERELE.GER_CODFOR = NOTGER.GER_CODFOR');
  qryTabela.SQL.Add('                  AND GERELE.B07_SERIE = NOTGER.GER_SERIE_');
  qryTabela.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = NOTGER.GER_CODFOR');
  qryTabela.SQL.Add('  LEFT JOIN PCMGER ON PCG_JAEMIT = 1');
  qryTabela.SQL.Add('                  AND PCG_DTAEMI = GER_DTAENT');
  qryTabela.SQL.Add('                  AND PCG_DOCEMI = GER_NUMDOC');
  qryTabela.SQL.Add('                  AND PCG_ESPEMI = GER_ESPDOC');
  qryTabela.SQL.Add('                  AND PCG_SEREMI = GER_SERIE_');
  qryTabela.SQL.Add('  LEFT JOIN PEDELE ON PEL_SEQELE = GERELE.AUTOINCREM');
  qryTabela.SQL.Add(' INNER JOIN CFGSIS USACON ON USACON.SIS_CODEMP = NOTGER.GER_CODEMP AND USACON.SIS_CODCFG = "CFG_USACON"');
  qryTabela.SQL.Add(' INNER JOIN CFGSIS CONFME ON CONFME.SIS_CODEMP = NOTGER.GER_CODEMP AND CONFME.SIS_CODCFG = "CFG_CONFME"');
  qryTabela.SQL.Add(' INNER JOIN CFGSIS TIPPNT ON TIPPNT.SIS_CODEMP = NOTGER.GER_CODEMP AND TIPPNT.SIS_CODCFG = "CFG_TIPPNT"');
  qryTabela.SQL.Add(' WHERE IMP_SQMVDT IS NULL');
  qryTabela.SQL.Add('   AND NOTGER.GER_CODEMP = "'+ VS_StrCodEmp+'"');
  qryTabela.SQL.Add(' GROUP BY NOTGER.AUTOINCREM');
  qryTabela.Open;
end;

end.
