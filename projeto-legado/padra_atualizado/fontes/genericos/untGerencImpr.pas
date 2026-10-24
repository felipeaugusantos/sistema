unit untGerencImpr;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, Grids, Buttons, ExtCtrls, {Qt,} Menus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmGerencImpr = class(TfrmPai)
    stgFilas: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure stgFilasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgFilasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    strNomeFila: String;
    intLinha: Integer;
  public
    { Public declarations }
  end;

implementation

uses untfuncoesSimples, untCfgRel;

{$R *.dfm}

procedure TfrmGerencImpr.FormCreate(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  pRetFilasImpressao(TCfgRel.arrFilas);
  intLinha := 1;
  stgFilas.RowCount := Length(TCfgRel.arrFilas) + 1;

  stgFilas.ColWidths[0] := 300;
  stgFilas.ColWidths[1] := 60;

  stgFilas.Cells[0, 0] := 'Nome da Fila';
  stgFilas.Cells[1, 0] := 'Mostrar';

  For intContador := 0 To Length(TCfgRel.arrFilas) -1 Do
  Begin

    stgFilas.Cells[0, intContador+1] := TCfgRel.arrFilas[intContador].strNomeFila;
    If TCfgRel.arrFilas[intContador].blnMostrar Then
      stgFilas.Cells[1, intContador+1] := 'Sim'
    Else
      stgFilas.Cells[1, intContador+1] := 'Não';

  End;
end;

procedure TfrmGerencImpr.stgFilasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intRetorno: Integer;
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    intRetorno := fMensagem('', 'Mostrar Fila?', ['&Sim', '&Não', '&Cancelar']);
    If intRetorno = 1 Then
    Begin
      stgFilas.Cells[1, intLinha] := 'Sim';
      TCfgRel.arrFilas[intLinha-1].blnMostrar := True;
    End
    Else If intRetorno = 2 Then
    Begin
      stgFilas.Cells[1, intLinha] := 'Não';
      TCfgRel.arrFilas[intLinha-1].blnMostrar := False;
    End;
    pSetFocus(stgFilas)
  End
  Else If (Key = VK_Escape) Then
    Close;
end;

procedure TfrmGerencImpr.stgFilasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  intLinha := ARow;
  strNomeFila := stgFilas.Cells[0, ARow];
end;

end.


