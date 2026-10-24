unit untCadPrevMesBase;

interface

uses
  Windows, Classes, Controls,
  untPai, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls, StdCtrls;

type
  TfrmCadPrevMesBase = class(TfrmPai)
    rdgMesBas: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intMesBas : Integer;
    
  end;


implementation

uses Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadPrevMesBase.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If rdgMesBas.ItemIndex <> -1 Then
  Begin

    If fMensagem('', 'Copiar previsão de ' + rdgMesBas.Items[rdgMesBas.ItemIndex] + ' para todos os meses?', ['&Sim', '&Não']) = 1 Then
    Begin
      intMesBas := rdgMesBas.ItemIndex + 1;
      Close;
    End;

  End
  Else
  Begin
    fMensagem('', 'Você deve selecionar um mês base!', ['&Ok']);
    intMesBas := 0;
    Exit;
  End;
end;

procedure TfrmCadPrevMesBase.btnSairClick(Sender: TObject);
begin
  inherited;

  intMesBas := 0;

end;

procedure TfrmCadPrevMesBase.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnConfirma);

end;

end.
