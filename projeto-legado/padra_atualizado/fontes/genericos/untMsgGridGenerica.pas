unit untMsgGridGenerica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
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
    intWidth : Integer;
   End;

   TArrRecordFields = Array Of TRecordField;

  TfrmMsgGridGenerica = class(TfrmPaiConfirma)
    dtsDados: TDataSource;
    cxDados: TcxGrid;
    cxgDados: TcxGridDBTableView;
    cxlDados: TcxGridLevel;
    procedure btnConfirmaClick(Sender: TObject);
  protected
    FArrRecordFields:TArrRecordFields;
    blnSelecionado: Boolean;
    procedure pMontaGrid(BtnConfirmaExibe, BtnSairExibe: Boolean; CaptionBtnConfirma, CaptionBtnCancelar: String);
  public
    class function fMontaGridGenerico(ArrRecordFields: TArrRecordFields; DataSet: TDataSet;
                   CaptionForm: String; BtnConfirmaExibe: Boolean = True; BtnSairExibe: Boolean = True;
                   CaptionBtnConfirma: String = '&Confirma'; CaptionBtnCancelar: String = 'C&ancela'; PermiteFiltrarGrid: Boolean = True): Boolean;
  end;

var
  frmMsgGridGenerica: TfrmMsgGridGenerica;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}


procedure TfrmMsgGridGenerica.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnSelecionado := True;
  Close;
end;

class function TfrmMsgGridGenerica.fMontaGridGenerico(ArrRecordFields: TArrRecordFields; DataSet: TDataSet;
               CaptionForm: String; BtnConfirmaExibe: Boolean = True; BtnSairExibe: Boolean = True;
               CaptionBtnConfirma: String = '&Confirma'; CaptionBtnCancelar: String = 'C&ancela'; PermiteFiltrarGrid: Boolean = True): Boolean;
begin
  pCriarFormularios(TfrmMsgGridGenerica, frmMsgGridGenerica);
  Try
    frmMsgGridGenerica.blnSelecionado := False;
    frmMsgGridGenerica.Caption := CaptionForm;
    frmMsgGridGenerica.FArrRecordFields := ArrRecordFields;
    frmMsgGridGenerica.pMontaGrid(BtnConfirmaExibe, BtnSairExibe, CaptionBtnConfirma, CaptionBtnCancelar);
    frmMsgGridGenerica.cxgDados.OptionsCustomize.ColumnFiltering := PermiteFiltrarGrid;

    frmMsgGridGenerica.dtsDados.DataSet := DataSet;
    frmMsgGridGenerica.ShowModal;

    Result := frmMsgGridGenerica.blnSelecionado;

  Finally
    FreeAndNil(frmMsgGridGenerica);
  End;
end;

procedure TfrmMsgGridGenerica.pMontaGrid(BtnConfirmaExibe, BtnSairExibe: Boolean; CaptionBtnConfirma, CaptionBtnCancelar: String);
var RecordField : TRecordField;
    vcont: Integer;
begin
  btnConfirma.visible := BtnConfirmaExibe;
  btnConfirma.Caption := CaptionBtnConfirma;
  btnSair.visible := BtnSairExibe;
  btnSair.Caption := CaptionBtnCancelar;

  vcont := 0;
  For RecordField In FArrRecordFields do
  Begin
    cxgDados.CreateColumn;
    cxgDados.Columns[vcont].DataBinding.FieldName := RecordField.strFieldName;
    cxgDados.Columns[vcont].Caption := RecordField.strFieldCaption;

    If (RecordField.intWidth > 0) Then
    Begin
      cxgDados.Columns[vcont].Width := RecordField.intWidth;
      cxgDados.Columns[vcont].MinWidth := RecordField.intWidth;
    End;

    inc(vcont);
  End;

  cxgDados.ApplyBestFit;

end;

end.
