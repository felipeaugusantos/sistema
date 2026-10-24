unit untIformacoesAdicionaisICMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untPai, untFuncoesSimples;

type
  TfrmInfAdicionaisICMS = class(TfrmPai)
    pnlConvenio: TPanel;
    pnlAmparoLegal: TPanel;
    Label4: TLabel;
    memAmparoLegal: TMemo;
    pnlProtocolo: TPanel;
    Label1: TLabel;
    memprotocolo: TMemo;
    memConvenio: TMemo;
    Label3: TLabel;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure pChamaInfAdcICMS(AmparoLegal,
                                     NomeProtocolo,
                                     DescProtocolo,
                                     NomeConvenio,
                                     DescConvenio: String);




  end;

var
  frmInfAdicionaisICMS: TfrmInfAdicionaisICMS;

implementation

{$R *.dfm}

{ TfrmInfAdicionaisICMS }

class procedure TfrmInfAdicionaisICMS.pChamaInfAdcICMS(AmparoLegal,
  NomeProtocolo, DescProtocolo, NomeConvenio, DescConvenio: String);
begin
  pCriarFormularios(TfrmInfAdicionaisICMS, frmInfAdicionaisICMS);
  Try
    frmInfAdicionaisICMS.memAmparoLegal.Text :=  AmparoLegal;
    frmInfAdicionaisICMS.memprotocolo.Text :=  NomeProtocolo + #$A#$D + DescProtocolo;
    frmInfAdicionaisICMS.memConvenio.Text  :=  NomeConvenio + #$A#$D + DescConvenio;
    frmInfAdicionaisICMS.ShowModal;
  Finally
    FreeAndNil(frmInfAdicionaisICMS);
  End;
end;

end.
