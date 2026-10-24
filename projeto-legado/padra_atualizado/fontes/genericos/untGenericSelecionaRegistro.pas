unit untGenericSelecionaRegistro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TRecordField = Record
    strFieldName: String;
    strFieldCaption: String;
  End;

  TArrRecordFields = Array Of TRecordField;


  TfrmGenericSelecionaRegistro = class(TfrmPai)
    cxgDados: TcxGridDBTableView;
    cxlDados: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    btnConfirmar: TBitBtnLocked;
    procedure btnConfirmarClick(Sender: TObject);
  protected
    FArrRecordFields:TArrRecordFields;
    blnSelecionado: Boolean;
    procedure pMontaGrid;
    { Private declarations }
  public
    class function fSelecionaRegistro(ArrRecordFields: TArrRecordFields; DataSet: TDataSet; CaptionForm: String): Boolean;
    { Public declarations }
  end;

var
  frmGenericSelecionaRegistro: TfrmGenericSelecionaRegistro;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmGenericSelecionaRegistro }

procedure TfrmGenericSelecionaRegistro.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  blnSelecionado := True;
  Close;
end;

class function TfrmGenericSelecionaRegistro.fSelecionaRegistro(
  ArrRecordFields: TArrRecordFields; DataSet: TDataSet; CaptionForm: String): Boolean;
begin
  pCriarFormularios(TfrmGenericSelecionaRegistro, frmGenericSelecionaRegistro);
  Try
    frmGenericSelecionaRegistro.blnSelecionado := False;
    frmGenericSelecionaRegistro.Caption := CaptionForm;
    frmGenericSelecionaRegistro.FArrRecordFields := ArrRecordFields;
    frmGenericSelecionaRegistro.pMontaGrid;

    frmGenericSelecionaRegistro.dtsDados.DataSet := DataSet;
    frmGenericSelecionaRegistro.ShowModal;
    Result := frmGenericSelecionaRegistro.blnSelecionado;
  Finally
    FreeAndNil(frmGenericSelecionaRegistro);
  End;
end;

procedure TfrmGenericSelecionaRegistro.pMontaGrid;
var RecordField : TRecordField;
    vcont: Integer;
begin
  vcont := 0;
  For RecordField In FArrRecordFields do
  Begin
    cxgDados.CreateColumn;
    cxgDados.Columns[vcont].DataBinding.FieldName := RecordField.strFieldName;
    cxgDados.Columns[vcont].Caption := RecordField.strFieldCaption;
    inc(vcont);
  End;
end;

end.
