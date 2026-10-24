unit untCadTintasBasesResicolor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBases, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, Buttons, ComCtrls, ExtCtrls,
  untICadastroTintaBaseResicolor, Math, DB, BitBtnLockedIncrem;

type
  TfrmCadTintasBasesResicolor = class(TfrmCadTintasBases)
    lblProdKey: TLabel;
    dbeProdKey: TDBEditFocus;
    lblSubKey: TLabel;
    dbeSubKey: TDBEditFocus;
  private
    cadastro: ICadastroTintaBaseResicolor;
  protected
    procedure pLigarDataSets; override;
    procedure pConfigurarLabels; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseResicolor); reintroduce;

    { Public declarations }
  end;

var
  frmCadTintasBasesResicolor: TfrmCadTintasBasesResicolor;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesResicolor }

constructor TfrmCadTintasBasesResicolor.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseResicolor);
begin
  Self.cadastro := cadastro;
  Inherited Create(AOwner, cadastro);
end;

procedure TfrmCadTintasBasesResicolor.pConfigurarLabels;
begin
  inherited pConfigurarLabels;
  
  lblProdKey.Caption := cadastro.fGetLabelProdKey() + ':';
  lblSubKey.Caption := cadastro.fGetLabelProdKey() + ':';
end;

procedure TfrmCadTintasBasesResicolor.pLigarDataSets;
begin
  inherited pLigarDataSets;

  dbeProdKey.DataField := cadastro.fGetCampoProdKey();
  dbeProdKey.Visible := Not fEmptyStr(cadastro.fGetCampoProdKey);
  dbeProdKey.Tag := IfThen(dbeProdKey.Visible, 99, 0);
  dbeProdKey.Visible := Not fEmptyStr(cadastro.fGetCampoProdKey);

  dbeSubKey.DataField := cadastro.fGetCampoSubKey();
  dbeSubKey.Visible := Not fEmptyStr(cadastro.fGetCampoSubKey);
  dbeSubKey.Tag := IfThen(dbeSubKey.Visible, 99, 0);
  dbeSubKey.Visible := Not fEmptyStr(cadastro.fGetCampoSubKey);
end;

procedure TfrmCadTintasBasesResicolor.pSetaEnableReadOnly(
  DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);

  dbeProdKey.Enabled := dbeCodigo.Enabled;
  dbeSubKey.Enabled := dbeCodigo.Enabled;
end;

end.
