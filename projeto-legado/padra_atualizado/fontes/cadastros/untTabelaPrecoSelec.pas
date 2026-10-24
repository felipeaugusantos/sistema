unit untTabelaPrecoSelec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TfrmTabelaPrecoSelec = class(TfrmPaiConfirma)
    cklTabelas: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    blnErro: Boolean;
    VS_strTabPrcForPrincipal: String;
    function fInconsistenciaCfgTBOFPC: Boolean;
    function fValidaRegra(intIndice, intTabela: Integer): Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTabelaPrecoSelec: TfrmTabelaPrecoSelec;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmTabelaPrecoSelec.btnConfirmaClick(Sender: TObject);
begin
  blnErro := fInconsistenciaCfgTBOFPC;
  If Not blnErro Then
    inherited;
end;

procedure TfrmTabelaPrecoSelec.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If blnErro then
  Begin
    CanClose := False;
    blnErro := False;
  End

end;

procedure TfrmTabelaPrecoSelec.FormCreate(Sender: TObject);
  Var
    intIndice: Integer;
begin
  inherited;

  cklTabelas.Clear;

  VS_strTabPrcForPrincipal := fCfgSis('TBOFPC');

  blnErro := False;
  For intIndice := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intIndice] = 'S' Then
    begin
      cklTabelas.Items.Add('Tabela ' + intIndice.ToString);
      If  VS_strTabPrcForPrincipal[intIndice] = 'S' Then
        cklTabelas.Checked[cklTabelas.Items.Count -1] := True;

    End;


end;

function TfrmTabelaPrecoSelec.fInconsistenciaCfgTBOFPC: Boolean;
var intIndice: integer;
    intTabela: integer;
    strErro: String;
begin
  Result := False;
  strErro := '';
  For intIndice := 0 To cklTabelas.Count -1 do
  Begin
    intTabela := StrToInt(Copy(cklTabelas.Items[intIndice], 8, 1));
    If Not fValidaRegra(intIndice, intTabela) Then
    begin
      If StrErro = '' Then
        StrErro := 'Devido a configuração CFG_TBOFPC(Obrigar que a tabela de preço do fornecedor ativa, ' + #13 +
                   'ou que será ativada para o custo, tenha o mesmo fornecedor na tabela de preço, do fornecedor principal) ' + #13 +
                   'Então: ';
      strErro :=  strErro + #13 + cklTabelas.Items[intIndice] + ' deve ser marcada.';
    End;
  End;

  If strErro <> '' Then
  Begin
    pMensagemOk(strErro, 600, 250);
    Result := True;
  End;
end;

function TfrmTabelaPrecoSelec.fValidaRegra(intIndice, intTabela: Integer): Boolean;
Begin
  Result := True;
  If VS_strTabPrcForPrincipal[intTabela] = 'S' Then
    If VS_strTabPrcForPrincipal[intTabela] = 'S' Then
      If Not cklTabelas.Checked[intIndice] Then
        Result := False;
End;

end.
