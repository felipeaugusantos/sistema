unit untPagForAPIRetPagForFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Vcl.ExtCtrls, System.DateUtils, untTiposPagFor, System.StrUtils;

type
  TfraPagForAPIRetPagForFrame = class(TFrame)
    pnlItens: TPanel;
    lblPeriodoImportacao: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    pnlTopo: TPanel;
    edtDataInicial: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    gbCarteira: TGroupBox;
    lblDadosDaConta: TLabel;
  private
    { Private declarations }
  public
    function ValidarDados: Boolean;

    procedure CarregarDadosCarteira(ADadosCarteira: TPagForAPIDadosCarteira);
    { Public declarations }
  end;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

{ TfraPagForAPIRetPagForFrame }

procedure TfraPagForAPIRetPagForFrame.CarregarDadosCarteira(
  ADadosCarteira: TPagForAPIDadosCarteira);
begin
  lblDadosDaConta.Caption := Concat(
                             'Banco: ', ADadosCarteira.CodigoBanco, ' - ', fRetNomeBancoSelec(ADadosCarteira.CodigoBanco), ' [Online]', #13#10,
                             'Carteira selec.: ', RightStr(ADadosCarteira.ConfiguracaoSemEmpresa, 1), #13#10,
                             'Agência: ',         ADadosCarteira.CodigoAgencia, '-',
                                                  ADadosCarteira.DigitoAgencia, #13#10,
                             'Conta Corrente: ',  ADadosCarteira.ContaCorrente +
                                                  ADadosCarteira.DigitoContaCorrente);
end;

function TfraPagForAPIRetPagForFrame.ValidarDados: Boolean;
begin
  Result := True;

  If fEmptyStr(edtDataInicial.Text) Then
  Begin
    fMensagem('ATENÇÃO','O campo Data Inicial deve ser preenchido!', ['&OK']);
    Result := False;
  End
  Else If fEmptyStr(edtDataInicial.Text) Then
  Begin
    fMensagem('ATENÇÃO','O campo Data Final deve ser preenchido!', ['&OK']);
    Result := False;
  End
  Else If Not fEmptyStr(edtDataInicial.Text) Then
  Begin
    If edtDataInicial.Date > edtDataFinal.Date Then
    Begin
      fMensagem('ATENÇÃO','O campo Data Final deve ser maior ou igual ao campo Data Inicial!', ['&OK']);
      Result := False;
    End
    Else If DaysBetween(StrToDate(edtDataInicial.Text), StrToDate(edtDataFinal.Text)) > 10 Then
    Begin
      fMensagem('ATENÇÃO','O o período entre as datas não pode ser superior a 10 dias!', ['&OK']);
      Result := False;
    End;
  End;
end;

end.
