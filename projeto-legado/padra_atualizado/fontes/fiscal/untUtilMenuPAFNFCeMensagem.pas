unit untUtilMenuPAFNFCeMensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni;

type
  TfrmUtilMenuPAFNFCeMensagem = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    mmoAlerta: TMemo;
    procedure FormShow(Sender: TObject);
    function fRetornaPassos : String;
  private
    { Private declarations }


  public
    strMensagem : String;
  end;

var
  frmUtilMenuPAFNFCeIdentificacao: TfrmUtilMenuPAFNFCeMensagem;

implementation

uses
  untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmUtilMenuPAFNFCeMensagem }


procedure TfrmUtilMenuPAFNFCeMensagem.FormShow(Sender: TObject);
begin
  inherited;

  mmoAlerta.Lines.Clear;
  mmoAlerta.Lines.Add(strMensagem);
  mmoAlerta.Lines.Add(fRetornaPassos);
end;

function TfrmUtilMenuPAFNFCeMensagem.fRetornaPassos: String;
begin
  Result := #13#10;
  Result := Result + 'Passos para realizar a atualização do certificado digital:' + #13#10;
  Result := Result + '    -Acessar a Manutenção de Empresas em >Principal>Manutenção de Cadastros>Auxiliares>Empresas;' + #13#10;
  Result := Result + '    -Pesquisar a Empresa ' + VS_strCodEmp + ' e utilizar o botão no que está no rodapé da tela, chamado "Certificado Digital".';
end;

end.

