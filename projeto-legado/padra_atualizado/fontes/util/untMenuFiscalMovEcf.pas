unit untMenuFiscalMovEcf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  ComCtrls, AppEvnts, BitBtnLockedIncrem, EditFocus, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmMenuFiscalMovEcf = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    rdgIntervalo: TRadioGroup;
    gpbValores: TGroupBox;
    lblFiltroIni: TLabel;
    lblFiltroFin: TLabel;
    mskFiltroIni: TMaskEditFocus;
    mskFiltroFin: TMaskEditFocus;
    Label1: TLabel;
    pgbGeral: TProgressBar;
    pgbDetalhe: TProgressBar;
    lblDetalhe: TLabel;
    btnExportar: TBitBtnLocked;
    Label2: TLabel;
    edtCodNac: TEditFocus;
    tmrIniciarExportacao: TTimer;
    procedure rdgIntervaloClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrIniciarExportacaoTimer(Sender: TObject);
  private
    { Private declarations }
    procedure pAntesInicio(Sender: TObject; strRegistro: String; intQtdReg: Integer);
    procedure pLinhaProcessada(Sender: TObject; strRegistro: String; intRegAtu: Integer);
    procedure pAntesFinal(Sender: TObject; strRegistro: String);
  public
    { Public declarations }
    blnGerarDoDia: Boolean;
    dtaReducao: TDateTime;
  end;


implementation

uses untFiscal, untPafExportacaoMovEcf, untFuncoesSimples;

{$R *.dfm}

procedure TfrmMenuFiscalMovEcf.rdgIntervaloClick(Sender: TObject);
begin
  inherited;
//  If rdgIntervalo.ItemIndex = 0 Then
//  Begin
//    gpbValores.Visible := True;
//  End
//  Else
//  Begin
//    gpbValores.Visible := False;
//  End;
end;

procedure TfrmMenuFiscalMovEcf.tmrIniciarExportacaoTimer(Sender: TObject);
begin
  inherited;
  tmrIniciarExportacao.Enabled := False;
  btnExportar.Click;
end;

procedure TfrmMenuFiscalMovEcf.FormShow(Sender: TObject);
  Var
    strNumSer: String;
begin
  inherited;
  strNumSer := Trim(VS_objFiscal.fNumeroSerie);
  rdgIntervalo.Items.Add('ECF: ' + strNumSer);

  Try
    edtCodNac.Text := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'CODNAC'   , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  Except
  End;
end;

procedure TfrmMenuFiscalMovEcf.btnExportarClick(Sender: TObject);
  Var
    movEcf: TExportaMovEcf;
    strNumSer: String;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    dtaDtaArq: TDateTime;
begin
  inherited;

  Try
    fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'CODNAC'   , edtCodNac.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  Except
    //
  End;

  btnExportar.Enabled := False;

  pgbGeral.Max := 8;
  pgbGeral.Position := 0;

  pgbDetalhe.Position := 0;

  If (rdgIntervalo.ItemIndex = 0) Then
  Begin
    strNumSer := '';
    dtaDtaIni := StrToDate(mskFiltroIni.Text);
    dtaDtaFin := StrToDate(mskFiltroFin.Text);
  End
  Else
  Begin
    strNumSer := VS_objFiscal.fNumeroSerie;
    dtaDtaIni := StrToDateDef(mskFiltroIni.Text, 0);
    dtaDtaFin := StrToDateDef(mskFiltroFin.Text, 0);
  End;

  If (blnGerarDoDia) Then
    dtaDtaArq := dtaReducao
  Else
    dtaDtaArq := dtaDtaIni;

  movEcf := TExportaMovEcf.Create(strNumSer, dtaDtaIni, dtaDtaFin, dtaDtaArq);
  movEcf.AntesIniciarRegistro   := pAntesInicio;
  movEcf.LinhaProcessada        := pLinhaProcessada;
  movEcf.AntesFinalizarRegistro := pAntesFinal;
  movEcf.strCodNac := edtCodNac.Text;
  movEcf.pExportar;

  FreeAndNil(movEcf);

  btnExportar.Enabled := True;

  fMensagem('ATENÇÃO!', 'Geração Concluída!', ['&Ok']);
end;

procedure TfrmMenuFiscalMovEcf.pAntesFinal(Sender: TObject;
  strRegistro: String);
begin
  pgbGeral.StepBy(1);
end;

procedure TfrmMenuFiscalMovEcf.pAntesInicio(Sender: TObject;
  strRegistro: String; intQtdReg: Integer);
begin
  pgbDetalhe.Position := 0;
  pgbDetalhe.Max := intQtdReg;

  If SameText(strRegistro, 'ASSINATURA') Then
    lblDetalhe.Caption := 'ASSINANDO ARQUIVOS DIGITALMENTE...'
  Else
    lblDetalhe.Caption := 'GERANDO REGISTRO ' + strRegistro;

  Self.Repaint;
  lblDetalhe.Repaint;
  Application.ProcessMessages;
end;

procedure TfrmMenuFiscalMovEcf.pLinhaProcessada(Sender: TObject; strRegistro: String;
  intRegAtu: Integer);
begin
  pgbDetalhe.StepBy(1);
end;

procedure TfrmMenuFiscalMovEcf.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskFiltroIni);
end;

procedure TfrmMenuFiscalMovEcf.FormCreate(Sender: TObject);
begin
  inherited;
  blnGerarDoDia := False;
end;

procedure TfrmMenuFiscalMovEcf.FormPaint(Sender: TObject);
begin
  inherited;

  If blnGerarDoDia Then
  Begin
    blnGerarDoDia := False;
    mskFiltroIni.Text := DateToStr(dtaReducao);
    mskFiltroFin.Text := DateToStr(dtaReducao);

    tmrIniciarExportacao.Enabled := True;
  End;

end;

end.
