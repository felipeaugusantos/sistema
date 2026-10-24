unit untFatMostraProdutos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, Menus, EditFocus, AppEvnts, UniClientDataSet, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatMostraProdutos = class(TfrmPaiSimples)
    dbgItens: TDBGridCitel;
    pnlTotais: TPanel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    Label1: TLabel;
    edtPrzMed: TEditFocus;
    dtsDados: TDataSource;
    Label2: TLabel;
    edtTotQtq: TEditFocus;
    Label3: TLabel;
    edtTotUnt: TEditFocus;
    Label4: TLabel;
    edtTotGer: TEditFocus;
    Label5: TLabel;
    edtTotCom: TEditFocus;
    lblTotPontos: TLabel;
    edtTotPontos: TEditFocus;
    lblComissaoGeral: TLabel;
    edtPercComVenda: TEditFocus;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    blnExiPro: Boolean;

    procedure pAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
    strPrzMed: String;
    fltTotQtq,
    fltTotUnt,
    fltTotGer,
    fltTotCom,
    fltTotPon: Double;
    cdsDados : TUniClientDataSet;
    strOpcDoc: String;
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraProdutos.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdutos.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnFechar.Click;
end;

procedure TfrmFatMostraProdutos.FormShow(Sender: TObject);
begin
  inherited;

  blnExiPro := fCfgSis('EXIPRO', VarBoolean) And (Pos(strOpcDoc, 'VN_PD_OR_') > 0);

  TFloatField(cdsDados.FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsDados.FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDados.FieldByName('ITE_TOTITE')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('GRU_PERCOM')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('ITE_COMVEN')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('ITE_PONBRI')).DisplayFormat := fMskDigitos(2);

  edtPrzMed.Text   := strPrzMed;

  edtTotQtq.Text       := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), fltTotQtq);
  edtTotUnt.Text       := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fltTotUnt);
  edtTotGer.Text       := FormatFloat(fMskDigitos(2), fltTotGer);
  edtTotCom.Text       := FormatFloat(fMskDigitos(2), fltTotCom);
  edtPercComVenda.Text := FormatFloat(fMskDigitos(2), (fltTotCom * 100) / fltTotGer);
  edtTotPontos.Text    := FormatFloat(fMskDigitos(2), fltTotPon);

  edtTotPontos.Visible := blnExiPro;
  lblTotPontos.Visible := blnExiPro;
  dbgItens.Columns[9].Visible := blnExiPro;
end;

procedure TfrmFatMostraProdutos.pAfterScroll(DataSet: TDataSet);
begin
  If (Not cdsDados.IsEmpty) Then
    pnlInfo.Caption := '   ' + cdsDados.FieldByName('ITE_CODITE').AsString
                          + '-' + cdsDados.FieldByName('ITE_DESITE').AsString
                          + ' | Marca: ' + cdsDados.FieldByName('ITE_DESMAR').AsString
  Else pnlInfo.Caption := '';
end;

procedure TfrmFatMostraProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados  := TUniClientDataSet.Create(Self);
  cdsDados.AfterScroll := pAfterScroll;
  dtsDados.DataSet := cdsDados;

  fltTotQtq := 0;
  fltTotUnt := 0;
  fltTotGer := 0;
  fltTotCom := 0;
  fltTotPon := 0;
end;

end.
