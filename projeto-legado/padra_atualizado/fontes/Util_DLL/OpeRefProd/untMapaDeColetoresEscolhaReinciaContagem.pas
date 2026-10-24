unit untMapaDeColetoresEscolhaReinciaContagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TOpcReiniciaContagem = (opcrcDivergentes, opcrcUltimaContagem, opcrcTotal, opcrcTotalLocalizacao, opcrcIndefinido);

  TfrmMapaDeColetoresEscolhaReinciaContagem = class(TfrmPai)
    rdgOpcao: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    OpcReiniciaContagem: TOpcReiniciaContagem;
  public
    { Public declarations }
    class function fCallEscolhaReinciaContagem(strLocFis: string): TOpcReiniciaContagem;
  end;

var
  frmMapaDeColetoresEscolhaReinciaContagem: TfrmMapaDeColetoresEscolhaReinciaContagem;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmMapaDeColetoresEscolhaReinciaContagem }

procedure TfrmMapaDeColetoresEscolhaReinciaContagem.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  case rdgOpcao.ItemIndex of
    0: OpcReiniciaContagem := opcrcDivergentes;
    1: OpcReiniciaContagem := opcrcUltimaContagem;
    2: OpcReiniciaContagem := opcrcTotal;
    3: OpcReiniciaContagem := opcrcTotalLocalizacao;

  end
end;

class function TfrmMapaDeColetoresEscolhaReinciaContagem.fCallEscolhaReinciaContagem(strLocFis: string): TOpcReiniciaContagem;
begin
  pCriarFormularios(TfrmMapaDeColetoresEscolhaReinciaContagem, frmMapaDeColetoresEscolhaReinciaContagem);
  Try
    frmMapaDeColetoresEscolhaReinciaContagem.OpcReiniciaContagem := opcrcIndefinido;
    frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Caption := Format(frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Caption, [strLocFis]);
    frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Items.Clear;
    frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Items.Add('Iniciar Nova Contagem  Para  Divergentes');
    frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Items.Add('Reiniciar Última Contagem');
    frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Items.Add('Reiniciar Todas as Localizações (Todas as contagens serão excuídas)');
    frmMapaDeColetoresEscolhaReinciaContagem.rdgOpcao.Items.Add(Format('Reiniciar toda a Localização %s  (Todas as contagens serão excuídas)', [strLocFis]));
    frmMapaDeColetoresEscolhaReinciaContagem.caption := 'Opções para Reinicio de Contagem.';

    frmMapaDeColetoresEscolhaReinciaContagem.Showmodal;
    Result := frmMapaDeColetoresEscolhaReinciaContagem.OpcReiniciaContagem;
  Finally
    FreeAndNil(frmMapaDeColetoresEscolhaReinciaContagem);
  End;
end;

end.
