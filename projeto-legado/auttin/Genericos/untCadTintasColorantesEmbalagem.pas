unit untCadTintasColorantesEmbalagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasColorantes, AppEvnts, Menus, StdCtrls, EditFocus, Mask, DBCtrls, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem,
  ExtCtrls, untICadastroTintaColorantesEmbalagem, DB, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadTintasColorantesEmbalagem = class(TfrmCadTintasColorantes)
    lblEmbalagem: TLabel;
    dbeEmbalagem: TDBEditFocus;
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeEmbalagemChange(Sender: TObject);
  private
    { Private declarations }
    cadastro: ICadastroTintaColorantesEmbalagem;
    procedure pAddMascara;
  protected
    procedure pConfigurarLabels; override;
    procedure pCriarDataSets; override;
    procedure pLigarDataSets; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaColorantesEmbalagem); reintroduce;
    { Public declarations }
  end;

var
  frmCadTintasColorantesEmbalagem: TfrmCadTintasColorantesEmbalagem;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasColorantesEmbalagem }

procedure TfrmCadTintasColorantesEmbalagem.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pAddMascara;
end;

procedure TfrmCadTintasColorantesEmbalagem.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pAddMascara;
end;

procedure TfrmCadTintasColorantesEmbalagem.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pAddMascara;
end;

constructor TfrmCadTintasColorantesEmbalagem.Create(AOwner: TComponent; cadastro: ICadastroTintaColorantesEmbalagem);
begin
  Self.cadastro := cadastro;
  inherited Create(AOwner, cadastro);
end;

procedure TfrmCadTintasColorantesEmbalagem.dbeEmbalagemChange(Sender: TObject);
begin
  inherited;
  pAddMascara;
end;

function TfrmCadTintasColorantesEmbalagem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if Sender = dbeEmbalagem then
    begin
      if fStrToFloat(dbeEmbalagem.Text) <= 0 then
      begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser preenchida e maior que zero!', ['OK']);
        Result := False;
      end;      
    end;  
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasColorantesEmbalagem.pAddMascara;
begin
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem)).DisplayFormat:= '0.0000';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem)).EditFormat   := '0.0000';

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).DisplayFormat := '0.0000';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).EditFormat    := '0.0000';
end;

procedure TfrmCadTintasColorantesEmbalagem.pConfigurarLabels;
begin
  inherited pConfigurarLabels;
  Self.lblEmbalagem.Caption := cadastro.fGetLabelEmbalagem + ':';
end;

procedure TfrmCadTintasColorantesEmbalagem.pCriarDataSets;
begin
  inherited pCriarDataSets;
  pAddMascara;
end;

procedure TfrmCadTintasColorantesEmbalagem.pLigarDataSets;
begin
  inherited pLigarDataSets;
  pLigarDataSets(dbeEmbalagem, lblEmbalagem, cadastro.fGetCampoEmbalagem);
end;

end.
