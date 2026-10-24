unit untMetaCompDepVendDocsDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  cxCheckBox;

type
  TfrmMetaCompDepVendDocsDevolucao = class(TfrmPaiEdit)
    Panel1: TPanel;
    btnAdicionar: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    grdDocsDevTv: TcxGridDBTableViewCitel;
    grdDocsDevLvl: TcxGridLevel;
    grdDocsDev: TcxGridCitel;
    dtsDocsDev: TDataSource;
    grdDocsDevTvSELECIONADO: TcxGridDBColumn;
    grdDocsDevTvDOCUME: TcxGridDBColumn;
    grdDocsDevTvCODEMP: TcxGridDBColumn;
    grdDocsDevTvCLIENTE: TcxGridDBColumn;
    grdDocsDevTvDTAEMI: TcxGridDBColumn;
    grdDocsDevTvVALDOC: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsDocsDev: TUniClientDataSet;
  end;

implementation

uses
  untFuncoesSimples, untMetaCompDepVendConsultaDocsDevolucao;

{$R *.dfm}

procedure TfrmMetaCompDepVendDocsDevolucao.btnAdicionarClick(Sender: TObject);
var
  frmMetaCompDepVendConsultaDocsDevolucao: TfrmMetaCompDepVendConsultaDocsDevolucao;
  I: Integer;
begin
  inherited;
  pCriarFormularios(TfrmMetaCompDepVendConsultaDocsDevolucao, frmMetaCompDepVendConsultaDocsDevolucao);
  Try
    if frmMetaCompDepVendConsultaDocsDevolucao.ShowModal = MrOk then
    begin
      frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.First;
      while not frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.Eof do
      begin
        if not cdsDocsDev.Locate(
          'DEV_NUMDOC;DEV_ESPDOC;DEV_CODEMP',
          VarArrayOf([
            frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.FieldByName('DEV_NUMDOC').AsString,
            frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.FieldByName('DEV_ESPDOC').AsString,
            frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.FieldByName('DEV_CODEMP').AsString]),
          []) then
        begin
          cdsDocsDev.Append;
          for I := 0 to Pred(cdsDocsDev.Fields.Count) do
            cdsDocsDev.Fields[I].Value := frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.FieldByName(cdsDocsDev.Fields[I].FieldName).Value;

          cdsDocsDev.FieldByName('SELECIONADO').AsBoolean := False;
          cdsDocsDev.Post;
        end;

        frmMetaCompDepVendConsultaDocsDevolucao.cdsDocsDev.Next;
      end;
    end;
  Finally
    pFreeAndNil(frmMetaCompDepVendConsultaDocsDevolucao);
  End;
end;

procedure TfrmMetaCompDepVendDocsDevolucao.btnRemoverClick(Sender: TObject);
begin
  inherited;
  cdsDocsDev.DisableControls;
  try
    cdsDocsDev.Filtered := False;
    cdsDocsDev.Filter := 'SELECIONADO = TRUE';
    cdsDocsDev.Filtered := True;

    if cdsDocsDev.IsEmpty then
      fMensagem('ATENÇÃO!', 'Necessário selecionar pelo menos um Documento!', ['&Ok'])
    else
    begin
      while not cdsDocsDev.IsEmpty do
        cdsDocsDev.Delete;
    end;

  finally
    cdsDocsDev.Filtered := False;
    cdsDocsDev.First;
    cdsDocsDev.EnableControls;
  end;
end;

procedure TfrmMetaCompDepVendDocsDevolucao.FormShow(Sender: TObject);
begin
  inherited;
  dtsDocsDev.DataSet := cdsDocsDev;
end;

end.
