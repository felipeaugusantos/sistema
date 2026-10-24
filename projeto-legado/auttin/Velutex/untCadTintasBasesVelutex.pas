unit untCadTintasBasesVelutex;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untCadTintasBases, Mask, DBCtrls, 
  Uni,  AppEvnts, Menus, StdCtrls, EditFocus, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesVelutex = class(TfrmCadTintasBases)
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadTintasBasesVelutex: TfrmCadTintasBasesVelutex;

implementation

uses untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadTintasBasesVelutex }

procedure TfrmCadTintasBasesVelutex.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  inherited;
end;

procedure TfrmCadTintasBasesVelutex.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  if fPesqUnidade(Self, dbeCodUni, nil, nil, nil, Key, arrSel, true, false, false, 'AND UNI_CODUNI IN ("LT","GL","LA")' ) then
     SelectNext(ActiveControl, True, True);
end;

function TfrmCadTintasBasesVelutex.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);
end;

end.
