unit untDDAAPIRetDDAFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Vcl.ExtCtrls, untTiposDDA, untFuncoesSimples, System.DateUtils,
  System.StrUtils;

type
  TfraDDAAPIRetDDAFrame = class(TFrame)
    pnlTopo: TPanel;
    gbCarteira: TGroupBox;
    lblDadosDaConta: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    cbSituacao: TcxComboBox;
    Panel2: TPanel;
    Label2: TLabel;
    cbTipoData: TcxComboBox;
    Panel3: TPanel;
    gbxPeriodo: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    edtDataInicial: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
  private
    { Private declarations }
    function GetSituacao: Integer;
    function GetTipoData: Integer;
  public
    { Public declarations }
    function ValidarDados: Boolean;
    procedure CarregarDadosCarteira(ADadosCarteira: TDDAAPIDadosCarteira);

    property Situacao: Integer read GetSituacao;
    property TipoData: Integer read GetTipoData;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TfraDDAAPIRetDDAFrame.CarregarDadosCarteira(
  ADadosCarteira: TDDAAPIDadosCarteira);
var
  LTextoAgencia, LTextoConta: string;
begin
  if ADadosCarteira = nil then
  begin
    lblDadosDaConta.Caption := EmptyStr;
    Exit;
  end;

  if ADadosCarteira.DigitoAgencia <> EmptyStr then
    LTextoAgencia := ADadosCarteira.CodigoAgencia + '-' + ADadosCarteira.DigitoAgencia
  else
    LTextoAgencia := ADadosCarteira.CodigoAgencia;

  if ADadosCarteira.DigitoContaCorrente <> EmptyStr then
    LTextoConta := ADadosCarteira.ContaCorrente + '-' + ADadosCarteira.DigitoContaCorrente
  else
    LTextoConta := ADadosCarteira.ContaCorrente;

  lblDadosDaConta.Caption :=
    'Banco: ' + ADadosCarteira.CodigoBanco + ' - ' + fRetNomeBancoSelec(ADadosCarteira.CodigoBanco) + ' [Online]' + sLineBreak +
    'Carteira selec.: ' + ADadosCarteira.NumeroCarteiraSelecionada + sLineBreak +
    'Agência: ' + LTextoAgencia + sLineBreak +
    'Conta Corrente: ' + LTextoConta;
end;

function TfraDDAAPIRetDDAFrame.GetSituacao: Integer;
begin
  if cbSituacao.ItemIndex >= 0 then
    Result := cbSituacao.ItemIndex + 1
  else
    Result := 1;
end;

function TfraDDAAPIRetDDAFrame.GetTipoData: Integer;
begin
  if cbTipoData.ItemIndex >= 0 then
    Result := cbTipoData.ItemIndex + 1
  else
    Result := 1;
end;

function TfraDDAAPIRetDDAFrame.ValidarDados: Boolean;
begin
  Result := True;

  if fEmptyStr(edtDataInicial.Text) then
  begin
    fMensagem('ATENÇÃO','O campo Data Inicial deve ser preenchido!', ['&OK']);
    Result := False;
  end
  else if fEmptyStr(edtDataInicial.Text) then
  begin
    fMensagem('ATENÇÃO','O campo Data Final deve ser preenchido!', ['&OK']);
    Result := False;
  end
  else if not fEmptyStr(edtDataInicial.Text) then
  begin
    if edtDataInicial.Date > edtDataFinal.Date then
    begin
      fMensagem('ATENÇÃO','O campo Data Final deve ser maior ou igual ao campo Data Inicial!', ['&OK']);
      Result := False;
    end
    else if DaysBetween(StrToDate(edtDataInicial.Text), StrToDate(edtDataFinal.Text)) > 60 then
    begin
      fMensagem('ATENÇÃO','O período entre as datas não pode ser superior a 60 dias!', ['&OK']);
      Result := False;
    end;
  end;
  if cbSituacao.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO','Selecione a Situação.', ['&OK']);
    Exit(False);
  end;
  if cbTipoData.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO','Selecione o Tipo de Data.', ['&OK']);
    Exit(False);
  end;
end;

end.
