unit Fulfillment.View.NotasFulfillmentPat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untFrameDirectoryEditFocus, Fulfillment.Classes.NotasFulfillment,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  cxCurrencyEdit;

type
  TfrmNotasFulfillmentPat = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    fraPathXml: TfraDirectoryEditFocus;
    cxvZip: TcxGridDBTableView;
    cxgZipLevel1: TcxGridLevel;
    cxgZip: TcxGrid;
    cxvZipColumn1: TcxGridDBColumn;
    cxvZipColumn2: TcxGridDBColumn;
    cxvZipColumn3: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnQtdXML: TBitBtn;
    dtsArquivos: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnQtdXMLClick(Sender: TObject);
  private
    { Private declarations }
    objNotas: TNotasFulfillment;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples,
  Fulfillment.View.NotasFulfillmentGrid;

procedure TfrmNotasFulfillmentPat.btnConfirmaClick(Sender: TObject);
  Var
    frmNotasFulfillmentGrid: TfrmNotasFulfillmentGrid;
begin
  If Not objNotas.fTemArquivoSelecionado Then
    Exit;

  If Not objNotas.fCarregaArquivosXML Then
    Exit;

  pCriarFormularios(TfrmNotasFulfillmentGrid, frmNotasFulfillmentGrid);

  Try
    frmNotasFulfillmentGrid.objNotas := objNotas;
    frmNotasFulfillmentGrid.ShowModal;
  Finally
    pFreeAndNil(frmNotasFulfillmentGrid);
  End;
end;

procedure TfrmNotasFulfillmentPat.btnQtdXMLClick(Sender: TObject);
begin
  inherited;

  objNotas.pOpenSelecionados;
end;

procedure TfrmNotasFulfillmentPat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult <> mrOk Then
  Begin

     If Not fPergunta('Deseja abandonar a tarefa?') Then
       Action := caNone;

  End;

end;

procedure TfrmNotasFulfillmentPat.FormCreate(Sender: TObject);
begin
  inherited;

  objNotas := TNotasFulfillment.Create(Self);

  dtsArquivos.DataSet := objNotas.cdsArquivosZip;
end;

procedure TfrmNotasFulfillmentPat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5 : btnQtdXML.Click;
    VK_F10: btnConfirma.Click;
  End;
end;

function TfrmNotasFulfillmentPat.fValidaCampos(Sender: TWinControl;
         blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = fraPathXml.edtDirectory) Then
    Begin
      fraPathXml.edtDirectory.Text := Trim(fraPathXml.edtDirectory.Text);

      If fEmptyStr(fraPathXml.edtDirectory.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o pasta de importação de arquivos!', ['&Ok']);
        Result := FALSE;
      End

      Else If Not DirectoryExists(fraPathXml.edtDirectory.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pasta não econtrada!', ['&Ok']);
        Result := FALSE;
      End

      Else If blnBuscaPorChave Then
      Begin
        Result := objNotas.fCarregaArquivosZip(fraPathXml.edtDirectory.Text);
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

