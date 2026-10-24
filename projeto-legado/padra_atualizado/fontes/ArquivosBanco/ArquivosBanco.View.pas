unit ArquivosBanco.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  Datasnap.DBClient, UniClientDataSet, cxGridCustomView, cxGridCustomTableView,
  cxGridWinExplorerView, cxGridDBWinExplorerView, cxClasses, cxGridLevel,
  cxGrid, cxGridCitel, untFuncoesSimples,
  ArquivosBanco.Interfaces, cxDBEdit,
  System.ImageList, Vcl.ImgList, cxImageList;

type
  TfrmArquivosBanco = class(TfrmPaiConfirma)
    grdArquivosLvl: TcxGridLevel;
    grdArquivos: TcxGridCitel;
    cdsArquivos: TUniClientDataSet;
    btnIncluir: TBitBtnLocked;
    cdsArquivosAUTINC: TStringField;
    cdsArquivosARQUIV: TBlobField;
    cdsArquivosARQB64: TStringField;
    cdsArquivosNOMARQ: TStringField;
    dtsArquivos: TDataSource;
    grdArquivosWev: TcxGridDBWinExplorerView;
    grdArquivosWevNOMARQ: TcxGridDBWinExplorerViewItem;
    imlThumb: TcxImageList;
    cdsArquivosIDXIMAGE: TIntegerField;
    grdArquivosWevIIDXIMG: TcxGridDBWinExplorerViewItem;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure grdArquivosWevCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grdArquivosWevKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FTipoArquivo: IArquivosBancoInterface;
    procedure pCarregaArquivos;
    procedure pGravaArquivo;
    procedure pVisualizarArquivo;
    procedure pExcluirArquivo;
    function fSelecionaArquivo(strInitialDir, strFilter: String; opoOpenOptions: TOpenOptions): String;
  public
    { Public declarations }
    class procedure pShowArquivos(ATipoArquivo: IArquivosBancoInterface);
  end;

implementation

uses
  untGravando, ArquivosBanco.Funcoes;

{$R *.dfm}

{ TfrmArquivosBanco }

procedure TfrmArquivosBanco.btnIncluirClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pGravaArquivo, 'Aguarde, importando arquivo...', '');
  TfrmGravando.fExecutarModalA(pCarregaArquivos, 'Aguarde, recarregando arquivos...', '');
end;

procedure TfrmArquivosBanco.grdArquivosWevCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pVisualizarArquivo
end;

procedure TfrmArquivosBanco.grdArquivosWevKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    pVisualizarArquivo
  Else If (Key = VK_DELETE) Then
    TfrmGravando.fExecutarModalA(pExcluirArquivo, 'Aguarde, excluindo arquivo...', '');
end;

procedure TfrmArquivosBanco.FormCreate(Sender: TObject);
begin
  inherited;
  cdsArquivos.CreateDataSet;
end;

procedure TfrmArquivosBanco.pCarregaArquivos;
begin
  FTipoArquivo.pCarregaArquivos(cdsArquivos);
end;

procedure TfrmArquivosBanco.pExcluirArquivo;
begin
  if (cdsArquivos.isEmpty) Then
    Exit;

  If (fMensagem('','Deseja realmente excluir o arquivo?', ['','']) <> 1) Then
    Exit;

  FTipoArquivo.pExcluirArquivo(cdsArquivosAUTINC.AsString);
  cdsArquivos.Delete;
end;

procedure TfrmArquivosBanco.pGravaArquivo;
var
  strCaminhoArquivoOrigem: String;
begin
  inherited;
  strCaminhoArquivoOrigem := fSelecionaArquivo('', FTipoArquivo.fFileOpenFilter, [ofFileMustExist]);
  If Not fEmptyStr(strCaminhoArquivoOrigem) Then
    FTipoArquivo.pGravaArquivo(strCaminhoArquivoOrigem);
end;

class procedure TfrmArquivosBanco.pShowArquivos(ATipoArquivo: IArquivosBancoInterface);
var
  LfrmArquivosBanco: TfrmArquivosBanco;
begin
  Try
    pCriarFormularios(TfrmArquivosBanco, LfrmArquivosBanco);
    LfrmArquivosBanco.FTipoArquivo := ATipoArquivo;
    LfrmArquivosBanco.Caption := ATipoArquivo.fTitulo;

    LfrmArquivosBanco.FTipoArquivo.fThumbList(LfrmArquivosBanco.imlThumb);

    TfrmGravando.fExecutarModalA(LfrmArquivosBanco.pCarregaArquivos, 'Aguarde, carregando arquivos...', '');

    LfrmArquivosBanco.ShowModal;
  Finally
     pFreeAndNil(LfrmArquivosBanco);
  end;
end;

procedure TfrmArquivosBanco.pVisualizarArquivo;
var
  mmStream: TMemoryStream;
begin
  mmStream := TMemoryStream.Create;
  Try
    cdsArquivosARQUIV.SaveToStream(mmStream);

    TArquivoBancoFuncoes.pAbrirArquivo(mmStream, cdsArquivosNOMARQ.AsString);
  Finally
    FreeAndNil(mmStream);
  End;

end;

function TfrmArquivosBanco.fSelecionaArquivo(strInitialDir, strFilter : String; opoOpenOptions : TOpenOptions ) : String;
Var
  objOpenDialog : TOpenDialog;
Begin
  Result := '';
  objOpenDialog := TOpenDialog.Create(nil);
  Try
    if strInitialDir <> '' Then
      objOpenDialog.InitialDir :=  strInitialDir;

    if strFilter <> '' Then
      objOpenDialog.Filter :=  strFilter;

    objOpenDialog.Options := opoOpenOptions;

    If objOpenDialog.Execute Then
      Result := objOpenDialog.FileName;
  Finally
    If Assigned(objOpenDialog) Then FreeAndNil(objOpenDialog);
  End;
End;

end.
