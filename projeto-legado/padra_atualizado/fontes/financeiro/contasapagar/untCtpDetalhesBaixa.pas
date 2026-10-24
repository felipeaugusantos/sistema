unit untCtpDetalhesBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, DB, Uni;

type
  TfrmCtpDetalhesBaixa = class(TfrmPai)
    pnlGeral: TPanel;
    Label22: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    edtValorPago: TEditFocus;
    edtValorJuros: TEditFocus;
    edtValorDesconto: TEditFocus;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    btnSelChEmi: TBitBtnLocked;
    btnSelChTer: TBitBtnLocked;
    edtDinheiro: TEditFocus;
    edtChequeEmitido: TEditFocus;
    edtChequeTerceiros: TEditFocus;
    edtDeposito: TEditFocus;
    Label9: TLabel;
    edtOutrasEntidades: TEditFocus;
    Label4: TLabel;
    edtVendor: TEditFocus;
    edtValorMulta: TEditFocus;
    lblMulta: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSelChTerClick(Sender: TObject);
    procedure btnSelChEmiClick(Sender: TObject);
  private
    { Private declarations }
  public
    dtsCtaPagar: TDataSet;
    { Public declarations }
  end;

implementation

Uses untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmCtpDetalhesBaixa.btnSelChEmiClick(Sender: TObject);
begin

  inherited;

  If (Not dtsCtaPagar.FieldByName('CTP_CHQAVI').IsNull) And (dtsCtaPagar.FieldByName('CTP_CHQAVI').AsFloat > 0) Then
  begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(81, 5366, [],
                          ['NUMDUP','PARCEL','CODEMP','CODFOR','SERIE_','SEQBAI'],
                          [dtsCtaPagar.FieldByName('CTP_NUMDUP').AsString,
                          dtsCtaPagar.FieldByName('CTP_PARCEL').AsString,
                          dtsCtaPagar.FieldByName('CTP_CODEMP').AsString,
                          dtsCtaPagar.FieldByName('CTP_CODFOR').AsString,
                          dtsCtaPagar.FieldByName('CTP_SERIE_').AsString,
                          dtsCtaPagar.FieldByName('CTP_SEQBAI').AsString],
                          Sender,
                          nil,
                          True);
    End;

  end;

end;

procedure TfrmCtpDetalhesBaixa.btnSelChTerClick(Sender: TObject);
begin

  inherited;

  If (Not dtsCtaPagar.FieldByName('CTP_REPCHQ').IsNull) And (dtsCtaPagar.FieldByName('CTP_REPCHQ').AsFloat > 0) Then
  begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(80, 5360, [],
                          ['SEQRCH','EMPRCH'],
                          [dtsCtaPagar.FieldByName('CTP_SEQRCH').AsString,
                          dtsCtaPagar.FieldByName('CTP_EMPBAI').AsString],
                          Sender,
                          nil,
                          True);
    End;

  end;

end;

procedure TfrmCtpDetalhesBaixa.FormShow(Sender: TObject);
begin

  inherited;

  edtDinheiro.Text        := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_DINHEI').AsFloat);
  edtChequeEmitido.Text   := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_CHQAVI').AsFloat);
  edtChequeTerceiros.Text := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_REPCHQ').AsFloat);
  edtDeposito.Text        := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_ORDPAG').AsFloat);
  edtValorPago.Text       := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_VALPAG').AsFloat);
  edtValorJuros.Text      := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_VALJUR').AsFloat);
  edtValorMulta.Text      := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_VALMUL').AsFloat);
  edtValorDesconto.Text   := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_VALDES').AsFloat);
  edtOutrasEntidades.Text := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_OUTENT').AsFloat);
  edtVendor.Text          := FormatFloat('#,##0.00', dtsCtaPagar.FieldByName('CTP_VENDOR').AsFloat);

  btnSelChEmi.Enabled := (Not fEmptyStr(edtChequeEmitido.Text)) And (edtChequeEmitido.Text <> '0,00');
  btnSelChTer.Enabled := (Not fEmptyStr(edtChequeTerceiros.Text)) And (edtChequeTerceiros.Text <> '0,00');

end;

end.
