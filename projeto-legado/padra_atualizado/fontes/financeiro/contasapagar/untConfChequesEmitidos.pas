unit untConfChequesEmitidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, UniClientDataSet, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConfChequesEmitidos = class(TfrmPaiSimples)
    Panel1: TPanel;
    btnConfirma: TBitBtnLocked;
    cxgChqEmiRegistros: TcxGridDBTableView;
    cxgChqEmiLevel1: TcxGridLevel;
    cxgChqEmi: TcxGrid;
    cxgChqEmiRegistrosCODBCO: TcxGridDBColumn;
    cxgChqEmiRegistrosNUMAGE: TcxGridDBColumn;
    cxgChqEmiRegistrosCONCOR: TcxGridDBColumn;
    cxgChqEmiRegistrosNUMCHQ: TcxGridDBColumn;
    cxgChqEmiRegistrosVALCHQ: TcxGridDBColumn;
    cxgChqEmiRegistrosDTAEMI: TcxGridDBColumn;
    cxgChqEmiRegistrosBOMPAR: TcxGridDBColumn;
    cxgChqEmiRegistrosFAVORE: TcxGridDBColumn;
    dtsChqEmi: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgChqEmiRegistrosEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    function fVerificaDuplicidade(strCodBco, strNumAge,
      strNumChq, strConCor: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
    fltValTot: Double;
    cdsChqEmi : TUniClientDataset;
    blConfirma : boolean;
  end;

var
  frmConfChequesEmitidos: TfrmConfChequesEmitidos;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmConfChequesEmitidos.btnConfirmaClick(Sender: TObject);
  Var
    fltTotGer: Double;
begin

  fltTotGer := 0;

  cdsChqEmi.First;

  While Not cdsChqEmi.Eof Do
  Begin
    If cdsChqEmi.FieldByName('VALCHQ').AsFloat = 0 Then
    Begin
      pMensagemOk('Existem cheques com valor ZERO! Favor verifique!');
      Exit;
    End;

    If fVerificaDuplicidade(cdsChqEmi.FieldByName('CODBCO').AsString,
                            cdsChqEmi.FieldByName('NUMAGE').AsString,
                            cdsChqEmi.FieldByName('NUMCHQ').AsString,
                            cdsChqEmi.FieldByName('CONCOR').AsString) Then
    Begin
      pMensagemOk('Existem duplicidades de cheques! Favor verifique!');
      Exit;
    End;

    If (fEmptyStr(cdsChqEmi.FieldByName('CODBCO').AsString)) Or
       (fEmptyStr(cdsChqEmi.FieldByName('NUMAGE').AsString)) Or
       (fEmptyStr(cdsChqEmi.FieldByName('NUMCHQ').AsString)) Or
       (fEmptyStr(cdsChqEmi.FieldByName('CONCOR').AsString)) Then
    Begin
      pMensagemOk('Os campos Banco, Agência, Conta e Cheque devem ser preenchidos!');
      Exit;
    End;

    If fEmptyStr(cdsChqEmi.FieldByName('DTAEMI').AsString) Then
    Begin
      pMensagemOk('A Data de emissão deve ser preenchida!');
      Exit;
    End;

   If Not fEmptyStr(cdsChqEmi.FieldByName('BOMPAR').AsString) Then
   Begin
    If Not fValidaPeriodo(FormatDateTime('dd/mm/yyyy',cdsChqEmi.FieldByName('DTAEMI').AsDateTime), FormatDateTime('dd/mm/yyyy',cdsChqEmi.FieldByName('BOMPAR').AsDateTime)) Then
    Begin
      pMensagemOk('A Data para depósito deve ser maior ou igual a data de emissão!');
      Exit;
    End;
   End;

    fltTotGer := fltTotGer + cdsChqEmi.FieldByName('VALCHQ').AsFloat;
    cdsChqEmi.Next;
  End;

  If fFormataFloat(fltTotGer, 2) <> fFormataFloat(fltValTot, 2)Then
  Begin
    pMensagemOk('A soma dos valores informados não bate com o total geral R$ ' + FormatFloat('#,##0.00', fltValTot) + '. Corrija!');
    Exit;
  End;

  inherited;

  blConfirma := True;

  Close;

end;

procedure TfrmConfChequesEmitidos.cxgChqEmiRegistrosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin

  If Key = '.' Then
   Key := #0;
  
  inherited;
end;

procedure TfrmConfChequesEmitidos.FormActivate(Sender: TObject);
begin
  inherited;

  With cdsChqEmi Do
  Begin
    (FieldByName('VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('DTAEMI') As TDateField).DisplayFormat  := 'dd/mm/yyyy';
    (FieldByName('BOMPAR') As TDateField).DisplayFormat  := 'dd/mm/yyyy';
  End;

  cdsChqEmi.IndexFieldNames := 'CODBCO;NUMAGE;CONCOR;NUMCHQ';
  dtsChqEmi.Dataset := cdsChqEmi;

  pSetFocus(btnConfirma);

end;

procedure TfrmConfChequesEmitidos.FormCreate(Sender: TObject);
begin
  inherited;

  cdsChqEmi := TUniClientDataset.Create(Self);
  blConfirma := False;
end;

procedure TfrmConfChequesEmitidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then Close;
end;

function TfrmConfChequesEmitidos.fVerificaDuplicidade(strCodBco, strNumAge, strNumChq, strConCor: String): Boolean;
  Var
    cdsAux: TUniClientDataset;
Begin
  cdsAux := TUniClientDataset.Create(Nil);
  cdsAux.Data := cdsChqEmi.Data;

  cdsAux.Filter := 'CODBCO = ' + QuotedStr(strCodBco) + ' AND ' +
                   'NUMAGE = ' + QuotedStr(strNumAge) + ' AND ' +
                   'NUMCHQ = ' + QuotedStr(strNumChq) + ' AND ' +
                   'CONCOR = ' + QuotedStr(strConCor);
  cdsAux.Filtered := True;

  Result := cdsAux.RecordCount > 1;
  FreeAndNil(cdsAux);
End;

end.
