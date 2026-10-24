unit untFatDigitaLotesWMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  UniClientDataSet, Math, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxTextEdit, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatDigitaLotesWMS = class(TfrmPaiConfirma)
    pnlCabec: TPanel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensNUMLOT: TcxGridDBColumn;
    cxgItensLOCFIS: TcxGridDBColumn;
    cxgItensPICKIN: TcxGridDBColumn;
    cxgItensDTAVAL: TcxGridDBColumn;
    cxgItensSALDIS: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensQTDTOT: TcxGridDBColumn;
    Label1: TLabel;
    edtQtdIte: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    dtsItens: TDataSource;
    btnLotIte: TBitBtnLocked;
    Bevel1: TBevel;
    Bevel2: TBevel;
    cxgItensBROKER: TcxGridDBColumn;
    Label3: TLabel;
    edtSituac: TEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLotIteClick(Sender: TObject);
  private
    { Private declarations }
    Function fRetNomeLote: String;
  public
    { Public declarations }
    cdsLotes : TUniClientDataSet;
    strNumLot: String;
    fltQtdIte: Double;
  end;

implementation

uses  untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmFatDigitaLotesWMS.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6: Begin
             If ssAlt In Shift Then
               btnLotIte.Click;

             Key := 0;
           End;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
    VK_RETURN: If cxgItensQTDITE.Focused And (cdsLotes.State = dsEdit) Then
                 cdsLotes.Next;
  End;
end;

procedure TfrmFatDigitaLotesWMS.FormShow(Sender: TObject);
begin
  inherited;
  edtSituac.Visible      := VS_strUsaTmq = 'S';
  dtsItens.DataSet       := cdsLotes;
  cxgItensBROKER.Visible := (Not fEmptyStr(cdsLotes.FieldByName('ORIGEM').AsString));
  cxgItensQTDITE.Focused := True;
end;

Function TfrmFatDigitaLotesWMS.fRetNomeLote: String;
Begin
  Result := '';
  With cdsLotes Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If (FieldByName('QTDITE').AsFloat > 0) Then
      Begin
        If fEmptyStr(Result) Then
        Begin
          Result := FieldByName('LOTDES').AsString;
        End Else
        Begin
          Result := 'VÁRIOS';
          Break;
        End;
      End;

      Next;
    End;

    EnableControls;
  End;
End;

procedure TfrmFatDigitaLotesWMS.btnLotIteClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(207, 7616, [7719,7720,7721,7722],
                      ['CODITE'],
                      [Copy(edtCodIte.Text, 1, fTamCodIte)],
                      Sender,
                      ['CODITE'],
                      True);
  End;

end;

procedure TfrmFatDigitaLotesWMS.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    intDecQtd: Integer;
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If dtsItens.DataSet.State = dsEdit Then
      dtsItens.DataSet.Post;

    intDecQtd := fCfgSis('DECQTD');

    If RoundTo(fltQtdIte, -intDecQtd) < RoundTo(fDoubleAggregate(cdsLotes, 'AGG_TOTQTD'), -intDecQtd) Then
    Begin
      pMensagemOk('A soma das quantidades digitadas excede a quantidade total do produto!');
      pSetFocus(cxgItens);
      cxgItensQTDITE.Focused := True;
      Action := caNone;
    End;

    If RoundTo(fltQtdIte, -intDecQtd) > RoundTo(fDoubleAggregate(cdsLotes, 'AGG_TOTQTD'), -intDecQtd) Then
    Begin
      strNumLot := 'A DEFINIR';
      pMensagemOk('A quantidade digitada ainda é menor que a quantidade total do produto!');
    End

    Else strNumLot := fRetNomeLote;

  End;

end;

end.
