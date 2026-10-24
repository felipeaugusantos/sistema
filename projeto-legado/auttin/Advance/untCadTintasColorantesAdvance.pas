unit untCadTintasColorantesAdvance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasColorantes, AppEvnts, Menus, StdCtrls, EditFocus, Mask, DBCtrls,
  DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem, ExtCtrls, untICadastroTintaColorantesAdvance,
  DB, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasColorantesAdvance = class(TfrmCadTintasColorantes)
    lblEmbalagem: TLabel;
    dbeEmbalagem: TDBEditFocus;
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeEmbalagemChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    cadastro: ICadastroTintaColorantesAdvance;
    procedure pAddMascara;
  protected
    procedure pConfigurarLabels; override;
    procedure pCriarDataSets; override;
    procedure pLigarDataSets; override;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaColorantesAdvance); reintroduce;
    { Public declarations }
  end;

var
  frmCadTintasColorantesAdvance: TfrmCadTintasColorantesAdvance;

implementation

{$R *.dfm}

{ TfrmCadTintasColorantesAdvance }

procedure TfrmCadTintasColorantesAdvance.btnAlterarClick(Sender: TObject);
begin
  pAddMascara;
  inherited;

end;

procedure TfrmCadTintasColorantesAdvance.btnCancelaClick(Sender: TObject);
begin
  pAddMascara;
  inherited;
end;

procedure TfrmCadTintasColorantesAdvance.btnIncluirClick(Sender: TObject);
begin
  pAddMascara;
  inherited;
end;

procedure TfrmCadTintasColorantesAdvance.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pAddMascara;
end;

constructor TfrmCadTintasColorantesAdvance.Create(AOwner: TComponent; cadastro: ICadastroTintaColorantesAdvance);
begin
  Self.cadastro := cadastro;
  inherited Create(AOwner, cadastro);
end;

procedure TfrmCadTintasColorantesAdvance.dbeEmbalagemChange(Sender: TObject);
begin
  inherited;
//  dbeEmbalagem.Text := FormatFloat('0.0000', qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem).AsFloat);
  pAddMascara
end;

procedure TfrmCadTintasColorantesAdvance.pAddMascara;
begin
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem)).DisplayFormat := '0.0000';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem)).EditFormat    := '0.0000';

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).DisplayFormat := '0.0000';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).EditFormat    := '0.0000';

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).DisplayFormat  := '0.0000';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).EditFormat     := '0.0000';

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).DisplayFormat := '0.0000';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).EditFormat    := '0.0000';
end;

procedure TfrmCadTintasColorantesAdvance.pConfigurarLabels;
begin
  inherited pConfigurarLabels;
  lblEmbalagem.Caption := cadastro.fGetLabelEmbalagem;
end;

procedure TfrmCadTintasColorantesAdvance.pCriarDataSets;
begin
  inherited pCriarDataSets;
  pAddMascara;
end;

procedure TfrmCadTintasColorantesAdvance.pLigarDataSets;
begin
  inherited pLigarDataSets;
  pLigarDataSets(dbeEmbalagem, lblEmbalagem, cadastro.fGetCampoEmbalagem);
end;

end.
