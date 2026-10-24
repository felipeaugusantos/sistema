unit untAgrupSelFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Uni, untFuncoesSimples;

type
  TfrmAgrupSelFornecedor = class(TfrmPai)
    pnlCentro: TPanel;
    grdFornecedores: TcxGridCitel;
    grdFornecedoresDados: TcxGridDBTableViewCitel;
    grdFornecedoresDadosFOR_CODFOR: TcxGridDBColumn;
    grdFornecedoresDadosFOR_NOMFOR: TcxGridDBColumn;
    grdFornecedoresDadosFOR_NOMFAN: TcxGridDBColumn;
    grdFornecedoresDadosFOR_C_G_C_: TcxGridDBColumn;
    grdFornecedoresDadosFOR_I_E_S_: TcxGridDBColumn;
    grdFornecedoresDadosMCA_MARDES: TcxGridDBColumn;
    grdFornecedoresDadosMCA_RESCAI: TcxGridDBColumn;
    grdFornecedoresDadosMCA_DTATRA: TcxGridDBColumn;
    grdFornecedoresNivel: TcxGridLevel;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryFornecedores: TUniQuery;
    dtsFornecedores: TDataSource;

    procedure pCriaTemporaria;
  public
    { Public declarations }
    strCNPJ,
    strCodFor: String;
  end;

implementation

{$R *.dfm}

procedure TfrmAgrupSelFornecedor.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If grdFornecedoresDAdos.DataController.GetSelectedCount = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um fornecedor para continuar!', ['&OK'], 0);
    Exit;
  End;

  ModalResult := mrOK;
  strCodFor := grdFornecedoresDAdos.DataController.GridView.FindItemByName('grdFornecedoresDadosFOR_CODFOR').EditValue;
end;

procedure TfrmAgrupSelFornecedor.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmAgrupSelFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(dtsFornecedores);
  FreeAndNil(qryFornecedores);
end;

procedure TfrmAgrupSelFornecedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    btnConfirma.Click;

  If Key = VK_Escape Then
    btnSair.Click;
end;

procedure TfrmAgrupSelFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  pCriaTemporaria;

  pSetFocus(grdFornecedores);
end;

procedure TfrmAgrupSelFornecedor.pCriaTemporaria;
begin
  qryFornecedores := fCriaQuery;
  qryFornecedores.SQL.Add('SELECT FOR_CODFOR, FOR_NOMFOR, FOR_NOMFAN, ');
  qryFornecedores.SQL.Add('       FOR_C_G_C_, FOR_I_E_S_              ');
  qryFornecedores.SQL.Add('FROM CADFOR                                ');
  qryFornecedores.SQL.Add('WHERE FOR_C_G_C_ LIKE :PARTECNPJ           ');

  qryFornecedores.ParamByName('PARTECNPJ').AsString := strCNPJ + '%';
  qryFornecedores.Open;

  dtsFornecedores         := TDataSource.Create(Self);
  dtsFornecedores.DataSet := qryFornecedores;

  grdFornecedoresDados.DataController.DataSource := dtsFornecedores;
end;

end.
