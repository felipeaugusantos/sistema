unit Contabilidade.View.ConfiguracaoPisCofinsReceitaFinanceira;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus;

type
  TfrmConfiguracaoPisCofinsReceitaFinanceira = class(TfrmPaiConfirmaContabilidade)
    pnlAlq: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    chkPICORF: TCheckBox;
    edtAlqPis: TEditFocus;
    edtAlqCof: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    procedure chkPICORFClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    procedure pAtualizaTela;
    procedure pCarregar;
    procedure pGravar;
    function fAlqToStr(AAlq: Double): string;
    function fStrToAlq(AStr: string): Double;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

const
  PICORF_Habilitado = 'Habilitado';
  PICORF_Desabilitado = 'Desabilitado';

implementation

uses
  untFuncoesSimples, StrUtils, Uni, Data.Db;

{$R *.dfm}

{ TfrmConfiguracaoPisCofinsReceitaFinanceira }

procedure TfrmConfiguracaoPisCofinsReceitaFinanceira.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmConfiguracaoPisCofinsReceitaFinanceira.chkPICORFClick(Sender: TObject);
begin
  inherited;
  pAtualizaTela;
end;

function TfrmConfiguracaoPisCofinsReceitaFinanceira.fAlqToStr(AAlq: Double): string;
begin
  Result := FormatFloat('0.0000', AAlq);
end;

procedure TfrmConfiguracaoPisCofinsReceitaFinanceira.FormShow(Sender: TObject);
begin
  inherited;
  chkPICORF.Checked := UpperCase(fCfgSisL('PICORF', VarString)) = UpperCase(PICORF_Habilitado);
  pAtualizaTela;

  if chkPICORF.Checked then
    pCarregar;
end;

function TfrmConfiguracaoPisCofinsReceitaFinanceira.fStrToAlq(AStr: string): Double;
begin
  Result := StrToFloatDef(AStr.Trim, 0);
end;

function TfrmConfiguracaoPisCofinsReceitaFinanceira.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := true;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin
    if (chkPICORF.Checked) then
    begin
      if (Sender = edtAlqPis) then
      begin
        if fEmptyStr(edtAlqPis.Text) then
        begin
          fMensagem('ATENÇÃO!', 'A Alíquota PIS deve ser preenchida!', ['&O k']);
          Result := False;
          Exit;
        end;

        if (fStrToAlq(edtAlqPis.Text) < 0) then
        begin
          fMensagem('ATENÇÃO!', 'A Alíquota não pode ser negativa!', ['&O k']);
          Result := False;
          Exit;
        end;

        if (fStrToAlq(edtAlqPis.Text) > 99.9999) then
        begin
          fMensagem('ATENÇÃO!', 'A Alíquota não pode ser maior que 99,9999%!', ['&O k']);
          Result := False;
          Exit;
        end;
      end;

      if (Sender = edtAlqCof) then
      begin
        if fEmptyStr(edtAlqCof.Text) then
        begin
          fMensagem('ATENÇÃO!', 'A Alíquota COFINS deve ser preenchida!', ['&O k']);
          Result := False;
          Exit;
        end;

        if (fStrToAlq(edtAlqCof.Text) < 0) then
        begin
          fMensagem('ATENÇÃO!', 'A Alíquota não pode ser negativa!', ['&O k']);
          Result := False;
          Exit;
        end;

        if (fStrToAlq(edtAlqCof.Text) > 99.9999) then
        begin
          fMensagem('ATENÇÃO!', 'A Alíquota não pode ser maior que 99,9999%!', ['&O k']);
          Result := False;
          Exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmConfiguracaoPisCofinsReceitaFinanceira.pAtualizaTela;
begin
  pnlAlq.Enabled := True;

  if not chkPICORF.Checked then
  begin
    edtAlqPis.Text := '';
    edtAlqCof.Text := '';
  end;

  pnlAlq.Enabled := chkPICORF.Checked;
end;

procedure TfrmConfiguracaoPisCofinsReceitaFinanceira.pCarregar;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;
  try
    LQry.Close;
    LQry.SQL.Text := 'SELECT * FROM PICORF WHERE PCR_CODEMP = "' + VS_strCodEmp + '"';

    LQry.Open;

    if not LQry.IsEmpty then
    begin
      edtAlqPis.Text := fAlqToStr(LQry.FieldByName('PCR_ALQPIS').AsFloat);
      edtAlqCof.Text := fAlqToStr(LQry.FieldByName('PCR_ALQCOF').AsFloat);
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmConfiguracaoPisCofinsReceitaFinanceira.pGravar;
var
  LQry: TUniQuery;
begin
  if not fValidaCampos(edtAlqPis) then
    Exit;

  if not fValidaCampos(edtAlqCof) then
    Exit;

  fAtuCfgSis('PICORF', IIF(chkPICORF.Checked, PICORF_Habilitado, PICORF_Desabilitado));

  LQry := fCriaQuery;
  try
    LQry.Close;

    if chkPICORF.Checked then
    begin
      LQry.SQL.Text := 'REPLACE INTO PICORF (PCR_CODEMP, PCR_ALQPIS, PCR_ALQCOF) VALUES (:CODEMP, :ALQPIS, :ALQCOF)';

      LQry.ParamByName('ALQPIS').AsFloat := fStrToAlq(edtAlqPis.Text);
      LQry.ParamByName('ALQCOF').AsFloat := fStrToAlq(edtAlqCof.Text);
    end
    else
    begin
      LQry.SQL.Text := 'DELETE FROM PICORF WHERE PCR_CODEMP = :CODEMP';
    end;

    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;

    LQry.ExecSQL;
  finally
    FreeAndNil(LQry);
  end;
end;

end.
