unit Contabilidade.View.PlanoReferencial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, Data.DB, untFuncoesSimples, Vcl.DBCtrls, DBMemoFocus,
  Vcl.Mask, DBEditFocus, untTypesSistema, Contabilidade.Consultas, EditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmPlanoReferencial = class(TfrmPaiContabilidade)
    dtsPlanRe: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbmDescricao: TDBMemoFocus;
    Label4: TLabel;
    Label5: TLabel;
    edtTipCta: TEditFocus;
    edtCtaSup: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    edtNivel: TEditFocus;
    Label8: TLabel;
    edtNature: TEditFocus;
    dbmOrient: TDBMemoFocus;
    Label9: TLabel;
    btnPesquisa: TBitBtnLocked;
    edtContaRef: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    dbgPlanoRef: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dtsPlanReStateChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgPlanoRefDblClick(Sender: TObject);
    procedure dbgPlanoRefKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    strSQL: string;
  public
    strCodRef: string;
    qryTabela: TUniQuery;
  end;

var
  frmPlanoReferencial: TfrmPlanoReferencial;

implementation

{$R *.dfm}

procedure TfrmPlanoReferencial.btnConfirmaClick(Sender: TObject);
begin
  if not btnConfirma.Enabled then
    Exit;

  strCodRef := qryTabela.FieldByName('NRE_CODREF').AsString;
  Self.Close;
end;

procedure TfrmPlanoReferencial.btnPesquisaClick(Sender: TObject);
begin
  if (fEmptyStr(edtContaRef.Text)) and (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))
     and (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))
     and (fEmptyStr(edtTipCta.Text)) and (fEmptyStr(edtCtaSup.Text))
     and (fEmptyStr(edtNivel.Text)) and (fEmptyStr(edtNature.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário preencher pelo menos um campo para efetuar a pesquisa!', ['&OK']);
    pSetFocus(edtContaRef);
    Exit;
  end;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add(strSQL);
  qryTabela.SQL.Add('WHERE TRUE ');

  if (not fEmptyStr(edtContaRef.Text)) then
    qryTabela.SQL.Add('  AND NRE_CODREF = :CODREF ');

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) then
    qryTabela.SQL.Add('  AND NRE_DTAINI = :DTAINI ');

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
    qryTabela.SQL.Add('  AND NRE_DTAFIN = :DTAFIN ');

  if (not fEmptyStr(edtTipCta.Text)) then
    qryTabela.SQL.Add('  AND NRE_TIPCTA = :TIPCTA ');

  if (not fEmptyStr(edtCtaSup.Text)) then
    qryTabela.SQL.Add('  AND NRE_CTASUP = :CTASUP ');

  if (not fEmptyStr(edtNivel.Text)) then
    qryTabela.SQL.Add('  AND NRE_NIVEL_ = :NIVEL_ ');

  if (not fEmptyStr(edtNature.Text)) then
    qryTabela.SQL.Add('  AND NRE_NATURE = :NATURE ');

  if (not fEmptyStr(edtContaRef.Text)) then
    qryTabela.ParamByName('CODREF').AsString := edtContaRef.Text;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) then
    qryTabela.ParamByName('DTAINI').AsDate := mskDtaIni.Date;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
    qryTabela.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

  if (not fEmptyStr(edtTipCta.Text)) then
    qryTabela.ParamByName('TIPCTA').AsString := edtTipCta.Text;

  if (not fEmptyStr(edtCtaSup.Text)) then
    qryTabela.ParamByName('CTASUP').AsString := edtCtaSup.Text;

  if (not fEmptyStr(edtNivel.Text)) then
    qryTabela.ParamByName('NIVEL_').AsString := edtNivel.Text;

  if (not fEmptyStr(edtNature.Text)) then
    qryTabela.ParamByName('NATURE').AsString := edtNature.Text;

  try
    qryTabela.Open;
    pSetFocus(btnConfirma);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnPesquisaClick]');
    End;
  End;
end;

procedure TfrmPlanoReferencial.dbgPlanoRefDblClick(Sender: TObject);
begin
  inherited;
  btnConfirmaClick(nil);
end;

procedure TfrmPlanoReferencial.dbgPlanoRefKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    btnConfirmaClick(nil);
end;

procedure TfrmPlanoReferencial.dtsPlanReStateChange(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := (qryTabela.Active) and (not qryTabela.IsEmpty);
end;

procedure TfrmPlanoReferencial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryTabela.Close;
  FreeAndNil(qryTabela);
end;

procedure TfrmPlanoReferencial.FormCreate(Sender: TObject);
begin
  inherited;
  strSQL := 'SELECT * FROM PLANRE ';
  qryTabela         := fCriaQuery();
  dtsPlanRe.DataSet := qryTabela;
  strCodRef := '';
end;

procedure TfrmPlanoReferencial.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtContaRef);
end;

end.
