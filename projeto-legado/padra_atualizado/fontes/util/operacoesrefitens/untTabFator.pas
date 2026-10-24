unit untTabFator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untTabQtd, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  ComboBoxFocus, EditFocus, Vcl.Buttons, BitBtnLockedIncrem, untPaiSimples,
  Vcl.ComCtrls;

type
  TfrmTabFator = class(TfrmTabQtd)
    edtFator1: TEditFocus;
    lblFator1: TLabel;
    lblFator2: TLabel;
    edtFator2: TEditFocus;
    lblFator3: TLabel;
    edtFator3: TEditFocus;
    lblFator4: TLabel;
    edtFator4: TEditFocus;
    lblFator5: TLabel;
    edtFator5: TEditFocus;
    lblFator7: TLabel;
    edtFator6: TEditFocus;
    lblFator6: TLabel;
    edtFator7: TEditFocus;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  function fVerificaTabelaProduto1a3(intContador: Integer; strTabela: String): Boolean;
  function fVerificaTabelaProduto4a6(intContador: Integer; strTabela: String): Boolean;
  function fVerificaTabelaProduto7(intContador: Integer; strTabela: String): Boolean;
  procedure pAjustaForm();
  procedure pHabilitaCampos(IntContador: Integer; intTopLabel: Integer; intTopEdit: Integer);
  public
    { Public declarations }
  strTabPreco: String;
  end;

var
  frmTabFator: TfrmTabFator;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmTabFator }

procedure TfrmTabFator.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaForm();
end;

function TfrmTabFator.fVerificaTabelaProduto4a6(intContador: Integer;
  strTabela: String): Boolean;
begin
  If intContador = 4 Then
  Begin
    If strTabela = '4' Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else If intContador = 5 Then
  Begin
    If strTabela = '5' Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else If intContador = 6 Then
  Begin
    If strTabela = '6' Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  Result := fVerificaTabelaProduto7(intContador, strTabela);
end;

function TfrmTabFator.fVerificaTabelaProduto7(intContador: Integer;
  strTabela: String): Boolean;
begin
  Result := True;

  If intContador = 7 Then
  Begin
    If strTabela = '7' Then
    Begin
      Result := False;
      Exit;
    End;
  End;
end;

function TfrmTabFator.fVerificaTabelaProduto1a3(intContador: Integer;
  strTabela: String): Boolean;
begin
  If intContador = 1 Then
  Begin
    If strTabela = '1' Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else If intContador = 2 Then
  Begin
    If strTabela = '2' Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else If intContador = 3 Then
  Begin
    If strTabela = '3' Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  Result := fVerificaTabelaProduto4a6(intContador, strTabela);
end;

procedure TfrmTabFator.pAjustaForm;
Var
  intContador: Integer;
  intTopLabel: Integer;
  intTopEdit: Integer;
begin
  intTopLabel := 2;
  intTopEdit := 22;
  For intContador := 1 To 7 Do
  Begin

    If Copy(strTabPreco, intContador, 1) = 'N' Then
      Continue;

    If Not fVerificaTabelaProduto1a3(intContador, fCfgSis('TABPRE')) Then
      Continue;

    intTopLabel := intTopLabel + 45;
    intTopEdit := intTopEdit + 45;

    If intContador <= 6 Then
    Begin
      pHabilitaCampos(intContador, intTopLabel, intTopEdit);
    End
    Else If intContador > 6 Then
    Begin
      lblFator7.Top := intTopLabel;
      edtFator7.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator7.Visible := True;
      edtFator7.Visible := True;
      lblFator7.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator7.Enabled := True;
    End;
  End;
end;

procedure TfrmTabFator.pHabilitaCampos(IntContador: Integer; intTopLabel: Integer; intTopEdit: Integer);
begin
    If IntContador = 1 Then
    Begin
      lblFator1.Top := intTopLabel;
      edtFator1.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator1.Visible := True;
      edtFator1.Visible := True;
      lblFator1.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator1.Enabled := True;
    End
    Else If IntContador = 2 Then
    Begin
      lblFator2.Top := intTopLabel;
      edtFator2.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator2.Visible := True;
      edtFator2.Visible := True;
      lblFator2.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator2.Enabled := True;
    End
    Else If IntContador = 3 Then
    Begin
      lblFator3.Top := intTopLabel;
      edtFator3.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator3.Visible := True;
      edtFator3.Visible := True;
      lblFator3.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator3.Enabled := True;
    End
    Else If IntContador = 4 Then
    Begin
      lblFator4.Top := intTopLabel;
      edtFator4.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator4.Visible := True;
      edtFator4.Visible := True;
      lblFator4.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator4.Enabled := True;
    End
    Else If IntContador = 5 Then
    Begin
      lblFator5.Top := intTopLabel;
      edtFator5.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator5.Visible := True;
      edtFator5.Visible := True;
      lblFator5.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator5.Enabled := True;
    End
    Else If IntContador = 6 Then
    Begin
      lblFator6.Top := intTopLabel;
      edtFator6.Top := intTopEdit;
      Self.ClientHeight := Self.ClientHeight + 50;
      lblFator6.Visible := True;
      edtFator6.Visible := True;
      lblFator6.Caption := 'Fator Pr. Venda ' + IntToStr(intContador) + ':';
      edtFator6.Enabled := True;
    End;
end;

end.
