unit untLotePrecosMargemLucroGeral;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Datasnap.DBClient,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridCitel, cxCheckBox, cxCurrencyEdit, untLotePrecos, cxProgressBar;

type
  TfrmLotePrecosMargemLucroGeral = class(TfrmPaiConfirma)
    cxvTabelas: TcxGridDBTableView;
    cxGridTabelasLevel1: TcxGridLevel;
    cxGridTabelas: TcxGrid;
    dtsTabelas: TDataSource;
    cxGridTabelasMARDES: TcxGridDBColumn;
    cxGridTabelasDESCRI: TcxGridDBColumn;
    cxGridTabelasMARGEM: TcxGridDBColumn;
    cdsTabelas: TFDMemTable;
    cdsTabelasMARDES: TStringField;
    cdsTabelasDESCRI: TStringField;
    cdsTabelasMARGEM: TFloatField;
    cdsTabelasNUMTAB: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure cxvTabelasCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    Function fAlteraMargem(pgbStatus: TcxProgressBar = Nil):Boolean;
    procedure pCriaCampos;
    procedure pConfirma;
  public
    objPreLotes: TLotePrecos;
  end;

var
  frmLotePrecosMargemLucroGeral: TfrmLotePrecosMargemLucroGeral;

implementation

uses
  untGravando;

{$R *.dfm}


Function TfrmLotePrecosMargemLucroGeral.fAlteraMargem(pgbStatus: TcxProgressBar = Nil):Boolean;
begin
  Result := True;
  objPreLotes.cdsConsulta.DisableControls;
  try
    objPreLotes.AlterandoMargemGeral := True;
    pgbStatus.Properties.Max := cdsTabelas.RecordCount * objPreLotes.cdsConsulta.RecordCount;
    While not cdsTabelas.Eof Do
    Begin
      objPreLotes.cdsConsulta.First;
      While not objPreLotes.cdsConsulta.Eof Do
      Begin
        objPreLotes.cdsConsulta.Edit;
        objPreLotes.cdsConsulta.FieldByName('LTP_MARBR'+cdsTabelas.FieldByName('NUMTAB').AsString).AsFloat := cdsTabelas.FieldByName('MARGEM').AsFloat;
        objPreLotes.cdsConsulta.Post;
        objPreLotes.cdsConsulta.Next;
        pgbStatus.Position := pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;
      cdsTabelas.Next;
    End;
  finally
    objPreLotes.cdsConsulta.EnableControls;
    objPreLotes.AlterandoMargemGeral := False;
  end;
end;

procedure TfrmLotePrecosMargemLucroGeral.pConfirma;
var frmAlteraMargem: TFrmGravando;
begin
  If fMensagem('ATENÇÃO', 'Confirma a alteração da margem de lucro para todos os itens?', ['&Sim', '&Não']) = 1 Then
  Begin
    cdsTabelas.Filter := 'MARDES = '+QuotedStr('M');
    cdsTabelas.Filtered := True;

    cdsTabelas.First;
    try
      pCriarFormularios(TfrmGravando,frmAlteraMargem);
      Try
        frmAlteraMargem.fExecutarAcao := fAlteraMargem;
        frmAlteraMargem.lblGravando.Caption := 'Aguarde, Validando margem negativa ou zerada...';
        frmAlteraMargem.ShowModal;
      Finally
        freeAndNil(frmAlteraMargem);
      End;

      fMensagem('', 'Margens alteradas com sucesso.', ['&Ok']);
      ModalResult := mrOk;
      Except on E:Exception do
      Begin
        fMensagem('ATENÇÃO!', 'Erro ao alterar a margem de lucro geral.', ['&Ok']);
      End;
    End;
  End;
end;

procedure TfrmLotePrecosMargemLucroGeral.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pConfirma;
end;

procedure TfrmLotePrecosMargemLucroGeral.cxvTabelasCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
   cxGridTabelasMARGEM.Options.Editing := VarToStr(Sender.DataController.Values[ARecord.RecordIndex,cxGridTabelasMARDES.Index]) = 'M';
end;

procedure TfrmLotePrecosMargemLucroGeral.FormShow(Sender: TObject);
begin
  inherited;
  pCriaCampos;
end;


procedure TfrmLotePrecosMargemLucroGeral.pCriaCampos;
var
  strConfig : String;
  I : Integer;
begin
  strConfig := fCfgSis('TABPRC');

  cdsTabelas.Open;
  cdsTabelas.EmptyDataSet;
  For I := 1 to Length(strConfig) Do
  Begin
    If strConfig[I] = 'S' Then
    Begin
      cdsTabelas.Append;
      cdsTabelas.FieldByName('NUMTAB').AsInteger     :=    I;
      cdsTabelas.FieldByName('DESCRI').AsString      :=    'Tabela '+IntToStr(I);
      cdsTabelas.FieldByName('MARGEM').AsFloat       :=    0.0;
      cdsTabelas.FieldByName('MARDES').AsString      :=    'D';
      cdsTabelas.Post;
    End;
  End;

end;

end.
