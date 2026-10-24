unit untCopiaComissao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmCopiaComissao = class(TfrmPai)
    Panel1: TPanel;
    FlowPanel1: TFlowPanel;
    chkComVar: TCheckBox;
    chkComAta: TCheckBox;
    chkComDis: TCheckBox;
    pnlTabela: TPanel;
    chkTabela4: TCheckBox;
    chkTabela7: TCheckBox;
    chkTabela6: TCheckBox;
    chkTabela5: TCheckBox;
    chkTabela3: TCheckBox;
    chkTabela2: TCheckBox;
    chkTabela1: TCheckBox;
    btnAdicionar: TBitBtnLocked;
    flwpnlTabelas: TFlowPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pMostraTabelaPrecoConfigurada;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCopiaComissao.btnAdicionarClick(Sender: TObject);
var
  intIndice,
  intTotTabela: integer;
begin
  inherited;
  intTotTabela := 0;

  for intIndice := 0 to flwpnlTabelas.ControlCount - 1 do
  begin
    if flwpnlTabelas.Controls[intIndice] is TCheckBox then
    begin
      if (TCheckBox(flwpnlTabelas.Controls[intIndice]).Visible) then
      begin
        if (TCheckBox(flwpnlTabelas.Controls[intIndice]).Checked) then
        begin
          Inc(intTotTabela);
        end;
      end;
    end;
  end;

  if intTotTabela = 0 then
  begin
    fMensagem('','Informe ao menos uma tabela!', ['&Ok']);
    pSetFocus(chkTabela1);
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TfrmCopiaComissao.FormCreate(Sender: TObject);
begin
  inherited;
  chkComVar.Checked := True;
  chkComAta.Checked := True;
  chkComDis.Checked := True;
end;

procedure TfrmCopiaComissao.FormShow(Sender: TObject);
begin
  inherited;
  pMostraTabelaPrecoConfigurada;
end;

procedure TfrmCopiaComissao.pMostraTabelaPrecoConfigurada;
var
  strTabelas: string;
  intIndice: integer;
begin
  strTabelas := fCfgSis('TABPRC');

  for intIndice := 1 to Length(strTabelas) do
  begin
    case intIndice of
      1:begin
        chkTabela1.Visible := strTabelas[intIndice] = 'S';
        chkTabela1.Checked := chkTabela1.Visible;
      end;

      2:begin
        chkTabela2.Visible := strTabelas[intIndice] = 'S';
        chkTabela2.Checked := chkTabela2.Visible;
      end;

      3:begin
        chkTabela3.Visible := strTabelas[intIndice] = 'S';
        chkTabela3.Checked := chkTabela3.Visible;
      end;

      4:begin
        chkTabela4.Visible := strTabelas[intIndice] = 'S';
        chkTabela4.Checked := chkTabela4.Visible;
      end;

      5:begin
        chkTabela5.Visible := strTabelas[intIndice] = 'S';
        chkTabela5.Checked := chkTabela5.Visible;
      end;

      6:begin
        chkTabela6.Visible := strTabelas[intIndice] = 'S';
        chkTabela6.Checked := chkTabela6.Visible;
      end;

      7:begin
        chkTabela7.Visible := strTabelas[intIndice] = 'S';
        chkTabela7.Checked := chkTabela7.Visible;
      end;
    end;
  end;
end;

end.
