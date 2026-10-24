unit untInfAdicEtiqItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  ComboBoxFocus, EditFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmInfAdicEtiqItens = class(TfrmPaiConfirma)
    edtInfAdi: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    strCodIte: String;
    { Public declarations }
    blnSomInfAdi: Boolean;
  end;

var
  frmInfAdicEtiqItens: TfrmInfAdicEtiqItens;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmInfAdicEtiqItens.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

  End;

  If Not Result Then
    pSetFocus(Sender);
    
end;


procedure TfrmInfAdicEtiqItens.FormCreate(Sender: TObject);
begin
  inherited;
  strCodIte := EmptyStr;
end;

procedure TfrmInfAdicEtiqItens.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  if Not fEmptyStr(strCodIte) then
    Self.Caption := Format('Informação Adicional Etiqueta de Itens [%s]',[strCodIte]);
end;

end.
