unit untOpcaoCancelamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmOpcaoCancelamento = class(TfrmPaiConfirma)
    Panel2: TPanel;
    lsbEspecies: TListBox;
    Panel1: TPanel;
    Label1: TLabel;
    lblSelecionado: TLabel;
    btnRestaurarOpcaoOriginal: TBitBtnLocked;
    procedure lsbEspeciesDblClick(Sender: TObject);
    procedure lsbEspeciesClick(Sender: TObject);
    procedure lsbEspeciesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRestaurarOpcaoOriginalClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FOpcaoDefault : String;
    procedure SetaSelecionado;
    procedure Selecionar(const AOpcao: String);
  public
    { Public declarations }
    class function EscolherOpcaoCancelamento(const AOpcoes : TListBox; ADefault : String): Integer;
    property OpcaoDefault : String read FOpcaoDefault write FOpcaoDefault;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmOpcaoCancelamento }

class function TfrmOpcaoCancelamento.EscolherOpcaoCancelamento(const AOpcoes : TListBox; ADefault : String): Integer;
  Var
    frmOpcaoCancelamento : TfrmOpcaoCancelamento;
begin
  pCriarFormularios(TfrmOpcaoCancelamento, frmOpcaoCancelamento);
  Try
    Result := -1;
    frmOpcaoCancelamento.lsbEspecies.Items.Assign(AOpcoes.Items);
    frmOpcaoCancelamento.OpcaoDefault := ADefault;
    frmOpcaoCancelamento.ShowModal;
    If (frmOpcaoCancelamento.ModalResult = mrOk) Then
      Result := frmOpcaoCancelamento.lsbEspecies.ItemIndex;
  Finally
    pFreeAndNil(frmOpcaoCancelamento);
  End;
end;

procedure TfrmOpcaoCancelamento.btnRestaurarOpcaoOriginalClick(Sender: TObject);
begin
  Selecionar(FOpcaoDefault);
end;

procedure TfrmOpcaoCancelamento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirma);
end;

procedure TfrmOpcaoCancelamento.FormCreate(Sender: TObject);
begin
  inherited;
  FOpcaoDefault := EmptyStr;
end;

procedure TfrmOpcaoCancelamento.FormShow(Sender: TObject);
begin
  inherited;
  Selecionar(FOpcaoDefault);
  btnRestaurarOpcaoOriginal.Visible := (Not fEmptyStr(FOpcaoDefault));
end;

procedure TfrmOpcaoCancelamento.lsbEspeciesClick(Sender: TObject);
begin
  SetaSelecionado;
end;

procedure TfrmOpcaoCancelamento.lsbEspeciesDblClick(Sender: TObject);
begin
  SetaSelecionado;
end;

procedure TfrmOpcaoCancelamento.lsbEspeciesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetaSelecionado;
end;

procedure TfrmOpcaoCancelamento.Selecionar(const AOpcao: String);
  Var
    LCount : Integer;
begin
  If fEmptyStr(AOpcao) Then
    Exit;
  For LCount := 0 To Pred(lsbEspecies.Count) Do
  Begin
    If (Copy(lsbEspecies.Items[LCount], 1, Length(AOpcao)) = AOpcao) Then
    Begin
      lsbEspecies.ItemIndex := LCount;
      SetaSelecionado;
      Break;
    End;
  End;
end;

procedure TfrmOpcaoCancelamento.SetaSelecionado;
begin
  lblSelecionado.Caption := lsbEspecies.Items[lsbEspecies.ItemIndex];
end;

end.
