unit untVerificaIntegridadeCaixa2;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Menus, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem;

type
  TfrmVerificaIntegridadeCaixa2 = class(TfrmPaiSimples)
    pnlFaltantes: TPanel;
    pnlDivergentes: TPanel;
    pnlBotoesIntegrigade: TPanel;
    lsvFaltantes: TListView;
    lsvDivergentes: TListView;
    svdSalvar: TSaveDialog;
    btnSairIntegridade: TBitBtnLocked;
    btnSalvar: TBitBtnLocked;
    procedure btnSairIntegridadeClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pAppendItens(lsvFal, lsvDiv: TListView);
  end;

var
  frmVerificaIntegridadeCaixa2: TfrmVerificaIntegridadeCaixa2;

implementation

uses  untfuncoesSimples, untPai;

{$R *.dfm}

procedure TfrmVerificaIntegridadeCaixa2.pAppendItens(lsvFal, lsvDiv: TListView);
  Var
    intContador1: Integer;
    intContador2: Integer;
begin

  lsvDiv.Visible := False;
  lsvFal.Visible := False;

  For intContador1 := 0 To lsvFal.Items.Count -1 Do
  Begin
    lsvFaltantes.Items.Add;
    lsvFaltantes.Items[intContador1].Caption := lsvFal.Items[intContador1].Caption;

    For intContador2 := 0 To lsvFal.Items[intContador1].SubItems.Count -1 Do
    Begin
      lsvFaltantes.Items[intContador1].SubItems.Add(lsvFal.Items[intContador1].SubItems[intContador2]);
    End;

  End;

  For intContador1 := 0 To lsvDiv.Items.Count -1 Do
  Begin
    lsvDivergentes.Items.Add;
    lsvDivergentes.Items[intContador1].Caption := lsvDiv.Items[intContador1].Caption;

    For intContador2 := 0 To lsvDiv.Items[intContador1].SubItems.Count -1 Do
    Begin
      lsvDivergentes.Items[intContador1].SubItems.Add(lsvDiv.Items[intContador1].SubItems[intContador2]);
    End;

  End;

end;

procedure TfrmVerificaIntegridadeCaixa2.btnSairIntegridadeClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmVerificaIntegridadeCaixa2.btnSalvarClick(Sender: TObject);
  Var
    txtArquivo: TextFile;
    intContador: Integer;
    strLinha: String;
begin
  inherited;

  If svdSalvar.Execute Then
  Begin

    Screen.Cursor := crHourGlass;
    If (Not fEmptyStr(svdSalvar.FileName)) Then
    Begin

      AssignFile(txtArquivo, svdSalvar.FileName);
      Rewrite(txtArquivo);

      WriteLn(txtArquivo, 'Coluna Faltando          no arquivo');      
      If lsvFaltantes.Items.Count > 0 Then
      Begin

        For intContador := 0 To lsvFaltantes.Items.Count -1 Do
        Begin
          strLinha := fPadR(lsvFaltantes.Items[intContador].Caption, 25);
          strLinha := strLinha + lsvFaltantes.Items[intContador].SubItems[0];
          WriteLn(txtArquivo, strLinha);
        End;

      End;

      WriteLn(txtArquivo, '');
      WriteLn(txtArquivo, 'Coluna Faltando          no arquivo     Motivo');
      If lsvDivergentes.Items.Count > 0 Then
      Begin

        For intContador := 0 To lsvDivergentes.Items.Count -1 Do
        Begin
          strLinha := fPadR(lsvDivergentes.Items[intContador].Caption, 25);
          strLinha := strLinha + fPadR(lsvDivergentes.Items[intContador].SubItems[0], 15);
          strLinha := strLinha + lsvDivergentes.Items[intContador].SubItems[1];
          WriteLn(txtArquivo, strLinha);
        End;


      End;
      WriteLn(txtArquivo, '');

      Flush(txtArquivo);
      CloseFile(txtArquivo);


    End;
    Screen.Cursor := crDefault;

  End;
end;

procedure TfrmVerificaIntegridadeCaixa2.FormShow(Sender: TObject);
begin
  inherited;
  pnlNomeForm.Caption := '';
  pSetFocus(btnSalvar);
end;

end.

