unit untCadTintasBasesWeg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBases, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, Buttons, ComCtrls, ExtCtrls,
  untICadastroTintaBaseWeg, Math, DB,  BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesWeg = class(TfrmCadTintasBases)
    lblProdKey: TLabel;
    dbeProdKey: TDBEditFocus;
    lblSubKey: TLabel;
    dbeSubKey: TDBEditFocus;
  private
    { Private declarations }
    cadastro: ICadastroTintaBaseWeg;
  protected
    procedure pLigarDataSets; override;
    procedure pConfigurarLabels; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseWeg); reintroduce;
  end;

var
  frmCadTintasBasesWeg: TfrmCadTintasBasesWeg;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesWeg }

constructor TfrmCadTintasBasesWeg.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseWeg);
begin
  Self.cadastro := cadastro;
  Inherited Create(AOwner, cadastro);
end;

function TfrmCadTintasBasesWeg.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = dbeProdKey) Then
    begin
      If fEmptyStr(dbeProdKey.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Prod. Key deve ser preenchido!', ['OK']);
        Result := False;
      End;
    End
    Else If (Sender = dbeSubKey) Then
    Begin
      If fEmptyStr(dbeSubKey.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Sub. Key deve ser preenchido!', ['OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasBasesWeg.pConfigurarLabels;
begin
  inherited pConfigurarLabels;
  
  lblProdKey.Caption := cadastro.fGetLabelProdKey() + ':';
  lblSubKey.Caption := cadastro.fGetLabelSubKey() + ':';
end;

procedure TfrmCadTintasBasesWeg.pLigarDataSets;
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

procedure TfrmCadTintasBasesWeg.pSetaEnableReadOnly(DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);

  dbeProdKey.Enabled := dbeCodigo.Enabled;
  dbeSubKey.Enabled := dbeCodigo.Enabled;
end;

end.
