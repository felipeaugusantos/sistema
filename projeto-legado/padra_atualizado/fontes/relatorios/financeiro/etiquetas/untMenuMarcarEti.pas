unit untMenuMarcarEti;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, Grids, Buttons, ExtCtrls, {Qt,} Menus,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmMenuMarcarEti = class(TfrmPai)
    stgOpcoes: TStringGrid;
    procedure stgOpcoesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure stgOpcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgOpcoesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intLinha: Integer;
    blnConfirma: Boolean;
    blnEtiIte : Boolean;
  end;

var
  frmMenuMarcarEti: TfrmMenuMarcarEti;

implementation

uses untConstantes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmMenuMarcarEti.stgOpcoesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  intLinha := ARow;
end;

procedure TfrmMenuMarcarEti.FormShow(Sender: TObject);
begin
  inherited;

  {***************************************************}
  {* QUANDO USA ARMAZEM NÃO PERMITE SELECIONAR TODAS *}
  {************************************************RN*}
  stgOpcoes.RowCount := 3;

  If (fCfgSis('CTLEST') = '2') And (blnEtiIte) Then
    stgOpcoes.Cells[0, ETI_MARCAR]    := ''
  Else
    stgOpcoes.Cells[0, ETI_MARCAR]    := 'MARCAR TODAS';

  stgOpcoes.Cells[0, ETI_DESMARCAR] := 'DESMARCAR TODAS';
  stgOpcoes.Cells[0, ETI_CANCELAR]  := 'CANCELAR';
end;

procedure TfrmMenuMarcarEti.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmMenuMarcarEti.stgOpcoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return)   And
     (stgOpcoes.Enabled) Then
  Begin
    If intLinha <> ETI_CANCELAR Then
    Begin
      stgOpcoes.Enabled := False;
      blnConfirma := True;
    End;
    Close
  End
  Else If (Key = VK_Escape) Then
    Close;
end;

procedure TfrmMenuMarcarEti.stgOpcoesDblClick(Sender: TObject);
  Var
    Key: Word;
    Shift: TShiftState;
begin
  inherited;
  Key := VK_Return;
  stgOpcoes.OnKeyDown(Sender, Key, Shift);
end;

end.
