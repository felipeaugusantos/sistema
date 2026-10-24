unit untCadTintasBasesAnjo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBases, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, Buttons, ComCtrls, ExtCtrls,
  untICadastroTintaBaseAnjo, Math, DB,  BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesAnjo = class(TfrmCadTintasBases)
    lblProdKey: TLabel;
    dbeProdKey: TDBEditFocus;
    lblSubKey: TLabel;
    dbeSubKey: TDBEditFocus;
  private
    { Private declarations }
    cadastro: ICadastroTintaBaseAnjo;
  protected
    procedure pLigarDataSets; override;
    procedure pConfigurarLabels; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseAnjo); reintroduce;
  end;

var
  frmCadTintasBasesAnjo: TfrmCadTintasBasesAnjo;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesAnjo }

constructor TfrmCadTintasBasesAnjo.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseAnjo);
begin
  Self.cadastro := cadastro;
  Inherited Create(AOwner, cadastro);
end;

function TfrmCadTintasBasesAnjo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeProdKey) then
    begin
      If fEmptyStr(dbeProdKey.Text) Then
      begin
        fMensagem('ATENÇÃO!', 'O Campo Prod. Key precisa ser preenchido !', ['OK']);
        Result := False;
      end;
    end

    Else if (Sender = dbeSubKey) then
    begin
      If fEmptyStr(dbeSubKey.Text) Then
      begin
        fMensagem('ATENÇÃO!', 'O Campo Sub. Key precisa ser preenchido !', ['OK']);
        Result := False;
      end;
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasBasesAnjo.pConfigurarLabels;
begin
  inherited pConfigurarLabels;
  
  lblProdKey.Caption := cadastro.fGetLabelProdKey() + ':';
  lblSubKey.Caption := cadastro.fGetLabelSubKey() + ':';
end;

procedure TfrmCadTintasBasesAnjo.pLigarDataSets;
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

procedure TfrmCadTintasBasesAnjo.pSetaEnableReadOnly(DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);

  dbeProdKey.Enabled := dbeCodigo.Enabled;
  dbeSubKey.Enabled := dbeCodigo.Enabled;
end;

end.
