unit untCadTintasBasesIquine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untCadTintasBases, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Vcl.Buttons, Vcl.ComCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, DBComboBoxFocus, untICadastroTintaBaseIquine,
  Uni;

type
  TfrmCadTintasBasesIquine = class(TfrmCadTintasBases)
    lblProduto: TLabel;
    dbeProduto: TDBComboBoxFocus;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cadastro: ICadastroTintaBaseIquine;
  protected
    procedure pLigarDataSets; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseIquine); reintroduce;
  end;

var
  frmCadTintasBasesIquine: TfrmCadTintasBasesIquine;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesIquine }

constructor TfrmCadTintasBasesIquine.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseIquine);
begin
  Self.cadastro := cadastro;
  inherited Create(AOwner, cadastro);
end;

procedure TfrmCadTintasBasesIquine.FormShow(Sender: TObject);
var
  qryProd: TUniQuery;
begin
  inherited;
  Try
    qryProd := fCriaQuery(Nil);
    With qryProd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT(BAS_PRODUT) ');
      SQL.Add('   FROM IQU_CADBAS           ');
      Open;

      First;
      While Not Eof Do
      Begin
        dbeProduto.Items.Add(FieldByName('BAS_PRODUT').AsString);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryProd);
  End;
end;

function TfrmCadTintasBasesIquine.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = dbeProduto) Then
    Begin
      If fEmptyStr(dbeProduto.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento do campo produto !', ['OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasBasesIquine.pLigarDataSets;
begin
  inherited pLigarDataSets;
  dbeProduto.DataField := cadastro.fGetCampoProduto;
end;

end.
