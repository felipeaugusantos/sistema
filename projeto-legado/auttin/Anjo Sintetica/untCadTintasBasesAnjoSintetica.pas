unit untCadTintasBasesAnjoSintetica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBases, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, Buttons, ComCtrls, ExtCtrls,
  untICadastroTintaBaseAnjoSintetica, Math, DB,  BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesAnjoSintetica = class(TfrmCadTintasBases)
    lblProdKey: TLabel;
    dbeProdKey: TDBEditFocus;
    lblSubKey: TLabel;
    dbeSubKey: TDBEditFocus;
  private
    { Private declarations }
    cadastro: ICadastroTintaBaseAnjoSintetica;
  protected
    procedure pLigarDataSets; override;
    procedure pConfigurarLabels; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseAnjoSintetica); reintroduce;
  end;

var
  frmCadTintasBasesAnjoSintetica: TfrmCadTintasBasesAnjoSintetica;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesAnjoSintetica }

constructor TfrmCadTintasBasesAnjoSintetica.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseAnjoSintetica);
begin
  Self.cadastro := cadastro;
  Inherited Create(AOwner, cadastro);
end;

procedure TfrmCadTintasBasesAnjoSintetica.pConfigurarLabels;
begin
  inherited pConfigurarLabels;
  
  lblProdKey.Caption := cadastro.fGetLabelProdKey() + ':';
  lblSubKey.Caption := cadastro.fGetLabelSubKey() + ':';
end;

procedure TfrmCadTintasBasesAnjoSintetica.pLigarDataSets;
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

procedure TfrmCadTintasBasesAnjoSintetica.pSetaEnableReadOnly(DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);

  dbeProdKey.Enabled := dbeCodigo.Enabled;
  dbeSubKey.Enabled := dbeCodigo.Enabled;
end;

function TfrmCadTintasBasesAnjoSintetica.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If (Result) Then
  Begin
    If Sender = dbeProdKey Then
    Begin
      If fEmptyStr(dbeProdKey.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'É necessário preencher o campo "Prod. Key"!', ['OK']);
        Result := False;
      End;
    End
    Else If Sender = dbeSubKey Then
    Begin
      If fEmptyStr(dbeSubKey.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'É necessário preencher o campo "Sub. Key"!', ['OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
