unit untCadTintasBasesAutomotivaStandox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBasesAutomotiva, AppEvnts, Menus, Mask, DBCtrls,
  DBEditFocus, StdCtrls, Buttons, ComCtrls, ExtCtrls,
  untICadastroTintaBaseAutomotivaStandox, untIConsulta, DB, Math,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesAutomotivaStandox = class(TfrmCadTintasBasesAutomotiva)
    chkPesGra: TDBCheckBox;
    procedure dbeQualidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTipoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeLinhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cadastro: ICadastroTintaBaseAutomotivaStandox;
    consulta: IConsulta;
  protected
    procedure pLigarDataSets; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseAutomotivaStandox);
      reintroduce;

    { Public declarations }
  end;

var
  frmCadTintasBasesAutomotivaStandox: TfrmCadTintasBasesAutomotivaStandox;

implementation

uses untCadTintas, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesAutomotivaStandox }

constructor TfrmCadTintasBasesAutomotivaStandox.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseAutomotivaStandox);
begin
  Self.cadastro := cadastro;
  Self.consulta := cadastro.fGetConsulta;
  inherited Create(AOwner, cadastro);
end;

procedure TfrmCadTintasBasesAutomotivaStandox.pLigarDataSets;
begin
  inherited pLigarDataSets;
  pLigarDataSets(nil, nil, cadastro.fGetCampoPesoGrama, chkPesGra);
end;

procedure TfrmCadTintasBasesAutomotivaStandox.dbeQualidadeKeyPress(
  Sender: TObject; var Key: Char);
//  Var
//    arrQualidade: untICadastroTintaBaseAutomotivaStandox.TStringArray;
begin
  inherited;
  If (fEntraCons(Key)) {And (Not dbeQualidade.ReadOnly)} Then
  Begin
    Key := #0;
//    arrQualidade := cadastro.fGetArrayQualidades;
//    dbeQualidade.Field.AsString := arrQualidade[fGetMenu('Escolha a qualidade', arrQualidade, 1) - 1];
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTintasBasesAutomotivaStandox.dbeTipoKeyPress(
  Sender: TObject; var Key: Char);
begin
{  If (fEntraCons(Key)) And (Not dbeTipo.ReadOnly) Then
  Begin
    Key := #0;
    arrTipo := cadastro.fGetArrayTipos;
    dbeTipo.Field.AsString := arrTipo[fGetMenu('Escolha o tipo', arrTipo, 1) - 1];
    SelectNext(ActiveControl, True, True);
  End;}
end;

procedure TfrmCadTintasBasesAutomotivaStandox.dbeLinhaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
{  If (fEntraCons(Key)) And (Not dbeLinha.ReadOnly) Then
  Begin
    Key := #0;
    arrLinha := cadastro.fGetArrayLinhas;
    dbeLinha.Field.AsString := arrLinha[fGetMenu('Escolha a linha', arrLinha, 1) - 1];
    SelectNext(ActiveControl, True, True);
  End;}
end;

procedure TfrmCadTintasBasesAutomotivaStandox.pSetaEnableReadOnly(
  DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);
end;

end.
