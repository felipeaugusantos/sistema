unit untConsultaArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiConfirma, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untArquivamento, cxButtonEdit, cxLabel,
  cxTextEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImage,
  System.ImageList, Vcl.ImgList, cxImageList, System.Actions, Vcl.ActnList, ArquivosBanco.Funcoes;

type
  TfrmConsultaArquivo = class(TfrmPai)
    cxgArquivLevel: TcxGridLevel;
    cxgArquivView: TcxGridDBTableViewCitel;
    cxgArquiv: TcxGridCitel;
    cxgArquivViewCAT_DESCRI: TcxGridDBColumn;
    cxgArquivViewARQ_NOMARQ: TcxGridDBColumn;
    cxgArquivViewARQ_DTAIMP: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    btnExportar: TBitBtnLocked;
    cxgArquivViewABRARQ: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure cxgArquivViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure cxgArquivViewABRARQPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    objArquivamento : TArquivamento;
    dtsArquiv       : TDataSource;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaArquivo: TfrmConsultaArquivo;

implementation

{$R *.dfm}

uses untFuncoesSimples;


procedure TfrmConsultaArquivo.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not objArquivamento.fDeletaArquivo then
    pMensagemOk('Não foi possível excluir o arquivo selecionado!');
end;

procedure TfrmConsultaArquivo.btnExportarClick(Sender: TObject);
begin
  inherited;
  if objArquivamento.fExportarArquivo then
    pMensagemOk('Arquivo exportado com sucesso!');
end;

procedure TfrmConsultaArquivo.cxgArquivViewABRARQPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var stream: TMemoryStream;
    ArquivoBancoFuncoes: TArquivoBancoFuncoes;
begin
  inherited;
  Try
    stream := TMemoryStream.Create;
    ArquivoBancoFuncoes := TArquivoBancoFuncoes.Create;
    stream.WriteData(TBlobField(objArquivamento.cdsArquiv.FieldByName('ARQ_ARQUIV') as TBlobField).AsBytes,
                     Length(TBlobField(objArquivamento.cdsArquiv.FieldByName('ARQ_ARQUIV') as TBlobField).AsBytes));
    ArquivoBancoFuncoes.pAbrirArquivo(stream, objArquivamento.cdsArquiv.FieldByName('ARQ_NOMARQ').AsString);
  Finally
    FreeAndNil(stream);
    FreeAndNil(ArquivoBancoFuncoes);
  End;

end;

procedure TfrmConsultaArquivo.cxgArquivViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DELETE : btnExcluir.Click;
    VK_F1     : btnExportar.click;
    VK_ESCAPE : btnSair.click;
  end;
end;

procedure TfrmConsultaArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  objArquivamento := TArquivamento.Create(Self);
  objArquivamento.pOpenArquiv;

  dtsArquiv         := TDataSource.Create(Self);
  dtsArquiv.DataSet := objArquivamento.cdsArquiv;

  cxgArquivView.DataController.Datasource := dtsArquiv;
end;

end.
